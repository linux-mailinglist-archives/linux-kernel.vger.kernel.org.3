Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EE2511FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbiD0PE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbiD0PEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:04:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92ED247472
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F22661E83
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDA3C385A7;
        Wed, 27 Apr 2022 15:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651071700;
        bh=uT8KmHeI6bEJWYMat3yaxNgP5uwItUD4qVKDN3oBXoo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bnpBtUKQW0evw/CyAm/6VLk9g4H8i682oTDskwAj6V0nARPAbUNcLBcfHCKvEMClh
         KYLZwrP6zJZc8+3E5KYSmkUgcrE0THvPL+fjlfFySUM3szUSyYCJgtl5ScL3DukzBo
         IuyZUekqzbRIFXkixDC2KpQkSLwAWPzO5lJPAQ1x3L1b401KlQygsbrbBBQkDHU2Bd
         QOBjWqYn7wjXOBNmYr9rIUTA7Atg1SVyc3ADYq2+5gZWEZR5q+dvYeHtjUSy+YdYMR
         SEglg2k2N7GTf860ZOpcU32dbgr10Zd06ixhF/WpH/I4CdQkRmBawsZ9Q0k1mWaDUI
         hcUOWQM0zltmQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 922DF5C0387; Wed, 27 Apr 2022 08:01:39 -0700 (PDT)
Date:   Wed, 27 Apr 2022 08:01:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chris Mason <clm@fb.com>
Cc:     Christoph Bartoschek <bartoschek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "riel@surriel.com" <riel@surriel.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH RFC fs/namespace] Make kern_unmount() use
 synchronize_rcu_expedited()
Message-ID: <20220427150139.GO4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <8E281DF1-248F-4861-A3C0-2573A5EFEE61@fb.com>
 <20220426065917.3123488-1-bartoschek@google.com>
 <20220426140919.GD4285@paulmck-ThinkPad-P17-Gen-1>
 <CAAQBG5jnvSxcjwr+L5nuxwh87bv=D=tzU325W2Zp3DVpn-VmcQ@mail.gmail.com>
 <20220426231100.GL4285@paulmck-ThinkPad-P17-Gen-1>
 <2A61C695-450E-499B-BCFA-411A36008D72@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2A61C695-450E-499B-BCFA-411A36008D72@fb.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 12:19:56PM +0000, Chris Mason wrote:
> 
> > On Apr 26, 2022, at 7:11 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > On Wed, Apr 27, 2022 at 12:58:34AM +0200, Christoph Bartoschek wrote:
> >>> 3. https://lore.kernel.org/lkml/20220218183114.2867528-1-riel@surriel.com/
> >>> Refined queue_rcu_work() approach.
> >>> 
> >>> #1 should work, but the resulting IPIs are not going to make the real-time
> >>> guys happy. #2 and #3 have been subject to reasonably heavy testing
> >>> and did fix a very similar issue to the one that you are reporting,
> >>> but last I knew there were doubts about the concurrency consequences.
> >>> 
> >>> Could you please give at least #3 a shot and see if it helps you?
> >> 
> >> I have tried #3 and it works well with my testcases as far as I can see it.
> > 
> > Thank you for giving it a try!
> > 
> > Al, are further adjustments needed to make this patch cover all the
> > corner cases?
> 
> Did we end up addressing all of Al’s comments here?
> 
> https://lore.kernel.org/lkml/YhCFKyVMtOSyBDJh@zeniv-ca.linux.org.uk/

Indeed we have not!  Thank you for the reminder, and I will get with
Rik to look into this.

							Thanx, Paul
