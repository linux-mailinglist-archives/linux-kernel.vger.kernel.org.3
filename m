Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35C55ACD3B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbiIEHzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbiIEHzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:55:08 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5AD11C25
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1662364501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BtUJUYZOy4dsKmtYSOJkIch/jexIUqRsQ+FbLNIyJJQ=;
        b=HvvjpPNYr6G2Rg53atVCceL0cWusJNbrtwFjF2G5ko0pnAp41yA8up0Vwq9UmtdEzvE4xr
        pL/xXI8woEf+/m+NhAezPe7W4OW6drCdEsRUZqTI7u4V/dxr4sgFsonuKrrqo66jOgcnG+
        RpkI3K7XQpvWNToYGjK2vFTN3/pG3t14TywMdWEyf2qrKkxow8f/DpNrf+Pweb9k23zCiQ
        RNz5K62VAQQs+JgX16i/itTNxe5duBuocCZBmzVt5K4XiXuz5uikpfnd82iJDB4oDSYRf9
        3EE4R8L2rZubCxT3X7qPbabWxE5HQ2/4QkXMBNdU6GDKrIk1ZbTsS4DOlTaiGQ==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-78-H49kdtHfNy6Rs7NwcPrkMA-1; Mon, 05 Sep 2022 03:44:08 -0400
X-MC-Unique: H49kdtHfNy6Rs7NwcPrkMA-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Mon, 5 Sep 2022 00:44:05 -0700
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        "Rahul Tanwar" <rtanwar@maxlinear.com>
Subject: [PATCH v2 5/5] clk: mxl: Add a missing flag to allow parent clock rate change
Date:   Mon, 5 Sep 2022 15:43:48 +0800
Message-ID: <112a3d6f959fdb14a853897fe4b171d50eab7e55.1662363020.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1662363020.git.rtanwar@maxlinear.com>
References: <cover.1662363020.git.rtanwar@maxlinear.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the clock entry "dcl" clk's rate can only be changed by
changing its parent's clock rate. But it was missing to have
CLK_SET_RATE_PARENT flag as enabled.

Add/enable CLK_SET_RATE_PARENT flag for dcl clk in order to
allow its clk rate to be changed via its parent's clk.

Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
---
 drivers/clk/x86/clk-lgm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/x86/clk-lgm.c b/drivers/clk/x86/clk-lgm.c
index e312af42e97a..34e16ea90596 100644
--- a/drivers/clk/x86/clk-lgm.c
+++ b/drivers/clk/x86/clk-lgm.c
@@ -255,7 +255,7 @@ static const struct lgm_clk_branch lgm_branch_clks[] =
=3D {
 =09LGM_FIXED(LGM_CLK_SLIC, "slic", NULL, 0, CGU_IF_CLK1,
 =09=09  8, 2, CLOCK_FLAG_VAL_INIT, 8192000, 2),
 =09LGM_FIXED(LGM_CLK_DOCSIS, "v_docsis", NULL, 0, 0, 0, 0, 0, 16000000, 0)=
,
-=09LGM_DIV(LGM_CLK_DCL, "dcl", "v_ifclk", 0, CGU_PCMCR,
+=09LGM_DIV(LGM_CLK_DCL, "dcl", "v_ifclk", CLK_SET_RATE_PARENT, CGU_PCMCR,
 =09=0925, 3, 0, 0, 0, 0, dcl_div),
 =09LGM_MUX(LGM_CLK_PCM, "pcm", pcm_p, 0, CGU_C55_PCMCR,
 =09=090, 1, CLK_MUX_ROUND_CLOSEST, 0),
--=20
2.17.1

