Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDB1575393
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiGNRAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiGNRAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:00:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D52012AB9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8745B8276A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 17:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4918BC3411C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 17:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657818001;
        bh=UGj+eCckkc850V3QsjcZ5WcggED7iC+1xqWLrRUQ6RE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LVfFFhzebpd9sdj1mBa1NU5HBzaJ3dd2bGpm/fA6MTmUnhd4iMXd7c+qgsSzth2ZP
         YfO3GVhRy9GwydKpBg3ZdiDzDT5A12nj5QcjfREo+sfoo2iXeWSu7PxmhmZltk78SD
         A4AfWaDY/ftUQVoKygIcOMBuS8/pQDhhrrje+cJkFq5Ra5DEE1D9UpM9lWt4OFWdRl
         f2VH9lG6cOOtSm5WofJxZ3gv5GxaPuRlJytpOo1mcVt9l0z11v0FM3C+HA1/WIOIvu
         bgsTQhL/5H0TLDv9+fVpFhU8emE+OAPhnw6VfKuZNWKiSg1ILDDcz3sx6fes2BiMJa
         El6ZIlB3M5hbw==
Received: by mail-vs1-f54.google.com with SMTP id 189so2035191vsh.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:00:01 -0700 (PDT)
X-Gm-Message-State: AJIora8yecx5NHU88LyOQjpE2aQ3lApPgigL59cSmPiu6BBX2RUIPfFo
        nO5hzseyrg1lcU6F+D8wIBrTYc4ZGO5C5UKoTw==
X-Google-Smtp-Source: AGRyM1tmQNpW9X8WBPr5RSgt1vVGyZK+vlYOHFnoy0tJ5bkRE4CcAyAU0o9zvmYAP32soYW6YihRiO6TiY9gUmtrtVE=
X-Received: by 2002:a67:d194:0:b0:357:8ea:5554 with SMTP id
 w20-20020a67d194000000b0035708ea5554mr3983654vsi.0.1657818000224; Thu, 14 Jul
 2022 10:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
 <20220707081826.953449-3-Naresh.Solanki@9elements.com> <20220714141041.GB2229197-robh@kernel.org>
 <YtAkwcwXaQqZV75d@sirena.org.uk> <CAL_JsqKu_HCDoPBTcVdVV2JyD_8p3+cbrNC0u6VrK85vWZmt3Q@mail.gmail.com>
 <YtArbh4a40cACRMt@sirena.org.uk> <CAL_Jsq+KRyE3i3CkPKopGgFvL+h0pT3R-d3aZNgVmKyiTy3gjw@mail.gmail.com>
 <YtA8KOLDIsEH+okf@sirena.org.uk>
In-Reply-To: <YtA8KOLDIsEH+okf@sirena.org.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Jul 2022 10:59:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKCByvNASAxRWV3bcjFSBjXZUQf0Xvv_dCZ0z1CRCcOKA@mail.gmail.com>
Message-ID: <CAL_JsqKCByvNASAxRWV3bcjFSBjXZUQf0Xvv_dCZ0z1CRCcOKA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: regulator: add bindings for output-supply
To:     Mark Brown <broonie@kernel.org>, Zev Weiss <zev@bewilderbeest.net>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Zev

On Thu, Jul 14, 2022 at 9:54 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jul 14, 2022 at 09:07:49AM -0600, Rob Herring wrote:
> > On Thu, Jul 14, 2022 at 8:43 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > Consider for example a BMC (IIRC that's what their specific product is),
> > > a bench supply or some automated test equipment.  Part of the function
> > > for these systems is to provide power to other systems which would be
> > > represented as a root or wall supply in the description of the system
> > > that actually uses the supply if it were described using DT.
>
> > Didn't someone else have a similar use recently? Controlling some
> > supply external to the system. I can't seem to find it now.
>
> IIRC that was an earlier iteration of the same thing - it's been round
> the houses a bit.  extcon seemed like it might be a home since these are
> external connections from the system but in the end people didn't think
> it looked like a good fit.

Found it:

v1: https://lore.kernel.org/all/20220504065252.6955-2-zev@bewilderbeest.net/
v2: https://lore.kernel.org/all/20220505232557.10936-1-zev@bewilderbeest.net/

v2 was the using extcon version. v1 looks pretty similar to this one
though anything that's just a compatible plus supplies would.

But AFAICT these 2 submissions are completely independent.

> > In any case, it's not for you to describe, but Naresh, and in the
> > binding and commit messages. But first we need to overcome proper
> > usage of get_maintainers.pl. In response, to my first reply on v4, I
> > have a second v4 sent privately today (and still only the vendor
> > prefix). Sigh. AFAICT, for v1-v3, the only thing that made it to the
> > list was the cover letters. Bottom line is this series has multiple
> > problems and shouldn't have been applied yet.
>
> I can drop it but I do think it's reasonable to be adding a vendor
> binding for this, we don't seem to have enough people engaged to scope
> out a generic binding confidently and TBH I've got a feeling we might
> want multiple application specific generic bindings when we do have one.

I don't mind the vendor prefix. I mind the vendor prefix without any
description of the vendor's h/w.

Rob
