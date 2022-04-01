Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE124EF9D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351016AbiDAS27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351001AbiDAS24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:28:56 -0400
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Apr 2022 11:27:04 PDT
Received: from relay3-g.mailbaby.net (relay3-g.mailbaby.net [66.45.229.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DB31AC72A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbaby.net;
 q=dns/txt; s=bambino; bh=k/8TzgWh4nCFw8vlYksITye8TseoA5qe5lkr22s9LRM=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
 b=CdeC4ZY2hK2fPpmP9+TEkLWiAr/FZgPEcWPFzXwO5wqvn1d41k61OQ3GidNyBqpk0e1ccTddK
 hi4OBcCpJ5MEGlpyhZbCcZXsyU+nkf0Bo80/tVCgp6jNkI4oalMX5vnlbWI3/TjNB7uVbzpPyxN
 v/cY0arAL9s9BrU3PAUgeTs=
Received: from mia1000.iaasdns.com ([162.254.200.130] mia1000.iaasdns.com)
 (Authenticated sender: mb6724)
 by relay3-g.mailbaby.net (InterServerMTA) with ESMTPSA id 17fe65cc526000e98b.005
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Fri, 01 Apr 2022 18:21:53 +0000
X-Zone-Loop: e1a3459bda5f8a9327bc00dc4b375de19f10a437fc36
ARC-Authentication-Results: i=1;        relay1.mailbaby.net;    auth=pass
 smtp.auth=mb6724 smtp.mailfrom=codeagain@codeagain.dev
ARC-Seal: i=1; s=detka; d=mailbaby.net; t=1648837313; a=rsa-sha256;
        cv=none;
        b=eU2Pwi2yb4MB/glvYZSZq3OQE0P5F6DK915Ko5gt1S6DtqRSu086ycEIWFV1AaLMOkg+dO
        9J2oBaAwxcd1rqmeUUUvV7LI1tR/IzV0ZhIW2f7sagrwmxKZWiIOvAVsBWSWEtzskVdL+f
        R8cvcvNb1ZVdIEBJIUcOomRtUMF05GRaIJ9X2Ub7/xoxVNnKk5tQVAyPM+xlPsb1sqEmVa
        7TSvzH4TMPJBCgtOEjmfl8LEhSPaUp1NwDuLtFd26f5QCUHxYoCOeBaOj/02GLkd9YGbMw
        KpxuefjKh7PJZIaUPryxLEN0Q3VKZCDPKFROIP158y69vYFO49oviSh8K+hjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbaby.net;        s=detka; t=1648837313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/8TzgWh4nCFw8vlYksITye8TseoA5qe5lkr22s9LRM=;
        b=tgqM7wtGQ7BKnNsAqe2Ft9Fo1FDE3JLUPaX4buFmhhaQ96s+RQgnfvSLoytPeEklBYfvX8
        x7kDvmhCTI/OX6dHpcU872++mCO0tB4/mz4pqVsq+83bsCAfemYCEVm5tHxNFNBYKcTHIY
        6T1G7ZCA/rgSs6WDrkNZbE5XwuDjy+8RAawm+nnAgqz7jGFBKluofcg6l91KC1ClupJdJ3
        8k+0XtPMDNn323NKM0+q85VF4LnzRLQJtF1sOMGY7v/rc2rF1QL18aeRNhLOQSrwr0VgdS
        qlck4HnGvZCqpenuWfskAQdnbBPCRyN8tt07hQqOhunbal2XatAraeRFZMifKw==
X-Originating-IP: [162.254.200.130]
Received: from [170.84.58.28] (port=24959 helo=[192.168.21.4])
        by mia1000.iaasdns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <codeagain@codeagain.dev>)
        id 1naLuC-0000Ej-Va; Fri, 01 Apr 2022 14:21:53 -0400
Message-ID: <37e5203d1efd310ea82cf91c18c6a07eea743ac7.camel@codeagain.dev>
Subject: Re: [PATCH] staging: vme: Adjusted VME_USER in Kconfig
From:   Bruno <codeagain@codeagain.dev>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Date:   Fri, 01 Apr 2022 15:21:50 -0300
In-Reply-To: <YkaXRpIElW1BwKGb@kroah.com>
References: <20220401050045.3686663-1-codeagain@codeagain.dev>
         <YkaW0ThT8Ah3z0wW@kroah.com> <YkaXRpIElW1BwKGb@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: me@brunodout.dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-01 at 08:10 +0200, reg Kroah-Hartman wrote:
> On Fri, Apr 01, 2022 at 08:08:17AM +0200, reg Kroah-Hartman wrote:
> > On Fri, Apr 01, 2022 at 02:00:45AM -0300, Bruno Moreira-Guedes
> > wrote:
> > > Currently, the VME_USER driver is in the staging tree Kconfig,
> > > unlike
> > > other VME drivers already moved to the main portions of the
> > > kernel tree.
> > > Its configuration is, however, nested into the VME_BUS config
> > > option,
> > > which might be misleading.
> > > 
> > > Since the staging tree "[...] is used to hold stand-alone[1]
> > > drivers and
> > > filesystem that are not ready to be merged into the main portion
> > > of the
> > > Linux kernel tree [...]"[1], IMHO all staging drivers should
> > > appear
> > > nested into the Main Menu -> Device Drivers -> Staging Drivers
> > > to make
> > > sure the user don't pick it without being fully aware of its
> > > staging
> > > status as it could be the case in Menu -> Device Drivers -> VME
> > > bridge
> > > support (the current location).
> > > 
> > > With this change menuconfig users will clearly know this is not
> > > a driver
> > > in the main portion of the kernel tree and decide whether to
> > > build it or
> > > not with that clearly in mind.
> > > 
> > > This change goes into the same direction of commit 4b4cdf3979c3
> > > ("STAGING: Move staging drivers back to staging-specific menu")
> > > 
> > > [1] https://lkml.org/lkml/2009/3/18/314
> > > 
> > > Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
> > > ---
> > >  drivers/staging/Kconfig | 2 ++
> > >  drivers/vme/Kconfig     | 2 --
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> > > index 932acb4e8cbc..0545850eb2ff 100644
> > > --- a/drivers/staging/Kconfig
> > > +++ b/drivers/staging/Kconfig
> > > @@ -88,4 +88,6 @@ source "drivers/staging/qlge/Kconfig"
> > >  
> > >  source "drivers/staging/wfx/Kconfig"
> > >  
> > > +source "drivers/staging/vme/devices/Kconfig"
> > > +
> > >  endif # STAGING
> > > diff --git a/drivers/vme/Kconfig b/drivers/vme/Kconfig
> > > index 936392ca3c8c..c13dd9d2a604 100644
> > > --- a/drivers/vme/Kconfig
> > > +++ b/drivers/vme/Kconfig
> > > @@ -15,6 +15,4 @@ source "drivers/vme/bridges/Kconfig"
> > >  
> > >  source "drivers/vme/boards/Kconfig"
> > >  
> > > -source "drivers/staging/vme/devices/Kconfig"
> > > -
> > >  endif # VME
> > > -- 
> > > 2.35.1
> > > 
> > > 
> > 
> > The problem with this change is that you just changed the
> > initialization
> > order of the drivers if they are built into the kernel.  Are you
> > sure
> > that you can initialize a vme device driver before the vme bridge
> > and
> > bus code is run?  I don't know if that will work properly, which
> > is why
> > the Kconfig entries are in the order they currently are in (we
> > preserved
> > the link order.)
> > 
> > It's not an obvious thing at all, sorry, but build order defines
> > link
> > order, which defines the order in which things are initialized in
> > the
> > kernel.
> > 
> > So I can't take this change unless you are able to prove that it
> > still
> > works properly on the hardware that these drivers control.  Do you
> > have
> > this hardware to test this change with?
> 
> Oh wait, it's the Makefile order that controls this, not the Kconfig
> order.  Sorry for the noise here, it's still early...

No worries, your previous message was quite helpful to make realize
some scenarios I wasn't considering at first. I did a more throrough
inspection of how this patch impacts everything thanks to this
observations.

I don't have the hardware so indeed I'm avoiding changes that would
need it to be tested, and as far as I'm properly aware my patch just
changes the places of things in the config targets. Build is protected
from such changes through some Makefile validations such as in
drivers/staging/Makefile:
| obj-$(CONFIG_VME_BUS)           += vme/

> 
> So this change _should_ be fine, but it would be good if you could
> prove it still works with some build tests.  How did you test this
> change?

At first I ran menuconfig and tested if it was still properly setting
CONFIG_VME_USER. Then I built with CONFIG_VME_USER=m and
CONFIG_VME_USER=n to check if it would build the module.

After your first e-mail I realized I didn't account for
CONFIG_VME_USER=y on my tests. I have now successfuly built with this
option too. Are those enough tests for this situation?

> 
> thanks,
> 
> greg k-h
> 

With my tests in my, I have found two other things that I think are
remarkable to mention. First one is a missing `depends on` line for
`VME_BRIDGE` in drivers/staging/vme/devices/Kconfig, not visible
because they were in the same tree, but now unveiled. I'm fixing it,
do you think it's best to add it in the same patch?

Finally, not directly related with the patch, yet remarkable, I
happened to notice something. When probing the vme_user module
(compiled with CONFIG_VME_USER=m), I naturally get the following
messages on my log and command output for `modprobe vme_user`:
| [177666.590400] vme_user: module is from the staging directory, the
quality is unknown, you have been warned.
| [177666.601166] vme_user: VME User Space Access Driver
| [177666.602111] vme_user: No cards, skipping registration modprobe:
| ERROR: could not insert 'vme_user': No such device

While this is completely expected, the message about the code from
staging directory does not appear when compiled with
CONFIG_VME_USER=y, as shows a `grep -i vme` on the console log:

| [0.000000] Linux version 5.17.0lsa-t-vme_user=y-13483-gfeb94431c35c-
dirty (bruno@AN5Bruno) (gcc (GCC) 11.2.0, GNU ld (GNU Binutils) 2.38)
#7 SMP PREEMPT_DYNAMIC Fri Apr 1 14:33:16 -03 2022
| [1.974450] vme_user: VME User Space Access Driver
| [ 1.975405] vme_user: No cards, skipping registration

Do you think it would be interesting for a future patch to provide
some output when drivers from the staging tree are present in the
running kernel image?

-- 
Sincerely,
Bruno | Pronouns: they/them/theirs
IRC: CodeAgain
