Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4007E4C1576
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241615AbiBWOe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiBWOeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:34:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6FEB23A7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 06:33:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE74E616AB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFCDC340E7;
        Wed, 23 Feb 2022 14:33:54 +0000 (UTC)
Date:   Wed, 23 Feb 2022 09:33:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, Miroslav Benes <mbenes@suse.cz>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 04/29] x86/livepatch: Validate __fentry__ location
Message-ID: <20220223093352.0f32e9d1@gandalf.local.home>
In-Reply-To: <20220223092327.0c73872d@gandalf.local.home>
References: <20220218164902.008644515@infradead.org>
        <20220218171408.808810436@infradead.org>
        <20220218210831.u2ugtfr7gxllk4cs@treble>
        <YhYH6FMNh8pMws6Z@hirez.programming.kicks-ass.net>
        <YhYTFhepH/rrUfBc@hirez.programming.kicks-ass.net>
        <20220223074139.161acfd0@rorschach.local.home>
        <20220223092327.0c73872d@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 09:23:27 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> 	return ip <= (rec->ip + MCOUNT_INSN_SIZE) ? rec->ip : 0;

That should be < and not <=, as I added the + MCOUNT_INSN_SIZE as an after
thought, and that addition changes the compare.

-- Steve
