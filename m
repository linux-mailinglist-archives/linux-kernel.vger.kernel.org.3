Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677EC598283
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 13:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244168AbiHRLxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 07:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiHRLxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:53:42 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907346D55D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 04:53:40 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 328EF103B1EE1;
        Thu, 18 Aug 2022 13:53:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0E5F2D554; Thu, 18 Aug 2022 13:53:38 +0200 (CEST)
Date:   Thu, 18 Aug 2022 13:53:38 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH] drm/i915: Switch TGL-H DP-IN to dGFX when it's supported
Message-ID: <20220818115338.GA26586@wunner.de>
References: <20220816025217.618181-1-kai.heng.feng@canonical.com>
 <87leror4sl.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leror4sl.fsf@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 11:06:18AM +0300, Jani Nikula wrote:
> On Tue, 16 Aug 2022, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > On mobile workstations like HP ZBook Fury G8, iGFX's DP-IN can switch to
> > dGFX so external monitors are routed to dGFX, and more monitors can be
> > supported as result.
> >
> > To switch the DP-IN to dGFX, the driver needs to invoke _DSM function 20
> > on intel_dsm_guid2. This method is described in Intel document 632107.
> 
> Is this the policy decision that we want to unconditionally make,
> though?

In general, we handle switching of outputs between GPUs in vga_switcheroo.c
upon a request from user space via sysfs (well, debugfs currently).
It's up to users to decide which policy suits their needs best.

That said, we never grew support to allow different switching policies for
the built-in panel and external outputs.  Laptops supporting this are
rare.  Older MacBook Pros introduced between 2008 and 2010 are among them:
They have separate muxes for the panel and external DP port.  Our policy
is documented in a code comment in drivers/platform/x86/apple-gmux.c:

 * The external DP port is only fully switchable on the first two unibody
 * MacBook Pro generations, MBP5 2008/09 and MBP6 2010. This is done by an
 * `NXP CBTL06141`_ which is controlled by gmux.
 [...]
 * Our switching policy for the external port is that on those generations
 * which are able to switch it fully, the port is switched together with the
 * panel when IGD / DIS commands are issued to vga_switcheroo. It is thus
 * possible to drive e.g. a beamer on battery power with the integrated GPU.
 * The user may manually switch to the discrete GPU if more performance is
 * needed.
 *
 * On all newer generations, the external port can only be driven by the
 * discrete GPU. If a display is plugged in while the panel is switched to
 * the integrated GPU, *both* GPUs will be in use for maximum performance.
 * To decrease power consumption, the user may manually switch to the
 * discrete GPU, thereby suspending the integrated GPU.

In other words, on these older MacBook Pros, we switch the panel and
external DP port in unison, thus always allowing one of the two GPUs
to runtime suspend and save power.

Thanks,

Lukas
