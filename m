Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CB74F5166
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1846139AbiDFCC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454028AbiDEP5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:57:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D545167F87;
        Tue,  5 Apr 2022 08:03:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEB3C6179F;
        Tue,  5 Apr 2022 15:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB57BC385A4;
        Tue,  5 Apr 2022 15:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649170979;
        bh=qNv9WCGw+H4LJDj4fT2rA98UYD02WLOHpYP7c+6zAxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jxc7Wj5dW0eM8sgkO1wX3113Q5/56VIuZs3gNSexvnbVAgzV2iDk7oiXCV9x/jAOr
         Hbs1KRTXzrpGvuCd9gnbxAURMYmfjIW6T7bkvOG2sZqHPkX8ZFEGRekFM1VFcOc9Sy
         x8qkS/8jN/R2vWMCk8/RlnYuB3Xs1y2A1cZKBJcI=
Date:   Tue, 5 Apr 2022 17:02:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-usb@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/4] usb: phy: generic: Support enabling/disabling VBUS
Message-ID: <YkxaIK/y+7H8HgwZ@kroah.com>
References: <20220114170941.800068-1-sean.anderson@seco.com>
 <ffee044a-d34f-6be5-1fa9-c14cf3bb30de@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffee044a-d34f-6be5-1fa9-c14cf3bb30de@seco.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 10:51:34AM -0400, Sean Anderson wrote:
> 
> 
> On 1/14/22 12:09 PM, Sean Anderson wrote:
> > The generic USB phy has had VBUS-related code for a long time, but it
> > has always been broken, since the regulator was never gotten from the
> > device tree. However, the support itself seems not very useful, since
> > e.g.  usb_phy_vbus_on/off has no users and usb_phy_set_power is only
> > used by gadgets to make sure they don't draw too much current. Instead,
> > use the VBUS regulator to implement otg_set_vbus, which is called from
> > several drivers. This results in a change in semantics of VBUS, but
> > since support was always broken I don't think this will have any affect.
> > 
> > 
> > Sean Anderson (4):
> >   dt-bindings: usb: usb-nop-xceiv: Repurpose vbus-regulator
> >   usb: phy: generic: Get the vbus supply
> >   usb: phy: generic: Implement otg->set_vbus
> >   usb: phy: generic: Disable vbus on removal
> > 
> >  .../bindings/usb/usb-nop-xceiv.yaml           |  8 +--
> >  drivers/usb/phy/phy-generic.c                 | 55 +++++++++----------
> >  2 files changed, 31 insertions(+), 32 deletions(-)
> > 
> 
> ping?
> 
> When this was submitted I got an email saying that the merge window was
> closed... but I think it has opened and closed again during the
> intervening time.

It opened yesterday.  Please give us a chance to catch up.

While that happens, please take the time to review other changes on the
mailing lists, we can always use the help.

thanks,

greg k-h
