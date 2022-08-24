Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8253D59F355
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiHXF7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiHXF7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:59:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EE56E8A8;
        Tue, 23 Aug 2022 22:59:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 863E9B820E2;
        Wed, 24 Aug 2022 05:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF14C433C1;
        Wed, 24 Aug 2022 05:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661320788;
        bh=Cqed2AyEOa8HzjSfWn4Ar8N2KOWo4TBNXbZeZFIpcB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ol81/3hWrML2yIwM4VwH84RQAuBNIHA7A0ik3J4/N5x43VRC1rLrlD2hbrN5Ln/+G
         l16H3UbpueK26MI4UzbBnSX1viF/6DYCNyfdLHMSBVu5rlvOdHYmmBtVNiP0HpNPOx
         vxquLbcM158Voe7vqex+yul18dOTsGyiqvNB4+bU=
Date:   Wed, 24 Aug 2022 07:59:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajat Khandelwal <rajat.khandelwal@intel.corp-partner.google.com>
Cc:     heikki.krogerus@linux.intel.com, rajat.khandelwal@intel.com,
        shawn.c.lee@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Enter safe mode only when pins need to be reconfigured
Message-ID: <YwW+UUrn47MCbNIA@kroah.com>
References: <20220823170949.2066916-1-rajat.khandelwal@intel.corp-partner.google.com>
 <YwW+LI345ind56ks@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwW+LI345ind56ks@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 07:59:08AM +0200, Greg KH wrote:
> On Tue, Aug 23, 2022 at 10:39:49PM +0530, Rajat Khandelwal wrote:
> > From: Lee Shawn C <shawn.c.lee@intel.com>
> > 
> > There is no point to enter safe mode during DP/TBT configuration
> > if the DP/TBT was already configured in mux. This is because safe
> > mode is only applicable when there is a need to reconfigure the
> > pins in order to avoid damage within/to port partner.
> > 
> > 1. if HPD interrupt arrives and DP mode was already configured,
> > safe mode is entered again which is not desired.
> > 2. in chrome systems, IOM/mux is already configured before OS
> > comes up. Thus, when driver is probed, it blindly enters safe
> > mode due to PD negotiations but only after gfx driver lowers
> > dp_phy_ownership, will the IOM complete safe mode and send
> > ack to PMC.
> > Since, that never happens, we see IPC timeout.
> > 
> > Hence, allow safe mode only when pin reconfiguration is not
> > required, which makes sense.
> > 
> > Signed-off-by: Rajat Khandelwal <rajat.khandelwal@intel.com>
> > Signed-off-by: Lee Shawn C <shawn.c.lee@intel.com>
> 
> First off, don't use invalid "corp-partner.google.com" email addresses,
> you know that's not going to work and just bounce everywhere and there's
> no proof that this has any relationship to your intel address :(

Also the email verification fails, so it looks like you just spoofed
this message, which also makes it impossible for me to accept.

greg k-h
