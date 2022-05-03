Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEAE518939
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbiECQCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238803AbiECQCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:02:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AD13C722
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:59:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EE608CE1E2F
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 15:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37067C385A4;
        Tue,  3 May 2022 15:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651593558;
        bh=XY9ch2qBQz1SEgroJDBDxJ7tbxMsdOzqeG8iF4Vg6NA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=j51WGuTq2KD/fLVJmuUDFZe+OZdWlAv8lR3nxVgu+whTaECowisgCxpMK7kYHvjo7
         hMee1gp1pLguQI0tuxugGNPQcOkcl4vX5MpuH2efetRFWh0F6qOkcahZQFDaqnLOBP
         90Pgrsy3CtA6Dx/y9sp7axtpqPASAG5tmz6jsoIUv79pV7KPq6V2oh72kM4Y4qVHPw
         b4OOBDRWHrvs/YLISULk0upIqPoN0nHAJTqylDO/aPa3KjayQ6OnEcLCedZJ0hjh+Z
         I37cepvKUZKOWILyaTJVa6bXzJHD0sjkB9rarzL2oKySkt3T0cOtWd9rEQv8+hQjbM
         lsYTkvd69L0qA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0F0AA5C0115; Tue,  3 May 2022 08:59:13 -0700 (PDT)
Date:   Tue, 3 May 2022 08:59:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     liam.howlett@oracle.com, willy@infradead.org, walken.cr@gmail.com,
        mhocko@suse.com, hannes@cmpxchg.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Memory allocation on speculative fastpaths
Message-ID: <20220503155913.GA1187610@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Just following up from off-list discussions yesterday.

The requirements to allocate on an RCU-protected speculative fastpath
seem to be as follows:

1.	Never sleep.
2.	Never reclaim.
3.	Leave emergency pools alone.

Any others?

If those rules suffice, and if my understanding of the GFP flags is
correct (ha!!!), then the following GFP flags should cover this:

	__GFP_NOMEMALLOC | __GFP_NOWARN

Or is this just a fancy way of always returning NULL or some such?  ;-)

							Thanx, Paul
