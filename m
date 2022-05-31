Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8824253991C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348227AbiEaVyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbiEaVy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:54:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC4D22B0D
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:54:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB768613EA
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 21:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F48FC385A9;
        Tue, 31 May 2022 21:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654034067;
        bh=p1OW3169Xm6Eo04hC32FJFeedrLyv3PKo3DiY4M7gOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIb1CqARRBC6qSSdyiOWLJrKknzwu45ZhejlZUVs8aK0HhuFvWbQsRBGPsJR86/IF
         ydAqEZDaqp0qAoApwZ31qSdQweyQnLiq7CMvgF4o2a8zxonxmUVuyiWet0x8kc+dth
         JcrxCYsUr27twnEjiFxlzj2Myh3Yetj+mvOfsvIJz0NLoKLkRKIy3jcVkx64NXnRpY
         aROv1sCg7zzz17tttNDeYWua5QNEII+OJN4GKM/I99E4Nh8sNmtxDgB43pV9QKLAnA
         0Ba9+Dk451XP8orDqNcpihNf0vtbYaqn24YZvJUKTy/jtSpp2kGfqobjaAiZWtEEfi
         /l1eOJiXn6Zog==
Date:   Tue, 31 May 2022 15:54:23 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Tony Battersby <tonyb@cybernetics.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, kernel-team@fb.com,
        Matthew Wilcox <willy@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/10] dmapool: improve scalability of dma_pool_free
Message-ID: <YpaOj/C1SA8y1VCg@kbusch-mbp.dhcp.thefacebook.com>
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
 <801335ba-00f3-12ae-59e0-119d7d8fd8cd@cybernetics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <801335ba-00f3-12ae-59e0-119d7d8fd8cd@cybernetics.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 02:23:44PM -0400, Tony Battersby wrote:
> dma_pool_free() scales poorly when the pool contains many pages because
> pool_find_page() does a linear scan of all allocated pages.  Improve its
> scalability by replacing the linear scan with a red-black tree lookup.
> In big O notation, this improves the algorithm from O(n^2) to O(n * log n).

The improvement should say O(n) to O(log n), right?
