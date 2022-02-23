Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFD94C1CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbiBWUIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbiBWUIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:08:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EEA4CD4B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:08:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB6A3617BB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 20:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 481DEC340F0;
        Wed, 23 Feb 2022 20:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645646898;
        bh=rPvsHk9rO11ss9D+hCqp2bK02KgpNSQcTHp8HbGr4GY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W4BRfXY2Ymt3eevB8M68rNwwpStykkiZwQ2K6QauRnyeAgfOlxJ3yH/D4CoTNHU5v
         I5CQw8Aa4gloiOw3lUfNuXb5sNKWjkn6grS7s6r4464K0dWX6ZyjcoApvId2WAJiT3
         EsgQTiOiv/Hwt/pu/BxGKuFLPxDAimdaneFsu+LMwXAGrweDAiHvd+p9Ek8wHeKtL8
         M9RyXZ6oPx9ptMRPZUAJMESJsNp2CFUCH9l8Ol8NVOCDiV5hQTQ/ExIn7wb3YDgwmo
         dPhH6CXp49IXE3hYVi65Mu65i5SZp2EINd2Pu87KK2+deP0FKy8347zwsHn8pdIUdB
         zKV3TXQdttEQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 364DEE5D09D;
        Wed, 23 Feb 2022 20:08:18 +0000 (UTC)
Subject: Re: [GIT PULL] slab fixes for 5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <02623bc1-fc54-bc5d-8879-e62d548924fd@suse.cz>
References: <02623bc1-fc54-bc5d-8879-e62d548924fd@suse.cz>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <02623bc1-fc54-bc5d-8879-e62d548924fd@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-5.17-rc6
X-PR-Tracked-Commit-Id: 221944736f66f38e9bdbce52c616d10df7f15c54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4eb0a7c8e195d4549221f9df3a0313254c493949
Message-Id: <164564689821.4348.3420955279683855883.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Feb 2022 20:08:18 +0000
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Feb 2022 10:44:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-5.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4eb0a7c8e195d4549221f9df3a0313254c493949

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
