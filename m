Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5450522218
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347834AbiEJRSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244070AbiEJRST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:18:19 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91AC2BF306;
        Tue, 10 May 2022 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652202861; x=1683738861;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=83162g9zxtcfDjx2nWTNvvkXPY5uRoho8j7OS99ySF8=;
  b=aosI5TvhuLwLKBWFXyA4X3UGCFk83FMw9ffWM73KAL8BGTqZoH3XBNGu
   9KCMcsv4S8EKOs1AZ+NVVe+zVHcPAaeaDx4enE/4XN3D/I3Nsro9E0xG/
   B0XzgG3GX59VbgjDIm6wz6EagQbCSlHm+VcSL0pNlmZQ07w2CuBJSTt2i
   I=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 10 May 2022 10:14:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 10:14:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 10:14:19 -0700
Received: from [10.216.42.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 10 May
 2022 10:14:14 -0700
Message-ID: <6dc59fa7-5885-9ed1-54c3-f2d112786312@quicinc.com>
Date:   Tue, 10 May 2022 22:44:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2] dmabuf: ensure unique directory name for dmabuf stats
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        <gregkh@linuxfoundation.org>, <sumit.semwal@linaro.org>,
        <hridya@google.com>, <daniel.vetter@ffwll.ch>,
        <tjmercier@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>
References: <1652191562-18700-1-git-send-email-quic_charante@quicinc.com>
 <4ac55be2-7d55-2c3b-0d5e-f61c02c62792@amd.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <4ac55be2-7d55-2c3b-0d5e-f61c02c62792@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/2022 8:42 PM, Christian König wrote:
>>    * The information in the interface can also be used to derive
>> per-exporter
>>    * statistics. The data from the interface can be gathered on error
>> conditions
>> @@ -172,6 +172,7 @@ int dma_buf_stats_setup(struct dma_buf *dmabuf)
>>   {
>>       struct dma_buf_sysfs_entry *sysfs_entry;
>>       int ret;
>> +    static atomic64_t unique_id = ATOMIC_INIT(0);
> 
> Please move that to the beginning of the declarations.
> 

Done. Any scripts I can run at my end to catch these type of trivial
changes? checkpatch.pl didn't report this coding style.

>>         if (!dmabuf || !dmabuf->file)
>>           return -EINVAL;
>> @@ -192,7 +193,8 @@ int dma_buf_stats_setup(struct dma_buf *dmabuf)
>>         /* create the directory for buffer stats */
>>       ret = kobject_init_and_add(&sysfs_entry->kobj, &dma_buf_ktype,
>> NULL,
>> -                   "%lu", file_inode(dmabuf->file)->i_ino);
>> +                   "%lu-%lu", file_inode(dmabuf->file)->i_ino,
> 
> Why not just use the unique value here? Or is the inode number necessary
> for something?

This will ease the debugging a lot. Given the dump, I can easily map
which dmabuf buffer to the process. On the crashutilty I just have to
search for this inode in the files output, just one example.
