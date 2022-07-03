Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681A85645A6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 09:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiGCHu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 03:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiGCHuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 03:50:55 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6A164CD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 00:50:54 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 5DD052F2F8B;
        Sun,  3 Jul 2022 09:50:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1656834652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S8YcGqEHjJHk34HSjQbYqB2GjJJsnBUKB4IdSCKHySo=;
        b=434PAj6heVFX7rIt/CJoYwBbrDHYgDJZRnQHeFtCZzKQ5n/rTxPqz2osuLW6Fap8wakYmU
        Mr4VbzkDpVtXyf/MSdgiuByqwsDUXTKAS/KoFMr5pvtsRHQpx395Zx6InmNks9a8K5Jb5/
        4j2nTU1aT4PPJarPNBQavrmefWgIYpbCLuyEiaSsd+K+mbk+zzx5aloUxmGuLlPUbaVCrF
        r/O/lLtpFxRua4dF2W9nkMUDe6P/vzth3722EBkKW3EYKsMhBumPvracLuWdNvEm9BvmU9
        2Z6TUshMpxv+ph6RXNFCdBpsr2G45/eoH/gi8H2fdl9ne/NREV8mPlQm66B/mw==
Message-ID: <6a4ea3d21bfb4c692d257d3f38ba28c83f242dfc.camel@svanheule.net>
Subject: Re: [PATCH v4 0/5] cpumask: Fix invalid uniprocessor assumptions
From:   Sander Vanheule <sander@svanheule.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        elver@google.com, gregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, vschneid@redhat.com,
        Yury Norov <yury.norov@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Date:   Sun, 03 Jul 2022 09:50:51 +0200
In-Reply-To: <20220702133840.943817a7694406a135bb48a9@linux-foundation.org>
References: <cover.1656777646.git.sander@svanheule.net>
         <20220702133840.943817a7694406a135bb48a9@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-07-02 at 13:38 -0700, Andrew Morton wrote:
> On Sat,=C2=A0 2 Jul 2022 18:08:23 +0200 Sander Vanheule <sander@svanheule=
.net> wrote:
>=20
> > On uniprocessor builds, it is currently assumed that any cpumask will
> > contain the single CPU: cpu0. This assumption is used to provide
> > optimised implementations.
> >=20
> > The current assumption also appears to be wrong, by ignoring the fact
> > that users can provide empty cpumask-s. This can result in bugs as
> > explained in [1].
>=20
> It's a little unkind to send people off to some link to explain the
> very core issue which this patchset addresses!=C2=A0 So I enhanced this
> paragraph:
>=20
> : The current assumption also appears to be wrong, by ignoring the fact t=
hat
> : users can provide empty cpumasks.=C2=A0 This can result in bugs as expl=
ained in
> : [1] - for_each_cpu() will run one iteration of the loop even when passe=
d
> : an empty cpumask.

Makes sense to add this, sorry for the inconvenience.

Just to make sure, since I'm not familiar with the process for patches goin=
g through the mm tree,
can I still send a v5 to move the last patch forward in the series, and to =
include Yury's tags?

Best,
Sander

> > This series introduces some basic tests, and updates the optimisations
> > for uniprocessor builds.
> >=20
> > The x86 patch was written after the kernel test robot [2] ran into a
> > failed build. I have tried to list the files potentially affected by th=
e
> > changes to cpumask.h, in an attempt to find any other cases that fail o=
n
> > !SMP. I've gone through some of the files manually, and ran a few cross
> > builds, but nothing else popped up. I (build) checked about half of the
> > potientally affected files, but I do not have the resources to do them
> > all. I hope we can fix other issues if/when they pop up later.
> >=20
> > [1] https://lore.kernel.org/all/20220530082552.46113-1-sander@svanheule=
.net/
> > [2] https://lore.kernel.org/all/202206060858.wA0FOzRy-lkp@intel.com/
>=20

