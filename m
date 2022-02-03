Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1896F4A9013
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355299AbiBCVlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355169AbiBCVk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:40:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB486C061714;
        Thu,  3 Feb 2022 13:40:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F700B835AE;
        Thu,  3 Feb 2022 21:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7D7C340F0;
        Thu,  3 Feb 2022 21:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643924456;
        bh=kFckNU1ZizTo6xCiEOr5zJellumfmnajUCSZP4HD5Oc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WE1Cke65LfqrirHXfptPY6xOvi4enWXoi0rucjD4XbRpUWX3joZ+Po/rRQpDbCTKs
         8rwMDw4lT8PwXeOqkK1EsGEkmy+XLddce/JArzQyAOrsF495dWcsk+MCuZQSqnwFhd
         hrJN9zDRD5YBo3AK3WUprhKjVa9NflTaQbFvGhSHfzBLDbDNoyCdnLGjblRcgzYqnS
         6/kUQ3sZh4Ydf6nj5lJsvXFxR+mrJGFHh4P7y/h4ONf2tcIit0cputMhg3tYSpD7gw
         P6SQ55MytaKfymYfkAdrABe140V4s9oGJsuxlE2AWe3pzdW3xa+ZW7YntOZ+IsGy9H
         kiD7i4UWH5JJA==
Received: by mail-ej1-f46.google.com with SMTP id j2so12672684ejk.6;
        Thu, 03 Feb 2022 13:40:56 -0800 (PST)
X-Gm-Message-State: AOAM533vKA9aj88xAiVmX8S5QNcREFm1COJ8Xu7qLH1P3q/ZV4q9ipp5
        0Ql4xod7MtnHCc/npewb3ugDiNkHGLNUEQc9Gw==
X-Google-Smtp-Source: ABdhPJyVD5aUcVjFLsHVEhlkVnpzGqjhjJUUAmPUcPuSXmQIPKMo74wBtJ3E3QwaERBvdayXJrtV8GD2WyBC7VqzoJY=
X-Received: by 2002:a17:907:7f1a:: with SMTP id qf26mr25008004ejc.20.1643924454599;
 Thu, 03 Feb 2022 13:40:54 -0800 (PST)
MIME-Version: 1.0
References: <20220203211150.2912192-1-frowand.list@gmail.com>
In-Reply-To: <20220203211150.2912192-1-frowand.list@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 3 Feb 2022 15:40:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKMZWMtvdTvYHmWkd5CmehKJexJVv_BUBENrMPOf002+w@mail.gmail.com>
Message-ID: <CAL_JsqKMZWMtvdTvYHmWkd5CmehKJexJVv_BUBENrMPOf002+w@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: unittest: print pass messages at same loglevel as fail
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 3:12 PM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> Printing the devicetree unittest pass message for each passed test
> creates much console verbosity.  The existing pass messages are
> printed at loglevel KERN_DEBUG so they will not print by default.
>
> Change default to print the pass messages at the same loglevel as
> the fail messages.
>
> The test community expects either a pass or a fail message for each
> test in a test suite.  The messages are typically post-processed to
> report pass/fail results.
>
> Suppressing printing the pass message for each individual test is
> available via the kernel command line parameter unittest.hide_pass.
>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>  drivers/of/unittest.c                           | 17 ++++++++++++++++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f5a27f067db9..045455f9b7e1 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5997,6 +5997,10 @@
>                         Note that genuine overcurrent events won't be
>                         reported either.
>
> +       unittest.hide_pass

Can we rename the module name to include 'dt' so we're not taking a
generic name.

> +                       Disable printing individual drivers/of/unittest test
> +                       pass messages.
> +
>         unknown_nmi_panic
>                         [X86] Cause panic on unknown NMI.
>
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 70992103c07d..2cfbdc6b29ac 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -12,6 +12,7 @@
>  #include <linux/errno.h>
>  #include <linux/hashtable.h>
>  #include <linux/libfdt.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_fdt.h>
> @@ -32,6 +33,19 @@
>
>  #include "of_private.h"
>
> +MODULE_LICENSE("GPL v2");
> +static bool hide_pass;
> +
> +static int __init hide_pass_setup(char *str)
> +{
> +       hide_pass = true;
> +       return 0;
> +}
> +
> +early_param("hide_pass", hide_pass_setup);
> +module_param(hide_pass, bool, 0);
> +MODULE_PARM_DESC(hide_pass, "Disable printing individual of unittest pass messages");
> +
>  static struct unittest_results {
>         int passed;
>         int failed;
> @@ -44,7 +58,8 @@ static struct unittest_results {
>                 pr_err("FAIL %s():%i " fmt, __func__, __LINE__, ##__VA_ARGS__); \
>         } else { \
>                 unittest_results.passed++; \
> -               pr_debug("pass %s():%i\n", __func__, __LINE__); \
> +               if (!hide_pass) \
> +                       pr_err("pass %s():%i\n", __func__, __LINE__); \

Would 'PASS' be better here to align with FAIL?

If we make this info level, then you can filter with dmesg and also
seems to be aligned with what kunit does.


Rob
