Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E3C533041
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbiEXSOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiEXSOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:14:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB6E65419
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:14:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37C5F6158C
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 18:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57103C34100;
        Tue, 24 May 2022 18:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653416088;
        bh=ghsXIlmIRYTkU3v7z4TsD7IqVQw8lq+1AycKeOraXdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nd2DE5T+eEflk+L2ilaSKqyd3yw1FhMAozGX3lO/oHTxuj7XqR5+figQE3n4lKrJu
         TAcc7zg1cOscuRSeO/Z1iaVgXqxt0JcsUBu+ar1yxQ/MsqFvRgaIjI2MuUje/3HXD6
         VdzkOLkBOxFY3OsoObZzMQNZLWhaDaCPvNdS3ZobnrfLOz09h5J15T8+r7RLU5Gvfk
         0rQ/RB1icRYFiEPT2qYMflAsdofoajTjsP98evy6KcWr04zUIDFui3dlzJCGTC0kYQ
         RcceNU7WRiSDF96sZb0PCAfbRyZCQZaf0OR/lglAxYpCU4E04LRFUxMr/xgWBkmac7
         XC+J3JCm9Jgpw==
Date:   Tue, 24 May 2022 11:14:46 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] objtool changes for v5.19
Message-ID: <20220524181446.rwa333ulf3qjbm2f@treble>
References: <You3JC/BOIyEnmQj@gmail.com>
 <Yoxucp7aUrCaV9uE@gmail.com>
 <Yox088fRrhh4grBX@gmail.com>
 <CAHk-=whRTihOdCij9MxpG433cB_9ZHhBeMVAVpAA5Bf2mdr5yA@mail.gmail.com>
 <Yo0fBWQEevzxttdZ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yo0fBWQEevzxttdZ@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 08:08:05PM +0200, Peter Zijlstra wrote:
> On Tue, May 24, 2022 at 10:53:40AM -0700, Linus Torvalds wrote:
> > On Mon, May 23, 2022 at 11:02 PM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > > Note that with your latest tree you'll get 3 new conflicts:
> > 
> > No problem, but the conflicts did make something clear: the objtool
> > code should just get rid of the "--uaccess" flag that is now
> > unconditional when CONFIG_X86_SMAP has been removed.
> > 
> > I didn't actually do that, and instead just did the mindless merge
> > conflict resolution, but it might be a good idea.
> 
> Yes, I think there is patch pending for that, but given the total merge
> pain we already had, I was waiting for all the dust to settle before
> taking it further.

Actually I think we should go the other direction by keeping '--uaccess'
and adding CONFIG_HAVE_UACCESS_VALIDATION or so.   The main point of
that objtool rewrite was to make all the features modular so other
arches could port them piecemeal.

-- 
Josh
