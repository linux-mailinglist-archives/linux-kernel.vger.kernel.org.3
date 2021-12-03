Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D374670F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378434AbhLCD6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:58:38 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:45915 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhLCD6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:58:37 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J4zVm6JgMz4xQs;
        Fri,  3 Dec 2021 14:55:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1638503713;
        bh=CBcjaqWL5ywYRsLFA1bPdUjs/lKp7sGGKXcCqCVDPpA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ImBzqzy3hk58qj4+MzIK46abtIMGdkXPlKdMKe+c40R+FVcOYZg47nvV28/C7kvMH
         gNNpypJKL1sjYH2+g3vp+qE9/CKJE5T+68Zb3tTGNtPuCITgrHLv22VJis5ANEKfw9
         M23c94ciHb/s0gNLQJzR+wywGldXLYAuaxAHYOBPwQ1ULMRKsBZj5ibQ8zVQiIBJFB
         jCeq01a/NgDzfWoxfRpcy63VjCgY8gBGkFGVz7/1+gcF6MN5VFZMq1RrUYw/iswqy6
         0rusDl2tbQ+G+D+tHEJ5LgPQO3psy0x/vtJ/ePVDYnCBtZTWLZwrudL/3xb1es0/4m
         +P+Y3gR/xGDOw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32s: Allocate one 256k IBAT instead of two
 consecutives 128k IBATs
In-Reply-To: <ab58b296832b0ec650e2203200e060adbcb2677d.1637930421.git.christophe.leroy@csgroup.eu>
References: <ab58b296832b0ec650e2203200e060adbcb2677d.1637930421.git.christophe.leroy@csgroup.eu>
Date:   Fri, 03 Dec 2021 14:55:09 +1100
Message-ID: <871r2upcki.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Today we have the following IBATs allocated:
>
> 	---[ Instruction Block Address Translation ]---
> 	0: 0xc0000000-0xc03fffff 0x00000000         4M Kernel   x     m
> 	1: 0xc0400000-0xc05fffff 0x00400000         2M Kernel   x     m
> 	2: 0xc0600000-0xc06fffff 0x00600000         1M Kernel   x     m
> 	3: 0xc0700000-0xc077ffff 0x00700000       512K Kernel   x     m
> 	4: 0xc0780000-0xc079ffff 0x00780000       128K Kernel   x     m
> 	5: 0xc07a0000-0xc07bffff 0x007a0000       128K Kernel   x     m
> 	6:         -
> 	7:         -
>
> The two 128K should be a single 256K instead.
>
> When _etext is not aligned to 128Kbytes, the system will allocate
> all necessary BATs to the lower 128Kbytes boundary, then allocate
> an additional 128Kbytes BAT for the remaining block.
>
> Instead, align the top to 128Kbytes so that the function directly
> allocates a 256Mbytes last block:
                 ^

I think that's meant to be 256Kbytes, I changed it when committing.

> 	---[ Instruction Block Address Translation ]---
> 	0: 0xc0000000-0xc03fffff 0x00000000         4M Kernel   x     m
> 	1: 0xc0400000-0xc05fffff 0x00400000         2M Kernel   x     m
> 	2: 0xc0600000-0xc06fffff 0x00600000         1M Kernel   x     m
> 	3: 0xc0700000-0xc077ffff 0x00700000       512K Kernel   x     m
> 	4: 0xc0780000-0xc07bffff 0x00780000       256K Kernel   x     m
> 	5:         -
> 	6:         -
> 	7:         -
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>


cheers
