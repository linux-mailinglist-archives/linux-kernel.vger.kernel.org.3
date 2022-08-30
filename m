Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4431B5A59BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiH3DGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiH3DGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:06:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5956C719AF;
        Mon, 29 Aug 2022 20:06:11 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MGsXv5VCkzkWmW;
        Tue, 30 Aug 2022 11:02:07 +0800 (CST)
Received: from [10.174.178.165] (10.174.178.165) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 11:05:45 +0800
Subject: Re: [PATCH -next 3/4] spi: mockup: Add runtime device tree overlay
 interface
To:     Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220826144341.532265-1-weiyongjun1@huawei.com>
 <20220826144341.532265-4-weiyongjun1@huawei.com>
 <8c436553-e35c-4e46-1407-24184fd113ba@gmail.com>
From:   "weiyongjun (A)" <weiyongjun1@huawei.com>
Message-ID: <4eab3d1a-199f-fdfe-8d8f-3369eeefde47@huawei.com>
Date:   Tue, 30 Aug 2022 11:05:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8c436553-e35c-4e46-1407-24184fd113ba@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.165]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/30 5:29, Frank Rowand wrote:
> comment inline below, plus adding to cc: and to: list
> 
> On 8/26/22 09:43, Wei Yongjun wrote:
>> Add a runtime device tree overlay interface for device need dts file.
>> With it its possible to use device tree overlays without having to use
>> a per-platform overlay manager.
> 
> Why is an overlay needed?  The documentation in patch 4 shows providing
> a dtb as an argument to the qemu-system-x86_64 command, which should be
> sufficient to supply the appropriate dtb.

Fist, we are aimed to build a device driver regression testsuit. Without
overlay, lots of the dtb fragments must be combined to a very big one, it
may different to maintainence. overlay makes easily to attach/detech as
the device's requirement.

Seconds, overlay dts may be used to found or verification issues related
to of_node_put or others, such as patches like:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?qt=grep&q=node_put

many of them may found by static check tool, which may leak of tesing.

The documentation I post does not use overlay dts, but when overlay
dts[1] is used, we can found the of node leak:

$ python3 -m kddv.cmds.mock -b spi -d mchp23k256
create spi device mchp23k256 success!
$ ls /sys/bus/spi/drivers/mchp23k256/spi0.0/mtd/
mtd0  mtd0ro
$ python3 -m kddv.cmds.mock -b spi -d mchp23k256 -r
[  233.508565] Deleting MTD partitions on "spi0.0":
[  233.516784] OF: ERROR: memory leak, expected refcount 1 instead of 2,
  of_node_get()/of_node_put() unbalanced - destroy cset entry: attach
  overlay node /spi/spi-sram@0
remove spi device mchp23k256 success!

Not sure it is worth to fix issues like this, but at least, we can
tesing them now.

-[1]---------------------------------------------------------
/dts-v1/;
/plugin/;

&{/spi} {
	spi-sram@0 {
		#address-cells = <1>;
		#size-cells = <1>;
		compatible = "microchip,mchp23k256";
		reg = <0>;
		spi-max-frequency = <20000000>;
	};
};

-------------------------------------------------------

Regards,
Wei Yongjun

> 
> -Frank
> 
>>
>> Add a new device by command:
>> $ cat test.dtbo > /sys/class/spi_master/spi0/overlay_fdto
>>
>> Remove the device by command:
>> $ echo remove > /sys/class/spi_master/spi0/overlay_fdto
>>
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>> ---
>>   drivers/spi/Kconfig      |  2 ++
>>   drivers/spi/spi-mockup.c | 48 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 50 insertions(+)
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index e0f0fa2746ad..4b7c84ddb367 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -1161,6 +1161,8 @@ config SPI_TLE62X0
>>   config SPI_MOCKUP
>>   	tristate "SPI controller Testing Driver"
>>   	depends on OF
>> +	select OF_EARLY_FLATTREE
>> +	select OF_RESOLVE
>>   	select BPF_EVENTS
>>   	help
>>   	  This enables SPI controller testing driver, which provides a way to
>> diff --git a/drivers/spi/spi-mockup.c b/drivers/spi/spi-mockup.c
>> index 7a93b194ee53..404ad821bf6a 100644
>> --- a/drivers/spi/spi-mockup.c
>> +++ b/drivers/spi/spi-mockup.c
>> @@ -21,6 +21,9 @@
>>   struct mockup_spi {
>>   	struct mutex lock;
>>   	struct spi_device *devs[MOCKUP_CHIPSELECT_MAX];
>> +
>> +	void *fdto;
>> +	int ovcs_id;
>>   };
>>   
>>   static struct spi_master *to_spi_master(struct device *dev)
>> @@ -145,9 +148,53 @@ delete_device_store(struct device *dev, struct device_attribute *attr,
>>   }
>>   static DEVICE_ATTR_WO(delete_device);
>>   
>> +static ssize_t
>> +overlay_fdto_store(struct device *dev, struct device_attribute *attr,
>> +		   const char *buf, size_t count)
>> +{
>> +	struct spi_master *master = to_spi_master(dev);
>> +	struct mockup_spi *mock = spi_master_get_devdata(master);
>> +	int ret;
>> +
>> +	mutex_lock(&mock->lock);
>> +
>> +	if (strncmp(buf, "remove\n", count) == 0) {
>> +		if (mock->ovcs_id < 0) {
>> +			ret = -ENOENT;
>> +			goto out_unlock;
>> +		}
>> +		of_overlay_remove(&mock->ovcs_id);
>> +		kfree(mock->fdto);
>> +		mock->ovcs_id = -1;
>> +		mock->fdto = NULL;
>> +	} else {
>> +		if (mock->ovcs_id >= 0) {
>> +			ret = -EINVAL;
>> +			goto out_unlock;
>> +		}
>> +		mock->fdto = kmemdup(buf, count, GFP_KERNEL);
>> +		if (!mock->fdto) {
>> +			ret = -ENOMEM;
>> +			goto out_unlock;
>> +		}
>> +		ret = of_overlay_fdt_apply(mock->fdto, count, &mock->ovcs_id);
>> +		if (ret < 0)
>> +			goto out_unlock;
>> +	}
>> +
>> +	mutex_unlock(&mock->lock);
>> +	return count;
>> +
>> +out_unlock:
>> +	mutex_unlock(&mock->lock);
>> +	return ret;
>> +}
>> +static DEVICE_ATTR_WO(overlay_fdto);
>> +
>>   static struct attribute *spi_mockup_attrs[] = {
>>   	&dev_attr_new_device.attr,
>>   	&dev_attr_delete_device.attr,
>> +	&dev_attr_overlay_fdto.attr,
>>   	NULL
>>   };
>>   ATTRIBUTE_GROUPS(spi_mockup);
>> @@ -227,6 +274,7 @@ static int spi_mockup_probe(struct platform_device *pdev)
>>   
>>   	mock = spi_master_get_devdata(master);
>>   	mutex_init(&mock->lock);
>> +	mock->ovcs_id = -1;
>>   
>>   	ret = spi_register_master(master);
>>   	if (ret) {
> 
