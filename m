Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B56152F5D1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 00:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiETWoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 18:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbiETWoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 18:44:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAC919FB0E
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:44:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id er5so12399535edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BKPudRHbttJcLyjKjpiyZYvJ7LnbTP0JY0qSwMBvUr4=;
        b=Af0+D8Ms8xIY23vBD3Lz9KxxFdwPqgs77iFuhxqXNylJe7nYNsLSz4qTZRUD+N2Nf/
         fcBPr1fsu0LFbU5hADuVGe4RhelcuRQxsqEUOiE0WKyahoJqVPBJHAqV2MVMSYIDVeVs
         E50K/zS8oTaI3aAGYafxdMI7oCw5w6CNkRXL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BKPudRHbttJcLyjKjpiyZYvJ7LnbTP0JY0qSwMBvUr4=;
        b=7K0UGwpBcIb49Gzv1MS5h7ek90t2xg/XxUvNtsokQORHaDBxBAvoOXQNqbor0DsktX
         +4EdQk8cpsX0D58infvms7jOZjoUKWoygVwY0XRMWU2KS8/zhx2iDinWxxUDEP/nz4Jx
         ijBW+o9fCdOV8XRLXvUzOKFqfrwdKJFMRB0oAexPaz65YlgXU+XGgxvU3UZe3gqX+RyS
         rFgh1GxXa9m+bwF/zVq0o7nFKr+X6Do1NfPRQ93vVT559pMD7OlXrJjp4/6SpZjcdVwm
         Bp/Mvu4kws9KRsznTnF0mxGNS5LNYdfRsh6qmpljOhvgs225waF5UIzrM2np0IfiJd28
         bf7w==
X-Gm-Message-State: AOAM531yJoeDOXDwvORg/JPNgT3j4ztK20ogKMd2WGBOc8Kh4/Tk2zCc
        MAgZopW/jXm4/pZM1drNfo46XD26IA2KjLDzlSI=
X-Google-Smtp-Source: ABdhPJx8vEUA6wXHlYxEcMUvsLullAvEf00DXSjehv/EPAEODxn0bnAoW2jgbAmkFN8+cLIxXz1tKA==
X-Received: by 2002:a05:6402:23a9:b0:42b:228:5df with SMTP id j41-20020a05640223a900b0042b022805dfmr7265648eda.63.1653086652539;
        Fri, 20 May 2022 15:44:12 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id k26-20020aa7c39a000000b0042617ba63cbsm4854330edq.85.2022.05.20.15.44.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 15:44:12 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso7594987wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:44:12 -0700 (PDT)
X-Received: by 2002:a05:600c:4f13:b0:394:8978:7707 with SMTP id
 l19-20020a05600c4f1300b0039489787707mr10638855wmq.34.1653086651600; Fri, 20
 May 2022 15:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220518150150.1.Ie8ea0e945a9c15066237014be219eed60066d493@changeid>
In-Reply-To: <20220518150150.1.Ie8ea0e945a9c15066237014be219eed60066d493@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 May 2022 15:43:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UPQV-ocuz0ovvhY0DOqUdx=-uuqMKVaDRo05=PS9vR9w@mail.gmail.com>
Message-ID: <CAD=FV=UPQV-ocuz0ovvhY0DOqUdx=-uuqMKVaDRo05=PS9vR9w@mail.gmail.com>
Subject: Re: [PATCH] usb: Probe EHCI, OHCI controllers asynchronously
To:     Brian Norris <briannorris@chromium.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 18, 2022 at 3:04 PM Brian Norris <briannorris@chromium.org> wrote:
>
> From: Dmitry Torokhov <dtor@chromium.org>
>
> initcall_debug shows that OHCI controllers take ~60ms to probe on
> Rockchip RK3399 systems:
>
>   probe of fe3a0000.usb returned 1 after 58941 usecs
>
> A few of these can add up to waste non-trivial amounts of time at boot.
>
> These host controllers don't provide resources to other drivers, so
> this shouldn't contribute to exposing race conditions.
>
> Chrome OS kernels have carried this patch on some systems for a while
> without issues. Similar patches have been merged for a variety of (e)MMC
> host controllers for similar reasons.
>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> [Brian: rewrote commit message, refreshed, but retained dtor's original
>  authorship ]
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
>  drivers/usb/host/ehci-platform.c | 1 +
>  drivers/usb/host/ohci-platform.c | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
