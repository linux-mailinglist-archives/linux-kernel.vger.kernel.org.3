Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271AC4C04C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbiBVWle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbiBVWlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:41:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261411275DE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:41:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB1F3B81A2C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 22:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75FAC340E8;
        Tue, 22 Feb 2022 22:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645569663;
        bh=vYUDG34b3FyL+BLECZibvwUq4aUPL4xJK5z3VtwR2UU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p/UyrtFu6gbGPg2450KZlgOkxBv0wqgRwPoG44kdpeEbYOH7J6Z18/KZO4r9p1hr7
         gGrJCLVWyNp9gDZhjCM18l88YTR9l544tgfCnlNMcHvK0dOQmXhYG0VH8GRCq3GEkt
         wO60Fv5Q2j2lyqCjs/Psh6XtRJqUIEzbDspOiXkvImNjOHZ4gD/HVr4Gzv4eE/ArWl
         ngUW3h93b52KUGvBj0XQ6iXx0x8aQkAH0FmSU72RAN8gKyUITR8WH9v5HvQN/JOiBI
         jbucPLEf9yD4ktT0X8P8GDwSBai6n0iZ2qxYAUtZvXeUIUn+0ocReInB8yqliX8Mww
         OcssI2guawztA==
Date:   Tue, 22 Feb 2022 22:40:57 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, acme@redhat.com, ardb@kernel.org,
        bp@alien8.de, broonie@kernel.org, dave.hansen@linux.intel.com,
        joey.gouly@arm.com, jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH v4 0/4] linkage: better symbol aliasing
Message-ID: <20220222224056.GA16976@willie-the-truck>
References: <20220216162229.1076788-1-mark.rutland@arm.com>
 <Yg4qV6GHaHuLrUmm@hirez.programming.kicks-ass.net>
 <20220222100918.GA16108@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222100918.GA16108@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 10:09:19AM +0000, Will Deacon wrote:
> Hi Peter,
> 
> On Thu, Feb 17, 2022 at 11:58:31AM +0100, Peter Zijlstra wrote:
> > On Wed, Feb 16, 2022 at 04:22:25PM +0000, Mark Rutland wrote:
> > > Catalin, Will, Peter: I think this is ready now and would like to get it
> > > queued, but it looks like this may (trivially) conflict with other bits
> > > we'll want to queue in either the arm64 tree (Joey's string routine
> > > changes [4]), or tip tree (Peter's IBT series).
> > > 
> > > I assume the best thing to do would be to have a stable branch merged in
> > > both of those. I've tagged this such that it can be pulled (details
> > > below); Peter also suggested he could make a stable branch in the tip
> > > tree. Any preference?
> > 
> > No real preference, The conflicts on my end are really rather trivial
> > IIRC, but they're a nice clean-up.
> > 
> > If I don't take then, feel free to add:
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Mark mentioned yesterday that this series will conflict with some pending
> rework to the arm64 string routines [1], so we probably want a shared
> branch to handle the fallout.
> 
> Do you plan to queue this someplace in -tip that I can pull from, or
> shall I create a stable branch on the arm64 side?

Following discussion on IRC, I've pushed this out to the for-next/linkage
branch on the arm64 git. Let's give it a day or so in -next, then if it
doesn't fall apart you can pull it in to -tip as well.

Cheers,

Will
