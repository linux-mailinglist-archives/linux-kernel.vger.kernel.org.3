Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC5D4F0EF2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 07:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353119AbiDDFJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 01:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377363AbiDDFJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 01:09:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5CF3AA71;
        Sun,  3 Apr 2022 22:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30C866116F;
        Mon,  4 Apr 2022 05:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01954C2BBE4;
        Mon,  4 Apr 2022 05:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649048848;
        bh=rQVIxA1afwJ+h3SVM7T+uP8DlSo28TtyzvT0bkF0qPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l27SCTbH51/9XHHwDMydw7JG/oLhbLYQ588ZhIfA75G40vgj6H/pir4pDPKTMqB58
         2DbZNJbqPzXnRBhFjNBUWfQOBHRTe6fJnlHTxcOWyn9MH/Ejl81vmJi0Ee2SL9A85k
         J3vEiEVWFml/0oyJjbBE0QoESQdzrFzKmEPNvnKY=
Date:   Mon, 4 Apr 2022 07:07:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        stable-commits@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: Patch "can: isotp: add local echo tx processing for consecutive
 frames" has been added to the 5.15-stable tree
Message-ID: <Ykp9CxBncgUv7inJ@kroah.com>
References: <20220402160350.2129531-1-sashal@kernel.org>
 <020deca3-6560-ab5c-8794-ec06f2a8498a@hartkopp.net>
 <4ee9edd1-f805-b125-32d6-13b06d38bedc@hartkopp.net>
 <YknZSon6bikrS7ij@sashalap>
 <33688c0b-f90f-15cc-d098-c21a23b285ff@hartkopp.net>
 <YkowdppmGGMSPjNB@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkowdppmGGMSPjNB@sashalap>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 07:40:38PM -0400, Sasha Levin wrote:
> On Sun, Apr 03, 2022 at 08:24:04PM +0200, Oliver Hartkopp wrote:
> > Hi Sasha,
> > 
> > On 03.04.22 19:28, Sasha Levin wrote:
> > > On Sun, Apr 03, 2022 at 11:26:30AM +0200, Oliver Hartkopp wrote:
> > > > Hello Sasha/Greg,
> > > > 
> > > > the way how the can-isotp patches are currently applied to the
> > > > stable trees 5.17/5.16/5.15/5.10 is FINE.
> > > > 
> > > > This means 5.15 now has a functional improvement (as only stable
> > > > tree). But that should be fine too.
> > > 
> > > Are they all a functional improvement? or are some fixes?
> > > 
> > 
> > Only upstream commit 4b7fe92c06901f4563af0e36d25223a5ab343782 ("can:
> > isotp: add local echo tx processing for consecutive frames") is an
> > improvement, see:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.15/can-isotp-add-local-echo-tx-processing-for-consecuti.patch?id=c0c51980438b5e5b0d758dc28eef5947e57c9c1e
> > 
> > All others are fixes.
> > 
> > You now added this improvement to 5.15 which then needs this original
> > fix, which you correctly applied:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.15/can-isotp-sanitize-can-id-checks-in-isotp_bind.patch?id=c0c51980438b5e5b0d758dc28eef5947e57c9c1e
> > 
> > The other stable kernels 5.17, 5.16, 5.10 do not contain the improvement
> > and for that reason I sent an adapted fix, which Greg applied to those
> > kernels, e.g. in 5.17:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.17/can-isotp-sanitize-can-id-checks-in-isotp_bind.patch?id=c0c51980438b5e5b0d758dc28eef5947e57c9c1e
> > 
> > I originally sent this adapted patch to both of you on 02.04.22 11:12
> > ("[PATCH stable v5.10-v5.17] can: isotp: sanitize CAN ID checks in
> > isotp_bind()")
> > 
> > So you could either leave it as-as and only the 5.15 has the improvement
> > OR you remove the two first referenced patches from the 5.15-queue and
> > add only the *adapted* "sanitized CAN ID ..." patch which is applied in
> > 5.17 and the other series. Your choice ;-)
> 
> Looks like we had a mismerge in 5.15. I've dropped the feature patch and
> picked up your backport instead of the one that was in the tree.
> 
> > Sorry for this big pile of patches this time :-/
> 
> Fixes are good :)
> 
> > Finally another hint:
> > 
> > All stable trees (5.10, 5.15, 5.16, 5.17) already contain the patch
> > "can: isotp: support MSG_TRUNC flag when reading from socket" (upstream
> > commit 42bf50a1795a185).
> > 
> > E.g. see
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.17/can-isotp-support-msg_trunc-flag-when-reading-from-s.patch?id=c0c51980438b5e5b0d758dc28eef5947e57c9c1e
> > 
> > This patch is needed but unfortunately introduced a regression which is
> > fixed with this follow up patch here:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=e382fea8ae54f5bb62869c6b69b33993d43adeca
> > 
> > "can: isotp: restore accidentally removed MSG_PEEK feature"
> > 
> > So this last patch needs to be added to 5.10, 5.15, 5.16, 5.17 too.
> 
> I've queued it up for the above trees.

Thanks for fixing up my merge mess here, much appreciated.

greg k-h
