Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5904D517A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbiCJTUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbiCJTUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:20:34 -0500
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A0C266C;
        Thu, 10 Mar 2022 11:19:32 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id u3so12868748ybh.5;
        Thu, 10 Mar 2022 11:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RsZ3zXGw1xKWGbwqOAoJ3iWwiAdQKU/G/m5iJq8ngBs=;
        b=TqjosO+kDrRHp0Nm1/x7xbob+lAO+bjQldG4Yk1r/94x2AuPh+LqedNWwEJeytv/4P
         sWFozjU5E9DwHXaGXYw4ZZECEmZHuEebYSYtmD4pt55TMkpg/we8r6HUHDb/0FkTBIkt
         EGn2E8R8vU6WpOdWVfUlKq7hPRun/7IuJyapWqji5EL06PeNBy8gBB+WNfLGttdPerJz
         wbtw41ahtkiA/epVlIzpJlPq0hII9fJOqvD2UZHb6eGnrIZpY0XdvVTg46hSDpXC5xTp
         CXtDaet4Uz+VzwVe/S9XKB8Cxxp6yTYsJjQZlyk+T/Bi3oK7kc3nSENt4Uru/2mO3h/l
         SjMw==
X-Gm-Message-State: AOAM533UqW1HmKR56LXVj+J2E98mDYuWySvHGsx6rv93KpltbcqPblqX
        aC3R08PoGuaFC9hC8uFMY5/3dzhezmPkSywGEwM=
X-Google-Smtp-Source: ABdhPJwzdvxZaw5N4g/ICTjGlkN/17w0aoXA26cjkq/DTm08OWp+q0EfHKjM3aQPrhzB3c1ppgNlyJTsryVMtKpDRAk=
X-Received: by 2002:a25:3a41:0:b0:628:86a2:dbc with SMTP id
 h62-20020a253a41000000b0062886a20dbcmr5000136yba.633.1646939970903; Thu, 10
 Mar 2022 11:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20220309020750.65399-1-ilkka@os.amperecomputing.com>
 <20220309020750.65399-3-ilkka@os.amperecomputing.com> <YinAtUVV5e24r34j@lpieralisi>
In-Reply-To: <YinAtUVV5e24r34j@lpieralisi>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Mar 2022 20:19:20 +0100
Message-ID: <CAJZ5v0ggVdrc9a0kFe4uu7r_B3rH393iN2c2FsJ7OUQf8jd89A@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] ACPI: AGDI: Add driver for Arm Generic Diagnostic
 Dump and Reset device
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        James Morse <james.morse@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        Darren Hart <darren@os.amperecomputing.com>
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

On Thu, Mar 10, 2022 at 10:11 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, Mar 08, 2022 at 06:07:50PM -0800, Ilkka Koskinen wrote:
> > ACPI for Arm Components 1.1 Platform Design Document v1.1 [0] specifices
> > Arm Generic Diagnostic Device Interface (AGDI). It allows an admin to
> > issue diagnostic dump and reset via an SDEI event or an interrupt.
> > This patch implements SDEI path.
> >
> > [0] https://developer.arm.com/documentation/den0093/latest/
> >
> > Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/acpi/arm64/Kconfig  |  10 ++++
> >  drivers/acpi/arm64/Makefile |   1 +
> >  drivers/acpi/arm64/agdi.c   | 116 ++++++++++++++++++++++++++++++++++++
> >  drivers/acpi/bus.c          |   2 +
> >  include/linux/acpi_agdi.h   |  13 ++++
> >  5 files changed, 142 insertions(+)
> >  create mode 100644 drivers/acpi/arm64/agdi.c
> >  create mode 100644 include/linux/acpi_agdi.h
>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Both patches in the series applied as 5.18 material, thanks!
