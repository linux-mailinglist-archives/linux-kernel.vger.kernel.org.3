Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346E758E890
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiHJISW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiHJISS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:18:18 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B4B83F3D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:18:13 -0700 (PDT)
Received: from vanadium.ugent.be (vanadium.ugent.be [157.193.99.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 61F523091ED;
        Wed, 10 Aug 2022 10:18:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1660119491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z3yd5KzYnzw3eFmZydYb79W7Hsqz+VkDumQMRZwYAVk=;
        b=WSn7AVcsA/ajvykHO59NmIBEj52E8TkSoiJpKsV7pwEfx2Bq9BfSP7+qm2NQTD4x3X6Yyc
        +DV5nZQ5dphB5rPQsedWJhty0pgubTynD4AIqFkiG3KIts6GqEzSosv1/q8F1d4wWzqyW9
        La4DnLT/fRSkBvn0snIJdr/rip5aT0XjWM/++pjBALgJvj9jdf8bDNzeVoz4HZ35GL/cd+
        nlLMFsVfbo4nfkHDlxUj2YjipEVdpgDkKC7vM3XjZ+9mQBYZpRSBlEAb04BghGm5ddPcNE
        gfRxwjhwY35SVym9k/OL+5LHteC9Dkj+5Jr1fnHoLv8p/YrxXK0t2R1RjgJdmw==
Message-ID: <b723f2a292e92a792df95b912404e8d8e8e5e5f4.camel@svanheule.net>
Subject: Re: [PATCH v1 0/3] cpumask: UP optimisation fixes follow-up
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Date:   Wed, 10 Aug 2022 10:18:09 +0200
In-Reply-To: <YvM6LjJCMK4ZKrxK@yury-laptop>
References: <cover.1660066581.git.sander@svanheule.net>
         <YvM6LjJCMK4ZKrxK@yury-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

On Tue, 2022-08-09 at 21:55 -0700, Yury Norov wrote:
> On Tue, Aug 09, 2022 at 07:36:32PM +0200, Sander Vanheule wrote:
> > As an older version of the UP optimisation fixes was merged, not all
> > review feedback has been implemented.=C2=A0 These patches implement the
> > feedback received on the merged version [1], and the respin [2], for
> > changes related to include/linux/cpumask.h and lib/cpumask.c.
> >=20
> > [1] https://lore.kernel.org/lkml/cover.1656777646.git.sander@svanheule.=
net/
> > [2] https://lore.kernel.org/lkml/cover.1659077534.git.sander@svanheule.=
net/
> >=20
> > Sander Vanheule (3):
> > =C2=A0 cpumask: align signatures of UP implementations
> > =C2=A0 lib/cpumask: add inline cpumask_next_wrap() for UP
> > =C2=A0 lib/cpumask: drop always-true preprocessor guard
>=20
> Acked-by: Yury Norov <yury.norov@gmail.com>
>=20
> Applying at bitmap-for-next, after some testing.

Thanks! Any chance to get this in for 6.0? I would rather avoid building cp=
umask.o only on 6.0, but
otherwise I don't think anything is functionally wrong with what is current=
ly merged.

Best,
Sander
