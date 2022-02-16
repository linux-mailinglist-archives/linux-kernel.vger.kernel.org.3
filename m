Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BF64B87AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiBPMai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:30:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiBPMa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:30:27 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CD52A39F8;
        Wed, 16 Feb 2022 04:30:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzHNP2glbz4xn7;
        Wed, 16 Feb 2022 23:30:13 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jiri Kosina <jikos@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>
Cc:     live-patching@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <cover.1640017960.git.christophe.leroy@csgroup.eu>
References: <cover.1640017960.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 00/13] Implement livepatch on PPC32 and more
Message-Id: <164501436743.521186.7455974435190677793.b4-ty@ellerman.id.au>
Date:   Wed, 16 Feb 2022 23:26:07 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 16:37:58 +0000, Christophe Leroy wrote:
> This series implements livepatch on PPC32 and implements
> CONFIG_DYNAMIC_FTRACE_WITH_ARGS to simplify ftracing.
> 
> v2:
> - Fix problem with strict modules RWX
> - Convert powerpc to CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> - Convert function graph tracing to C
> - Refactor PPC32 versus PPC64
> 
> [...]

Patches 1 and 3-13 applied to powerpc/next.

[01/13] livepatch: Fix build failure on 32 bits processors
        https://git.kernel.org/powerpc/c/2f293651eca3eacaeb56747dede31edace7329d2
[03/13] powerpc/module_32: Fix livepatching for RO modules
        https://git.kernel.org/powerpc/c/0c850965d6909d39fd69d6a3602bb62b48cad417
[04/13] powerpc/ftrace: Add support for livepatch to PPC32
        https://git.kernel.org/powerpc/c/a4520b25276500f1abcfc55d24f1251b7b08eff6
[05/13] powerpc/ftrace: Don't save again LR in ftrace_regs_caller() on PPC32
        https://git.kernel.org/powerpc/c/7875bc9b07cde868784195e215f4deaa0fa928a2
[06/13] powerpc/ftrace: Simplify PPC32's return_to_handler()
        https://git.kernel.org/powerpc/c/7bdb478c1d15cfd3a92db6331cb2d3dd3a8b9436
[07/13] powerpc/ftrace: Prepare PPC32's ftrace_caller() for CONFIG_DYNAMIC_FTRACE_WITH_ARGS
        https://git.kernel.org/powerpc/c/d95bf254be5f74c1e4c8f7cb64e2e21b9cc91717
[08/13] powerpc/ftrace: Prepare PPC64's ftrace_caller() for CONFIG_DYNAMIC_FTRACE_WITH_ARGS
        https://git.kernel.org/powerpc/c/c75388a8ceffbf1bf72c61afe66a72e58aa20c74
[09/13] powerpc/ftrace: Implement CONFIG_DYNAMIC_FTRACE_WITH_ARGS
        https://git.kernel.org/powerpc/c/40b035efe288f42bbf4483236cde652584ccb64e
[10/13] powerpc/ftrace: Refactor ftrace_{en/dis}able_ftrace_graph_caller
        https://git.kernel.org/powerpc/c/0c81ed5ed43863d313cf253b0ebada6ea2f17676
[11/13] powerpc/ftrace: directly call of function graph tracer by ftrace caller
        https://git.kernel.org/powerpc/c/830213786c498b0c488fedd2abc15a7ce442b42f
[12/13] powerpc/ftrace: Prepare ftrace_64_mprofile.S for reuse by PPC32
        https://git.kernel.org/powerpc/c/41315494beed087011f256b4f1439bb3d8236904
[13/13] powerpc/ftrace: Remove ftrace_32.S
        https://git.kernel.org/powerpc/c/4ee83a2cfbc46c13f2a08fe6d48dbcede53cdbf8

cheers
