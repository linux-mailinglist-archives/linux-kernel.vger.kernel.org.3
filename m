Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440964DBA28
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354948AbiCPVdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346516AbiCPVcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:32:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A7F286F1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:31:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e8-20020a259248000000b0063391b39d14so1973087ybo.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to;
        bh=Bl7MJwhFK3CmN1p0LqSa7+Zpx9isugSorKxGIE7TLbU=;
        b=ah8JhERqzsKI4zoA2wM2uCY/y/mKtUqCZoLIwB3GCdvt+R176gYWd3Ld2kbRNtnnUr
         8U9wbv3CAC9uy871ywNAiGgwkvf2m1U1vpk02cmN9umb/paDX/JSEhaidAUA1G4DjaLa
         piJhYvpV0OAAwCx9uvkOkFCvddGwkYOxWm6eHR78imHUeT5mSVGe4/2GO8O38vVlQ/Pc
         Y2YhL72G8o9DMCyMGfm2wrxfQAydVc4Qd7QhupIGdBqah1qSlM5P/thLWnxhmNyYwHmp
         /i4KM0WUSg8C87uwFk6w5KNfuGFRZ3OJ2xUbHDCy2cu2f0IkbUhFfpaksKteCqj7/715
         2zFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=Bl7MJwhFK3CmN1p0LqSa7+Zpx9isugSorKxGIE7TLbU=;
        b=toaTOD/z6/ksKCf9opBGWDpBM79O1FDChPI0ogWrQdt5bUPmdHNKheWy0fyQSqssN8
         A5b1hcJCc/0rKkil7USX9b0VKgnqRlxh45i5h36ulGS8lBXTWEvp+9gugWFN+Gkop+HB
         MQ+Mp0hRerWVbH1di2LNGzNIV9jPFN6UmjHBjrS9OYhf4qDwBu3aGqiJV4/XnVYgO3BU
         D91wdVQy+hK+6ig/iFYeSEu/u6MRj5k4ljKYrgprkBx0tG7x4JftfSXtUK1PSkxv9fqk
         V2R4mwNMJt2fIcih/5jR8d/PkmLWuOWX7QEFOPuAH564KYMwXPyyblxtqbT6bUh7g3KT
         h1pw==
X-Gm-Message-State: AOAM531N1STZxBf+yEQzduGwbajuNtZulJ2KKbOdJMygi3eEIZEF1dR6
        73Ozat4HJJ2AH7A7Di4ljBiDKeCp
X-Google-Smtp-Source: ABdhPJxcu9/nbwO++m/ad4AXWkdgZrz+qZB/yIay3eyHTM4D+IPKZRAvikVbXXZyPH347XhAgqrOD/zsyA==
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:7dae:6503:2272:5cd1])
 (user=morbo job=sendgmr) by 2002:a25:8b8a:0:b0:62c:25e2:cf2d with SMTP id
 j10-20020a258b8a000000b0062c25e2cf2dmr2115234ybl.186.1647466277390; Wed, 16
 Mar 2022 14:31:17 -0700 (PDT)
Date:   Wed, 16 Mar 2022 14:31:14 -0700
Message-Id: <20220316213114.2352352-1-morbo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH] net/fsl: xgmac_mdio: use correct format characters
From:   Bill Wendling <morbo@google.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tobias Waldekranz <tobias@waldekranz.com>,
        Marcin Wojtas <mw@semihalf.com>, Andrew Lunn <andrew@lunn.ch>,
        Bill Wendling <morbo@google.com>,
        Calvin Johnson <calvin.johnson@oss.nxp.com>,
        Markus Koch <markus@notsyncing.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with -Wformat, clang emits the following warning:

drivers/net/ethernet/freescale/xgmac_mdio.c:243:22: warning: format
specifies type 'unsigned char' but the argument has type 'int'
[-Wformat]
                        phy_id, dev_addr, regnum);
                                          ^~~~~~
./include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                    ~~~     ^~~~~~~~~~~
./include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                        ~~~    ^~~~~~~~~~~

The types of these arguments are unconditionally defined, so this patch
updates the format character to the correct ones for ints and unsigned
ints.

Link: ClangBuiltLinux/linux#378
Signed-off-by: Bill Wendling <morbo@google.com>
---
 drivers/net/ethernet/freescale/xgmac_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/xgmac_mdio.c b/drivers/net/ethernet/freescale/xgmac_mdio.c
index 266e562bd67a..1d5d09d2eb41 100644
--- a/drivers/net/ethernet/freescale/xgmac_mdio.c
+++ b/drivers/net/ethernet/freescale/xgmac_mdio.c
@@ -239,7 +239,7 @@ static int xgmac_mdio_read(struct mii_bus *bus, int phy_id, int regnum)
 	if ((xgmac_read32(&regs->mdio_stat, endian) & MDIO_STAT_RD_ER) &&
 	    !priv->has_a011043) {
 		dev_dbg(&bus->dev,
-			"Error while reading PHY%d reg at %d.%hhu\n",
+			"Error while reading PHY%d reg at %d.%d\n",
 			phy_id, dev_addr, regnum);
 		ret = 0xffff;
 	} else {
-- 
2.35.1.723.g4982287a31-goog

