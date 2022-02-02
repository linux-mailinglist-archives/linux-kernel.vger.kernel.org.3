Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD724A6E71
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245738AbiBBKMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:12:50 -0500
Received: from relay05.th.seeweb.it ([5.144.164.166]:45795 "EHLO
        relay05.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiBBKMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:12:48 -0500
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 85EBA3F7B3;
        Wed,  2 Feb 2022 11:12:47 +0100 (CET)
Date:   Wed, 2 Feb 2022 11:12:46 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     phone-devel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 1/2] config: android-recommended: Don't explicitly
 disable CONFIG_AIO
Message-ID: <20220202101246.qinrngus3llyjwo6@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        phone-devel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <john.stultz@linaro.org>
References: <20220202093314.107927-1-marijn.suijten@somainline.org>
 <YfpS19cSbsSTgKVk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfpS19cSbsSTgKVk@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-02 10:45:59, Greg Kroah-Hartman wrote:
> On Wed, Feb 02, 2022 at 10:33:13AM +0100, Marijn Suijten wrote:
> > Android nowadays (for a couple years already) requires AIO for at least
> > its `adb` "Android Debug Bridge" [1].  Without this config option
> > (`default y`) it simply refuses start, making users unable to connect to
> > their phone for debugging purposes when using these kernel fragments.
> > 
> > [1]: https://cs.android.com/android/_/android/platform/packages/modules/adb/+/a2cb8de5e68067a5e1d002886d5f3b42d91371e1
> > 
> > Cc: Amit Pundir <amit.pundir@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: John Stultz <john.stultz@linaro.org>
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >  kernel/configs/android-recommended.config | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/kernel/configs/android-recommended.config b/kernel/configs/android-recommended.config
> > index eb0029c9a6a6..22bd76e43aca 100644
> > --- a/kernel/configs/android-recommended.config
> > +++ b/kernel/configs/android-recommended.config
> > @@ -1,5 +1,4 @@
> >  #  KEEP ALPHABETICALLY SORTED
> > -# CONFIG_AIO is not set
> >  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> >  # CONFIG_INPUT_MOUSE is not set
> >  # CONFIG_LEGACY_PTYS is not set
> > -- 
> > 2.35.1
> > 
> 
> There are lots of "required" configs now for modern Android releases, do
> you want to sync up with all of them here?  If so, look at the
> gki_defconfig files in the AOSP kernels for the full list of what is
> required.  Is it really needed to keep this file up to date or should it
> be dropped entirely given that no one has noticed how out-of-date it is?

This is all I need for now to get Android booting with a mainline
kernel, no fancy features though that make the device worthy of being a
phone (pending hardware drivers).  Perhaps replacing these config
fragments with gki_defconfig upstream is a good idea - as discussed with
John - but that's not something for me to decide nor embark on :).
Having them upstreamed might be nicer than finding the appropriate
corresponding downstream tree.

- Marijn
