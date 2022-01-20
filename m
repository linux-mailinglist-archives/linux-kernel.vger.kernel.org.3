Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4D84945CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 03:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358208AbiATCZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 21:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358204AbiATCZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 21:25:30 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89493C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 18:25:30 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id x7so15919888lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 18:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=py1R6hBTeextxqIqIZAUb6qP1RluD2ICHuOhsBmhdMs=;
        b=Rs1yORG1XKC8zdQxpvOqgjDUvMir+QHBGCTfgTN6nupgdPiTE1sHhp7CF4yn8C2wi4
         gL6dZzZ3P1oaAqAkhi5Ea/ztP1WHJ4GVsnZqriZax2ZY6eDUHYiSgjnwrAJ+Jx4QTeP2
         gd0Jt5fYvLQYKUuYnxuZHG4mReaOOj8SLig/o5t++QXzyAOJs4eHYs7dZBamvaid/sYC
         WIH+8WjjFdg1L4ZYeioRrbNZmNLjUEPWScnnVJ6v96VTDfkMlITMnZlLJYJvRl7+AFmc
         UmjVdu37xU3b5TEzHGBWdgGnXjVysrDm4kttltetNCvQI6KOOGnDnjbLTQ119bEZB5N6
         7w3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=py1R6hBTeextxqIqIZAUb6qP1RluD2ICHuOhsBmhdMs=;
        b=1LN81NE/zha51mH62EY72Q59nscqkugRkEI5jIAEuMn9ukodN6RjJ0+QY8rT012rEO
         d5Jwt+skPgQHqrB8634iabf+XMYeSaK8sxwwWlQaGFIFqk+OF0a2Jpo637LoBjDw/Z5p
         lCeOOaoOULeQnP/PcknUXNTUmQp1aO8pQke3E4BYmGNpmeObJmhcwxIAj0iMr6EbnWow
         MK5q1KgrV+GqouD65Gt9HAU+qrwzC9PZyg0UnQyQ6iuSzxWdwfKC/fVWKtLdOqTE/v1S
         RTr7Fjf+dsTGKCF9ZeqXQgXfEg7/g6hvfYxpX9/pHUd/xfQF35FKTnEr8fC/ejwcDa/P
         UBgw==
X-Gm-Message-State: AOAM531Gamd3SSGFW6cvYqAW4IF/IjIN+8PhD1x7CuwKaKDSxmEuQ75r
        6Bq2OZtw2Z8v5XYXYHRHr3tpgtJoQdYY4TUUKpGMtA==
X-Google-Smtp-Source: ABdhPJwE2rL4bwMl/8llwM7+/yaIYfui/bPGeEUtXEAvfetfJcgZHU0Qrq7c0XQm5lapUm42+97q1DX2SClu9HzdKIY=
X-Received: by 2002:a2e:9c10:: with SMTP id s16mr15271700lji.280.1642645527973;
 Wed, 19 Jan 2022 18:25:27 -0800 (PST)
MIME-Version: 1.0
References: <20220120000409.2706549-1-rajatja@google.com>
In-Reply-To: <20220120000409.2706549-1-rajatja@google.com>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Wed, 19 Jan 2022 18:25:11 -0800
Message-ID: <CAE_wzQ_XxONXx5bgDNLAWM_UbV0r8hP9fW6s5sgRYRVSHQWjLw@mail.gmail.com>
Subject: Re: [PATCH] PCI: ACPI: Allow internal devices to be marked as untrusted
To:     Rajat Jain <rajatja@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajatxjain@gmail.com,
        jsbarnes@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

On Wed, Jan 19, 2022 at 4:04 PM Rajat Jain <rajatja@google.com> wrote:
>
> Today the pci_dev->untrusted is set for any devices sitting downstream
> an external facing port (determined via "ExternalFacingPort" property).
> This however, disallows any internal devices to be marked as untrusted.
>
> There are use-cases though, where a platform would like to treat an
> internal device as untrusted (perhaps because it runs untrusted
> firmware, or offers an attack surface by handling untrusted network
> data etc).
>
> This patch introduces a new "UntrustedDevice" property that can be used
> by the firmware to mark any device as untrusted.
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/pci/pci-acpi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a42dbf448860..3d9e5fa49451 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1350,12 +1350,25 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
>                 dev->external_facing = 1;
>  }
>
> +static void pci_acpi_set_untrusted(struct pci_dev *dev)
> +{
> +       u8 val;
> +
> +       if (device_property_read_u8(&dev->dev, "UntrustedDevice", &val))
> +               return;
> +
> +       /* These PCI devices are not trustworthy */
> +       if (val)
> +               dev->untrusted = 1;

Should this all be replaced with:

dev->untrusted = device_property_read_bool(&dev->dev, "UntrustedDevice");

?

Also, is this ACPI-specific? Why won't we need this for DT systems (or
do we already have this)?.

Thanks,
Dmitry
