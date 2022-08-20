Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D1D59AD71
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344492AbiHTL0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiHTL0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:26:09 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69842193E2;
        Sat, 20 Aug 2022 04:26:08 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-335624d1e26so181884697b3.4;
        Sat, 20 Aug 2022 04:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=X55tJK6SwStzChxJgm/vni+D0twkhoJ6fdk+hQZkwrU=;
        b=xDMvAy221Mjvj/CMv6nMlFH8TPt5V2hbCGbs4Q+c4zPzJbaU+hnuJ/1lSi4w2KoFkE
         l31qql2Z0g64Tl3vinyXYXXy89neGap/KgEmbMbZUGgvNHBDmWxN9JmG/FdxshwsPzdy
         qrsCx1+TUH+eCiknyKlExW1cvJA+NZ6ouNKfEvEzaRBomLP1uEmrUqu8Fwf3xOw7W9L3
         ZcE1buOmUQjkHjiuX10Sg5WES9XMRkYZbiV6bxIcoVQGzJDNuRMu7V+zYuxnl6BKmzgg
         /EvtBGPKV3ZZ81ilcZqmQibNc3QyxyodgA/EyxXYegPLw7HrP9SiLZQAhofk7yDg/h+u
         cMXQ==
X-Gm-Message-State: ACgBeo0VQVMzzQOubXv8dTab+j3Fq4HBA2Hj+xYt6vjsTr+UtzZDPL4g
        bZRh7tSy3ZV8I+Mf2vJtJ+ZuFGsEQYmkRZFzeeA=
X-Google-Smtp-Source: AA6agR628vKI0tbnu0N8qUd5OW6pJUINV7CGdfSi9on2Aox71vQfT9mZu6t4+ZRX9rnhTAe1k0DK/BEBMBWMLOIBdPw=
X-Received: by 2002:a81:104e:0:b0:336:37f1:9686 with SMTP id
 75-20020a81104e000000b0033637f19686mr12115184ywq.149.1660994767631; Sat, 20
 Aug 2022 04:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220816101629.69054-1-heikki.krogerus@linux.intel.com>
 <Yv6PLl4aLPzHTJTQ@kroah.com> <Yv9ftg2MVx+okmzC@kuha.fi.intel.com> <Yv9m6LSGKXvnnBSY@kroah.com>
In-Reply-To: <Yv9m6LSGKXvnnBSY@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 20 Aug 2022 13:25:56 +0200
Message-ID: <CAJZ5v0h19Rdvt-HYdnFC=dD=gWv=HRqNbA=cpx=zbXNyV1rGKA@mail.gmail.com>
Subject: Re: [PATCH 0/6] ACPI: New helper function acpi_dev_get_memory_resources()
 and a new ACPI ID
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>
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

On Fri, Aug 19, 2022 at 12:33 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 19, 2022 at 01:02:30PM +0300, Heikki Krogerus wrote:
> > Hi,
> >
> > On Thu, Aug 18, 2022 at 09:12:46PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Aug 16, 2022 at 01:16:23PM +0300, Heikki Krogerus wrote:
> > > > Hi,
> > > >
> > > > The helper function returns all memory resources described for a
> > > > device regardless of the ACPI descriptor type (as long as it's
> > > > memory), but the first patch introduces new ACPI ID for the IOM
> > > > controller on Intel Meteor Lake and also separately modifies the
> > > > driver so that it can get the memory resource from Address Space
> > > > Resource Descriptor.
> > > >
> > > > An alternative would have been to introduce that helper function first
> > > > so we would not need to modify the driver when the new ID is added,
> > > > but then the helper would also need to be applied to the stable kernel
> > > > releases, and that does not feel necessary or appropriate in this
> > > > case, at least not IMO.
> > > >
> > > > So that's why I'm proposing here that we first add the ID, and only
> > > > after that introduce the helper, and only for mainline. That way the
> > > > patch introducing the ID is the only that goes to the stable releases.
> > > >
> > > > If that's okay, and these don't have any other problems, I assume it's
> > > > OK if Rafael takes all of these, including the ID?
> > >
> > > I took the id now, for 6.0-final as it seems to be totally independant
> > > of the other commits (otherwise you would not have tagged it for the
> > > stable tree.)
> > >
> > > The remainder should probably be resent and send through the acpi tree.
> >
> > Okay. The last patch depends on that ID patch, so Rafael, you need to
> > handle that conflict with immutable branch I guess. Or should we just
> > skip that patch for now?
>
> You can wait for -rc3 or so which should have that commit in it.

I'll apply the series on top of -rc3.

Cheers!
