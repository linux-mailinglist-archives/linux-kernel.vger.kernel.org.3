Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0C553634D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 15:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352185AbiE0N1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 09:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbiE0N1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 09:27:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53B83057F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 06:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=dJg7G2nPL/gjA12rwYq4JM6XgoNicJnOgK9xyJkk0Gg=;
        t=1653658052; x=1654867652; b=U9APU1LJPWUieD2+cduNaRIVhwBPzgdMXfn0k3iNE+WTi2M
        PiizYdN96UrAo0dE4GhM4oEjXOEkAe8QIiyVsGvaIfZiOZU4ncLWqlB8vRoEJVYQNP5o2fABr1DL/
        IAZyEAmLhBOmoQV0Kbnx/udnWaHZ9mGw+dcVXQNnhFN9XSx5IPingLIElp/TdOa3ql5SISsuJkWXw
        8j1f9lKIpDOMzf2INWrj3xk+2MUi6oLW8FVYsHeQqIDaEc5Fpeg5V4WRb11kURRxxOqwTSyxgJrHZ
        Pade4j3CGqEEdGr5JZlOmyDJmQ1YdN7qk0KX7TyCWbnN7eriMCea4mabE5vhA6Ig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nuZzw-0063Un-KX;
        Fri, 27 May 2022 15:27:24 +0200
Message-ID: <134957369d2e0abf51f03817f1e4de7cbf21f76e.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v3] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>
Date:   Fri, 27 May 2022 15:27:23 +0200
In-Reply-To: <CACT4Y+bhBMDn80u=W8VBbn4uZg1oD8zsE3RJJC-YJRS2i8Q2oA@mail.gmail.com>
References: <20220525111756.GA15955@axis.com>
         <20220526010111.755166-1-davidgow@google.com>
         <e2339dcea553f9121f2d3aad29f7428c2060f25f.camel@sipsolutions.net>
         <CACT4Y+ZVrx9VudKV5enB0=iMCBCEVzhCAu_pmxBcygBZP_yxfg@mail.gmail.com>
         <6fa1ebe49b8d574fb1c82aefeeb54439d9c98750.camel@sipsolutions.net>
         <CACT4Y+bhBMDn80u=W8VBbn4uZg1oD8zsE3RJJC-YJRS2i8Q2oA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-27 at 15:18 +0200, Dmitry Vyukov wrote:
> On Fri, 27 May 2022 at 15:15, Johannes Berg <johannes@sipsolutions.net> w=
rote:
> >=20
> > On Fri, 2022-05-27 at 15:09 +0200, Dmitry Vyukov wrote:
> > > > I did note (this is more for kasan-dev@) that the "freed by" is fai=
rly
> > > > much useless when using kfree_rcu(), it might be worthwhile to anno=
tate
> > > > that somehow, so the stack trace is recorded by kfree_rcu() already=
,
> > > > rather than just showing the RCU callback used for that.
> > >=20
> > > KASAN is doing it for several years now, see e.g.:
> > > https://groups.google.com/g/syzkaller-bugs/c/eTW9zom4O2o/m/_v7cOo2RFw=
AJ
> > >=20
> >=20
> > Hm. It didn't for me:
>=20
> Please post a full report with line numbers and kernel version.

That was basically it, apart from a few lines snipped from the stack
traces. Kernel version was admittedly a little older - 5.18.0-rc1 + a
few UML fixes + this KASAN patch (+ the fixes I pointed out earlier)

I guess it doesn't really matter that much, just had to dig a bit to
understand why it was freed.

johannes


