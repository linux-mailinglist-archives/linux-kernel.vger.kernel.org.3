Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684EC57801E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiGRKsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbiGRKsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:48:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D869B1F2E2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:48:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b11so20405675eju.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4oRak+C2KluI48BtBgPjPXk/AjJSdRg3YOHC7j1IJKc=;
        b=xCzpO+0vKd22GOhNS1gpEGBGfBEZxh6GUzkKqmPMQhJ67hvOqoR2/zJc88DP/6ChMG
         h2DJL9SJMDPhUNWDfpFIl9pl3RvditxQW06A8rSrycYLo0YuvzMnR9xSh0xrG7vjfuun
         3rZXgUni7hrSCJe8aTi2GnHOO6XrnwL4UGzXL53yMXrP+dEXJJlQyjnnvJ5D9tK6pwll
         9dPJJyMUPEFGC8rkIp6SYXmpqnaop/gDPaMNgf9I5prw1zQwY1JgKviM1xC5SkAx/gU3
         qzWgQ8fDM6CqpJopBJsI/g6wlk21hyiELyGfp79nJGDq8h5NxRsfZA24wEY7LZ74PYtO
         l3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4oRak+C2KluI48BtBgPjPXk/AjJSdRg3YOHC7j1IJKc=;
        b=loTHy01S+XtOX9xENq+aROpxsGiq0AHsrmXiR0tJlCbth3YpHstCOlkm7O/F1SsY8E
         aaS963K6qu6dAJsqKT8usQAWzCpiavjrt1UZ4h1q69FwKrubMFolPHt8JYGyy7MSy1R8
         NNZDVBTAEQSGnOdAvE4R+zc0sMCraRDuzbv0r+MtfEQTl33Icf5omgGwLw1Ew1aQSk1S
         umsJgCVekiH5mLgaiMJgbn3npk0m2kUYLNjUIY7OlGOOYpG4HLLXn5Sk7fvwM8wI3+B3
         JQqkfN7tkTvOfdj5X7Ju+LK/69O7/0B8nXNRtQu1ej0S7B0ytnIfqyNXChmQMFkCILVR
         u/xw==
X-Gm-Message-State: AJIora/Plag9r/30I6vvd29qIPP7fqn/mMZrCGheX1XeF/DVTgJEI7U4
        ay6L4i29M25SBA+UAZm7UvSIf7GZVnQOc90TA1gb5w==
X-Google-Smtp-Source: AGRyM1v58741g9YF1j3O3YhZhbaaALkEvMwjbuiSWX6eGAUC4RwB+foXNRxi9DundUhsUPDjhOqkyanAVMGdqiE8fM4=
X-Received: by 2002:a17:907:a053:b0:72b:3051:b79b with SMTP id
 gz19-20020a170907a05300b0072b3051b79bmr23902331ejc.690.1658141303429; Mon, 18
 Jul 2022 03:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220713175950.964-1-mario.limonciello@amd.com>
In-Reply-To: <20220713175950.964-1-mario.limonciello@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 12:48:11 +0200
Message-ID: <CACRpkdbcP32Bi51pHOJQM6d-0NgaHxSmxwvEsxmk4PoO1R0Fqg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Don't allow PINCTRL_AMD to be a module
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Basavaraj.Natikar@amd.com, madcatx@atlas.cz,
        jwrdegoede@fedoraproject.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 8:00 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> It was observed that by allowing pinctrl_amd to be loaded
> later in the boot process that interrupts sent to the GPIO
> controller early in the boot are not serviced.  The kernel treats
> these as a spurious IRQ and disables the IRQ.
>
> This problem was exacerbated because it happened on a system with
> an encrypted partition so the kernel object was not accesssible for
> an extended period of time while waiting for a passphrase.
>
> To avoid this situation from occurring, stop allowing pinctrl-amd
> from being built as a module and instead require it to be built-in
> or disabled.
>
> Reported-by: madcatx@atlas.cz
> Suggested-by: jwrdegoede@fedoraproject.org
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216230
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Patch applied for fixes!
Excellent root causing.

Yours,
Linus Walleij
