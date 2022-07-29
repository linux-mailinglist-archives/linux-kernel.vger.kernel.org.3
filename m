Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0E6584D37
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiG2INc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiG2INa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:13:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45F281B1A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50ECC61CA5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514A0C433C1;
        Fri, 29 Jul 2022 08:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659082408;
        bh=yDZnCB3APvLSk3XRDlJBpBbSxgoh+g1mEqhb2QgyFDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DoxTatfhQb/8esRQ+KtIyE1ZXjVjpBPY3kglXwx7xahU4peTY6kTo9Q9Eewr9qypb
         P0HxCrA1d22/JFR6nmZRr0aSVWHxKWPxXJ8/n6a6Uz+tXizo8JA/AZm2adRqEdyp1D
         ybJyOHq+wJfDv3wuU2x9St2rAKfz4oPoNXyN5cFM=
Date:   Fri, 29 Jul 2022 10:13:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dipanjan Das <mail.dipanjan.das@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>, perex@perex.cz, tiwai@suse.com,
        consult.awy@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        fleischermarius@googlemail.com, its.priyanka.bose@gmail.com
Subject: Re: KASAN: vmalloc-out-of-bounds Write in snd_pcm_hw_params
Message-ID: <YuOWpk2dDNMuiEDM@kroah.com>
References: <CANX2M5Zw_zW6ez0_wvaXL1pbLnR2jWY=T7MgkT=4a-zNkiwVig@mail.gmail.com>
 <YtuceCr5OCJcDatJ@kroah.com>
 <874jz82kx0.wl-tiwai@suse.de>
 <CANX2M5Ywm+GpYY3+GsOWCLH24Nhy0M0LjBE-pHC8wFcd7SO=wQ@mail.gmail.com>
 <87tu73p1o2.wl-tiwai@suse.de>
 <CANX2M5abRrSADvd3x_rm+TrA2ziu71VL6X3=v_Cft4LtaB=6Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANX2M5abRrSADvd3x_rm+TrA2ziu71VL6X3=v_Cft4LtaB=6Eg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 04:24:12PM -0700, Dipanjan Das wrote:
> On Tue, Jul 26, 2022 at 10:25 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > Thanks for the analysis.  A good news is that, at least for the
> > vmalloc() case, it's a kind of false-positive; vmalloc() always takes
> > the full pages, so practically seen, the size is page-aligned.  It's
> > fooling the memory checker, though.
> >
> > But the similar problem could be seen with genalloc calls, and this
> > was fixed by the upstream commit
> > 5c1733e33c888a3cb7f576564d8ad543d5ad4a9e
> >     ALSA: memalloc: Align buffer allocations in page size
> >
> > I suppose you can simply backport this commit to 5.10.y.  Could you
> > confirm that this fixes your problem?
> 
> We confirm that the patch you proposed fixes the problem (blocks the
> reproducer). How do we proceed with getting the issue fixed? Do we
> send a patch according to the steps detailed here:
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html?

Normally, yes, that is the correct process.  But as Takashi mentioned, I
already picked it up as I happened to see this thread.

thanks,

greg k-h
