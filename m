Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91DE53FE4A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243381AbiFGMGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243364AbiFGMGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:06:43 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AA5F5534
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:06:42 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id E1BD22E4121;
        Tue,  7 Jun 2022 14:06:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1654603600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdrQnA0CzKhjQ+CgZgjEDrbnfx2bIpwxnd6bAIdma/8=;
        b=yHXlR8F6kxpuHuFORN3C2tx/0B2EyluclDsB8VqR0EKZtCbRLTOnXuhbJ4FOC1DHLkACqL
        cFggm0LtZMHPWWhllzMGFBRIZdsBn8RWKPYiWlXjJ/pGKQsGlSwoI1yybFbjEp7EsrTw+j
        3xnKC8lQMVpJlsSRDEJkSWaBB3DWNW3Nsb2TJ4O+/uwMKjMSp2kloDNuKmGpdxTLnFBXsr
        sqnhOX1G4MMQdNn+pu6K62bts8OOp1/oWLIoGTa8EES5PbpSpyUUtIc8j89zJVH9gh7oR4
        3z/aa49hef/NzXinXMb2G8KOh67o+Okvea32YRVZ5lZsyrd55ufrDWxm5CiRjw==
Message-ID: <541d89b3aa2092382405672b70b58b5b3d263f1e.camel@svanheule.net>
Subject: Re: [PATCH v3 1/4] cpumask: Fix invalid uniprocessor mask assumption
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Tue, 07 Jun 2022 14:06:38 +0200
In-Reply-To: <Yp5SJAkq8whC8EBI@yury-laptop>
References: <cover.1654410109.git.sander@svanheule.net>
         <cc1f7d3334348cccbf9fde091015a802f379a9be.1654410109.git.sander@svanheule.net>
         <Yp5SJAkq8whC8EBI@yury-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-06 at 12:14 -0700, Yury Norov wrote:
> On Sun, Jun 05, 2022 at 08:22:38AM +0200, Sander Vanheule wrote:
> > On uniprocessor builds, any CPU mask is assumed to contain exactly one
> > CPU (cpu0). This assumption ignores the existence of empty masks,
> > resulting in incorrect behaviour.
> > cpumask_first_zero(), cpumask_next_zero(), and for_each_cpu_not() don't
> > provide behaviour matching the assumption that a UP mask is always "1",
> > and instead provide behaviour matching the empty mask.
> >=20
> > Drop the incorrectly optimised code and use the generic implementations
> > in all cases.
> >=20
> > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > ---

[...]

> > -static inline unsigned int cpumask_local_spread(unsigned int i, int no=
de)
> > -{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > -}
> > -
> > -static inline int cpumask_any_and_distribute(const struct cpumask *src=
1p,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct cpumask *src2p) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return cpumask_first_and(src=
1p, src2p);
> > -}
> > -
> > -static inline int cpumask_any_distribute(const struct cpumask *srcp)
> > -{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return cpumask_first(srcp);
> > -}
>=20
> It looks like cpumask_local_spread, cpumask_any_and_distribute and
> cpumask_any_distribute were correct and better optimized in UP case.
> cpumask_local_spread - for sure. I think it's worth keeping them
> optimized.

Yes, these were correct and we can keep them. I will have to add an #ifded =
CONFIG_SMP (or #if
NR_CPUS > 1) guard in lib/cpumask.c around these functions, so they don't c=
ollide with the inlined
UP versions.

Best,
Sander
