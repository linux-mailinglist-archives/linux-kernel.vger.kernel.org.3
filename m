Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0706B4F1073
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377896AbiDDIE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377882AbiDDIEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:04:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5B23B3D6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:02:20 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g20so10011219edw.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 01:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1JgldMjDiu5zvK43QVM+MblMzFJyCLm6wag4GS38NI8=;
        b=ga3t17CYfB+KE5TsU35ymU7gxz3it957Oe4YUouw/nV0JQpApURccq9lNMFMZlgmex
         jCH1hxwg5j0DpUWw2a1DWbHQB4XgKTwrjQLTEiZi2wOOW6MxKBUVYR1hDcbLYo1rlNlA
         VVcEn6ELp11wq8wEBmvX58dV37HR66tsvubuyNwohvs0eIJr2lMksepdj7hQ45NQXcPh
         TkSJ1HyTe1fD15uHj35aLRr/2cKRM00z4bBP89rwISORGPjxUqwJSivRjVDrtgKQ+smB
         khIsYorPHxcGCaV0PH/16q+MJeOcAG+AcxMlNGiKD/8fnyBLsO1VkADj1b9Z0B3XcgGU
         +Q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1JgldMjDiu5zvK43QVM+MblMzFJyCLm6wag4GS38NI8=;
        b=fSp9NTFBnyirMbAWMbVyDfWc44RgRbjk39X84m41Y/Xt/zrxRDYSubHzZG0kIWFKKd
         n9Vk548EFnIAHkG70VgFu/nZ7t7irWmsixODAf6asbi+rA06T90EYwmYC/GSYPoLGxDX
         93K7gqMuRcYsXw9vhcdGsffGOeaWTjLbh7I1qDv0RooLicrNC5guYiJ7+Q1sRuk9CKNn
         rlXSJ7aus/vX8vf7m/vVg9BWnxi0iiNpfF50RBhxzoXkhuZZPtwve9y1EftvaaJGrHQ5
         v1c6xvKnPDYMJQl/9vHcaLY6UEobzgcavMrmfxauEz1L6H9vGQ7gMwABCM1GdMTfL0kj
         KONg==
X-Gm-Message-State: AOAM532Op6ie3eHBgGBCTscGFg0FEQK1PdfjE6FVsk9dS8YL3fdl7I8X
        3td2N3LaYQ1iaG+WIGQLR7c=
X-Google-Smtp-Source: ABdhPJy3Lne0mEdt5P7baRApHpBKwehsF8BbTaFxGRB7bweJOspyVKwdLk40Ri78C0idhxVP+MClyA==
X-Received: by 2002:a05:6402:4247:b0:419:3990:3db6 with SMTP id g7-20020a056402424700b0041939903db6mr31362069edb.193.1649059338902;
        Mon, 04 Apr 2022 01:02:18 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id jt8-20020a170906ca0800b006df9b29eaf1sm4039632ejb.8.2022.04.04.01.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 01:02:18 -0700 (PDT)
Message-ID: <bdd168a8-b260-0653-f835-a7814a8fd4c8@gmail.com>
Date:   Mon, 4 Apr 2022 10:02:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2] Fix unsafe memory access by memcmp
Content-Language: en-US
To:     Charlie Sands <sandsch@northvilleschools.net>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
References: <YkpdVyuQguGzPSNE@sckzor-linux.localdomain>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <YkpdVyuQguGzPSNE@sckzor-linux.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 04:52, Charlie Sands wrote:
> This patch fixes sparse warnings about the memcmp function unsafely
> accessing userspace memory without first copying it to kernel space.
> 
> Signed-off-by: Charlie Sands <sandsch@northvilleschools.net>
> ---
> 
> V2: Fixed checkpatch.pl warning and changed variable name as suggested
> by Greg K. H. and improved error checking on the "copy_from_user" function as
> suggested by Pavel Skripkin.
> 
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c | 21 ++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> 

Hi Charlie,

thanks for your patch. Looks good to me, but you should include
staging: r8188eu: in the subject line.

"staging: r8188eu: Fix unsafe memory access by memcmp"

thanks,
Michael
