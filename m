Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC03056CDBE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 10:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiGJIUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 04:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJITm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 04:19:42 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4A2BC0E;
        Sun, 10 Jul 2022 01:19:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657441146; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=G//ruNJWtc5KB4iy5vkg+oDxYaTZAblTm7aNahnX1lAklnS8eGAkKjdLZpOcPt3N8csTyyHBIGjL5OSxpoArIpLJuzvm8p2Gy9vKFPKmBzu2m5+wfkvXTMFXb0ua+DLOubhyfFL6HzF9+rZedqDPZP5TjEi3vAXfc66HFnhkCLw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657441146; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=NFS2/32BxwaD6fahAeZc1AfhBJU6/YF1+CjbT7OS85w=; 
        b=TQfGNYjIhWbat5WkxjQhtlgP4nkoe+soWGB9Tqh6zRPSp9UHKEpScFi66wvqXY55zM37TPJAaLb7UfjyJSWAOGtIcKY1d9Flpa2d+lzxDEpplxXr3zz4uEKEPzGYH8TlvvC8M8gEdotiaM2RVhHQQq2Mt8wX2rrKUIwWp3czFWc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657441146;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=NFS2/32BxwaD6fahAeZc1AfhBJU6/YF1+CjbT7OS85w=;
        b=KvRP9GWRsA+WTCougZocM3zTL73ekzM8w95wlu3fxEmAwg4qIRZq4zFRvkHiT1B6
        wFhaoG/Gr6UUMTxVtU0roRy5Tiu5zaxgpe7gDLfXNepk/+ylWBDPP2x89RjoRI7H7T1
        iIhPWCegA5wX36tB2Hsxmzq8Myv0Tkx1hyOV10Ns=
Received: from edelgard.icenowy.me (59.41.163.237 [59.41.163.237]) by mx.zohomail.com
        with SMTPS id 1657441143425993.9029258752463; Sun, 10 Jul 2022 01:19:03 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 0/3] Allwinner R329 {R-,}PIO pinctrl support
Date:   Sun, 10 Jul 2022 16:18:50 +0800
Message-Id: <20220710081853.1699028-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains support for two pin controllers on Allwinner R329
one, a CPUX one and a CPUS one (the standby processor on R329 is, in
fact, a Xtensa DSP), in addition to their bindings.

Icenowy Zheng (3):
  dt-bindings: pinctrl: document Allwinner R329 PIO and R-PIO
  pinctrl: sunxi: add support for R329 CPUX pin controller
  pinctrl: sunxi: add support for R329 R-PIO pin controller

 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |   4 +
 drivers/pinctrl/sunxi/Kconfig                 |  10 +
 drivers/pinctrl/sunxi/Makefile                |   2 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c | 293 +++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c   | 412 ++++++++++++++++++
 5 files changed, 721 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c

-- 
2.36.0

