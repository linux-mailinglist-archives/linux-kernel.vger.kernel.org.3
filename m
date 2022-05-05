Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3ED51C8A4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348871AbiEETHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384766AbiEETHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:07:38 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31454B848;
        Thu,  5 May 2022 12:03:56 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2ec42eae76bso58989917b3.10;
        Thu, 05 May 2022 12:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+d8jggKU6mOKErS+3k+HsyBKNRPIov5SQeHSvQ1qwKo=;
        b=fQGIewobS+NxJ3Q/9NPbYOQk4TeZTNA/GC2OYM9xhYU/2oWAU3pkTbCqnshLMi3A7F
         ZhUHvbn+1tSAuPBGojUo2y+Eo/rVpU5bQ4bbBD0Gg33XSd2mEqmmp6rBhPRCTFIYXAdy
         dQihFlLpWqUyslwQa9Ei0IG7wJ+AWlMpCyN1lwedboTJ0+RAi7vt++phfaSy19yGRv+f
         T4cqsyj++/t51GV47dlrv5EGvPCz/pwwLkfAx7diNj+p6UeIGqenEdQhLLdxtqI09Xo7
         OzCG/9M4IEIkBuyeQoNbGRxZhT0vGZOBX4OKFmXMje0pZ80wRKbvDnZhC36Kavf+aGXS
         rPmw==
X-Gm-Message-State: AOAM533sZJcVeecEtNtt9cQL519r8V6cVE655pikWQ+mtJJ9/0NLRrDV
        ZvxJDyufkSsEjxqg2nvYO2jdHj08SljWzExxzFA=
X-Google-Smtp-Source: ABdhPJw0KSCRp0CU4bSgUXmkXfGzcdWqfUroHgnRsTqE2GhIvIoHR9UIMvNgJwnp/08BKbH/c/lEqwZnq5cmCr50vNA=
X-Received: by 2002:a81:8493:0:b0:2f7:d7c3:15f8 with SMTP id
 u141-20020a818493000000b002f7d7c315f8mr26060015ywf.196.1651777435904; Thu, 05
 May 2022 12:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220428062430.31010-1-paul.gortmaker@windriver.com> <20220428062430.31010-3-paul.gortmaker@windriver.com>
In-Reply-To: <20220428062430.31010-3-paul.gortmaker@windriver.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 May 2022 21:03:45 +0200
Message-ID: <CAJZ5v0gkQqb-R1y_ZaPKTTiBNJYeNZd1csX=x_FkM9QxrR=pxA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ACPI: LPSS: make the Kconfig dependency on PMC_ATOM explicit
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 8:25 AM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> The code in acpi_lpss.c has been unconditionally using pmc_atom_read()
> for about the past six years.  This hasn't been a problem since you
> currently can't disable PMC_ATOM short of disabling PCI entirely.
>
> But it doesn't need to be that way, and so that we can change Kconfigs
> in a subsequent commit, we make sure LPSS selects PMC_ATOM in advance,
> so that existing .config files can live on with "make oldconfig".
>
> In theory, one could make LPSS build w/o PMC_ATOM, similar to what it
> did six years ago, but I doubt there is any demand for that now.

You probably are right and it will get some more build test coverage
with respect to the other option, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  arch/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2ee26f10a814..163c198ec8ec 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -654,6 +654,7 @@ config X86_INTEL_LPSS
>         select COMMON_CLK
>         select PINCTRL
>         select IOSF_MBI
> +       select PMC_ATOM
>         help
>           Select to build support for Intel Low Power Subsystem such as
>           found on Intel Lynxpoint PCH. Selecting this option enables
> --
> 2.17.1
>
