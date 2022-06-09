Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8D0544817
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbiFIJ4c convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Jun 2022 05:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiFIJ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:56:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B6539F24B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:56:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nzEtl-0006P2-4j; Thu, 09 Jun 2022 11:56:17 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nzEtk-007M6H-ST; Thu, 09 Jun 2022 11:56:15 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nzEti-0003tx-Q8; Thu, 09 Jun 2022 11:56:14 +0200
Message-ID: <236b39507da31d80a948fe308f515587e96c28de.camel@pengutronix.de>
Subject: Re: [PATCH] s390: disable -Warray-bounds
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        David Howells <dhowells@redhat.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 09 Jun 2022 11:56:14 +0200
In-Reply-To: <CAHk-=wiFn-_OaWKY=nXt3YSiy=obrNoQW_u7zKO7qoArez=GUw@mail.gmail.com>
References: <20220422134308.1613610-1-svens@linux.ibm.com>
         <202204221052.85D0C427@keescook>
         <CAHk-=wjahn2fZtMxmc4D9UOUGWVws1wZ=X46jrTV=_tEpzXeoA@mail.gmail.com>
         <202206081404.F98F5FC53E@keescook>
         <CAHk-=wiFn-_OaWKY=nXt3YSiy=obrNoQW_u7zKO7qoArez=GUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mi, 2022-06-08 at 16:59 -0700, Linus Torvalds wrote:
> On Wed, Jun 8, 2022 at 2:33 PM Kees Cook <keescook@chromium.org> wrote:
> > 
> > I and others have been working through a bunch of them, though yes,
> > they're not all fixed yet. I've been trying to track it here[1], but
> > many of those fixes are only in -next.
> 
> Hmm. Even with that disabled, I get a few warnings I *really* would
> want to get rid of.
> 
> The one in ipuv3-crtc.c seems valid about "address used as boolean is
> always true".
> 
> The 'dangling-pointer' warning does seem interesting, but not when the
> compiler does as bad a job as gcc seems to do.
> 
> See the attached patch for
> 
>  (a) make the s390 "use -Wno-array-bounds for gcc-12" be generic
> 
>  (b) fix the ipuv3-crtc.c one. IMX people?

Thank you, this fix clearly matches the original intention.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

The mistake had no adverse effect since the following condition doesn't
actually dereference the NULL pointer, but given the compiler warning
this

Fixes: eb8c88808c83 ("drm/imx: add deferred plane disabling")

regards
Philipp
