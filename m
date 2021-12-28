Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A31480C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbhL1SQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 13:16:56 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:33654 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbhL1SQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:16:51 -0500
Received: by mail-qt1-f173.google.com with SMTP id v4so14262363qtk.0;
        Tue, 28 Dec 2021 10:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hPyQaAtpdsCwtq9cD65/s5Z3KHHM6Rn5LsO9cVRzow=;
        b=mnFJ+BdH61WUAb36B0GP92zv8CSOP5Gq9Rgt4wX78jf9IYLmqaXxtFR9spX9q8YaFy
         LEpfo0arxsxHzwPFUXQScctDPUrbJp9plSu8Ujy016bZ4Hog7/sfEFTPIfeqIwWhD6/K
         PE2MDPXZ9TmVUFgVdZuRYTsrovgGCMLs0TUtDqqiEX4KYZq6lhxFBLuReKrokHUycPBi
         G9z/9GPe4DC//B1WjM87Y4RpILrqM71ga8foajSwe7hdVhFqyLohT8+0xXHx2S00ZyAo
         LWm2/Hpb0e88KYfHrv76Q49YivX/NqBuZN1XmKbLFoTmLrufHBwHPCrf2C26u8iSJdqJ
         NseQ==
X-Gm-Message-State: AOAM532I6Ob1qiZI9B+iyVFy/VQMButYEHyygkx9NmeBsJwLYs7lglWe
        our0qlfLMyuSxc31tLsKPsLEdz2FEmzQaKq4ESUrwoTi
X-Google-Smtp-Source: ABdhPJy0FQvrGDJagrmzJ0UpRfk/9sKYxxSpvUc6QZgwVhbcCzrxB30RickELfWkkghjclbA12JNzMbCyzTwEDfzI+g=
X-Received: by 2002:ac8:5c91:: with SMTP id r17mr20319911qta.18.1640715410911;
 Tue, 28 Dec 2021 10:16:50 -0800 (PST)
MIME-Version: 1.0
References: <20211228131423.249752-1-gregkh@linuxfoundation.org>
In-Reply-To: <20211228131423.249752-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Dec 2021 19:16:40 +0100
Message-ID: <CAJZ5v0jyuVjMeM4t+M28e6R9MYxh=nVU7i2tgvGWF3Y7PrB+rQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: sysfs: use default_groups in kobj_type
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 2:14 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the ACPI sysfs code to use default_groups field which has
> been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied as 5.17 material, thanks!

> ---
>  drivers/acpi/cppc_acpi.c    | 3 ++-
>  drivers/acpi/device_sysfs.c | 3 ++-
>  drivers/acpi/sysfs.c        | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a85c351589be..d251b2a1cd15 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -179,10 +179,11 @@ static struct attribute *cppc_attrs[] = {
>         &lowest_freq.attr,
>         NULL
>  };
> +ATTRIBUTE_GROUPS(cppc);
>
>  static struct kobj_type cppc_ktype = {
>         .sysfs_ops = &kobj_sysfs_ops,
> -       .default_attrs = cppc_attrs,
> +       .default_groups = cppc_groups,
>  };
>
>  static int check_pcc_chan(int pcc_ss_id, bool chk_err_bit)
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 61271e61c307..d5d6403ba07b 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -53,6 +53,7 @@ static struct attribute *acpi_data_node_default_attrs[] = {
>         &data_node_path.attr,
>         NULL
>  };
> +ATTRIBUTE_GROUPS(acpi_data_node_default);
>
>  #define to_data_node(k) container_of(k, struct acpi_data_node, kobj)
>  #define to_attr(a) container_of(a, struct acpi_data_node_attr, attr)
> @@ -79,7 +80,7 @@ static void acpi_data_node_release(struct kobject *kobj)
>
>  static struct kobj_type acpi_data_node_ktype = {
>         .sysfs_ops = &acpi_data_node_sysfs_ops,
> -       .default_attrs = acpi_data_node_default_attrs,
> +       .default_groups = acpi_data_node_default_groups,
>         .release = acpi_data_node_release,
>  };
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 00c0ebaab29f..a4b638bea6f1 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -939,10 +939,11 @@ static struct attribute *hotplug_profile_attrs[] = {
>         &hotplug_enabled_attr.attr,
>         NULL
>  };
> +ATTRIBUTE_GROUPS(hotplug_profile);
>
>  static struct kobj_type acpi_hotplug_profile_ktype = {
>         .sysfs_ops = &kobj_sysfs_ops,
> -       .default_attrs = hotplug_profile_attrs,
> +       .default_groups = hotplug_profile_groups,
>  };
>
>  void acpi_sysfs_add_hotplug_profile(struct acpi_hotplug_profile *hotplug,
> --
> 2.34.1
>
