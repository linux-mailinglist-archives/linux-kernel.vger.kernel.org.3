Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808C8479425
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbhLQShO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbhLQShN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:37:13 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1F1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 10:37:13 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y7so2623644plp.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 10:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jw3+o9tkTtZaFXuWp2piyMoDxF7elmFPwWeoUWpMXV8=;
        b=xEH1wEdUSk1xmiYH6ttaReiH5aeghdNG1EYWe4VzJd8UpXsRJ0qf7fKQwfbfjoAiMD
         qQRbrVQCNbFP0y2sBr7RPCzh8bk/vDdf0kLIHuaWJMfnressCyvgbEr13bk0uidFYB1a
         y+GFFrk8YicAA8/KS/HEyqWKedlu8bBssZnMXN4NsSQLE7bdKAtIx/Uvv6xlyOl8L++d
         h+OG2Bp2vB8zvWT3vgkPV+T12CqmDvx3XMFHkJfcmayOhbBsfP34YK166mx/VJxoh3Fa
         djf3lk2phSoFObMeS7U8K9L+drSJlVtE8fO1KWvC1O3/XXgr4e04060KG0B0r2R8MaPo
         beYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jw3+o9tkTtZaFXuWp2piyMoDxF7elmFPwWeoUWpMXV8=;
        b=WhK3VQY+QMfzJEwoGwODQPTPDA8ip8BlOmJKp0yVBVDSMA4bNni/YkIiFpliVuZYRb
         Czov/QE9NywQC6VeRIf6j8nuu5PAswCkZYD6cFF7AfmR0xxGFgzl1C3+LvP7lFDT7pzU
         v7V32AUySqhlk1OwqtWmZaXQNQ649oJS4sy5yCDuplEx1c5cIvzuzQzkzqzDzwl829Hr
         82w3zq7/SIgr62LsmEydIQZP2sivW0MD5zZysf1LAIP2PtPgAdA82Mbqau+sd2BQKpD6
         LQENbA34oKPLLmtEGcxjhMTTY+gJarqCSnIZrgDloO8vSp5YObIZUNJ6H2lWmc1ngZxH
         efEA==
X-Gm-Message-State: AOAM533RG43ExYF9XCmdFp/4M1tocIW0g/WK/5ioGWatI4RyybzJE6Zp
        Q3uoUeQcuupsAqvupm5UAI6I7SrHvHa4zph4tI5JPBrepTA=
X-Google-Smtp-Source: ABdhPJxDBkvgS9A026yO5Rs99/u8nNKM0OcQsqOSN3zAuOrNgAwJTO5XzM/AR0gZffNPUZNSYWtxvjhGqJ6Iy+HwKgw=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr5150038pjb.93.1639766232605;
 Fri, 17 Dec 2021 10:37:12 -0800 (PST)
MIME-Version: 1.0
References: <20211213204632.56735-1-andriy.shevchenko@linux.intel.com> <CAJZ5v0jq=XdH+xeHs5=wMGsu28i+r3nzZbhCNMJkfdOi65N0Gg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jq=XdH+xeHs5=wMGsu28i+r3nzZbhCNMJkfdOi65N0Gg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 17 Dec 2021 10:37:02 -0800
Message-ID: <CAPcyv4hA41u=RvNfvukrcRDjmw6i7t4Vg3u1cXReQGKi6MHwJA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Import GUID before use
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 10:10 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Dec 13, 2021 at 9:46 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Strictly speaking the comparison between guid_t and raw buffer
> > is not correct. Import GUID to variable of guid_t type and then
> > compare.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Dan, are you going to take care of this or should I?

I'll take it.

Apologies for the delay in responding. I am still catching up on some
patch merging backlog.
