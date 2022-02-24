Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5669F4C2403
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiBXGXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiBXGXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:23:41 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D66C165C19;
        Wed, 23 Feb 2022 22:23:12 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cm8so1415565edb.3;
        Wed, 23 Feb 2022 22:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69+mSNz7gTFXWXZZqcOIp0MaPmAG8AGfcHpHb4Enfug=;
        b=MJBLpupYfAwJzcBD8mLvjEcwEWbv8vQPdsyvldsB1LKJWaKAA/fp54IwLk9Md8lgTx
         ZI98umEuWLrlcQ+18uknmcQLI/20vN7T42gVy7ekJKRgXOXDhRd0GI3gVNUsl6nwziv3
         iJDEV6/NuhXbSWzimR30YSQlw9df9FS/mFe4dmWse561L5eZhGm6dftsMFinvr1tnbFi
         VWjo7hjS/DY8RBoM2oPvFR8rjhATfrcDH3MC5CRIectXuYpD88A+FkItGcNKTcd2bw0i
         OZizpDnvYC3yvynm2ggbIiSRwsYNqSx3oYCCaAhz5H3O4viil3q21GWfF0NrUnevtEpD
         F+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69+mSNz7gTFXWXZZqcOIp0MaPmAG8AGfcHpHb4Enfug=;
        b=X45OliCpQXC9qFisIjfLsBzQYxSKC0ivd5UFsdoztnFkfDu09gzjjFEmY3zundHEXL
         d8JL3/OMGWeS/aOsnSFLr9CohhfC5NmnXnh+OT2bReRn1kQfsBZ33zUfBgbmOqv4RJ2o
         GFDydjI/ncTu8Mb1/iiBWtM6gIg8qA3jfswhSBtPnsYnDALZuemb+dYG3SvRVmEe/iwZ
         nQ2EnXdEdtxom79bEsGw9TneYSyK6QPgHKE8fn2Q73sKG+8erpf2vvBNfa1jv/dm8MZu
         ok7VHb5iRC/gkqL0Ks/1bmJKyH+/9sdWt+Y5ltYeOXKxpxZVsjvsAMuaUq6jQ/Oom84D
         MMIg==
X-Gm-Message-State: AOAM532OXAXp72BGLektOX3mWwgShut//Y62c2BJ1VT+802e0hllEZxO
        YiWjMO6H7SFZEG4AADBC3a0OYSfgU9veBio55Qld0usD
X-Google-Smtp-Source: ABdhPJzcp+/rVwnIZbbhIn4T8pggvANZ5gREugNHsGU1SKDCTzJb9/uHDdbP9TyUYv/zqPlZ/7zOALAbBTKjvxsry2g=
X-Received: by 2002:a50:fa93:0:b0:40f:d482:ef63 with SMTP id
 w19-20020a50fa93000000b0040fd482ef63mr885613edr.348.1645683790702; Wed, 23
 Feb 2022 22:23:10 -0800 (PST)
MIME-Version: 1.0
References: <20220224060503.1856302-1-keescook@chromium.org>
In-Reply-To: <20220224060503.1856302-1-keescook@chromium.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 23 Feb 2022 22:22:59 -0800
Message-ID: <CAMo8BfJFJE-n3=AF+pb9_6oF3gzxX7a+7aBrASHjjNX5byqDqw@mail.gmail.com>
Subject: Re: [PATCH] xtensa: Implement "current_stack_pointer"
To:     Kees Cook <keescook@chromium.org>
Cc:     Chris Zankel <chris@zankel.net>, Marc Zyngier <maz@kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 10:05 PM Kees Cook <keescook@chromium.org> wrote:
>
> To follow the existing per-arch conventions replace open-coded uses
> of asm "sp" as "current_stack_pointer". This will let it be used in
> non-arch places (like HARDENED_USERCOPY).
>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: linux-xtensa@linux-xtensa.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/xtensa/Kconfig                  | 1 +
>  arch/xtensa/include/asm/current.h    | 2 ++
>  arch/xtensa/include/asm/stacktrace.h | 2 +-
>  arch/xtensa/kernel/irq.c             | 3 +--
>  4 files changed, 5 insertions(+), 3 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
