Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA3F4D8833
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242572AbiCNPfo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Mar 2022 11:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242549AbiCNPfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:35:33 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B605C2182D;
        Mon, 14 Mar 2022 08:34:23 -0700 (PDT)
Received: from smtpclient.apple (p5b3d2183.dip0.t-ipconnect.de [91.61.33.131])
        by mail.holtmann.org (Postfix) with ESMTPSA id ACCA2CECC5;
        Mon, 14 Mar 2022 16:34:22 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] Bluetooth: hci_uart: add missing NULL check in h5_enqueue
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220313174936.1299-1-paskripkin@gmail.com>
Date:   Mon, 14 Mar 2022 16:34:22 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Hilda Wu <hildawu@realtek.com>,
        Archie Pusaka <apusaka@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <E53EB6BA-06CE-48B4-96A5-745D0F2D3646@holtmann.org>
References: <20220313174936.1299-1-paskripkin@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> Syzbot hit general protection fault in __pm_runtime_resume(). The problem
> was in missing NULL check.
> 
> hu->serdev can be NULL and we should not blindly pass &serdev->dev
> somewhere, since it will cause GPF.
> 
> Reported-by: syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com
> Fixes: d9dd833cf6d2 ("Bluetooth: hci_h5: Add runtime suspend")
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
> drivers/bluetooth/hci_h5.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

However if someone would finally step up and write a standalone serdev only driver for 3-Wire UART support, this would not be a problem in the first place. We are just applying on bandaid after another.

Regards

Marcel

