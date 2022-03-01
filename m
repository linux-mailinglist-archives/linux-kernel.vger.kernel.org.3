Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA72B4C8CAB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiCANbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiCANbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:31:43 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD9F9D069;
        Tue,  1 Mar 2022 05:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646141460; x=1677677460;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6jTsJL2Nf6S109wFxCPWYCTVBMfXkFlLj36OQOqRjcc=;
  b=m8y+Gu8x1LkoaEH0vsJdVHviKkdSnmUY9d+WmxHCPoNBGv0qZvdGpHzo
   +5QYzqBhNxlurmNYp7FY763HrOEguMGoPjRgofOf4HHzfcgRlH4h1IgFu
   Wr4+yHHWZOmznSgwJRRM837Fbgy/G9J6Ql7xtVcZY3H9cAODMNbmz/vUV
   w=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 01 Mar 2022 05:31:00 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 05:30:59 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 1 Mar 2022 05:30:59 -0800
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 1 Mar 2022
 05:30:55 -0800
Message-ID: <edf83cee-d2af-867b-50e4-b065e7fb4b73@quicinc.com>
Date:   Tue, 1 Mar 2022 21:30:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] coresight: Defer probe when the child dev is not probed
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Mao Jinlong <jinlmao@qti.qualcomm.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20220228133112.3987-1-quic_jinlmao@quicinc.com>
 <861dd6e1-30dc-626e-3449-72d3b6822e7b@arm.com>
 <a63abe13-793e-323f-e214-1dd9826c8a9a@quicinc.com>
 <CAJ9a7VjShWLeSh0gyna-AUEB+jXO7u8JGLTXm_henn_cJ+E6Zw@mail.gmail.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <CAJ9a7VjShWLeSh0gyna-AUEB+jXO7u8JGLTXm_henn_cJ+E6Zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 3/1/2022 9:15 PM, Mike Leach wrote:
