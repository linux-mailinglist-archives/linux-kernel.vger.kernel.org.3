Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1482B57211E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiGLQjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiGLQjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:39:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEB62E680
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:38:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44CF961946
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 16:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002E6C3411C;
        Tue, 12 Jul 2022 16:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657643927;
        bh=4BDfSSRpMaIphCs/51FX5hBMkKL+h2V39A32PoeENKE=;
        h=Date:From:To:Cc:Subject:From;
        b=VszbvoOQ32Y5tUUOu1X5m/qZVrA8i8HEwF6OfAI3/1iEY8WzgXQYawQzWhkcEHNI1
         zb7w8lqauDh19oVhcNZgsh2p101mFkKJXH45mNi5sZfjBIZjIfjXX0qJk2ixP1XNaA
         1zzD/p9+2gIbYSLAfE5mJBzY40yFlUhhIcHqvp4k=
Date:   Tue, 12 Jul 2022 18:38:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: Build warnings in Xen 5.15.y and 5.10.y with retbleed backports
Message-ID: <Ys2jlGMqAe6+h1SX@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm seeing the following build warning:
	arch/x86/kernel/head_64.o: warning: objtool: xen_hypercall_mmu_update(): can't find starting instruction
in the 5.15.y and 5.10.y retbleed backports.

I don't know why just this one hypercall is being called out by objtool,
and this warning isn't in 5.18 and Linus's tree due to I think commit
5b2fc51576ef ("x86/ibt,xen: Sprinkle the ENDBR") being there.

But, is this a ret call that we "forgot" here?  It's a "real" ret in
Linus's branch:

.pushsection .noinstr.text, "ax"
	.balign PAGE_SIZE
SYM_CODE_START(hypercall_page)
	.rept (PAGE_SIZE / 32)
		UNWIND_HINT_FUNC
		ANNOTATE_NOENDBR
		ANNOTATE_UNRET_SAFE
		ret
		/*
		 * Xen will write the hypercall page, and sort out ENDBR.
		 */
		.skip 31, 0xcc
	.endr

while 5.15.y and older has:
.pushsection .text
	.balign PAGE_SIZE
SYM_CODE_START(hypercall_page)
	.rept (PAGE_SIZE / 32)
		UNWIND_HINT_FUNC
		.skip 31, 0x90
		ANNOTATE_UNRET_SAFE
		RET
	.endr

So should the "ret" remain or be turned into "RET" in mainline right
now?

thanks,

greg k-h
