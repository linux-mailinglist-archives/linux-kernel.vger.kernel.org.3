Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3CC5A377D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 13:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345293AbiH0Lp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 07:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiH0Lph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 07:45:37 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EEF61711;
        Sat, 27 Aug 2022 04:45:36 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-33dc345ad78so93881197b3.3;
        Sat, 27 Aug 2022 04:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GvJNLP40OETwZADaZTLkmY5BZ1XY428/Y6jRF2MfT/k=;
        b=0koRWWQDBIvEzDAEdB5RogGcJ1LplpwttddKxaSIeoleYBsQRseoWnayqMTrAxAeZl
         VHYb7RmVD7pRKOfl3QvYJZAzhTsmLsIlUdBeF386fe7s7ekm/ydsMiSoHZHd7K+8aImF
         nMcXYdYj0qTwiX55bqF64IBt4Mbd0UiSK3WdpuyHh92vscfAGzL/ovgOZjquvqWXZFYs
         SxMXHG27Wi7uh3bcFnx5T6LbLd6tFIcsuFlJ2ZUJxdFA94EUPrTKQOJbkbCmWshFOm3Q
         7sOz9aiwz7SHa4La6BOWeR9L8Aj4B0xmdhDSKxuaj0gmej/PMxh3bLM8siqsOeW/34BE
         TW8A==
X-Gm-Message-State: ACgBeo0vc5Af9BjRuVEGaDdrl+iYWqNibmXni8YahfIeVgsZeajXgGHp
        MNK3D6PWzm0jS4BlM6oFEL8129F/dvZ8LSHY9TzCVkbN
X-Google-Smtp-Source: AA6agR5XYU4nV2W34akQ3kEUoN5fw+2xswF7OURWDVx/e91zb6NiPrGIEiBZcSiSPc1sExcVdtcMAgMBp27BHQA4Pu4=
X-Received: by 2002:a25:b749:0:b0:68f:171f:96bd with SMTP id
 e9-20020a25b749000000b0068f171f96bdmr3163102ybm.137.1661600735335; Sat, 27
 Aug 2022 04:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220825164103.27694-1-andriy.shevchenko@linux.intel.com>
 <20220825164103.27694-5-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0if_gZpibSWx5mfoVpGXtF0sGe7MY+eRQJr09ONX0Q1rQ@mail.gmail.com>
 <CAHp75VcQkyCOo9jkKKmu=zgHgQiHD96QhTa9Ann3syTaVnBokQ@mail.gmail.com> <Ywj/Bxvv+Dtt/Dy0@smile.fi.intel.com>
In-Reply-To: <Ywj/Bxvv+Dtt/Dy0@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 27 Aug 2022 13:45:22 +0200
Message-ID: <CAJZ5v0iM9oZivWj6qbMfD8n2exwy7Xi=NVRZFFuam7y9Hk3cfw@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] ACPI: bus: Use the matching table, if ACPI driver
 has it
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
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

On Fri, Aug 26, 2022 at 7:12 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 25, 2022 at 08:17:11PM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 25, 2022 at 8:05 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Thu, Aug 25, 2022 at 6:41 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > In case we have an ACPI driver, check its ID table for matching,
> > > > This allows to use some generic device property APIs in such
> > > > drivers.
> > >
> > > No new provisions for ACPI drivers, please.
> >
> > OK! I will think about how to refactor a driver in question, so it
> > won't need this kind of trick. Meanwhile patches 1-3 can be applied
> > independently, if you have no objections.
>
> I see that you applied an equivalent patch to what I had here as patch 3.
> Taking into account rejection of patches 4 and 5 I will send a v2 with
> patch 1 and (modified due to drop of the 5) 2 for your convenience.

Appreciated, thanks!
