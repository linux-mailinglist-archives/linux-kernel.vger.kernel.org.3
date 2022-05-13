Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA115260E7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379891AbiEMLVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379871AbiEMLVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:21:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECD84D612;
        Fri, 13 May 2022 04:21:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1F1AB82E30;
        Fri, 13 May 2022 11:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58001C36AE5;
        Fri, 13 May 2022 11:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652440899;
        bh=EZO7tGXSGLsb5zNo/W7IbNfUPBSeYkjiCkhDxaB4HhE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MCvuwzYTu73MXXZHHNhOAng50Akf0jVW7X8XQXTC2v8HfzpgSznchWtGFdSD2B6xq
         uO+7h+5uOUNPk6LsDFGDMx0D5+7gOxXml/4pBKoczvOpYJvJkiklJAWfPcx9SWIVcW
         A4+9nb6isX0m4txKiSNouF7e2Bf5XtSxkYIe1KtsBbXQqeuUXGQt152TASehB+QZjR
         GKyVNxwBpzy9AmJkXxqI1CWV4ZOhH2GhSy0bFfbY7pOtDLdqLirij3NII7WkwoE+T8
         /xIgQV8/Ea1HeTLG3R/Q2Va6ZJtfysnNCpepqWaRv13DBZoaO9LJm/80M2JEgicko4
         7+c0NS56ukEYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3760BF03937;
        Fri, 13 May 2022 11:21:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: btmtksdio: fix the reset takes too long
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165244089922.8477.369060827203985339.git-patchwork-notify@kernel.org>
Date:   Fri, 13 May 2022 11:21:39 +0000
References: <e26167a3fcefdeae1151162e8676c9a467a8100d.1652390894.git.objelf@gmail.com>
In-Reply-To: <e26167a3fcefdeae1151162e8676c9a467a8100d.1652390894.git.objelf@gmail.com>
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, abhishekpandit@google.com,
        michaelfsun@google.com, mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        yake.yang@mediatek.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Fri, 13 May 2022 05:38:11 +0800 you wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Sending WMT command during the reset in progress is invalid and would get
> no response from firmware until the reset is complete, so we ignore the WMT
> command here to resolve the issue which causes the whole reset process
> taking too long.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: btmtksdio: fix the reset takes too long
    https://git.kernel.org/bluetooth/bluetooth-next/c/baabb7f530e8
  - [2/2] Bluetooth: btmtksdio: fix possible FW initialization failure
    https://git.kernel.org/bluetooth/bluetooth-next/c/7469720563e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


