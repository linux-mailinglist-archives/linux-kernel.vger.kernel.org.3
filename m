Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE15E4F0666
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 23:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237715AbiDBVUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 17:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiDBVUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 17:20:17 -0400
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com [192.185.50.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167AF2652
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 14:18:24 -0700 (PDT)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 8E4305FF08
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 16:18:23 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id al8ZnFcrR9AGSal8ZnvB1y; Sat, 02 Apr 2022 16:18:23 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iICxu8o08zMe7Ui0G3M/Cil+gzMynrzmoXIS4ku/IFc=; b=iAeWkgFTI4f+WwvufCpNRVV30g
        RARIdOHXZKwKzfrMlC9DuIe3dol5ANBgPCBYNKi+y7+GTRZj74OMa9Ar3Kk+hKW15w1XQKrWZdzD3
        BIwqV5mZELQ4m5GUz1Y+sXYHhl1nG7slujDlNbpovf2VVAJk043gY4alMMSTAJs47vOTP/bKuQkXJ
        h1o2GN86znlBn4kSFX8ryS1H2z77zvoF61MVn7PK0e44t5w9UpU9uZBOvHRy350yWHZxJ+jVUSMSB
        8XX/7umuQ8YPVlsGydKcHfgvMq8GfY5XsirjFAp75SfrkLqTjDUFmJcL5QcjQGumwmbUClMtElpBW
        uf3pDLdw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54664)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nal8Z-000y7u-6M; Sat, 02 Apr 2022 21:18:23 +0000
Message-ID: <0c646d80-3198-06c1-e8aa-442b245ffb3e@roeck-us.net>
Date:   Sat, 2 Apr 2022 14:18:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: r8188eu: Fix PPPoE tag insertion on big endian
 systems
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220401151257.3414576-1-linux@roeck-us.net>
 <782f0115-e45f-1aff-a152-5d403c990b31@lwfinger.net>
 <dcba377b-1fce-92e6-680a-77c5567cd06c@roeck-us.net>
 <8e68501c-24fd-cfbc-60f2-ec3e277159ab@lwfinger.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <8e68501c-24fd-cfbc-60f2-ec3e277159ab@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nal8Z-000y7u-6M
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54664
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/22 13:25, Larry Finger wrote:
> On 4/1/22 14:25, Guenter Roeck wrote:
>> The rest of the code uses htons/ntohs, so I prefer to follow that lead.
> 
> You just proved my point. It is hard to get be16_to_cpu() wrong. Sparse will flag the error when you use cpu_to_be16() instead. I expect that your htons/ntohs problem would also have shown up with Sparse.
> 

Ok, you made your point. I'll use be16_to_cpu() - the driver
already uses it elsewhere anyway. As for the other problems,
I am not sure if the driver ever worked. The function we are
looking at can't really have worked on a little endian system
because of the missing conversion, and the same is true for the
other code flagged by sparse. I think I'll just add a note
to this patch and let the driver authors decide what to do
about those problems.

Guenter
