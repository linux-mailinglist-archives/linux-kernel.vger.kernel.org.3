Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0251557FD77
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiGYK2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiGYK2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:28:41 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Jul 2022 03:28:40 PDT
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D534617056
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1658744920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JUCXNOWGeSPCiwGQYc/T+9+goJfq4FZanOX3lvy182E=;
        b=hRMf+pXbytl7a1wCKqV1c3hX1FGrWD7B51inLwsezZ52QFWodj0TF0XgOshx5gJOBPOtL2
        gYAFYqIHj2OD2kqAoszWKXSf15UbQO2nL7bNGmttodCpIhekSagXdwiWqnW459LIXVkwPW
        FhHk8dsq73b67uI6Nads4QsBE0cbXzv/W9B8IpTrfK1RQl4OyK9bOWvyUPScK3BEpIv/4y
        b3d7qL/Dw15U4qZ2Zh1DyEQN9/aUVAZ+yH2yYoNsU4sjykQh+kOAe8O3UbEBh3e214cI8T
        gDybe/62/zDHj8FEMzb4NAKUqrwihhnqiBdr+sCLr6mFgSX/WnTo9du6OgdtrA==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-649-gvVIEv8FMpuxeTfL3Jqjdw-1; Mon, 25 Jul 2022 06:27:35 -0400
X-MC-Unique: gvVIEv8FMpuxeTfL3Jqjdw-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Mon, 25 Jul 2022 03:27:37 -0700
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        "Rahul Tanwar" <rtanwar@maxlinear.com>
Subject: [PATCH RESEND 0/3] Modify MxL's CGU clk driver to make it secure boot compatible
Date:   Mon, 25 Jul 2022 18:27:26 +0800
Message-ID: <cover.1658742240.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA115A51 smtp.mailfrom=rtanwar@maxlinear.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Resend due to a mistake in adding --cc while sending patches

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

This patch series is based on below git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git

Rahul Tanwar (3):
  clk: mxl: Switch from direct readl/writel based IO to regmap based IO
  clk: mxl: Remove unnecessary spinlocks
  clk: mxl: Avoid disabling gate clocks from clk driver

 drivers/clk/x86/Kconfig       |   5 +-
 drivers/clk/x86/clk-cgu-pll.c |  23 ++-----
 drivers/clk/x86/clk-cgu.c     | 117 +++++++++++-----------------------
 drivers/clk/x86/clk-cgu.h     |  45 +++++++------
 drivers/clk/x86/clk-lgm.c     |  14 ++--
 5 files changed, 76 insertions(+), 128 deletions(-)

--=20
2.17.1

