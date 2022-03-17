Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A064DC4AF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiCQLVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiCQLVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:21:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CB01E3E08;
        Thu, 17 Mar 2022 04:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3231FCE21A0;
        Thu, 17 Mar 2022 11:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76C11C340EC;
        Thu, 17 Mar 2022 11:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647516014;
        bh=UIA6S5+bI123Q5sbQJDY+Ns5uSiqeYzaBozSAYu/4K4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Z3ZZuulDBrgB/ZWQVkelumI0w+sVh3lzG1cKOigLf8YoZK9+k8cvjEJXySuxHQwIU
         YQHQTtsz4E61+EAylenGzmklJA1rnFMDYx2/5gtc3odgjHEEZrBmP/DMxQgmxVCuGT
         dZNDIho6Y+6qiPRaAdOKORAabHPpN7fRk/YyJpmrj9PV3NgUzKl8PYyIFlW3hXIz2P
         Ol/i8iXXw9xLFny2UuI1kc2+080I7bUgnibJJON2ktEBDjUuvPdt+pXhw2+AE4UI98
         iuvnPoJg0Jlis2IRn2+Q9x6NHMURWfc1XzEcqCH8F8Jj2qVutzTh2HoRixN8o1aTJt
         IPadvR/zYskIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59BE2EAC09C;
        Thu, 17 Mar 2022 11:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 1/5] Bluetooth: btmtksdio: Fix kernel oops in
 btmtksdio_interrupt
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164751601436.15552.12891442472636759067.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Mar 2022 11:20:14 +0000
References: <d4be9c9c1ce2757bad4df19885d605e97a1ceec8.1647472087.git.objelf@gmail.com>
In-Reply-To: <d4be9c9c1ce2757bad4df19885d605e97a1ceec8.1647472087.git.objelf@gmail.com>
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
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 17 Mar 2022 07:15:19 +0800 you wrote:
> From: Yake Yang <yake.yang@mediatek.com>
> 
> Fix the following kernel oops in btmtksdio_interrrupt
> 
> [   14.339134]  btmtksdio_interrupt+0x28/0x54
> [   14.339139]  process_sdio_pending_irqs+0x68/0x1a0
> [   14.339144]  sdio_irq_work+0x40/0x70
> [   14.339154]  process_one_work+0x184/0x39c
> [   14.339160]  worker_thread+0x228/0x3e8
> [   14.339168]  kthread+0x148/0x3ac
> [   14.339176]  ret_from_fork+0x10/0x30
> 
> [...]

Here is the summary with links:
  - [v5,1/5] Bluetooth: btmtksdio: Fix kernel oops in btmtksdio_interrupt
    https://git.kernel.org/bluetooth/bluetooth-next/c/496eab9dde9f
  - [v5,2/5] Bluetooth: mt7921s: Set HCI_QUIRK_VALID_LE_STATES
    https://git.kernel.org/bluetooth/bluetooth-next/c/aeeb8ed27062
  - [v5,3/5] Bluetooth: mt7921s: Add .get_data_path_id
    https://git.kernel.org/bluetooth/bluetooth-next/c/c844ce71d5be
  - [v5,4/5] Bluetooth: mt7921s: Add .btmtk_get_codec_config_data
    https://git.kernel.org/bluetooth/bluetooth-next/c/3cabc5ca2c9d
  - [v5,5/5] Bluetooth: mt7921s: Add WBS support
    https://git.kernel.org/bluetooth/bluetooth-next/c/255a55aaccb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


