Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881F44E50A3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiCWKvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiCWKvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:51:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAFA75C3C;
        Wed, 23 Mar 2022 03:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5373C61180;
        Wed, 23 Mar 2022 10:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB96FC340E9;
        Wed, 23 Mar 2022 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648032611;
        bh=kjeZ9alUc2aWCvK8F3N4ELOWHGXAyCN/wyWHw77ecyM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m+R/v48GTVq6Nw0Y2NiGubmq/CXboOdaZKUJrWodtdkNCuBT+/GorN9ibMklBvltu
         7Ezlzpktyx54ZJTf04yYbhGSJsJEp0GHcQ1Ipoc/cPAquzAgYzAFNhkuGYtp0wMRmQ
         d/6IkwdClmOh8meJc2Alq13p0cgLEg+NTYjsFXFIE8M688F+itd8VcQ0g8yB9+IuaU
         EjmgNw1NRWVWlYKM8AaCf89jQlGTpgcOHquCjWAqPNP+JQHU/Eq8gTN5EfPAjJiKgb
         fj3cX79WIMmL+h1MdHfwYynzL4++93tTxT/YeZPVoAb05pDlkuqXB9aTBlAwQ6OY95
         QlWXbVptvxJSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85DF4EAC096;
        Wed, 23 Mar 2022 10:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: mt7921s: Fix the incorrect pointer check
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164803261154.27387.6013475934933962209.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Mar 2022 10:50:11 +0000
References: <5d56b2a23e6e793c64ed98890329ce1beb010ce0.1647991506.git.objelf@gmail.com>
In-Reply-To: <5d56b2a23e6e793c64ed98890329ce1beb010ce0.1647991506.git.objelf@gmail.com>
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
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Marcel Holtmann <marcel@holtmann.org>:

On Wed, 23 Mar 2022 07:30:40 +0800 you wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Fix the incorrect pointer check on ven_data.
> 
> Fixes: f41b91fa1783 ("Bluetooth: mt7921s: Add .btmtk_get_codec_config_data")
> Co-developed-by: Yake Yang <yake.yang@mediatek.com>
> Signed-off-by: Yake Yang <yake.yang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: mt7921s: Fix the incorrect pointer check
    https://git.kernel.org/bluetooth/bluetooth-next/c/864cc8a234cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


