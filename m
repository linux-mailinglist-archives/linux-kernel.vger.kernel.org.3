Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB7C4E504D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243522AbiCWK3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243513AbiCWK3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:29:32 -0400
X-Greylist: delayed 1023 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Mar 2022 03:28:02 PDT
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37A25F42
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 03:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=Content-Type:MIME-Version:Message-ID:Subject:To:
        From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0m+uRoiTivb2BUtxBNrl7ee/92eZ1F5hbLZE85sd5iE=; b=htCSIwcdYBnmNCnfVogfUkah+N
        nmvP/suO/0O/hXFz1o7AAVWWCA8upYwWL0eygvmZmqscoDDt10RKJUUw/z+7vtiiT0pdui+R4DDM/
        f9HpCu5xsv0PcSsz1eLS9gOtt3qd8nj/PEfb3CYw+nWXFbuIcJhEPw2v4AdM1rZy8QZQvd5PHRT6q
        IplTLJfCs1F/TURmlAAMbscIhS1cKNzqdeHu4Fz3kLMG7hS/gA8DgWz9J8UykH2di86WpccvJg0Wy
        fbq+bZ6X3IAPx5y6YZlAuue1gD3wWvKw+WtC8mN2rROuX/TYzk5yQJdJjIGgjZr+yfrDJC3Z9AJV/
        DWKJm+pA==;
Received: from tvk215040.tvk.ne.jp ([180.94.215.40] helo=sakefilet.preining.info)
        by hz.preining.info with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <norbert@preining.info>)
        id 1nWxxA-00AmUz-E7
        for linux-kernel@vger.kernel.org; Wed, 23 Mar 2022 10:10:57 +0000
Received: by sakefilet.preining.info (Postfix, from userid 1000)
        id 3D6232038C8C; Wed, 23 Mar 2022 19:10:53 +0900 (JST)
Date:   Wed, 23 Mar 2022 19:10:53 +0900
From:   Norbert Preining <norbert@preining.info>
To:     linux-kernel@vger.kernel.org
Subject: 5.17.0 fails to suspend
Message-ID: <YjryLd+TuigtA6co@sakefilet.preining.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

(please cc)

upgrading from 5.16.15 or so to 5.17.o my laptop (Fujitsu Lifebook U
Series) fails to suspend:

kernel: Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
kernel: printk: Suspending console(s) (use no_console_suspend to debug)
kernel: e1000e: EEE TX LPI TIMER: 00000011
kernel: PM: pci_pm_suspend(): hcd_pci_suspend+0x0/0x30 returns -16
kernel: PM: dpm_run_callback(): pci_pm_suspend+0x0/0x160 returns -16
kernel: xhci_hcd 0000:00:14.0: PM: failed to suspend async: error -16
kernel: PM: Some devices failed to suspend, or early wake event detected
kernel: nvme nvme0: Shutdown timeout set to 8 seconds
kernel: nvme nvme0: 8/0/0 default/read/poll queues
kernel: OOM killer enabled.

No external usb device connected, internal ones:
$ lsusb
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 004: ID 04f2:b6e1 Chicony Electronics Co., Ltd FJ Camera
Bus 001 Device 003: ID 298d:2033 Next Biometrics NB-2033-U
Bus 001 Device 002: ID 058f:9540 Alcor Micro Corp. AU9540 Smartcard Reader
Bus 001 Device 005: ID 8087:0026 Intel Corp. AX201 Bluetooth
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

What further information can I provide (no external usb device

(please cc)

All the best

Norbert

--
PREINING Norbert                              https://www.preining.info
Fujitsu Research     +    IFMGA Guide     +    TU Wien    +    TeX Live
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
