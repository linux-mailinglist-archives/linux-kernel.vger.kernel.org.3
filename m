Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E994BD0D3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 20:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244601AbiBTTGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 14:06:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244586AbiBTTGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:06:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7724C7B0;
        Sun, 20 Feb 2022 11:06:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E4E160EC8;
        Sun, 20 Feb 2022 19:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AD1CC340E8;
        Sun, 20 Feb 2022 19:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645383959;
        bh=sRnjFkhnYGjiXWOFuHa+scp8WHfJPy4P4V92MMpuk2E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=h3cbxM7zEARDLCHydJfHKXzpW2cXeltiQnk2i3CT9UhluTmdWlR69tP8T30E/Bbi+
         VKA4mYpKRLd7f96wmDTyMAxlxr9gP31yZUk/myjq44ODQUbSGtGTcPSHP364oLDR+j
         B7w13BM3Ip8RAO2dh289Nu3EnmMzbWDB/p1pU2jih99vsFaXF5F0GwoS9UqU9gEV0O
         OBkeTCb+uMjxJgY3udfqvRzmjwhiTYpVMt+ucmD2eSPIeWMrSBGWYbm9W1pQnplCWO
         rBqgKLH0JvJ5XjuKfR3F3o+nv2DqyvqtF8sKr9iTU3FhyXZfuMDUeAennLEkgeoaa6
         +l57ZM33yafJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED1BFE6D447;
        Sun, 20 Feb 2022 19:05:58 +0000 (UTC)
Subject: Re: [GIT PULL] ucounts: RLIMIT_NPROC fixes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87wnhsfatb.fsf_-_@email.froward.int.ebiederm.org>
References: <20220207121800.5079-1-mkoutny@suse.com>
        <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
        <87ilteiz4a.fsf_-_@email.froward.int.ebiederm.org> <87wnhsfatb.fsf_-_@email.froward.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-api.vger.kernel.org>
X-PR-Tracked-Message-Id: <87wnhsfatb.fsf_-_@email.froward.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-rlimit-fixes-for-v5.17
X-PR-Tracked-Commit-Id: 0cbae9e24fa7d6c6e9f828562f084da82217a0c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d3409ebc87f4bc4ed23bd39e78db9ffc29eec44
Message-Id: <164538395896.24844.842779137638491894.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Feb 2022 19:05:58 +0000
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Feb 2022 09:34:24 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-rlimit-fixes-for-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d3409ebc87f4bc4ed23bd39e78db9ffc29eec44

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
