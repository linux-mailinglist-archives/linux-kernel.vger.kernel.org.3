Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA91C54E5A6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377831AbiFPPEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377776AbiFPPET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:04:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70828326E2;
        Thu, 16 Jun 2022 08:04:17 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LP56Y73MVz67KsG;
        Thu, 16 Jun 2022 23:04:05 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 17:04:14 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 16 Jun
 2022 16:04:14 +0100
Date:   Thu, 16 Jun 2022 16:04:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/core: Add sysfs attribute get_poison for list
 retrieval
Message-ID: <20220616160412.00000c34@Huawei.com>
In-Reply-To: <57644934bb7af8e1c692735f53c2c415a1ba16d1.1655250669.git.alison.schofield@intel.com>
References: <cover.1655250669.git.alison.schofield@intel.com>
        <57644934bb7af8e1c692735f53c2c415a1ba16d1.1655250669.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022 17:10:28 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> The sysfs attribute, get_poison, allows user space to request the
> retrieval of a CXL devices poison list for its persistent memory.
> 
> From Documentation/ABI/.../sysfs-bus-cxl
>         (WO) When a '1' is written to this attribute the memdev
>         driver retrieves the poison list from the device. The list
>         includes addresses that are poisoned or would result in
>         poison if accessed, and the source of the poison. This
>         attribute is only visible for devices supporting the
>         capability. The retrieved errors are logged as kernel
>         trace events with the label: cxl_poison_list.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Hi Alison,

I'm planning to throw together QEMU support for this and test
it. In meantime a few quick comments / suggestions inline.

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 13 ++++++++++
>  drivers/cxl/core/memdev.c               | 32 +++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 7c2b846521f3..9d0c3988fdd2 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -163,3 +163,16 @@ Description:
>  		memory (type-3). The 'target_type' attribute indicates the
>  		current setting which may dynamically change based on what
>  		memory regions are activated in this decode hierarchy.
> +
> +What:		/sys/bus/cxl/devices/memX/get_poison
> +Date:		June, 2022
> +KernelVersion:	v5.20
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) When a '1' is written to this attribute the memdev
> +		driver retrieves the poison list from the device. The list
> +		includes addresses that are poisoned or would result in
> +		poison if accessed, and the source of the poison. This
> +		attribute is only visible for devices supporting the
> +		capability. The retrieved errors are logged as kernel
> +		trace events with the label: cxl_poison_list.
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f7cdcd33504a..5ef9ffaa934a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -106,12 +106,34 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
> +static ssize_t get_poison_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +
> +{
> +	int rc;
> +
> +	if (!sysfs_streq(buf, "1")) {

Maybe kstrtobool?  If you do then fine to leave the documentation claiming
it's tighter as that'll tell people who actually read it to expect to
write a 1.

> +		dev_err(dev, "%s: unknown value: %s\n", attr->attr.name, buf);

Feels noisy when I'd expect -EINVAL to be enough info to indicate an invalid
parameter.

> +		return -EINVAL;
> +	}
> +
> +	rc = cxl_mem_get_poison_list(dev);
> +	if (rc) {
> +		dev_err(dev, "Failed to retrieve poison list %d\n", rc);

Here I'd expect the error code to returned on the write to probably be enough
info so not sure this error print is useful either.

> +		return rc;
> +	}
> +	return len;
> +}
> +static DEVICE_ATTR_WO(get_poison);
> +
>  static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_serial.attr,
>  	&dev_attr_firmware_version.attr,
>  	&dev_attr_payload_max.attr,
>  	&dev_attr_label_storage_size.attr,
>  	&dev_attr_numa_node.attr,
> +	&dev_attr_get_poison.attr,
>  	NULL,
>  };
>  
> @@ -130,6 +152,16 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>  {
>  	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
>  		return 0;
> +
> +	if (a == &dev_attr_get_poison.attr) {
> +		struct device *dev = container_of(kobj, struct device, kobj);
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +		if (!test_bit(CXL_MEM_COMMAND_ID_GET_POISON,
> +			      cxlds->enabled_cmds))
			      to_cxl_memdev(dev)->enabled_cmds))
and drop the local variable is shorter and I don't htink it loses
any readability.

> +			return 0;
> +	}
>  	return a->mode;
>  }
>  

