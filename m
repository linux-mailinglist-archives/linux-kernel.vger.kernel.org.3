Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3194E529676
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 03:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbiEQBDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 21:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbiEQBDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 21:03:18 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3267244A18
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 18:03:16 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 8233147B;
        Mon, 16 May 2022 18:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1652749396;
        bh=WcK2JUZcjleYQ+ehJoqWZx1V98FwapKGFaS6k/OLh8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0nNjK825o6tRHWW3XPRoKEtGmyN5Wx2qzJJMWtd3360P2BOJH/AcfQMpVkQT5B7Z
         UQodwU6YcypPd5D/F1Kch895CPbtyFjodwOgNHCd+BZoT0mnoP4SiaWum/MIQjDkvN
         Mjta35KAfqlIWuOkJAnFF2730JxVOYJQ16OBOPc4=
Date:   Mon, 16 May 2022 18:03:12 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chanwoo Choi <cwchoi00@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2 2/2] extcon: Add extcon-regulator driver
Message-ID: <YoL0UGR+TiZojL9Y@hatter.bewilderbeest.net>
References: <20220505232557.10936-1-zev@bewilderbeest.net>
 <20220505232557.10936-3-zev@bewilderbeest.net>
 <e27ff1b2-c82f-8335-340f-ae1fa914ed30@gmail.com>
 <YnkyIBh2HnXXLHw3@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnkyIBh2HnXXLHw3@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding Sebastian for drivers/power discussion]

On Mon, May 09, 2022 at 08:24:16AM PDT, Mark Brown wrote:
> On Mon, May 09, 2022 at 09:24:39PM +0900, Chanwoo Choi wrote:
> > Hi Zev,
> > 
> > I checked this patch. But, it doesn't look like the extcon provider
> > driver. Because basically, extcon provider driver need the circuit
> > in order to detect the kind of external connector. But, there are
> > no any code for detection. Just add the specific sysfs attribute
> > for only this driver. It is not standard interface.
> 
> OTOH it's something where if I look at the physical system with the
> hardware there's a clearly visible external connector that I can point
> to - it just happens to not support hotplug.  It's not clear what other
> system it would sit in, and it seems like an application that displays
> external connections on a system in a UI would be able to do something
> sensible with it.

Chanwoo, any further thoughts on Mark's reasoning above?

I certainly understand the reluctance to add an extcon driver that 
doesn't really do anything with the extcon API, and I have no idea when 
we might end up enhancing it to do something more meaningful with that 
API (I don't know of any hardware at the moment that would need it).

That said, as Mark points out, the hardware *is* ultimately an "external 
connector" (if a very simplistic one).

Do you have any other ideas for where this functionality could go?  Greg 
wasn't enthusiastic about a previous revision that had it in 
drivers/misc -- though now a fair amount of what was in that version is 
now going to be in the regulator core, so maybe that could be 
reconsidered?

Or maybe something under drivers/power, though it's not really a supply 
or a reset device...drivers/power/output.c or something?

Personally I don't have any terribly strong opinions on this, I'd just 
like to reach a mutually-agreeable consensus on a place for it to live.


Thanks,
Zev

