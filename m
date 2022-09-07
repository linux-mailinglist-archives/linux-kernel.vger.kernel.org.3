Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DBE5B0C69
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiIGSUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIGSUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:20:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DDE8D3E7;
        Wed,  7 Sep 2022 11:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2A52B81CAE;
        Wed,  7 Sep 2022 18:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5755C433C1;
        Wed,  7 Sep 2022 18:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662574812;
        bh=KQWGyHNv41x321doUhi43sZ1FeTYu6CJWUNdSzv+1/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nd6mcfLJ0sjGtWJeQJR4b4elyeG7EqwB1LFRvSJZ4RNpMLttNfu3ByHXmoKbMaJ4P
         594CRL5DFwWuZsPi2rDol2IKZyR0qmFLq5dA1Sd5N690H+AwAnkwt5Wb8LRmEU0OmJ
         g2eAekDjo/CLI0zmeQF+ejMM1bqCK0WJn2Hq2FMxITfjWgRk3e7PfxU/GSqSxy5BDt
         Npyx9pzazOpSRpJbvJqXXQ46JKIHTJgtdpOVEC8JycNvsG9kQDvhl9X0YrqUxldLrO
         oJs1UZWzcDMAMhugq9wxLfgfmZkpBi0i60UMeuliuKCYBAcv6CPVd/HCTITfunjrsX
         2Rfc/zgN/DRQw==
Date:   Wed, 7 Sep 2022 12:20:09 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH] sbitmap: fix possible io hung due to lost wakeup
Message-ID: <Yxjg2Xsb7WExRv2w@kbusch-mbp.dhcp.thefacebook.com>
References: <20220803121504.212071-1-yukuai1@huaweicloud.com>
 <Yxe7V3yfBcADoYLE@kbusch-mbp.dhcp.thefacebook.com>
 <20220907102318.pdpzpmhah2m3ptbn@quack3>
 <YxinFEYRCU/QuQ5w@kbusch-mbp.dhcp.thefacebook.com>
 <20220907164150.tykjl3jsctjddcnq@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907164150.tykjl3jsctjddcnq@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 06:41:50PM +0200, Jan Kara wrote:
> On Wed 07-09-22 08:13:40, Keith Busch wrote:
> > 
> > I'm not sure about this part. We've already decremented, so the freed bit is
> > accounted for against the batch. Returning true here may double-count the freed
> > bit, right?
> 
> Yes, we may wake up waiters unnecessarily frequently. But that's a
> performance issue at worst and only if it happens frequently. So I don't
> think it matters in practice (famous last words ;).

Ok, let's go with that. Do you want to send the patch? I have a follow-up fix
for batched tagging that depends on this.
