Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFF04C2F46
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiBXPS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiBXPS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FBF141FDC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VjjxYc6tdAv69TRcKyX/ZQ7TSRpmvIcVA3HNv3EAMpo=; b=verhR6D6Ik3pIT9p42/cOkId1b
        +5V3GLpJwhYO1+YhX5HDIiQNm/z3Two9YXaCekNXS1cuGc37LHrqHCIzw65eXqgclUiGR2EYZCCx9
        Y4N9+AKZ+LBsycgIOdhxfof0j+DI0hwoa5sEbE243aFx+8JwK5ziTfgqg6tiHPxlFnOVBMDySX9M4
        zi4FqN7qyU4XS3UtxZm5lJGNmgPUkIq+WKWRnZ9A/T3tDGiaWxG3NrR3whCDvOYAvqwWE+Z0wv2sW
        6NgUpu+wofnhVen5cR3BnoWzM5mf6gAyEcjUMPnPL8c/W4GEtuT43ri7PQ/1MWIoYvFfWskj6opjO
        y8/12kKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs2-004s1p-K2; Thu, 24 Feb 2022 15:17:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 606D0300472;
        Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1B31029E75E47; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224145138.952963315@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:51:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 00/39] x86: Kernel IBT
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an even more complete Kernel IBT implementation.

Since last time (in no specific order):

 - Reworked Xen and paravirt bits lots (andyhpp)
 - Reworked entry annotation (jpoimboe)
 - Renamed CONFIG symbol to CONFIG_X86_KERNEL_IBT (redgecomb)
 - Pinned CR4_CET (kees)
 - Added __noendbr to CET control functions (kees)
 - kexec (redgecomb)
 - made function-graph, kprobes and bpf not explode (rostedt)
 - cleanups and split ups (jpoimboe, mbenes)
 - reworked whole module objtool (nathanchance)
 - attempted and failed at making Clang go

Specifically to clang; I made clang-13 explode by rediscovering:
https://reviews.llvm.org/D111108, then I tried clang-14 but it looks like
ld.lld is still generating .plt entries out of thin air.

Also, I know the very first patch is somewhat controversial amonst the clang
people, but I really think the current state of affairs is abysmal and this
lets me at least use clang.

Patches are also available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt

This series is on top of tip/master along with the linkage patches from Mark:

  https://lore.kernel.org/all/20220216162229.1076788-1-mark.rutland@arm.com/

Enjoy!

