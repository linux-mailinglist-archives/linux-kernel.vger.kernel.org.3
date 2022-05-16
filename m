Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB04527CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 06:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbiEPEeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 00:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiEPEeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 00:34:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E1C237E3;
        Sun, 15 May 2022 21:34:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id s14so13346701plk.8;
        Sun, 15 May 2022 21:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=htmaBZKsaFMpx4JIA7/CsRAg6+5c+s6+6dl8ZPXx/pQ=;
        b=X80L/lRs/O5ACxyA/f3IWydMhZMv0csOuo91YYZgTpiSAgbOgMyEWehSrsmfQgWZ5v
         Te7AiGtN543aW5VaTsYKwunkrOB1LMCZnOYiheVdrms44IPVRB13pAot7B77ZSZEZVy5
         tczMivnSSZ83+Fx//sQliNO1RS7TzHcLUFLFVZbPDMX4LA+AC7DtiPLrZfBcTj/oKkpY
         udTtMmts1M33Ip9W227v5De1unNQyVPNcGFt/7TTF+8q5WRj1T7JTg7APUI6AYHhyfMJ
         t+S0A3Qlg1kcobtUq4shSE41JeNZooR/nvbjZWn0gpRnC04ilsszALaTKlpIQmKV94kU
         +mlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=htmaBZKsaFMpx4JIA7/CsRAg6+5c+s6+6dl8ZPXx/pQ=;
        b=xG5Kc9jJlvsU5uUlHH6z4NvkzjwOUWPKUz/9VpHkSPZDP3TtpQQ40HPsNHiX89wcKL
         vDYZoie6lnY6aUdZP3ElGXna4WeDHcHUHY+gzitsi4MZP9RPEupYcq6z3b0mNUC6Able
         jL9Gz7mfoFaqRpo5icII5pHt2Zlf7V/YOan64ryaf26KowpjlMpQidtcoMFKTVOp933r
         N6udLvTs3m4/bGOhQxpZmn0ap256Z+C/WlBQS2HrGtZ7FgBSiqNqtQ98JqTaW0j+9kLF
         lvDu20cap8lQ0Opavoo72+ukzPvi30nBO1rUhj3hB3TvHQ4x9iYE03yGnGkuLGd3pg8/
         Oj0A==
X-Gm-Message-State: AOAM533ug60XFcgY36/BJYkeMRagnQ8oVeOOKbysoeRPkxNiuQxumJrE
        XEs3dN2tXNePG+TknkAs3No=
X-Google-Smtp-Source: ABdhPJyAS/pY+Zg1E++ZFWcMieQ3vvgDtMGGdEHP/WnEaF7GDtJy5mBPyy5WJ6Z24HyeMsPcG4nCeQ==
X-Received: by 2002:a17:90a:c48:b0:1df:6210:48a0 with SMTP id u8-20020a17090a0c4800b001df621048a0mr1716334pje.119.1652675642442;
        Sun, 15 May 2022 21:34:02 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id v127-20020a632f85000000b003c18ab7389asm5686793pgv.36.2022.05.15.21.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 21:34:02 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: CPC: Fix refcount leak in mips_cpc_default_phys_base
Date:   Mon, 16 May 2022 08:33:50 +0400
Message-Id: <20220516043353.8147-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_compatible_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 791412dafbbf ("MIPS: CPC: Map registers using DT in mips_cpc_default_phys_base()")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/mips/kernel/mips-cpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 17aff13cd7ce..3e386f7e1545 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -28,6 +28,7 @@ phys_addr_t __weak mips_cpc_default_phys_base(void)
 	cpc_node = of_find_compatible_node(of_root, NULL, "mti,mips-cpc");
 	if (cpc_node) {
 		err = of_address_to_resource(cpc_node, 0, &res);
+		of_node_put(cpc_node);
 		if (!err)
 			return res.start;
 	}
-- 
2.25.1

