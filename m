Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C57A5845F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiG1Sas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiG1Sag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:30:36 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBCE1903F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:30:35 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id j63so4538687ybb.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HmQc0gLXiC50oZ75chCana8wmF6UqmHFCPVxPkKeia4=;
        b=Y+Juq/GKtF4mJuJyY8N32y16gt2v96aLq/MKly8ctrl9sXMqw+4N3Qbifu5y6Bu+LG
         gM/L5t6q4aZ7Nu6JtXJ0LBHc68zY5SCyikR0qobmva0t8M2e3jYNyxp+xjeBoM1NvYCN
         p0JQrmEqD7mrPWRnHUoYOvMUx4ly0c0Hu/CbGQOXG9fUi/Lbt9RIuI1peB50jKX++ajL
         QmMRKRFHxZgQ6PPYlCZemuF1iTvcEYzBELF8YarJfP+h3iowAz4BKFEUFQo9Jjc8rcFd
         C/sKru3od0J+aLsSpgSoj31+k9KEBHP0Koyz/M1X4Eixnvkh6BuuX62eM+xVVM72SnBZ
         dlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HmQc0gLXiC50oZ75chCana8wmF6UqmHFCPVxPkKeia4=;
        b=ymTJypOZXdh8xEcxGDIy0UOLh7qPSG8rvv8agnQ9yKdT1gSVPqpHgHoP0oVVIsh8M9
         sl3BBKbPfiQx4FX8v6ZXJNg7KmwtPB3Qi597tbk6KHsxI1Q4VtxZ/pz+gTDIjBv6pbX2
         huMvP9Wx6O1UyMywFsjkRDydocjG9DIVzsc8pcCesHjULDDuxCHHqPXB8iXnAumzyYGc
         ghCFOdsvftKMEDnUw219Ctgwb0Gzh6vQht+imYIhSkZDrCCfN+bseKh+IbFZyiIfKUaY
         imIeIRwBa4qvGBQesjAv1L8Jqt1e9cV+H8ZRqyHongk5TVn5d8QrrvPg318bMXX5M5og
         EG4Q==
X-Gm-Message-State: ACgBeo0C99ESL9F/knXExXGGmxmnqfxqU69pqYjV6kUFjMtHZH/QIJLS
        JfRJ5Hf0KFN12JGtfNQshgOaxvRwWVh3sMrscY+vkQ==
X-Google-Smtp-Source: AA6agR6+oh/XbKkLTNjRpWANCDr/Kyu1eFryOlEg9HLAowpPABDqAyHRGoaU+P760KjRjiO9aii6l3RugtGIGzom2kc=
X-Received: by 2002:a25:9b88:0:b0:66d:b166:a430 with SMTP id
 v8-20020a259b88000000b0066db166a430mr6217ybo.80.1659033033765; Thu, 28 Jul
 2022 11:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220727181936.3250466-1-saravanak@google.com>
 <YuG5KCksLWzThSmF@shell.armlinux.org.uk> <CAGETcx9HFQa=58XUQ07FVQ_Qqem2La4YcR8_qDbg4uqCT8w3CQ@mail.gmail.com>
 <YuKaI5jJOZ8WQQPU@shell.armlinux.org.uk>
In-Reply-To: <YuKaI5jJOZ8WQQPU@shell.armlinux.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 28 Jul 2022 11:29:57 -0700
Message-ID: <CAGETcx8g1Sgs8Ev4Ab1E-fEGzo=Rx3Kx9WiT-3ekpQv2BmR_Qg@mail.gmail.com>
Subject: Re: [PATCH v6] amba: Remove deferred device addition
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@armlinux.org.uk, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 7:16 AM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Jul 27, 2022 at 05:10:57PM -0700, Saravana Kannan wrote:
> > On Wed, Jul 27, 2022 at 3:16 PM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Wed, Jul 27, 2022 at 11:19:35AM -0700, Saravana Kannan wrote:
> > > > The uevents generated for an amba device need PID and CID information
> > > > that's available only when the amba device is powered on, clocked and
> > > > out of reset. So, if those resources aren't available, the information
> > > > can't be read to generate the uevents. To workaround this requirement,
> > > > if the resources weren't available, the device addition was deferred and
> > > > retried periodically.
> > > >
> > > > However, this deferred addition retry isn't based on resources becoming
> > > > available. Instead, it's retried every 5 seconds and causes arbitrary
> > > > probe delays for amba devices and their consumers.
> > > >
> > > > Also, maintaining a separate deferred-probe like mechanism is
> > > > maintenance headache.
> > > >
> > > > With this commit, instead of deferring the device addition, we simply
> > > > defer the generation of uevents for the device and probing of the device
> > > > (because drivers needs PID and CID to match) until the PID and CID
> > > > information can be read. This allows us to delete all the amba specific
> > > > deferring code and also avoid the arbitrary probing delays.
> > >
> > > Oh, this is absolutely horrible. I can apply it cleanly to my "misc"
> > > branch, but it then conflicts when I re-merge my tree for the for-next
> > > thing (which is only supposed to be for sfr - the hint is in the name!)
> > > for-next is basically my "fixes" plus "misc" branch and anything else I
> > > want sfr to pick up for the -next tree.
> >
> > Btw, this is the repo I was using because I couldn't find any amba repo.
> > git://git.armlinux.org.uk/~rmk/linux-arm.git
>
> I don't maintain a separate repo for amba stuff.
>
> > Is the misc branch visible somewhere because I don't see it in that
> > repo? Or is that just a local branch? Also, what does sfr stand for
> > (s* for next)?
> >
> > In case this helps, all the conflicts are due to this commit:
> > 8030aa3ce12e ARM: 9207/1: amba: fix refcount underflow if
> > amba_device_add() fails
> >
> > It's fixing bugs in code I'm deleting. So if you revert that, I can
> > give you a patch that'll apply across 5.18 and 5.19.
> >
> > Let me know if you want me to do that.
>
> I dug into what had happened - the patch you mentioned patch 9207/1,
> and this also applies to 9208/1 as well although that isn't relevant
> for your patch. These two were merged as fixes in v5.19-rc7 via my
> fixes branch.
>
> They also appeared for some reason in the misc branch as entirely
> separate commits. Because 9207/1 appears in both, your patch applies
> cleanly on misc, but when fixes is then merged, it touches the same
> code and causes a conflict.
>
> Reverting the commit you mention won't actually fix anything - it'll
> only make things much worse, with a conflict then appearing between
> my tree and Linus'.
>
> The only sensible thing would be to delete those two duplicated
> commits from the misc branch, rebase misc on v5.19-rc7 (thus picking
> up those two commits that are already in mainline) and then putting
> your patch on top of misc.
>
> This is doable, because there's five commits there, most of them are
> trivially small changes, so its not a great loss in terms of the
> testing that's already been done.
>
> That appears to work fine - I've just pushed that out with your commit
> included, so should be in the final linux-next prior to the merge
> window opening this Sunday.

Thanks a lot for taking care of this Russell!

-Saravana
