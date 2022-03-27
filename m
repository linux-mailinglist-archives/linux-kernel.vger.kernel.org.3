Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A104E89D1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiC0TrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbiC0Tq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:46:57 -0400
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com [91.221.196.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF9F29C96
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 12:45:17 -0700 (PDT)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx1.smtp.larsendata.com (Halon) with ESMTPS
        id 6cdf4254-ae06-11ec-8da1-0050568c148b;
        Sun, 27 Mar 2022 19:45:16 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 4749C194B36;
        Sun, 27 Mar 2022 21:45:15 +0200 (CEST)
Date:   Sun, 27 Mar 2022 21:45:11 +0200
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/3] drm/panel : innolux-ej030na and abt-y030xx067a :
 add .enable and .disable
Message-ID: <YkC+x4m0BQFgu/n0@ravnborg.org>
References: <20220321133651.291592-1-cbranchereau@gmail.com>
 <20220321133651.291592-4-cbranchereau@gmail.com>
 <GJM39R.I3L8ZIKHOJ252@crapouillou.net>
 <CAFsFa85Rcxh7G-X9zygHdAaca2nydUXxGfE2Vgcx_nzqgQZVgw@mail.gmail.com>
 <CAFsFa85P8V-yePR5LTLjn57GCoqJJYn5pX6WNdp+a+G23XEbSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFsFa85P8V-yePR5LTLjn57GCoqJJYn5pX6WNdp+a+G23XEbSg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Mon, Mar 21, 2022 at 03:42:08PM +0100, Christophe Branchereau wrote:
> Sorry I meant "sleep out" not "sleep in" obviously
> 
> On Mon, Mar 21, 2022 at 3:39 PM Christophe Branchereau
> <cbranchereau@gmail.com> wrote:
> >
> > Following the introduction of bridge_atomic_enable in the ingenic
> > drm driver, the crtc is enabled between .prepare and .enable, if
> > it exists. Add it so the backlight is only enabled after the crtc is, to
> > avoid graphical issues.
> >
> > As we're moving the "sleep in" command out of the init sequence
> > into .enable for the ABT, we need to switch the regmap cache
> > to REGCACHE_FLAT to be able to use regmap_set_bits, given this
> > panel registers are write-ony and read as 0.
> >
> > On Mon, Mar 21, 2022 at 3:21 PM Paul Cercueil <paul@crapouillou.net> wrote:
> > >
> > > Hi Christophe,
> > >
> > > Le lun., mars 21 2022 at 14:36:51 +0100, Christophe Branchereau
> > > <cbranchereau@gmail.com> a écrit :
> > > > Following the introduction of bridge_atomic_enable in the ingenic
> > > > drm driver, the crtc is enabled between .prepare and .enable, if
> > > > it exists.
> > > >
> > > > Add it so the backlight is only enabled after the crtc is, to avoid
> > > > graphical issues.
> > > >
> > > > Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> > >
> > > Didn't Sam acked it?
No, that was the new driver, already replied.

For these changes - with the updated changelog:
Acked-by: Sam Ravnborg <sam@ravnborg.org>
