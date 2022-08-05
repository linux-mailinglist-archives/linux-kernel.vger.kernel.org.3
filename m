Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3838058A4A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 04:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiHECMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 22:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiHECMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 22:12:45 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BA022B27
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 19:12:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pm17so1429236pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 19:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=n6E00UKHlLLvbJHGhfdymyRpel5Ak5LfPBjCSLChZZg=;
        b=hSsr0xX4SUBoFaIsYOMfwHCcs3hXc6tsltf62qkBVfV9jWG8mjmoBO3MGGeI61OiIT
         Xp31aWNbRmoVSKRIzAp1ynukvbgiy/QmDPkD2DWyNlTSlLnCS+xRJkPOYwkSMRIqsiQl
         cpGnN1YTQ3JQtM6o9c5De8atInp7kFbWqQnzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=n6E00UKHlLLvbJHGhfdymyRpel5Ak5LfPBjCSLChZZg=;
        b=5dsHKTaqIP15RXKYhrlD/HLPnCn+gDWDIQfp8IjbL51y3zmiuWXAVXH6xm1AuHm83h
         C7hQlcmvwVSRTWPlGwylvXr9unf8VAGFjM7Bkz6DB1Te3Fd/SllsaSe7Schj89N/dD2e
         Uwl1iPrfVYbcdOWFkgoab+Ur5AHlw1XiZw77ED8PhUmG1m1iIyhB7czsigrCZVUL17vX
         SGuBRWLiQce/Uz72Xp14gQe78YH5/Xw/gHfOM5TLAgZrK64zihBeoLVUc5oom125Z7Gh
         RbHE8cfZD5kgwFtv4w4cH8gwGMQFaoAQliiXH3fd5ytmX9yH9Ig4nBazn3+d78xvfF/d
         htwA==
X-Gm-Message-State: ACgBeo0DjIW+eKnyufINoKRoZdIRcOJ6i8vJjyhD4po28pvEfw8LgNO5
        GkrQ8a1YwPkCvgF8+JUZFilO5A==
X-Google-Smtp-Source: AA6agR4w3Nnpwf/WjisKPRrE5NoCgmKppxM4PGZuaqAvgApoCvnpQhOKLT/Y+07a+cr2+cn1CYjCSg==
X-Received: by 2002:a17:902:ba83:b0:16a:2917:73de with SMTP id k3-20020a170902ba8300b0016a291773demr4407166pls.2.1659665563891;
        Thu, 04 Aug 2022 19:12:43 -0700 (PDT)
Received: from ?IPv6:::1? ([2607:fb90:3328:1fc5:9fd3:a882:8500:2baa])
        by smtp.gmail.com with ESMTPSA id t9-20020aa79469000000b0052b7f0ff197sm1704192pfq.49.2022.08.04.19.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 19:12:43 -0700 (PDT)
Date:   Thu, 04 Aug 2022 19:12:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PM: core: Do not randomize struct dev_pm_ops layout
User-Agent: K-9 Mail for Android
In-Reply-To: <2643836.mvXUDI8C0e@kreacher>
References: <2643836.mvXUDI8C0e@kreacher>
Message-ID: <FA016A79-B2B1-42A4-A63F-3A44B3EC57CB@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On August 4, 2022 10:15:08 AM PDT, "Rafael J=2E Wysocki" <rjw@rjwysocki=2E=
net> wrote:
>From: Rafael J=2E Wysocki <rafael=2Ej=2Ewysocki@intel=2Ecom>
>
>Because __rpm_get_callback() uses offsetof() to compute the address of
>the callback in question in struct dev_pm_ops, randomizing the layout
>of the latter leads to interesting, but unfortunately also undesirable
>results in some cases=2E

How does this manifest? This is a compile-time randomization, so offsetof(=
) will find the correct location=2E Is struct dev_pm_ops created or consume=
d externally from the kernel at any point?

-Kees

>
>Prevent that from happening by using the __no_randomize_layout
>annotation on struct dev_pm_ops=2E
>
>Signed-off-by: Rafael J=2E Wysocki <rafael=2Ej=2Ewysocki@intel=2Ecom>
>---
> include/linux/pm=2Eh |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>Index: linux-pm/include/linux/pm=2Eh
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>--- linux-pm=2Eorig/include/linux/pm=2Eh
>+++ linux-pm/include/linux/pm=2Eh
>@@ -307,7 +307,7 @@ struct dev_pm_ops {
> 	int (*runtime_suspend)(struct device *dev);
> 	int (*runtime_resume)(struct device *dev);
> 	int (*runtime_idle)(struct device *dev);
>-};
>+} __no_randomize_layout;
>=20
> #define SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> 	=2Esuspend =3D pm_sleep_ptr(suspend_fn), \
>
>
>

--=20
Kees Cook
