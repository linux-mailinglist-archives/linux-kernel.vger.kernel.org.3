Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307CE4B2705
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345241AbiBKNZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:25:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239313AbiBKNZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:25:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D46D5D54
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 05:25:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C42C1042;
        Fri, 11 Feb 2022 05:25:02 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.87.94])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11A773F718;
        Fri, 11 Feb 2022 05:24:58 -0800 (PST)
Date:   Fri, 11 Feb 2022 13:24:49 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>, acme@redhat.com,
        ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        will@kernel.org, llvm@lists.linux.dev,
        James Y Knight <jyknight@google.com>
Subject: Re: [PATCH v2 2/7] linkage: add SYM_{ENTRY,START,END}_AT()
Message-ID: <YgZjofwviaYFS88O@FVFF77S0Q05N>
References: <20220125113200.3829108-1-mark.rutland@arm.com>
 <20220125113200.3829108-3-mark.rutland@arm.com>
 <YgUmvuJYfycnhODA@FVFF77S0Q05N>
 <CAKwvOdmWV6AL2RM2SQNYQ7fu3kQwPf+W57LZ_szrfZm2eLtBcw@mail.gmail.com>
 <YgZJS6mDoAgVqC4l@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgZJS6mDoAgVqC4l@FVFF77S0Q05N>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 11:32:27AM +0000, Mark Rutland wrote:
> On Thu, Feb 10, 2022 at 05:20:10PM -0800, Nick Desaulniers wrote:
> > On Thu, Feb 10, 2022 at 6:52 AM Mark Rutland <mark.rutland@arm.com> wrote:
 > For the expression
> > 
> > > .if (qwerty_fiqin_end - qwerty_fiqin_start) > (0x200 - 0x1c)
> > 
> > can you use local labels (`.L` prefix) rather than symbolic
> > references? or is there a risk of them not being unique per TU?
>
> For the problem in this patch I might be able to do something of that shape,
> but I'll need to factor the SYM_*() helpers differently so that I can use
> labels for the primary definition.

FWIW, that refactoring turned out to be easier than I expected, and I actually
prefer the new structure.

I've ended up dropping this patch, and in the next patch I leave
SYM_FUNC_START() unchanged, but calculate the size in SYM_FUNC_END() and
propagate that to all the aliases pre-calculated:

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index dbf8506decca..027ab1618bf8 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -165,7 +165,18 @@
 #ifndef SYM_END
 #define SYM_END(name, sym_type)                                \
        .type name sym_type ASM_NL                      \
-       .size name, .-name
+       .set .L__sym_size_##name, .-name ASM_NL         \
+       .size name, .L__sym_size_##name
+#endif
+
+/* SYM_ALIAS -- use only if you have to */
+#ifndef SYM_ALIAS
+#define SYM_ALIAS(alias, name, sym_type, linkage)                      \
+       linkage(alias) ASM_NL                                           \
+       .set alias, name                                                \
+       .type alias sym_type ASM_NL                                     \
+       .set .L__sym_size_##alias, .L__sym_size_##name ASM_NL           \
+       .size alias, .L__sym_size_##alias
 #endif

I still think that in future we *might* want to be able to use two non-label
symbols (in the same section/fragment/etc) to generate an absolute expression,
but that's not a blocker for this series, and for the common cases (e.g.
checking size) we can probably work around that as above.

Thanks for looknig at this!

Mark.
