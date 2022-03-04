Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9C24CD7F1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbiCDPfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240352AbiCDPfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:35:30 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F01F71C57F7;
        Fri,  4 Mar 2022 07:34:41 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5D89DCECCC;
        Fri,  4 Mar 2022 16:34:40 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH 2/2] Bluetooth: btmtksdio: Fix kernel oops when sdio
 suspend.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <939606fc0825aa17729ab9a1400f3993043fa2d3.1645573830.git.objelf@gmail.com>
Date:   Fri, 4 Mar 2022 16:34:40 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        =?utf-8?B?Ik1hcmstWVcgQ2hlbiAo6Zmz5o+a5paHKSI=?= 
        <Mark-YW.Chen@mediatek.com>, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        michaelfsun@google.com, mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yake Yang <yake.yang@mediatek.com>
Content-Transfer-Encoding: 7bit
Message-Id: <0E9BE045-5600-4EBC-8461-8779967E6B7B@holtmann.org>
References: <dba1c05e4bfdf53e631ff134eaa9449e2ad5deef.1645573830.git.objelf@gmail.com>
 <939606fc0825aa17729ab9a1400f3993043fa2d3.1645573830.git.objelf@gmail.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> Do not kfree the skb when the skb failed to send with __hci_cmd_sync
> 
> 2435.241210] Call trace:
> [ 2435.241224]  kfree_skb+0x20/0x140
> [ 2435.241240]  btmtksdio_sdio_wakeup+0x8c/0xcc
> [ 2435.241360]  hci_suspend_notifier+0x108/0x184
> [ 2435.241377]  notifier_call_chain_robust+0x58/0xd8
> [ 2435.241390]  blocking_notifier_call_chain_robust+0x54/0x84
> [ 2435.241402]  pm_notifier_call_chain_robust+0x2c/0x4c
> [ 2435.241414]  suspend_prepare+0x40/0x238
> [ 2435.241425]  enter_state+0xec/0x3a8
> [ 2435.241436]  pm_suspend+0x60/0xcc
> [ 2435.241446]  state_store+0xb8/0x114
> [ 2435.241460]  kobj_attr_store+0x18/0x2c
> [ 2435.241473]  sysfs_kf_write+0x44/0x58
> [ 2435.241486]  kernfs_fop_write_iter+0xf4/0x190
> [ 2435.241500]  vfs_write+0x2b0/0x2e4
> [ 2435.241511]  ksys_write+0x80/0xec
> [ 2435.241523]  __arm64_sys_write+0x24/0x30
> [ 2435.241538]  el0_svc_common+0xf0/0x1d8
> [ 2435.241550]  do_el0_svc_compat+0x28/0x54
> [ 2435.241564]  el0_svc_compat+0x10/0x1c
> [ 2435.241574]  el0_sync_compat_handler+0xa8/0xcc
> [ 2435.241586]  el0_sync_compat+0x188/0x1c0
> [ 2435.241606] Code: a9014ff4 910003fd b40002c0 aa0003f3 (b84d4c08)
> [ 2435.241619] ---[ end trace d496539b850baf14 ]---
> 
> Fixes: ce64b3e94919  ("Bluetooth: mt7921s: Support wake on bluetooth")
> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Yake Yang <yake.yang@mediatek.com>
> ---
> drivers/bluetooth/btmtksdio.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

