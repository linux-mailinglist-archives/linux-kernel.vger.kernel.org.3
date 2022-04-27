Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76394512467
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbiD0VSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbiD0VSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:18:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51FB4EF61;
        Wed, 27 Apr 2022 14:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63DDAB82AD5;
        Wed, 27 Apr 2022 21:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6A5C385B2;
        Wed, 27 Apr 2022 21:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651094096;
        bh=lBUpmhEoCCcZjpNf/2LO2eIK1qQ0KYaM+91u1icRP2g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oU2ztVFjgMvw1+qj1WBS7W9/nmUHjCoVwwscgZzGJxiO3ECAaPQZf1Rx9JEdGenPM
         ebhN5I2piVZzEi3K7oFpHbXAMkXFYxjOl0jJkZenWlxk0HVLjOYRhKCtqdzfVu5SMM
         ZF0Vc+cNPrhcDozL+QJWz7TTfMat4l5LNGz3eFuP5OF7M5mEEe5BFby0oCuV71VXU/
         1h9CwX8oQiAyR3fQWYaqIEtb51x3e+fE4Rh275DplP3iJHWKmF8JyWSXAhiHaqytyW
         YxnQnsMne9fJw1e3I4q7hLuQuoVLZze3oELQGgHBvE56ytlqo/m3fmFGl8ZbuHMP9i
         pPqp19p6NDgew==
Received: by mail-pg1-f181.google.com with SMTP id t13so2386143pgn.8;
        Wed, 27 Apr 2022 14:14:56 -0700 (PDT)
X-Gm-Message-State: AOAM530FzQ4k/yLuZ+YHJjuBWyHVdHqJDncTI5ykCsLOp1DClCxgOl3W
        kTIT26h1oFVEHXpnQJaQkTbbO+JqV0gN05e35w==
X-Google-Smtp-Source: ABdhPJwV2SaLGU0GX3CnFgdD1fBlxA/qfqRI/BIaQ15BcYYssgYNxiLPcOUt3FKzTZN5Omsgafx0QjIeoktq+JTOgBk=
X-Received: by 2002:a63:ff4b:0:b0:3aa:3083:5131 with SMTP id
 s11-20020a63ff4b000000b003aa30835131mr25856825pgk.148.1651094095516; Wed, 27
 Apr 2022 14:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210324223713.1334666-1-frowand.list@gmail.com>
 <20210327174035.GA291160@robh.at.kernel.org> <3e6710e7-08ac-7d1b-aa69-bcd36f0d932a@gmail.com>
 <CAMuHMdXpGKMi-xv6hZQmmEw0JO=Q0WuvUzwJ2v0O28Tx5uW+sg@mail.gmail.com>
 <d1aefaae-7b12-b5fb-4b97-7230bd52c1be@gmail.com> <20210526061144.yvoaurpz75a3bsjr@vireshk-i7>
 <f651e95b-feef-5c86-edba-d6008bc80b34@gmail.com> <YK70Xsl1oXeEQpWZ@yekko>
 <CAMuHMdWdb2s08a=axC+m88gARSA3enOBnczsN59XL2F9yHXXYA@mail.gmail.com>
 <YLBnX4PeK51YwUJB@yekko> <CAMuHMdXPn9FHr41xmihuuzNNNKvY-50yAwY4HyuyVo6qBn=Z1w@mail.gmail.com>
 <CAMuHMdWeL3DOXY3xcPOBW2WDDGW3PxgSM8didt7J1KxSm1ivJg@mail.gmail.com>
 <CAMuHMdWXXoS9mmX9VWRQyXfmsy8YROgpLZ-xB7zthEdPdM2u4A@mail.gmail.com>
 <CAMuHMdVWkSnki8VQDaYRzJ8yu8xtEKpXyfQppTtw3wXDQPmYzw@mail.gmail.com>
 <d4b7ce06-23e7-1c60-cc0c-b6aea07e0a1a@gmail.com> <CAL_JsqKTckMABk6cM8d=boZcHyLdcqYmbzfKDjAHdCXoCPSDtg@mail.gmail.com>
 <CAMuHMdU4oUKaGxmaPiC=cX0XpHG3KXhr+4MywEfeQ8sq-EG18A@mail.gmail.com> <CAL_JsqL3fHXNdGS=ap6+5Y25T2zmnDYRkt5dNV9mW7hyanVvuw@mail.gmail.com>
In-Reply-To: <CAL_JsqL3fHXNdGS=ap6+5Y25T2zmnDYRkt5dNV9mW7hyanVvuw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 27 Apr 2022 16:14:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJn459-8wnwT0N0CKumnvh_gDkVdgVebvMVa13oTxfQ=g@mail.gmail.com>
Message-ID: <CAL_JsqJn459-8wnwT0N0CKumnvh_gDkVdgVebvMVa13oTxfQ=g@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: unittest: rename overlay source files from .dts
 to .dtso
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Anmar Oueja <anmar.oueja@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 1:31 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jan 14, 2022 at 3:25 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Rob,
> >
> > On Fri, Jan 14, 2022 at 3:10 AM Rob Herring <robh@kernel.org> wrote:
> > > On Thu, Jan 6, 2022 at 11:23 AM Frank Rowand <frowand.list@gmail.com> wrote:
> > > > Patient Geert has pinged again.
> > >
> > > If it's not a patch to be reviewed, then I'm not going to see it most
> > > likely. I don't read the DT list regularly...
> >
> > Fair enough...
> >
> > > > If I remember correctly you guys were not thrilled with this idea, but
> > > > also did not seem strongly against it.  Are you willing to go along
> > > > with .dtso for overlay source files?  If so, I will revive this patch
> > > > series.
> > > >
> > > > David, if you are against supporting .dtso in the dtc compiler then
> > > > the kernel can still support it through make rules.
> > >
> > > I'm not really interested in diverging from dtc. I'd suggest moving
> > > the discussion to dtc list and/or devicetree-spec if you want to get
> > > more attention on this.
> >
> > What needs to be supported in the dtc compiler?
> > The fallback passed to guess_input_format() is "dts".
> > So this has been working out-of-the-box since forever?
>
> Ah, okay.
>
> > > Also, keep in mind that extensions also affect MIME types which
> > > someone was also asking about recently.
> >
> > You mean "MIME type of Devicetree Blobs and Sources"[1]?
> > According to [2](2022-01-13), none of that has happened.
>
> This is what I was thinking of:
>
> https://github.com/devicetree-org/devicetree-specification/issues/46
>
> In any case, given everyone is ambivalent, send me an updated patch
> and I'll apply it.

Ping! Anyone still want this?

What I don't want to see is a mixture of .dts and .dtso. And now I'm
reviewing RPi overlay patches[1] with .dts.

Rob

[1] https://lore.kernel.org/r/20220427185243.173594-3-detlev.casanova@collabora.com
