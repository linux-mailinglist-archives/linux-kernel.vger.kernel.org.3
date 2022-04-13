Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A024FEE81
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiDMFfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiDMFfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:35:05 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E1AF2FFD6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:32:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A84EE8061;
        Wed, 13 Apr 2022 05:30:07 +0000 (UTC)
Date:   Wed, 13 Apr 2022 08:32:40 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        linux-kernel@vger.kernel.org, jyri.sarha@iki.fi, tomba@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        a-bhatia1@ti.com, r-ravikumar@ti.com, nikhil.nd@ti.com,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH] drm/tidss: Soft Reset DISPC on startup
Message-ID: <YlZgeGPoWv+Z0iYy@atomide.com>
References: <20220314113739.18000-1-devarsht@ti.com>
 <86a07099-1074-e8d1-6d0e-1ce68414b627@ideasonboard.com>
 <20220412212049.gjnel7aubol56azk@earache>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412212049.gjnel7aubol56azk@earache>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [220412 21:18]:
> On 17:24-20220412, Tomi Valkeinen wrote:
> > Hi,
> > 
> > On 14/03/2022 13:37, Devarsh Thakkar wrote:
> > > Soft reset the display subsystem controller on startup and wait for
> > > the reset to complete. This helps the scenario where display was
> > > already in use by some other core before the linux was booted.
> > 
> > The reason the omapdrm doesn't do a reset is that the PM features on some of
> > the DSS registers were set and controlled outside dss driver, so the dss
> > driver could not do a reset just like that. That design was carried to the
> > tidss driver, although I'm not sure if the reason is valid on AM6 and J7
> > platforms.
> > 
> > If that reasoning is not valid, this patch is ok and:
> > 
> > Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Yeah seems OK to me for tidss, I don't think there's any other layer to
do this in a generic way for k3 devices currently.

The thing to check here is that the sysconfig register gets properly
initialized to the right state after reset. For PM, likely the syconfig
value after reset is not correct, but that can be reconfigured later on
as needed.

> Tony - sysc control for older omap devices still control this directly?

Yes, for a  reason. The reset affects the entire interconnect target
module, and disabling clockdomain autoidle needs to be considered for
enable. For omaps, the resets are handled in a generic way for all the
TI devices by ti-sysc.

With ti-sysc, the reset is done before probing dss devices on init in
sysc_init_module(). The dss related quirk handling is done in
sysc_pre_reset_quirk_dss(). If needed, we could add support for reset
framework to ti-sysc for omapdrm to call. But so far there has not been
much of a need for that, I think 8250_omap could use reset framework if
available though.

Anyways, sounds like there's no need to do a similar dss reset in
omapdrm.

Regards,

Tony

