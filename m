Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD844AE734
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbiBICmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243919AbiBIBz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:55:26 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047F0C06157B;
        Tue,  8 Feb 2022 17:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644371725; x=1675907725;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cFSvP3+npMUwdpU+EuZVnBjWbMWZP6LIj/t9xD3NmzM=;
  b=fevRj8oEAu6r0OoVMEGCVLm5j7qluJ16VWOppm41DfBdlWFFvqMtIThf
   vSWeNz0/TDTVtc4X2bJlirMrnmsYywLU2jPmSW6hlEgZvm+0rcRIDRkmG
   hSkJFY10SffDXreo10WTCJn7BBmhwtg21OI69eOB8LuO9Au+N44YeOnxQ
   U=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 08 Feb 2022 17:55:25 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 17:55:24 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 17:55:23 -0800
Received: from [10.111.162.111] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 8 Feb 2022
 17:55:21 -0800
Message-ID: <b60d30cf-e435-49c4-a251-b910bc2e94ae@quicinc.com>
Date:   Tue, 8 Feb 2022 17:55:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] devcoredump: increase the device delete timeout to 10
 mins
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <swboyd@chromium.org>,
        <khsieh@codeaurora.org>, <nganji@codeaurora.org>,
        <seanpaul@chromium.org>, <gregkh@linuxfoundation.org>,
        <dmitry.baryshkov@linaro.org>, <aravindh@codeaurora.org>,
        <freedreno@lists.freedesktop.org>
References: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
 <8d67484c7e4b9fb4560d2eca1f71c75fde8bae0d.camel@sipsolutions.net>
 <ebd340e4-2a02-d484-2ed0-9ee738d5b5c5@quicinc.com>
 <c59bc1af9974484075091333a3c98a2088251321.camel@sipsolutions.net>
 <a280fec2-754a-88ec-acc7-337e069e9148@quicinc.com>
 <c2a6e29063793eecc5c65d32af9d826544404ecc.camel@sipsolutions.net>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <c2a6e29063793eecc5c65d32af9d826544404ecc.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Johannes

On 2/8/2022 1:54 PM, Johannes Berg wrote:
> On Tue, 2022-02-08 at 13:40 -0800, Abhinav Kumar wrote:
>>>
>> I am checking what usermode sees and will get back ( I didnt see an
>> error do most likely it was EOF ). I didnt follow the second part.
> 
> I think probably it got -ENODEV, looking at kernfs_file_read_iter().
> 
>> If the file descriptor read returns EOF, even if we consider them
>> separate how will it resolve this issue?
>>
>> My earlier questions were related to fixing it in devcoredump to detect
>> and fix it there. Are you suggesting to fix in usermode instead? How?
>>
> 
> Yeah, no, you cannot fix it in userspace.
> 
> But I just followed the rabbit hole down kernfs and all, and it looks
> like indeed the read would be cut short with -ENODEV, sorry.
> 
> It doesn't look like there's good API for this, but it seems at least
> from the underlying kernfs POV it should be possible to get_device() in
> open and put_device() in release, so that the device sticks around while
> somebody has the file open? It's entirely virtual, so this should be OK?
> 
> johannes

Are you suggesting something like below?

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 42dcf96..14203d0 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -32,6 +32,22 @@ static const struct sysfs_ops *sysfs_file_ops(struct 
kernfs_node *kn)
         return kobj->ktype ? kobj->ktype->sysfs_ops : NULL;
  }

+static int sysfs_kf_open(struct kernfs_open_file *of)
+{
+       struct kobject *kobj = of->kn->parent->priv;
+       struct device *dev = kobj_to_dev(kobj);
+
+       get_device(dev);
+}
+
+static void sysfs_kf_release(struct kernfs_open_file *of)
+{
+       struct kobject *kobj = of->kn->parent->priv;
+       struct device *dev = kobj_to_dev(kobj);
+
+       put_device(dev);
+}
+
  /*
   * Reads on sysfs are handled through seq_file, which takes care of hairy
   * details like buffering and seeking.  The following function pipes
@@ -211,6 +227,8 @@ static const struct kernfs_ops sysfs_file_kfops_wo = {
  };

  static const struct kernfs_ops sysfs_file_kfops_rw = {
+       .open       = sysfs_kf_open;
+       .release    = sysfs_kf_release;
         .seq_show       = sysfs_kf_seq_show,
         .write          = sysfs_kf_write,
  };

If so, dont you think this will be a more intrusive change just for the 
sake of devcoredump? Any other way to keep the changes limited to 
devcoredump?

Thanks

Abhinav

