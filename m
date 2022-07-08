Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E80A56BF9B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbiGHQbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiGHQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:31:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996351091
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 09:31:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C631B828AE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 16:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B5DC341CD;
        Fri,  8 Jul 2022 16:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657297901;
        bh=+KcBQnDBBn868FciMPHZhD4GJ/zuql+WDwqJYuQjSXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oi5R+s6zMMka3CnMUPVbNXZqOjEOpVF1CxGY5s7sKo1n3buOWAs4403IHJ64dmyf3
         b+umhRd8TlrX75kvlrKTnO8l46dCxANQY3Z/I9S4MzAePlOpT69Vuqkq6UVpPTXrJe
         C8QAaqMUkgn9Wsr2TqeP30qmXHipNOYuejTPOWXMh5m1hZbxdR0ZXQbuQCIQBDayjF
         fcMLQ4O0KtsIxij2dacmG1AGU0XfpPXEA8W+IzpWv3doVqzXtTij0l63GeKrHMjqVi
         12PRn4rOXpyeSoUqDpqd9QUSMQak9PMZP/BD9vL6Q0Qwb72fvy6+LwMwSXuhmSRaey
         f/IN35Q1QJ7sg==
Date:   Fri, 8 Jul 2022 17:31:35 +0100
From:   Will Deacon <will@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Wei Li <liwei391@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] arm64: Fix pending single-step debugging issues
Message-ID: <20220708163134.GB6286@willie-the-truck>
References: <20220511060521.465744-1-sumit.garg@linaro.org>
 <CAD=FV=WXoDvWuH=yjzCcqOZ5CeUtYun7C8zrtrBP4FC409GkqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WXoDvWuH=yjzCcqOZ5CeUtYun7C8zrtrBP4FC409GkqA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 03:14:16PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, May 10, 2022 at 11:05 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > This patch-set reworks pending fixes from Wei's series [1] to make
> > single-step debugging via kgdb/kdb on arm64 work as expected. There was
> > a prior discussion on ML [2] regarding if we should keep the interrupts
> > enabled during single-stepping. So patch #1 follows suggestion from Will
> > [3] to not disable interrupts during single stepping but rather skip
> > single stepping within interrupt handler.
> >
> > [1] https://lore.kernel.org/all/20200509214159.19680-1-liwei391@huawei.com/
> > [2] https://lore.kernel.org/all/CAD=FV=Voyfq3Qz0T3RY+aYWYJ0utdH=P_AweB=13rcV8GDBeyQ@mail.gmail.com/
> > [3] https://lore.kernel.org/all/20200626095551.GA9312@willie-the-truck/
> >
> > Changes in v3:
> > - Reword commit descriptions as per Daniel's suggestions.
> >
> > Changes in v2:
> > - Replace patch #1 to rather follow Will's suggestion.
> >
> > Sumit Garg (2):
> >   arm64: entry: Skip single stepping into interrupt handlers
> >   arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step
> >
> >  arch/arm64/include/asm/debug-monitors.h |  1 +
> >  arch/arm64/kernel/debug-monitors.c      |  5 +++++
> >  arch/arm64/kernel/entry-common.c        | 18 +++++++++++++++++-
> >  arch/arm64/kernel/kgdb.c                |  2 ++
> >  4 files changed, 25 insertions(+), 1 deletion(-)
> 
> Sorry it took so long for me to respond. I kept dreaming that I'd find
> the time to really dig deep into this to understand it fully and I'm
> finally giving up on it. I'm going to hope that Will and/or Catalin
> knows this area of the code well and can give it a good review. If not
> then I'll strive harder to make the time...

So the good news is that I spent a couple of days on this last week.

The bad news is that I'm nowhere done and about to disappear on holiday
for a week!

But anyway, I might be able to give this a review when I'm back. Failing
that, I wonder if enough of us have a little bit of time each that we
could hack on an agreed design together which covers the debug exception
behaviour beyond kgdb?

Will
