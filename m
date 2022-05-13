Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880205260E8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379887AbiEMLVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379872AbiEMLVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:21:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE264BBAE;
        Fri, 13 May 2022 04:21:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70240B82E2D;
        Fri, 13 May 2022 11:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E32EC34114;
        Fri, 13 May 2022 11:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652440899;
        bh=NSumgZGJhzw4Um65FRmlw3GUmWdXI8pQPXolPYvlJDM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aca5IocmkQXoNRqXxscwpGHGvEvVVEnoPo6+343RDS7hcbE2/NrNNNGEXvCs4BEyn
         DKYRdC0TqZxf8Z04x9n3PArd4q3cJV77Doc2fbugAoTjKyvvr3Q9GQwdUNArX1AKLU
         SuL3MDpJxPq6NG6OvHpTsCHyAhlm/pHwWxrV2eWjJXzIUGU9wc18D2UNgDlyLD+RIM
         5+VBp4JGfmLL85D5gdBdbXDtM37q3k0bz1WbiwUiL8BMOzf0UmPVZjk70KuP7xzaTl
         uoXFh8LCbj2lLzeA7Ijr0CaS8PmO1TYJU2eJD6PYZoyZf9qVwjWXiNfmByiOhh/kVG
         Cyu/aanGBvGQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E0A1F03935;
        Fri, 13 May 2022 11:21:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btmtksdio: fix use-after-free at
 btmtksdio_recv_event
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165244089905.8477.615548709486219646.git-patchwork-notify@kernel.org>
Date:   Fri, 13 May 2022 11:21:39 +0000
References: <f8bf12f9682a01de8905d4c0d7a0a1ff0502ba5f.1652307131.git.objelf@gmail.com>
In-Reply-To: <f8bf12f9682a01de8905d4c0d7a0a1ff0502ba5f.1652307131.git.objelf@gmail.com>
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

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Thu, 12 May 2022 06:22:15 +0800 you wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> We should not access skb buffer data anymore after hci_recv_frame was
> called.
> 
> [   39.634809] BUG: KASAN: use-after-free in btmtksdio_recv_event+0x1b0
> [   39.634855] Read of size 1 at addr ffffff80cf28a60d by task kworker
> [   39.634962] Call trace:
> [   39.634974]  dump_backtrace+0x0/0x3b8
> [   39.634999]  show_stack+0x20/0x2c
> [   39.635016]  dump_stack_lvl+0x60/0x78
> [   39.635040]  print_address_description+0x70/0x2f0
> [   39.635062]  kasan_report+0x154/0x194
> [   39.635079]  __asan_report_load1_noabort+0x44/0x50
> [   39.635099]  btmtksdio_recv_event+0x1b0/0x1c4
> [   39.635129]  btmtksdio_txrx_work+0x6cc/0xac4
> [   39.635157]  process_one_work+0x560/0xc5c
> [   39.635177]  worker_thread+0x7ec/0xcc0
> [   39.635195]  kthread+0x2d0/0x3d0
> [   39.635215]  ret_from_fork+0x10/0x20
> [   39.635247] Allocated by task 0:
> [   39.635260] (stack is not available)
> [   39.635281] Freed by task 2392:
> [   39.635295]  kasan_save_stack+0x38/0x68
> [   39.635319]  kasan_set_track+0x28/0x3c
> [   39.635338]  kasan_set_free_info+0x28/0x4c
> [   39.635357]  ____kasan_slab_free+0x104/0x150
> [   39.635374]  __kasan_slab_free+0x18/0x28
> [   39.635391]  slab_free_freelist_hook+0x114/0x248
> [   39.635410]  kfree+0xf8/0x2b4
> [   39.635427]  skb_free_head+0x58/0x98
> [   39.635447]  skb_release_data+0x2f4/0x410
> [   39.635464]  skb_release_all+0x50/0x60
> [   39.635481]  kfree_skb+0xc8/0x25c
> [   39.635498]  hci_event_packet+0x894/0xca4 [bluetooth]
> [   39.635721]  hci_rx_work+0x1c8/0x68c [bluetooth]
> [   39.635925]  process_one_work+0x560/0xc5c
> [   39.635951]  worker_thread+0x7ec/0xcc0
> [   39.635970]  kthread+0x2d0/0x3d0
> [   39.635990]  ret_from_fork+0x10/0x20
> [   39.636021] The buggy address belongs to the object at ffffff80cf28a600
>                 which belongs to the cache kmalloc-512 of size 512
> [   39.636039] The buggy address is located 13 bytes inside of
>                 512-byte region [ffffff80cf28a600, ffffff80cf28a800)
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btmtksdio: fix use-after-free at btmtksdio_recv_event
    https://git.kernel.org/bluetooth/bluetooth-next/c/0fab6361c4ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


