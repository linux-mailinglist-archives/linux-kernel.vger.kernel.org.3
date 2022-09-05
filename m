Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657365ACD37
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiIEHyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiIEHyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:54:07 -0400
X-Greylist: delayed 608 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Sep 2022 00:54:05 PDT
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0818944549
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1662364381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cXsJkI9uheokmDJdr4Al6h7pqoH+3TWVaaDrZ0MDZeY=;
        b=b64WXEXL32FZt7IXnfMe6YgCo6URilexHHHUuFrvToC+selj++Ys4Pm4M+Vabfa/Bod2Yb
        yWAFxN3mXVsCUCiswyukABfjhawxp4yXii20wnPSFvpo0OScjWYUakDJgtR9OVbhjfBn4b
        0cv25/5arudpn8DacLZbQIkAFaZCmKHw/iECM/a3Fq2TrLdhngFQP9rKOju6jrvgQs+jS3
        lF+yQJOxSIPl2XXxe1bfqBrsJmg/BkeLmMlNEvaFwzxucthMmtXovuw3r7nHTsDMGgrDxx
        lecYWi4BjJPalUV2M08pI9w3CSoax6+TBKBumrnWwOebTriyGTHZu2Eogn13dg==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-86-t3i3N88IO3eHPMNn8pxtqw-1; Mon, 05 Sep 2022 03:43:54 -0400
X-MC-Unique: t3i3N88IO3eHPMNn8pxtqw-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Mon, 5 Sep 2022 00:43:51 -0700
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        "Rahul Tanwar" <rtanwar@maxlinear.com>
Subject: [PATCH v2 0/5] Modify MxL's CGU clk driver to make it secure boot compatible
Date:   Mon, 5 Sep 2022 15:43:43 +0800
Message-ID: <cover.1662363020.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MxL's CGU driver was found to be lacking below required features. Add these
required lacking features:

1. Since it is a core driver, it has to conform to secure boot & secure
   access architecture. In order for the register accesses to be secure
   access compliant, it needs regmap support as per our security architectu=
re.
   Hence, replace direct read/writel with regmap based IO. Also remove spin=
locks
   because they are no longer necessary because regmap uses its own lock.

2. There are some gate clocks which are used by the power mgmt IP to gate w=
hen
   a certain power saving mode is activated. These gate clocks can also be=
=20
   gated from CGU clk driver. This creates a conflict. To avoid the conflic=
t,
   by default disable gating such gate registers from CGU clk driver. But k=
eep
   a flag to do so for other older IP's which uses same CGU clk IP but does=
 not
   use same power mgmt IP.

3. Fix two functional bugs found during testing.

This patch series is based on below git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git


Rahul Tanwar (5):
  clk: mxl: Switch from direct readl/writel based IO to regmap based IO
  clk: mxl: Remove unnecessary spinlocks
  clk: mxl: Avoid disabling gate clocks from clk driver
  clk: mxl: Add validation for register reads/writes
  clk: mxl: Add a missing flag to allow parent clock rate change

 drivers/clk/x86/Kconfig       |   5 +-
 drivers/clk/x86/clk-cgu-pll.c |  23 ++-----
 drivers/clk/x86/clk-cgu.c     | 117 +++++++++++-----------------------
 drivers/clk/x86/clk-cgu.h     |  71 +++++++++++++--------
 drivers/clk/x86/clk-lgm.c     |  16 +++--
 5 files changed, 101 insertions(+), 131 deletions(-)

--=20
2.17.1

