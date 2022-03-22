Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8A34E373B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbiCVDIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbiCVDIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:08:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC2A1EC62
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:06:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F28361192
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D10FAC36AEC;
        Tue, 22 Mar 2022 03:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647918398;
        bh=pu6WAXPRKYw4f3qu3q66R2j+oEyctA7RCgJ/67PbwLE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GaU2Q2VC4SzcxcAhRFz2dpVkxbzF2EOmFmyxHGOsWV+nNYdw5f/jdzRenarqPEw6K
         CD6mSY6uOnApZK/wkS1lhr7qHDrZ7MlYJsDvWICLE7Rgp9qnQDrqVrOksPaNea0f0/
         xkgzVUOrxrzzADK0I27mcpV9c/PQD7Eqax3BQOD8oMCw+/A4vCSD/Bzyu7dUtlb23s
         PWpM+cDJwm0GXjUPCVUrODbhvZ57XwroID7O8vnio0o8MkswpXKg819BLorPmP+g3i
         kMdm7IbvR5eKzi8OIsMiN09NafYdhfVembkQh9sBrVdTH8vi8eemEL3iR7Y2vFSGdN
         hJNGU4nNSjicA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9E5DE6D44B;
        Tue, 22 Mar 2022 03:06:38 +0000 (UTC)
Subject: Re: [GIT PULL] bounds fixes for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202203210843.0E70F58@keescook>
References: <202203210843.0E70F58@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202203210843.0E70F58@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/bounds-fixes-v5.18-rc1
X-PR-Tracked-Commit-Id: fad278388e01e3658a356118bed8ee2c2408d280
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8565d64430f8278bea38dab0a3ab60b4e11c71e4
Message-Id: <164791839875.13286.14753062288295956967.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 03:06:38 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Stefan Berger <stefanb@linux.ibm.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 08:52:31 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/bounds-fixes-v5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8565d64430f8278bea38dab0a3ab60b4e11c71e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
