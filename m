Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D384D3AE8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbiCIURT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiCIURS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:17:18 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C023A76E3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=qUvLtHVMxTZ4ULy0Xu+hnD7i1YDCW7jL7kYz3fRzYx0=; b=r09/x
        qQt0qRQh+AM35iZCcudF+6CBVQGdzRQj4JeL4SoJFWWt11x/hSCyuHje3oncg7+TSLqfmWoJ/VPFh
        yHxHZw84ES+tTvqWk0uPMEak5HHaRfUAu/aHEOJlQs61iTR+QOwXs8YvSbTO0OyHY4gdsu+AiJJeB
        7HEQ3FGbDXri6/qwMjVo4hvsd97uTd6Lb8i03iuccRfRp7kMf2EJumvBVnZ3zxWR8VB/jkATVxnBf
        xC9t3K/T2UwDIJsc95C+3q+iW3DFQ/5zyI/M0aP4vpYMvWTJH6Wev7W6AY54VjJq+kPZsrh2G2hsh
        c9wgKd6crytfY08DtWcoftRnr5FSw==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1nS2jB-0007ax-5w; Wed, 09 Mar 2022 20:16:09 +0000
Date:   Wed, 9 Mar 2022 20:16:07 +0000
From:   John Keeping <john@metanate.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: tas5805m: fix pdn polarity
Message-ID: <YikLB4+xHVxjFTSL@donbot>
References: <20220309135649.195277-1-john@metanate.com>
 <YijOHNT0eqDyoviP@sirena.org.uk>
 <YijTk0/UTXpjFiRq@donbot>
 <YijVrgZ+Ysv9J/8E@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YijVrgZ+Ysv9J/8E@sirena.org.uk>
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

On Wed, Mar 09, 2022 at 04:28:30PM +0000, Mark Brown wrote:
> On Wed, Mar 09, 2022 at 04:19:31PM +0000, John Keeping wrote:
> > On Wed, Mar 09, 2022 at 03:56:12PM +0000, Mark Brown wrote:
> 
> > > I'm still not seeing the functional change here.  The actual state of
> > > the GPIO is identical in both cases, all that's changing is the logical
> > > view internally to the kernel.
> 
> > Ah, sorry, I'm considering it functional since it changes the device
> > tree ABI.
> 
> > Used with the same device tree with, say, GPIO_ACTIVE_HIGH the physical
> > state of the GPIO will change as a result of this patch and the device
> > tree needs to be updated to use GPIO_ACTIVE_LOW.
> 
> I think the device tree binding needs to be clarified here to be
> explicit about this since there's obviously some room for user confusion
> here.  We can probably get away with a change at this point since it's
> not hit a release but we do need to try to avoid the situation where any
> other implementations use active high polarity for the bindings.

Taking a quick survey of the other devices that have a pdn-gpios
property:

- tvp5150 is correct with the driver setting 0 to make the device active

- tas571x also sets 0 to make the device active

- ak4375 uses the opposite sense setting PDN = 1 to make the device
  active; this has no in-tree users and was merged as part of v5.17-rc1
  so it's not in a released kernel yet
