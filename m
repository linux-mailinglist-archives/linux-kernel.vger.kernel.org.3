Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E805A8981
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 01:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiHaXaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 19:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiHaXaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600E479EDA;
        Wed, 31 Aug 2022 16:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBF6461CA4;
        Wed, 31 Aug 2022 23:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 470A5C433D7;
        Wed, 31 Aug 2022 23:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661988615;
        bh=CbM8i5pqI5d7io1Cbk/QR8oz21S+sd2XFL/3nw9UKWQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GiI2HLi61IqdwaTwp3vtqAs8kGFLHSfn34VaFUiBEuhSTfgFVOmi7PlXlTRTOzJZx
         O9UnjDkNawmBQIGLQlT/gjZz95rdBixXCbTUCZbvtJpki0cNAuMIDrIsp14QGdqn0Z
         0ClbugYQpF3y1y1TiZJm9Oncx9Kj3tMQVmqcVp673O/oPOGb5rS7M+xXhevya+zPCc
         T11Ii/xawFGJXgWzO0X5P3mVc1DJBqhaxFlnCrOI0O//SAmN30m+DXbSdDHYcqGjH9
         cPXm9ajOtH74XsqwzA+IKbhOyZPqm1MmiceqYZGiR0fwOfHMhepuGKJXW7tE7CWZO/
         GtuxAPY3wsP3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28B3EE924D6;
        Wed, 31 Aug 2022 23:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] Bluetooth: btusb: mediatek: fix WMT failure during runtime
 suspend
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166198861515.30343.13576995414925272614.git-patchwork-notify@kernel.org>
Date:   Wed, 31 Aug 2022 23:30:15 +0000
References: <6675f56fc8b0910f17ec506d534cf5330ff04733.1660177086.git.objelf@gmail.com>
In-Reply-To: <6675f56fc8b0910f17ec506d534cf5330ff04733.1660177086.git.objelf@gmail.com>
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        abhishekpandit@google.com, michaelfsun@google.com,
        mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        jing.cai@mediatek.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 11 Aug 2022 08:49:07 +0800 you wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> WMT cmd/event doesn't follow up the generic HCI cmd/event handling, it
> needs constantly polling control pipe until the host received the WMT
> event, thus, we should require to specifically acquire PM counter on the
> USB to prevent the interface from entering auto suspended while WMT
> cmd/event in progress.
> 
> [...]

Here is the summary with links:
  - [v5] Bluetooth: btusb: mediatek: fix WMT failure during runtime suspend
    https://git.kernel.org/bluetooth/bluetooth-next/c/177978b29426

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


