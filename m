Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8695AD597
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbiIEO52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238473AbiIEO5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:57:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFBEEE03
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:57:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E00886119A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 14:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEB0C433D6;
        Mon,  5 Sep 2022 14:57:21 +0000 (UTC)
Date:   Mon, 5 Sep 2022 10:57:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: CONFIG_RETHUNK int3 filling prevents kprobes in function body
Message-ID: <20220905105758.176734eb@gandalf.local.home>
In-Reply-To: <20220904230713.a461f8fe85329663226c755f@kernel.org>
References: <20220904230713.a461f8fe85329663226c755f@kernel.org>
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

On Sun, 4 Sep 2022 23:07:13 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Can we use another instruction for padding instead of INT3? (e.g. NOP or UD2)
> 
> Or, can I expect the instruction length in __return_sites[] are always 5?
> If so, I can just skip 5 bytes if the address is in __return_sites[].

Perhaps another option is to have a table of where the padding is placed
(tagged), and that kprobes could check to see if the int3 is due to this
padding or not?

-- Steve
