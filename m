Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B3057FEE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbiGYMWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiGYMWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:22:37 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B925167FA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:22:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lrzh93WXkz4xD9;
        Mon, 25 Jul 2022 22:22:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658751753;
        bh=5Fl0RHlEgXuBE2WPauMEneaFCDwh//pAstIMXhcK4IQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QMXMm72WGBtS6Qf4YunmB9MFolK45aDmMEUUmEeRDcGMBGvAJ3FbBz/aN/D5KIg2X
         s0SoQinKa2Cd1l4joa0rdtgPew9uj87CfgyTzuo7MZ/UHAvsBGtVjiFBs5fd3IqCgO
         tOKpb8Vec5dLh1oGpqV51mIEsqxu7CKR1WGaviPraHvsyVLzwqXx017DKYWMZQPfwq
         /OUuwgwhBrUDBkfAGVyRwcgg8U6HHx/ypEE75o+nAdG+gzAsxEpe2Zl14iSyCyj1/a
         dV+OFBRViom+W2CX2faWctnMv2lPgqniUxqtTGcvgBUGqybQitIKSOYnzMh7idmkHL
         D7S7jZnKO2Q4g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 1/2] powerpc: drop dependency on <asm/machdep.h> in
 archrandom.h
In-Reply-To: <20220723214537.2054208-2-yury.norov@gmail.com>
References: <20220723214537.2054208-1-yury.norov@gmail.com>
 <20220723214537.2054208-2-yury.norov@gmail.com>
Date:   Mon, 25 Jul 2022 22:22:33 +1000
Message-ID: <87tu75bcvq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yury Norov <yury.norov@gmail.com> writes:
> archrandom.h includes <asm/machdep.h> to refer ppc_md. This causes
> circular header dependency, if generic nodemask.h  includes random.h:
>
> In file included from include/linux/cred.h:16,
>                  from include/linux/seq_file.h:13,
>                  from arch/powerpc/include/asm/machdep.h:6,
>                  from arch/powerpc/include/asm/archrandom.h:5,
>                  from include/linux/random.h:109,
>                  from include/linux/nodemask.h:97,
>                  from include/linux/list_lru.h:12,
>                  from include/linux/fs.h:13,
>                  from include/linux/compat.h:17,
>                  from arch/powerpc/kernel/asm-offsets.c:12:
> include/linux/sched.h:1203:9: error: unknown type name 'nodemask_t'
>  1203 |         nodemask_t                      mems_allowed;
>       |         ^~~~~~~~~~
>
> Fix it by removing <asm/machdep.h> dependency from archrandom.h
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/powerpc/include/asm/archrandom.h |  9 +--------
>  arch/powerpc/kernel/setup-common.c    | 11 +++++++++++
>  2 files changed, 12 insertions(+), 8 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
