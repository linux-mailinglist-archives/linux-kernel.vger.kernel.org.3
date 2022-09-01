Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1A55A9E95
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiIASGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiIASFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:05:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045A04BA5D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 11:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7311BB828D2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22400C433C1;
        Thu,  1 Sep 2022 18:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662055517;
        bh=djm/H6971ldga3eCAQ7ZfeYfbmhDth2drr4zw/yfL0I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D6cCkdecqqCj2QaMni8IuwGumPvXK6lho3FUR9H+mATwH/HdW6rYHC0hTrNDj1zs6
         qhkPdMrD0x4BjS8kGayw8cMVCl+8xDr7s/S8Wlkkwo5ZtAkSSaqUqr/1eBzWWoA0rx
         PJaAsdMnTnwaiCkK1eglUOfijyBX5Efm6M8BmHjnl22Ev6bIVxMPHEpXsBcf9mQaXj
         ehaGbhPKsXv9eSiWJY2IFD2mzLC4MIeiPoEACqSZbBAVBry7otnT3sZdf64XEPjFmW
         OfxUyBaXJ+m3DB8Ot3yxTbAJb9azV0FkJLDTTqaqTDx2Pr9S8HUXU665Wb0E3H41g6
         t7cQiDN4yEXYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A0A4E924D5;
        Thu,  1 Sep 2022 18:05:17 +0000 (UTC)
Subject: Re: [GIT PULL] slab fix for 6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <72c237d6-df43-fc3b-4948-6d9a34ef3ba8@suse.cz>
References: <72c237d6-df43-fc3b-4948-6d9a34ef3ba8@suse.cz>
X-PR-Tracked-List-Id: <patches.lists.linux.dev>
X-PR-Tracked-Message-Id: <72c237d6-df43-fc3b-4948-6d9a34ef3ba8@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.0-rc4
X-PR-Tracked-Commit-Id: 0495e337b7039191dfce6e03f5f830454b1fae6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d330076e1d4b0cbaec477e1214f6f8df27da2bb8
Message-Id: <166205551702.13559.17299489648439764853.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Sep 2022 18:05:17 +0000
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 1 Sep 2022 15:51:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d330076e1d4b0cbaec477e1214f6f8df27da2bb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
