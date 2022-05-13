Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48839525FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379539AbiEMKjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbiEMKjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:39:00 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802E61FC2E1;
        Fri, 13 May 2022 03:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652438339; x=1683974339;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wgMVjWhvJhoWOt/KHhALzY1JWO2Y10o5k6lUReCLpcY=;
  b=Mf+RuqLgbWs/HkVSzdgSvL4Fvjx0otQSfQYf5jqac4J5Vu1M8XQF8rum
   HnnyUhgxc1jDZhjUbUUvX2dyc/C1IdeCh9xSO3YjupY35GFELDqvx+3WJ
   cwdDZ+6Zk8DgYu5TQ/Pe5t8uXMppU2CatDFywJzTRRClosvRJ1l0MvSv4
   o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 May 2022 03:38:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 03:38:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 13 May 2022 03:38:57 -0700
Received: from [10.214.30.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 13 May
 2022 03:38:54 -0700
Message-ID: <f5988884-ba0a-643c-e920-6ae626bb67a1@quicinc.com>
Date:   Fri, 13 May 2022 16:08:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3] dma-buf: ensure unique directory name for dmabuf stats
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <sumit.semwal@linaro.org>, <hridya@google.com>,
        <daniel.vetter@ffwll.ch>, <tjmercier@google.com>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
References: <1652434689-6203-1-git-send-email-quic_charante@quicinc.com>
 <Yn4u0AG8iC33S3jO@kroah.com>
 <2a45f1e1-39d5-76b3-8fd3-c1f8b288afac@quicinc.com>
 <0071e117-1d91-b086-7cb1-976b2a1c3498@amd.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <0071e117-1d91-b086-7cb1-976b2a1c3498@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/13/2022 3:59 PM, Christian König wrote:
> Am 13.05.22 um 12:18 schrieb Charan Teja Kalla:
>> On 5/13/2022 3:41 PM, Greg KH wrote:
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>> The trest robot did not say that the dmabuf stat name was being
>>> duplicated, did it?
>>>
>> It reported a printk warning on V2[1]. Should we remove this on V3?
> 
> We only add the kernel test robot is report when it found the underlying
> problem and not just noted some warning on an intermediate patch version.

Noted. Thanks!!
> 
>> @Christian: Could you please drop this tag while merging?
> 
> Sure, I don't have much on my plate at the moment. But don't let it
> become a habit.
> 

Sure. I am also thinking If it is worth to add stable tag? Though it is
not crashing the kernel but definitely making the dma_buf_export to fail
for no reason.

If yes, I can resend the patch with all these tags.

> Going to push it upstream through drm-misc-fixes now.
