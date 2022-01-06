Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF24486870
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241805AbiAFR1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:27:01 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:43583 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241717AbiAFR0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:26:53 -0500
Received: by mail-qk1-f171.google.com with SMTP id f138so3332293qke.10;
        Thu, 06 Jan 2022 09:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5Mh5bVpmK8eYyep3yxqYOdNWT89jlaMb60StPy485A=;
        b=cKPai63QXCOULd+JYweRNthK+EFz4BKyWWc8Q5dbhzW41L8rnpF7LhT7X5pxDLaW9T
         Qm4ynb54PiW3ktsE0anNODJoPIoDyg7P6NkMitAiSomzaeYB4OLfDaKug8WQMZNXn9YV
         FoRyt2y14r71al3XrKlCjP346fIRL+h4ncfzsEtQDZLi/zHxpIW6fW4ITf3+lpyo7wz+
         QPCcTX67aVI9DVaqOFqdbcLvvsDZY6SvcaRzzDloTtMgMoeyGRQ7CBD9qz/0CsO0k8dF
         NcKGcpmGwuHO3khUe2ELXH7OcEGrVZ/cD8e/Nr+qpIRO/eegkPNJtZjLPIbgxWbdX76y
         OjFw==
X-Gm-Message-State: AOAM531m0madbb1ipaw+g4/Bv8HYBNH/qmr12aSK0Js8M0KzR1mv8EYa
        xEY7OZXYYqTnpNN2yShzpBMnzEYdT0yhFz1uGaE=
X-Google-Smtp-Source: ABdhPJxtsqp8aUZfHoLl5dtQbIUKostepyMhKdNiM8HK9Tx9ep8MgjIudv2L7QVSqHIgf5RaQYlkr87oh5ASoEKjMSY=
X-Received: by 2002:a05:620a:4721:: with SMTP id bs33mr43755838qkb.8.1641490012648;
 Thu, 06 Jan 2022 09:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20220104164351.1360316-1-gregkh@linuxfoundation.org>
In-Reply-To: <20220104164351.1360316-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Jan 2022 18:26:41 +0100
Message-ID: <CAJZ5v0jS3NBSiO0W+phmP3wQUN4fJpRv4_ogG6EXA6dHbcr3Yg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: use default_groups in kobj_type
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 5:43 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the cpuidle sysfs code to use default_groups field which
> has been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/cpuidle/sysfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index 469e18547d06..565ed005833a 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -335,6 +335,7 @@ static struct attribute *cpuidle_state_default_attrs[] = {
>         &attr_default_status.attr,
>         NULL
>  };
> +ATTRIBUTE_GROUPS(cpuidle_state_default);
>
>  struct cpuidle_state_kobj {
>         struct cpuidle_state *state;
> @@ -448,7 +449,7 @@ static void cpuidle_state_sysfs_release(struct kobject *kobj)
>
>  static struct kobj_type ktype_state_cpuidle = {
>         .sysfs_ops = &cpuidle_state_sysfs_ops,
> -       .default_attrs = cpuidle_state_default_attrs,
> +       .default_groups = cpuidle_state_default_groups,
>         .release = cpuidle_state_sysfs_release,
>  };
>
> @@ -591,10 +592,11 @@ static struct attribute *cpuidle_driver_default_attrs[] = {
>         &attr_driver_name.attr,
>         NULL
>  };
> +ATTRIBUTE_GROUPS(cpuidle_driver_default);
>
>  static struct kobj_type ktype_driver_cpuidle = {
>         .sysfs_ops = &cpuidle_driver_sysfs_ops,
> -       .default_attrs = cpuidle_driver_default_attrs,
> +       .default_groups = cpuidle_driver_default_groups,
>         .release = cpuidle_driver_sysfs_release,
>  };
>
> --

Applied as 5.17 material, thanks!
