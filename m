Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DDC4E48AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 22:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbiCVVys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 17:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbiCVVyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:54:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6465FF39;
        Tue, 22 Mar 2022 14:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Cb/oh5dHOLa8+0WDevyRK5YUWqorboMG2kg3vlDi1LU=; b=ZsaUSrYhgKaYpSviGWk/HoEYM2
        mqqy5/xDHXphGZdk68wTG0lscCL1QPJvwK3T5iPrnlB1ZsOQfPR+QKnTADetiN2rKDecAfaENNP0E
        AjObEb6zTguM2jgaA+GQ3mMQ843m2P/S0Z6VNxfDRnLPhhuQKf7xIC2NhyzhsKAEyrPwp+1jH/Mzi
        ZPGLCw4jRNnsxRqBPYt/H5yIGCdf8ZiH4N38HFkdRS/eOh+WmcCa9AJH8ufW/MwBuc+2TnEkl6NEJ
        0sjRnFC/1Aey0M6GdbiqdLzPrGPHID0wJpOp2IbQHVETuzk2ooBIy/+7mZccGDfEL+85A1oEEuCCr
        wC2WoSaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWmQw-003Zbq-Iy; Tue, 22 Mar 2022 21:52:54 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E839986226; Tue, 22 Mar 2022 22:52:52 +0100 (CET)
Date:   Tue, 22 Mar 2022 22:52:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <20220322215252.GU8939@worktop.programming.kicks-ass.net>
References: <20220322145108.2878ed64@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220322145108.2878ed64@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 02:51:08PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
> produced these warnings:
>=20
> WARNING: modpost: EXPORT symbol "device_match_devt" [vmlinux] version ...
> Is "device_match_devt" prototyped in <asm/asm-prototypes.h>?
>=20
> I get thousands like this :-(
>=20
> I don't know what has done this, but there is a new Kbuild and modpost
> change:
>=20
>   2f35e67f621f ("kbuild: Fixup the IBT kbuild changes")

It was; I rebased that commit and asked Boris to regen tip so you should
have it fixed for the next round.
