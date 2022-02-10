Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BEF4B150F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245614AbiBJSOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:14:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245607AbiBJSOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:14:37 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BEC1167
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:14:38 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id p11so5040471ils.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gXG8tJVzrMFq4C8hId95PJlogUK12YK3EnPowhKGkb4=;
        b=ZIXzPvySnYF7ILs4xx3XU4BBL0GgywKstA+ZKJv4g1ICO/A2UbZScYJFtDNaG0R1NM
         wynZtHnzJx2nKGOX+kHf796Uf3T3PSeTMqmdDocutHQY1PYtrO6tVWd2f+Rtc0Z7NhfO
         gQA1QrxQ22M1iunv2zNRNRlF0hSVM0/W3mJXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gXG8tJVzrMFq4C8hId95PJlogUK12YK3EnPowhKGkb4=;
        b=POQbW16MlLh6L+6xjUax2lCKiN58fjAaa08LSQG0CL5DwzK+nYdw6M01t7hyBdGdfc
         w0SHvq7J2I7brk1JiHhI2fjuUgyHMyOgHbTOxelCjLQXVzKz6+jPKmjatYjAcBydqhqb
         lnEed9kC2nQ0/ErahMpxYe+Ue5zkq1aAqXgBZsUN5KjrHuHShdbxRckd4T9852n03X8Q
         ZqhcueAlJmLCTlu9CYxXq5dD7kUvKiJpQ+k/exP1vCH62r3tRTQTmvtWOIjMvozEyPfC
         Kr9b/xTJyJ+zuJQEYi07tnROpq029pvZQzSmzxXECG5TM1rYXjTqtRHvH89yuY7NARWE
         ijLA==
X-Gm-Message-State: AOAM530tPT8wFPnxEr4lzLJZYJYbAD0JjkBg20Kn9bAV4V4I+KcFFGi4
        OGVspzEiITEMyS+uhKKLnSbzsAE34NjoBw==
X-Google-Smtp-Source: ABdhPJxzqCXnyKU0rVKea/h/aM2EYzsEG28YeSvqPRtlrTz2ig8+angmY+Yv31ftwnhbSZRR4RGbMA==
X-Received: by 2002:a05:6e02:19c6:: with SMTP id r6mr1338659ill.306.1644516877448;
        Thu, 10 Feb 2022 10:14:37 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id i9sm2069385ilm.74.2022.02.10.10.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 10:14:37 -0800 (PST)
Subject: Re: [PATCH] selftests/seccomp: Fix seccomp failure by adding missing
 headers
To:     Sherry Yang <sherry.yang@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20220202201118.13933-1-sherry.yang@oracle.com>
 <203db09a-b048-1c1b-6609-d91e51e3c2f7@linuxfoundation.org>
 <A8A651FC-37A5-4716-888B-F141E7241003@oracle.com>
 <202202031219.792E9AFF@keescook>
 <C340461A-6FD2-440A-8EFC-D7E85BF48DB5@oracle.com>
 <b908237b-63ad-ff10-8d89-540d2cab842e@linuxfoundation.org>
 <6FCDF584-C765-4344-A851-E623B2FCB9A6@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9fb71ee9-37c8-575c-0ca7-5a849403f7d9@linuxfoundation.org>
Date:   Thu, 10 Feb 2022 11:14:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6FCDF584-C765-4344-A851-E623B2FCB9A6@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/22 11:08 AM, Sherry Yang wrote:
> Yeah, -I works, but just with some compiler warnings.
> 

warnings aren't good. Kees, hope you are okay with this.

> If warnings are acceptable, do I need to send V2 patch with -I?
> 
> Sherry
> 

No top posting please. No need to fix it to -I - please send v2
I can't find your patch on lore - not sure why.

Please cc linux-kselftest and linux-kernel@vger.kernel.org

Also run scripts/get_maintainer.pl for a complete list of recipients
for this patch.

thanks,
-- Shuah
