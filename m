Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1A15AFC2E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiIGGNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGGND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:13:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0808094134
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:13:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9747361791
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D078CC433D7;
        Wed,  7 Sep 2022 06:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662531182;
        bh=2Z5SbfLRhjQBWSS81cMRD/qvyxjtLBxz7Z9FZLKS6Rw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B0I/fd3/5pW13Zrr9/HMNXjOhKPKXW9SU+wSkvx2bZcgopEURohqHAW9f4HsJ0NMa
         yVadASdViUaNio3ksCAghwVRmAWZpZy2eghLHeqzNr3ekDnj0UzG1AZ1b2NOC7Lek4
         cHgk+o8YR3rWoVx4HVs3xUz6/70Sb6Bg1uRpjZrOd4HISO3C5MJhPDO/sYAt181d2e
         slTi6ZNE2XuBkfEHSwIoCIPhCxu/GNA52gDUMWxNDZMTSI7cQQii1kPPyH4humDwDx
         +vMcfAUQXp0ze1ZykbKP8FTt3HUTqY4L7gYCDu14Rf1JDuSqqisH1DDhNa5gIZm30d
         TbjIOBFij9Nxw==
Date:   Wed, 7 Sep 2022 15:12:58 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] tracing: Allow multiple hitcount values in
 histograms
Message-Id: <20220907151258.f7864399c05424d0a7a27747@kernel.org>
In-Reply-To: <20220906220346.53a9a623@gandalf.local.home>
References: <166226473132.223837.9011128463174539022.stgit@devnote2>
        <166226474055.223837.13947085068863989044.stgit@devnote2>
        <20220906220346.53a9a623@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 22:03:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun,  4 Sep 2022 13:12:20 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Tom Zanussi <zanussi@kernel.org>
> > 
> > The hitcount is treated specially in the histograms - since it's
> > always expected to be there regardless of whether the user specified
> > anything or not, it's always added as the first histogram value.
> > 
> > Currently the code doesn't allow it to be added more than once as a
> > value, which is inconsistent with all the other possible values.  It
> > would seem to be a pointless thing to want to do, but other features
> > being added such as percent and graph modifiers don't work properly
> > with the current hitcount restrictions.
> > 
> > Fix this by allowing multiple hitcounts to be added.
> > 
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> 
> Hi Masami,
> 
> When posting patches from other people, you still need to add your
> Signed-off-by, as that denotes the people who processed the patch before it
> made it into git.

Oops, I got it.

Please add my signed-off-by;

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
