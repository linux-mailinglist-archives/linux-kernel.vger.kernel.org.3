Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FB55ABF2B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 15:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiICNxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 09:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiICNxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 09:53:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125475B7BF;
        Sat,  3 Sep 2022 06:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7D31B80113;
        Sat,  3 Sep 2022 13:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A48C433D6;
        Sat,  3 Sep 2022 13:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662213191;
        bh=lMwzQ02SEWG/34khEpyuiktbPBlHfdcpRGPVn5PeCnc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SqPZnqs+b2jBHPlRwoOtrbs9x/hUs9LB+pPc6Wh4Mq7GHZZaGSrAPiHXWnO6t4vne
         7iSthZoYW4hbxbsouXL4Q+IP/u56AjgkMHQKDY8uetVvdD3lxMtNwBxEvVzOTAMGPG
         rJD+B8svihtBQVC+tsaaJTpMdUsF4vLedF06lRw0GGYQX/5x1h0ZdpYJQUKuW3jKyc
         kFIfJhZYoRcwR/9YZGYdgHoEiipJlXXP41LHpo4T0Ir2fL8XMuM7xVRbqlYw4jd+aU
         EZjlfQHSdvAdj5LBqg2zoFOwm1rZ8ScSei4PC2Cr/KbNaJEMWZAPjyHJeG5lC1hkOe
         TtSpUGkaqGkXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C9A575C0531; Sat,  3 Sep 2022 06:53:10 -0700 (PDT)
Date:   Sat, 3 Sep 2022 06:53:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        rostedt@goodmis.org, vineeth@bitbyteword.org, boqun.feng@gmail.com,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH v5 02/18] mm/sl[au]b: rearrange struct slab fields to
 allow larger rcu_head
Message-ID: <20220903135310.GS6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-3-joel@joelfernandes.org>
 <e84c90f2-d76f-83d4-d40b-403f894eda33@suse.cz>
 <75ad3ed3-7dcd-474c-472c-ca32c1734281@suse.cz>
 <013ca416-72de-8059-a5d5-cd63c92ef119@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013ca416-72de-8059-a5d5-cd63c92ef119@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 11:09:08AM -0400, Joel Fernandes wrote:
> 
> 
> On 9/2/2022 5:30 AM, Vlastimil Babka wrote:
> > On 9/2/22 11:26, Vlastimil Babka wrote:
> >> On 9/2/22 00:17, Joel Fernandes (Google) wrote:
> >>> From: Vlastimil Babka <vbabka@suse.cz>
> >>>
> >>> Joel reports [1] that increasing the rcu_head size for debugging
> >>> purposes used to work before struct slab was split from struct page, but
> >>> now runs into the various SLAB_MATCH() sanity checks of the layout.
> >>>
> >>> This is because the rcu_head in struct page is in union with large
> >>> sub-structures and has space to grow without exceeding their size, while
> >>> in struct slab (for SLAB and SLUB) it's in union only with a list_head.
> >>>
> >>> On closer inspection (and after the previous patch) we can put all
> >>> fields except slab_cache to a union with rcu_head, as slab_cache is
> >>> sufficient for the rcu freeing callbacks to work and the rest can be
> >>> overwritten by rcu_head without causing issues.
> >>>
> >>> This is only somewhat complicated by the need to keep SLUB's
> >>> freelist+counters aligned for cmpxchg_double. As a result the fields
> >>> need to be reordered so that slab_cache is first (after page flags) and
> >>> the union with rcu_head follows. For consistency, do that for SLAB as
> >>> well, although not necessary there.
> >>>
> >>> As a result, the rcu_head field in struct page and struct slab is no
> >>> longer at the same offset, but that doesn't matter as there is no
> >>> casting that would rely on that in the slab freeing callbacks, so we can
> >>> just drop the respective SLAB_MATCH() check.
> >>>
> >>> Also we need to update the SLAB_MATCH() for compound_head to reflect the
> >>> new ordering.
> >>>
> >>> While at it, also add a static_assert to check the alignment needed for
> >>> cmpxchg_double so mistakes are found sooner than a runtime GPF.
> >>>
> >>> [1] https://lore.kernel.org/all/85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org/
> >>>
> >>> Reported-by: Joel Fernandes <joel@joelfernandes.org>
> >>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >>
> >> I've added patches 01 and 02 to slab tree for -next exposure before Joel's
> >> full series posting, but it should be also ok if rcu tree carries them with
> >> the whole patchset. I can then drop them from slab tree (there are no
> >> dependencies with other stuff there) so we don't introduce duplicite commits
> >> needlessly, just give me a heads up.
> > 
> > Ah but in that case please apply the reviews from my posting [1]
> > 
> > patch 1:
> > Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > 
> > patch 2
> > Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > 
> > [1] https://lore.kernel.org/all/20220826090912.11292-1-vbabka@suse.cz/
> 
> 
> Sorry for injecting confusion - my main intent with including the mm patches in
> this series is to make it easier for other reviewers/testers to backport the
> series to their kernels in one shot. Some reviewers expressed interested in
> trying out the series.
> 
> I think it is best to let the -mm patches in the series go through the slab
> tree, as you also have the Acks/Reviews there and will take sure those
> dependencies are out of the way.
> 
> My lesson here is to be more clear, I could have added some notes for context
> below the "---" of those mm patches.
> 
> Thanks again for your help,

Hello, Vlastimil, and thank you for putting these together!

I believe that your two patches should go in via the slab tree.
I am queueing them in -rcu only temporarily and just for convenience
in testing.  I expect that I will rebase them so that I can let your
versions cover things in -next.

							Thanx, Paul
