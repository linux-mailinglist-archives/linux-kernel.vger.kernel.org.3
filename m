Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FA5475A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243117AbhLOOHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:07:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42634 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbhLOOHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:07:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB6F1618EE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE291C34605;
        Wed, 15 Dec 2021 14:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639577237;
        bh=pj5iVHGXV5c017g6VgAz7lvZgQOAh4kItDtaHYm4MZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WMoYGooPTcMaaB7Ac6PHgAj6Y/1e+QpjTJHXKKWL12Sw6dApItsdjztW1x8b7GqW1
         XP9Huit20dNb23oP76JXptCwJKIZjvas0Uv8p00WMpu6nud0PwOpNaYev3mIQnTDy6
         7vB3UFiY4fWwEuYr8agK/PSHHlUk7gXbffE4Fw9U=
Date:   Wed, 15 Dec 2021 15:07:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/i915/gsc: add gsc as a mei platform device
Message-ID: <Ybn2kmcJ4OOyaHhI@kroah.com>
References: <20211215135622.1060229-1-alexander.usyskin@intel.com>
 <20211215135622.1060229-2-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215135622.1060229-2-alexander.usyskin@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 03:56:18PM +0200, Alexander Usyskin wrote:
> From: Tomas Winkler <tomas.winkler@intel.com>
> 
> GSC is a graphics system controller, based on CSE, it provides
> a chassis controller for graphics discrete cards, as well as it
> supports media protection (HDCP 2.2) on selected devices.
> 
> There are two MEI interfaces in GSC HECI1, the one that provides media
> protection and HECI2 the one that provides firmware interface.
> 
> Both interfaces are on the BAR0 at offsets 0x00258000 and 0x00259000.
> GSC is a GT Engine (class 4: instance 6). HECI1 interrupt is signaled
> via bit 15 and HECI2 via bit 14 in the interrupt register.
> 
> This patch exports GSC as platform device for mei driver to bind to.

This is NOT a platform device.  It is part of a PCI device, which is NOT
a platform device.  I keep having to say this.

Please use the auxbus interface instead if you want to split a PCI
device up into sub-child-devices and bind drivers to them.  That is what
it was created for, and this SHOULD have been caught by the other Intel
reviewers who signed-off on this patch.

so no, I will not ack this, it is not ok at all, sorry.

greg k-h
