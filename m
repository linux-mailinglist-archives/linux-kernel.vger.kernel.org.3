Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40D458BE24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 01:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiHGXBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 19:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiHGXBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 19:01:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CAC12736
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 16:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659913287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xvZT7bMZ/JRYIKTtsEiVS1HUrcUq37VcQwAyJO4pGV4=;
        b=ZAvX/omRt41w7/6pwTyUqTHqBpquwGnDknD9SAtm+lhhyvUmse4nz5KuxC/vTpQnRGyWyb
        ZuUtcaaBUVrJxm50yVvTdubT3xS3LEwvw3gt3zIdnQYWFccBsB9Ifxbjgj/SXTPfLsQvwx
        VejHq4lQlTZ/5LGjvB9EtRImL65W/7M=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-v1T9KriaM7W-fn9X7dgb1A-1; Sun, 07 Aug 2022 19:01:26 -0400
X-MC-Unique: v1T9KriaM7W-fn9X7dgb1A-1
Received: by mail-il1-f197.google.com with SMTP id n2-20020a056e02100200b002dee632ca9fso5554044ilj.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 16:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xvZT7bMZ/JRYIKTtsEiVS1HUrcUq37VcQwAyJO4pGV4=;
        b=uthuDeI0kWEYn+MGZV4pCc8gskRqM82hpuylfKg7OH0x+P1vPipTp6+kVx2f9yR4LB
         nY05qdPdOtHKDNzcSufi/ms6DHWSIH2xWPKxx0nvL2JvgNhF8fHWpRuekbGAkHi9KKDc
         0UbBPUcIGwagR8LOTgPw3hVwMSqLoEKQERc4SAXxdzVGpWqz6sB0+ZcqbMJmgiy9FpOq
         7JJ4Ro+zJSUOIlLN117ECjIiwOvIQzKc+BaG74l7bkR5jLTXRGii7owFdwHKruFm6AWZ
         dF7JMcU0nGNUjXjWuKHYhjg9R8Sd/0ArkF48a8nJe37gtPA9dQbttGiT7Ht1XFv5+SzF
         zfOw==
X-Gm-Message-State: ACgBeo03IqMmhQT3R/f545S7SOIFfaT5QmD9GD9QVNhkpaVNRJuOIvou
        ZzU7huDvfd2nE/epvLnVpg1Hmptz4Trm5DSD9J+52Q4D6eK3Lj0TkSki+d5lZkvE0LU6xFcNUdd
        MJISlUppEpXR/uuLkUP5Nn3eL
X-Received: by 2002:a05:6e02:216a:b0:2df:947e:2318 with SMTP id s10-20020a056e02216a00b002df947e2318mr5043555ilv.220.1659913285633;
        Sun, 07 Aug 2022 16:01:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4VIpuCDDc3aC4qEKq4bmCIO3PvgOu137Q97CQjWnoc0nraYj4sf5kHB/nOI3Ok1AG39FC6wQ==
X-Received: by 2002:a05:6e02:216a:b0:2df:947e:2318 with SMTP id s10-20020a056e02216a00b002df947e2318mr5043547ilv.220.1659913285385;
        Sun, 07 Aug 2022 16:01:25 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id z4-20020a027a44000000b003415b95c097sm4434995jad.42.2022.08.07.16.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 16:01:24 -0700 (PDT)
Date:   Sun, 7 Aug 2022 19:01:23 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mm-hotfixes tree
Message-ID: <YvBEQ3PKqW6q/VrO@xz-m1.local>
References: <20220808071941.4e18e748@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220808071941.4e18e748@canb.auug.org.au>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 07:19:41AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   b2f4c6e29531 ("mm/smaps: don't access young/dirty bit if pte unpresent")
> 
> Fixes tag
> 
>   Fixes: b1d4d9e0cbd0 ("proc/smaps: carefully handle migration entries", 2012-05-31)
> 
> has these problem(s):
> 
>   - Subject has leading but no trailing quotes
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h ("%s")'
> 
> Please do not include the date part - it adds nothing.

The date confused the script.  I'd only rely on the 1st column (which
should definitely be the commit ID) normally for Fixes, but will remember
to use the general format in the future..

Thanks.

-- 
Peter Xu

