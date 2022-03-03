Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5B14CB385
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiCCAbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiCCAbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:31:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560808C7F3;
        Wed,  2 Mar 2022 16:30:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D6E6B82375;
        Thu,  3 Mar 2022 00:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F22BC004E1;
        Thu,  3 Mar 2022 00:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646267447;
        bh=UXrKG0FG0uhH5FQkd5ic7TriMJwr9/qDzzzaW1qTzyA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g5jhuD2yoea3gjR579YmeuluYEFEWY5x4U8Dg7Bi77nFOvgOflxAwSZr/nPLCKv3K
         BQzOAokzBnage37CLBIVJEqK55abXmQ28FXYKEllUFYLw1boR6iUG62rn0VPUuIPSE
         Lr5LF/OGNMfjizIiTE6leAT95bmnoCm/PFniTIcFOfNlwwwKL3ntJhtOGLBbktjUtD
         hfQPr2uXBcW5ax8coPX/dXPejz/ocgIR3q0INh1wVH3ZHwxEZ14ZJwgOZ6bt97Y2K/
         L7ugykP5s0q3MRWZiR+CphZI/v4kbGVoWoRiA4OLFFD5R7Q7FzCO6YmmoOlCKfvW+B
         8A7GIe4N+Jjdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89378E6D44B;
        Thu,  3 Mar 2022 00:30:47 +0000 (UTC)
Subject: Re: [GIT PULL] ucounts: Regression fix for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87o82nhp1j.fsf_-_@email.froward.int.ebiederm.org>
References: <20220207121800.5079-1-mkoutny@suse.com>
        <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
        <87ilteiz4a.fsf_-_@email.froward.int.ebiederm.org>
        <87wnhsfatb.fsf_-_@email.froward.int.ebiederm.org> <87o82nhp1j.fsf_-_@email.froward.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o82nhp1j.fsf_-_@email.froward.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-rlimit-fixes-for-v5.17
X-PR-Tracked-Commit-Id: 0ac983f512033cb7b5e210c9589768ad25b1e36b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5859a2b1991101d6b978f3feb5325dad39421f29
Message-Id: <164626744755.8102.8336793756050326308.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Mar 2022 00:30:47 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Michal =?utf-8?Q?Kou?= =?utf-8?Q?tn=C3=BD?= <mkoutny@suse.com>,
        linux-api@vger.kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 02 Mar 2022 18:12:40 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-rlimit-fixes-for-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5859a2b1991101d6b978f3feb5325dad39421f29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
