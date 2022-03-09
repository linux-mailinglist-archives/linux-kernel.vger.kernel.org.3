Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E844D34CA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 17:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiCIQ1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238151AbiCIQV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:21:29 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4207F14344A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=C6/n0ZrR9zK0w+X6zEmOY3Yoka9sh8gy0v8jEkCxVM0=; b=jcRm9
        kijG8+vrjh62enKeAf0xrHMHEKBQlQXSoeBHCpx8oi19tOnyErNk8jyFl0Pl4EJi8YjihK/v7Sida
        c2Yi3KNHOoL1NE2KtaZTwQ5uvucLWA9wNHTTk6vcJ8+MP3MXZOJ6d535TgvSjDOmN1GyWiiFrmYIH
        zYrwaeUtM1rMePyAVAD350+y6z9c4px6rjU5M6UAhFv4ExYli0Bn9L8GYyPB64Um5V11we5kfRiY6
        eHOZ/6E3Zg7OsDEaa/u2yQ1r7d1nPwCVq3X7H0NrZRyfz2DBCHVdN/PQZBo5K6wh5Hv5XS/DLHFYJ
        6uPcXOREdAB6QiM+Q3CT+xrPmFY5A==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1nRz2D-0004Ud-2p; Wed, 09 Mar 2022 16:19:33 +0000
Date:   Wed, 9 Mar 2022 16:19:31 +0000
From:   John Keeping <john@metanate.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: tas5805m: fix pdn polarity
Message-ID: <YijTk0/UTXpjFiRq@donbot>
References: <20220309135649.195277-1-john@metanate.com>
 <YijOHNT0eqDyoviP@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YijOHNT0eqDyoviP@sirena.org.uk>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 03:56:12PM +0000, Mark Brown wrote:
> On Wed, Mar 09, 2022 at 01:56:49PM +0000, John Keeping wrote:
> 
> > The binding defines the GPIO as "pdn-gpios" so when the GPIO is active
> > the expectation is that the power down signal is asserted and this is
> > how all other drivers using this GPIO name interpret the value.
> 
> > But the tas5805m driver inverts the sense from the normal expectation so
> > when the powerdown GPIO is logically asserted the chip is running.
> 
> > This is a new driver that is not yet in a released kernel and has no
> > in-tree users of the binding so fix the sense of the GPIO so that
> > logically asserted means that the device is powered down.
> 
> > - Rewrite commit message to make it more obvious that this is a change
> >   to the interpretation of the GPIO in the binding
> 
> I'm still not seeing the functional change here.  The actual state of
> the GPIO is identical in both cases, all that's changing is the logical
> view internally to the kernel.

Ah, sorry, I'm considering it functional since it changes the device
tree ABI.

Used with the same device tree with, say, GPIO_ACTIVE_HIGH the physical
state of the GPIO will change as a result of this patch and the device
tree needs to be updated to use GPIO_ACTIVE_LOW.
