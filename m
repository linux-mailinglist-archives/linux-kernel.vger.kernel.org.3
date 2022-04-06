Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2254F621A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiDFOni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbiDFOm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:42:57 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72FA5C887F;
        Wed,  6 Apr 2022 04:08:42 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2eba37104a2so22653377b3.0;
        Wed, 06 Apr 2022 04:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzsexMcHMCLiGQSiBjepjns9mFGB9BcIcuR+s6bhzUg=;
        b=uiWCEROjsLHy4fAN3z+Tee9BN7JWU5U6TWVM2+csx5YO/b7+DF9r5ZHxQzNhnp/Noz
         EATZh4SF7v6MXLbzYWH5uQdujQ5a+kIcjrNUgsuv2uvI0aHh/kR3xAC8v/J1tsj297qP
         fdhPXG6juE752bivtRolsEt++lhobOaziFE1asYb/J2tYdSZ6q3ok8+TQfVKHwf/VHtL
         QJyAgxyegNb36UQ3IuyLnzXJCFbnCgrqSTQ14liEsefSlNpfj7MTPBbABTNT8aE8vEHu
         0qkR5OG08iINn5vuaafsx8jwmCLtR8J5mX6FTbIfOq5LYvQ7/YTiNJ5M/+IDZbCIibdo
         EtOQ==
X-Gm-Message-State: AOAM533DiNC0X8sc91zZYixJM8NPIyEE9jm0aCrgGiPZZ8eOj+OKUyxv
        Ubz9fGShdssZSwhxhhvxZrPCfXezy7m+HZoDGInDhy8Bfds=
X-Google-Smtp-Source: ABdhPJzSj1+EHlt9b1DbyxrdfqL/RZSTw4gilvTwM+LhObx1IuDbXuoeAuMhPw9PCu3OReO259BkU4DTj4H2bvEY2zk=
X-Received: by 2002:a81:1549:0:b0:2eb:3dc7:bd16 with SMTP id
 70-20020a811549000000b002eb3dc7bd16mr6568724ywv.7.1649243321766; Wed, 06 Apr
 2022 04:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <5817980.lOV4Wx5bFT@kreacher> <Ykx2mOzf/xy8NMXr@sirena.org.uk>
In-Reply-To: <Ykx2mOzf/xy8NMXr@sirena.org.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Apr 2022 13:08:29 +0200
Message-ID: <CAJZ5v0gSCkEu8DuHGJEfH9cZ+e4ojyx7NZYtPFB2-OPYdT-QVQ@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: bus: Eliminate acpi_bus_get_device()
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 3:48 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Apr 05, 2022 at 06:57:10PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Replace the last instance of acpi_bus_get_device(), added recently
> > by commit 87e59b36e5e2 ("spi: Support selection of the index of the
> > ACPI Spi Resource before alloc"), with acpi_fetch_acpi_dev() and
> > finally drop acpi_bus_get_device() that has no more users.
>
> Acked-by: Mark Brown <broonie@kernel.org>

Thanks!

> Or I can take this via the SPI tree?

I'm going to push this for -rc2 so acpi_bus_get_device() is not there
in case somebody has a plan to use it again. :-)
