Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556004A6EB5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245457AbiBBK34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:29:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41838 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiBBK3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:29:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BC5A61596;
        Wed,  2 Feb 2022 10:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DDAC004E1;
        Wed,  2 Feb 2022 10:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643797793;
        bh=YVcweAmybZzB3DjEy6aQsOiptb9/VRCssQtFzzlnt9s=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=CdY/KtVvzPx5mtob/murCFCpzsSSGfCEcJatXmzbmGQ1zup4EDpu/U3CeT1L99GdH
         d9NNWDxK3V7luNEhpeBSXHyajcSReh1YyO3ZXd5tV4tRuqqvM0LQVBRhmtZck7mWCl
         pyboC/iyimKvtGuveAStpQka9vn3eyFIAtkVL4Fw=
Date:   Wed, 2 Feb 2022 11:29:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 1/2] config: android-recommended: Don't explicitly
 disable CONFIG_AIO
Message-ID: <YfpdH9zOLiWQBgU7@kroah.com>
References: <20220202093314.107927-1-marijn.suijten@somainline.org>
 <YfpS19cSbsSTgKVk@kroah.com>
 <20220202101246.qinrngus3llyjwo6@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202101246.qinrngus3llyjwo6@SoMainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 11:12:46AM +0100, Marijn Suijten wrote:
> On 2022-02-02 10:45:59, Greg Kroah-Hartman wrote:
> > On Wed, Feb 02, 2022 at 10:33:13AM +0100, Marijn Suijten wrote:
> > > Android nowadays (for a couple years already) requires AIO for at least
> > > its `adb` "Android Debug Bridge" [1].  Without this config option
> > > (`default y`) it simply refuses start, making users unable to connect to
> > > their phone for debugging purposes when using these kernel fragments.
> > > 
> > > [1]: https://cs.android.com/android/_/android/platform/packages/modules/adb/+/a2cb8de5e68067a5e1d002886d5f3b42d91371e1
> > > 
> > > Cc: Amit Pundir <amit.pundir@linaro.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: John Stultz <john.stultz@linaro.org>
> > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > ---
> > >  kernel/configs/android-recommended.config | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/kernel/configs/android-recommended.config b/kernel/configs/android-recommended.config
> > > index eb0029c9a6a6..22bd76e43aca 100644
> > > --- a/kernel/configs/android-recommended.config
> > > +++ b/kernel/configs/android-recommended.config
> > > @@ -1,5 +1,4 @@
> > >  #  KEEP ALPHABETICALLY SORTED
> > > -# CONFIG_AIO is not set
> > >  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> > >  # CONFIG_INPUT_MOUSE is not set
> > >  # CONFIG_LEGACY_PTYS is not set
> > > -- 
> > > 2.35.1
> > > 
> > 
> > There are lots of "required" configs now for modern Android releases, do
> > you want to sync up with all of them here?  If so, look at the
> > gki_defconfig files in the AOSP kernels for the full list of what is
> > required.  Is it really needed to keep this file up to date or should it
> > be dropped entirely given that no one has noticed how out-of-date it is?
> 
> This is all I need for now to get Android booting with a mainline
> kernel, no fancy features though that make the device worthy of being a
> phone (pending hardware drivers).

Why is adb needed to boot?

I know some Android people are working to try to get rid of the AIO
requirement of adb, as it's only a debugging tool (an important one,
yes), so they can turn off AIO in the kernel image due to the complexity
there.  So why turn it back on here?

> Perhaps replacing these config fragments with gki_defconfig upstream
> is a good idea - as discussed with John - but that's not something for
> me to decide nor embark on :).
> Having them upstreamed might be nicer than finding the appropriate
> corresponding downstream tree.

Keeping defconfigs up to date is a loosing battle for the most part, I
doubt many platforms actually do this well.

thanks,

greg k-h
