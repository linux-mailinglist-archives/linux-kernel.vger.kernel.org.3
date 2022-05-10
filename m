Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE54C52150D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241702AbiEJMVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241629AbiEJMU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:20:56 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BF8F6891;
        Tue, 10 May 2022 05:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652185019; x=1683721019;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JJaaWuWc8sV2e51bEleyOQg6zUB2DlPf9YjM1Nke9to=;
  b=OA1GhaYqHFPwcNkqHyp/vz55cymG5OaITuzPr2HsYsyltsGb0GBZyM1l
   AfLl4fWe3SiHd6CBBN6SPJ/8i2aiO5a/Em9TBHV8woGHflsstrj5B8+fO
   AlaTTli7lp4zVAgvicLGXa6UA113DL2RhNQwvi/eIv+p08JPncawsL7dE
   g=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 May 2022 05:16:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 05:16:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 05:16:58 -0700
Received: from [10.216.42.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 10 May
 2022 05:16:54 -0700
Message-ID: <cf3a80e3-301d-7c61-54ab-d63fd355dd48@quicinc.com>
Date:   Tue, 10 May 2022 17:46:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dmabuf: ensure unique directory name for dmabuf stats
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <sumit.semwal@linaro.org>, <daniel.vetter@ffwll.ch>,
        <tjmercier@google.com>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
References: <1652178212-22383-1-git-send-email-quic_charante@quicinc.com>
 <YnpF1XP1tH83uBlM@kroah.com> <039e1acc-8688-2e06-1b2a-1acbe813b91e@amd.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <039e1acc-8688-2e06-1b2a-1acbe813b91e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Christian for the inputs!!

On 5/10/2022 5:05 PM, Christian König wrote:
> 
>> And what's to keep the seconds field from also being the same?
> 
> Well exporting two DMA-bufs with the same ino in the same nanosecond
> should be basically impossible, but I would rather opt for using a 64bit
> atomic in that function.
> 
> This should be 100% UAPI compatible and even if we manage to create one
> buffer ever ns we need ~500years to wrap around.

I see that the inode->i_ctime->tv_sec is already defined as
64bit(time64_t tv_sec), hence used it. This way we don't need extra
static atomic_t variable just to get a unique name.

Just pasting excerpt from the reply posted to Greg about why this secs
will always be a unique: with secs field added, to get the same
inode-secs string, the uint should overflow in the same second which is
impossible.

Let me know If you still opt for atomic variable only.
