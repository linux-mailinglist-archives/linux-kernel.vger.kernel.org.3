Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C97E4B7F77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245607AbiBPE0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:26:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiBPE03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:26:29 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D5DDB85F;
        Tue, 15 Feb 2022 20:26:17 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id b10so510945oie.2;
        Tue, 15 Feb 2022 20:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RY42s9XP2vCaExmg8SW1b8959hPeZEJSy7UrnQIOnSA=;
        b=JvejWtnqzAJkoIgn8NJ8DU5qzp0fHD2Zi41OogWhqIfNYhxNdmwdKUVcs7GRmA4rKY
         suPtkCqSNRDVwsEBPG6EExFAycr35RIKSwprEwQH1zohlyqqlZxZh6f5Qk0Q4/fG31Ha
         I4fOstVhX55t+aOotFHxE0RzOeff+hGm3EhogS7Ow6Mltk0li2itQgWm9A7ViB7DTLI3
         OD29GMkEXGLSpSFsaZjURrEbRaLdo9uNgFOrayZJXuggRtaJSagZB65fyjagbctG1CRW
         L2qBogykcYAZgfHnoln87uG6FlpU9Ggolw3Mz6t5vntOsJMoAsFLr9OIVJNE6CGvDv8j
         xZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RY42s9XP2vCaExmg8SW1b8959hPeZEJSy7UrnQIOnSA=;
        b=AOX/5U4w5iarT5i4AlUX4Qv08nWE05UexvmOs9oUUGRWCzW2yRiIKJZynU1Q1fg0J3
         9YBgAnsZoDiA6AktMBWEgJcvojYiUSmA3rlQh3GFarF06sUcQFfm/njKhaWQcsgwmcIw
         ABVupxnNKIHH1TzgQlzMb0WDOfbBEmRds4Mlg+/kj2i0EE+y+8m/V7MDvFL9KVvN42xC
         nZWIf3p79+avcnLhnAkxKeLn1gkB5QknvONNcS0Rf8ZI6wVgCk6xB2fExs486G5F2Bt6
         Gtsx+boJMhI7NkGiemR/RGKMdRJ4UTBkY1jQ8dxSYdTt3dpGUUAeLAQWYo9U24KzT0Aw
         B/zQ==
X-Gm-Message-State: AOAM530+Znpy8MrXJNT5uQpqmKI2bD1Uetxda3AxoqtneVKw5cA5fntN
        7rwFCgDO4YV6WxmF3FM93+6iM8qmB4dm9A==
X-Google-Smtp-Source: ABdhPJwEhTSlGLzNvGzaceF503qrsfiNuHkumbVADHWU2qQ9wQpGTW305eaFMDGQUWBoYy42lKmghg==
X-Received: by 2002:a05:6808:f8d:b0:2ce:7461:200f with SMTP id o13-20020a0568080f8d00b002ce7461200fmr458038oiw.285.1644985577184;
        Tue, 15 Feb 2022 20:26:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b8sm4973952otk.36.2022.02.15.20.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 20:26:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 15 Feb 2022 20:26:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Klein <michael@fossekall.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH v2] ARM: dts: sun8i: Adjust power key nodes
Message-ID: <20220216042614.GA63304@roeck-us.net>
References: <20211129165510.370717-1-jernej.skrabec@gmail.com>
 <20220215002732.GA3215504@roeck-us.net>
 <4714494.31r3eYUQgx@kista>
 <23df0d53-d530-2363-09c9-5be2b2306a81@roeck-us.net>
 <35ca9258-3129-240c-7a0a-cacfa0a13253@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ca9258-3129-240c-7a0a-cacfa0a13253@sholland.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 10:11:36PM -0600, Samuel Holland wrote:
[ ... ]
> 
> I don't think there is any real issue here. The two irq_desc's being locked are
> always different, so there is no deadlock. This recursive irq_set_irq_wake seems
> to be a reasonably common pattern in GPIO drivers, and several of them contain
> code to silence lockdep. I've sent a patch adding a copy of that to the sunxi
> driver:
> 
> https://lore.kernel.org/lkml/20220216040037.22730-1-samuel@sholland.org/
> 
> Please see if it works for you.
> 
Yes, it does. The warning is gone with your patch applied on top of linux-next.

Thanks,
Guenter
