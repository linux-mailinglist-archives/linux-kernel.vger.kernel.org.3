Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BC14B1D45
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 05:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242470AbiBKEKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 23:10:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiBKEKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 23:10:13 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EB495
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 20:10:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jw0Wc719Rz4xcl;
        Fri, 11 Feb 2022 15:10:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1644552611;
        bh=RFsFjuurNBFd2aL+0sg0sXo9uTFRidxaWUgwOIgeZgM=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=Pg/t2qDQ/ohBUbWL2BXoOJZ/DzTFgFXC/f+noNff+KFgsYyqr05TeFDx1QR2E/XXJ
         ImF/OF6qjN3BRqpHCZ3C+Sm0Jt6zeVw8ISneyZbC4ElRqQofikI/4OoHggWpIMlkMi
         fBPDFia3KAfChQdV0serdS6occ5yWuLLgIVMCgvsGy4foONOhZVDVEEb9tsGkcb96c
         v0n8osmRE1S0YPTKo82ItglVuNZ+pQRUkWGmcZQg5JSlz/aaywfNXDpsV7Mlo9RB5k
         fhp7zZQBf7p9Ynzvun2jUUMIX5GYlyohyIelLyAKoCfnKBiItuZ37ewWMfgfTg2OGu
         ySFqR7lgMG+gw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Yury Norov <yury.norov@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Parth Shah <parth@linux.ibm.com>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Rob Herring <robh@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Xiongwei Song <sxwjean@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 38/49] arch/powerpc: replace cpumask_weight with
 cpumask_weight_{eq, ...} where appropriate
In-Reply-To: <20220210224933.379149-39-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-39-yury.norov@gmail.com>
Date:   Fri, 11 Feb 2022 15:10:02 +1100
Message-ID: <87tud6rqlh.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yury Norov <yury.norov@gmail.com> writes:
> PowerPC code uses cpumask_weight() to compare the weight of cpumask with
> a given number. We can do it more efficiently with cpumask_weight_{eq, ...}
> because conditional cpumask_weight may stop traversing the cpumask earlier,
> as soon as condition is (or can't be)  met.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/powerpc/kernel/smp.c      | 2 +-
>  arch/powerpc/kernel/watchdog.c | 2 +-
>  arch/powerpc/xmon/xmon.c       | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