> Hi,
>
> On Tue, 1 Mar 2022 at 11:42, Jinlong Mao <quic_jinlmao@quicinc.com> wrote:
>> On 2/28/2022 10:51 PM, Suzuki K Poulose wrote:
>>
>> Hi Jinlong
>>
>> On 28/02/2022 13:31, Mao Jinlong wrote:
>>
>> From: Mao Jinlong <jinlmao@qti.qualcomm.com>
>>
>> It is possible that when device probe, its child device is not
>> probed. Then it will fail when add sysfs connection for the device.
>> Make device defer probe when the child device is not probed.
>>
>>
>> Please could you a bit a more specific on the exact issue ?
>> I don't see a problem with probe deferral right now, with
>> coresight/next.
>>
>> For e.g.,
>>
>> root@juno-server:~# lsmod
>> Module                  Size  Used by
>> coresight              73728  0
>> root@juno-server:~# ls /sys/bus/coresight/devices/
>> root@juno-server:~# modprobe coresight-etm4x
>> root@juno-server:~# lsmod
>> Module                  Size  Used by
>> coresight_etm4x        81920  0
>> coresight              73728  1 coresight_etm4x
>> root@juno-server:~# ls /sys/bus/coresight/devices/
>> etm0  etm1
>>
>> -- Note etm2-etm5 doesn't appear --
>>
>> root@juno-server:~# modprobe coresight-funnel
>> root@juno-server:~# lsmod
>> Module                  Size  Used by
>> coresight_funnel       20480  0
>> coresight_etm4x        81920  0
>> coresight              73728  2 coresight_etm4x,coresight_funnel
>> root@juno-server:~# ls /sys/bus/coresight/devices/
>> etm0  etm1
>>
>> -- Still don't appear ---
>>
>> root@juno-server:~# modprobe coresight-replicator
>> root@juno-server:~# ls /sys/bus/coresight/devices/
>> etm0  etm1
>> root@juno-server:~# modprobe coresight-tmc
>>
>> -- At this stage, the devices automatically get probed and appear --
>> root@juno-server:~# ls /sys/bus/coresight/devices/
>> etm0  etm1  etm2  etm3  etm4  etm5  funnel0  funnel1  funnel2  tmc_etf0  tmc_etr0
>>
>>
>> root@juno-server:~# lsmod
>> Module                  Size  Used by
>> coresight_tmc          40960  0
>> coresight_replicator    20480  0
>> coresight_funnel       20480  0
>> coresight_etm4x        81920  0
>> coresight              73728  4 coresight_tmc,coresight_etm4x,coresight_replicator,coresight_funnel
>>
>> So, my question is, what is this patch trying to solve ?
>>
>>
>> Cheers
>> Suzuki
>>
>> Hi Suzuki,
>>
>> This issue happens when race condition happens.
>> The condition is that the device and its child_device's probe happens at the same time.
>>
>> For example: device0 and its child device device1.
>> Both of them are calling coresight_register function. device0 is calling coresight_fixup_device_conns.
>> device1 is waiting for device0 to release the coresight_mutex. Because device1's csdev node is allocated,
>> coresight_make_links will be called for device0. Then in coresight_add_sysfs_link, has_conns_grp is true
>> for device0, but has_conns_grp is false for device1 as has_conns_grp is set to true in coresight_create_conns_sysfs_group .
>> The probe of device0 will fail for at this condition.
>>
>>
>> struct coresight_device *coresight_register(struct coresight_desc *desc)
>> {
>>     .........
>>      mutex_lock(&coresight_mutex);
>>
>>      ret = coresight_create_conns_sysfs_group(csdev);
>>      if (!ret)
>>          ret = coresight_fixup_device_conns(csdev);
>>      if (!ret)
>>          ret = coresight_fixup_orphan_conns(csdev);
>>      if (!ret && cti_assoc_ops && cti_assoc_ops->add)
>>          cti_assoc_ops->add(csdev);
>>
>>      mutex_unlock(&coresight_mutex);
>>
>> .........
>>
>> }
>>
>> static int coresight_fixup_device_conns(struct coresight_device *csdev)
>> {
>>     ..........
>>          conn->child_dev =
>>              coresight_find_csdev_by_fwnode(conn->child_fwnode);
> The issue appears to be a constraint hidden in the lower layers of the code.
> Would a better solution not be to alter the code here:
>
> if (conn->child_dev && conn->child_dev->has_conns_grp) {
>     ...
> } else {
>        csdev->orphan = true;
> }
>
> which would mean that the connection attempt would drop through to
> label the connection as an orphan, to be cleaned up by the child
> itself when it runs coresight_fixup_orphan_conns()
>
> Regards
>
> Mike
Thanks Mike.

Your recommended fix looks much better than my fix. Let me try with it 
and get back to you.

Thanks

Jinlong  Mao


>
>>          if (conn->child_dev) {
>>              ret = coresight_make_links(csdev, conn,
>>
>>                             conn->child_dev);
>>
>> ..........
>>
>> }
>>
>>
>> int coresight_add_sysfs_link(struct coresight_sysfs_link *info)
>> {
>>     ................
>>      if (!info->orig->has_conns_grp || !info->target->has_conns_grp)
>>          return -EINVAL;
>>
>>
>>
>> The probe fail issue is reproduced with reboot stress test on our internal device.
>>
>> With the patch, the probe fail issue is not reproduced.
>>
>> Thanks
>>
>> Jinlong Mao
>>
>>
>>
>> Signed-off-by: Mao Jinlong <jinlmao@qti.qualcomm.com>
>> ---
>>    drivers/hwtracing/coresight/coresight-sysfs.c | 4 +++-
>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
>> index 34d2a2d31d00..7df9eb59bf2c 100644
>> --- a/drivers/hwtracing/coresight/coresight-sysfs.c
>> +++ b/drivers/hwtracing/coresight/coresight-sysfs.c
>> @@ -73,8 +73,10 @@ int coresight_add_sysfs_link(struct coresight_sysfs_link *info)
>>        if (!info->orig || !info->target ||
>>            !info->orig_name || !info->target_name)
>>            return -EINVAL;
>> -    if (!info->orig->has_conns_grp || !info->target->has_conns_grp)
>> +    if (!info->orig->has_conns_grp)
>>            return -EINVAL;
>> +    if (!info->target->has_conns_grp)
>> +        return -EPROBE_DEFER;
>>          /* first link orig->target */
>>        ret = sysfs_add_link_to_group(&info->orig->dev.kobj,
>>
>>
>
