Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2C653C9DE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244222AbiFCMSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiFCMSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:18:03 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A78B205C7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:18:02 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s68so7084553pgs.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 05:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l0xmT1KYSsFWSUGQw0bMdsHxE24gxAW166il/DMtpOQ=;
        b=Lj+0p3fXY2rF4JNEMIrj2XsKFvMXBJJ7ifsbXSrRrnSWqbwl7lzXtdkA+Ddz1Q/WFZ
         J48VdeLwvRH+1emzi+4wof4yF2kP2v3z0P/hFnhzy98V31yLWBH+5EzI45VTSBH2zf0O
         natUWEpkedu7hsQf2QU//Ek0/mgKjjJNTOb8/5jCgQ2SfFf4yiprV1ms1zgd6lo9sJi5
         5VCa0NiPORYnHtLOUiNBw/A76AoV/vcwTmfguv0nCIP8gwW8o0AGRuRYSSCzAUMu7Qh0
         sC5+7Jn0eHQ6+NOhao0UgWFnxBknSNXOycgHeKyNgOMSAoo+wFIsojrC6B7QebDUWQG4
         DDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l0xmT1KYSsFWSUGQw0bMdsHxE24gxAW166il/DMtpOQ=;
        b=vxhcK+Ni+pL8RSp03rk+j8ihaF/wFQHurVqvPJhoDOflkReqBEdYmhFOJgOVXqVyQN
         KbLYyhB0IU+cMmwdaQGAsJP4jhKck/IPrjA9f12J773gPD32womFoBmPeKzQCwUXvxOt
         F+9REH5204kKhn7RzmdY4Jh+U2NLtME9IB9pLMznyPQdeNxpfVqKD9v5NS5vIvddEw2n
         gLNYd/YGTDkcLWMjVDiGE38c6RcdUra8MnNyRBy/G3/m233vlQS+BYtl1pCYXp4IJy6y
         kfvoohfowi1hwdjc5pck5bn2MGjolZMXjgaOWLiuK5xL6wtQ757KLdas2TvRS92grCJk
         sYjQ==
X-Gm-Message-State: AOAM533AndlBoXxveLJTeeYVF+wYRkV/V3GUa2MSQ+Tji0tmGDQhdsyo
        d6p/Ctrsbe0G8GPbKM+oojs=
X-Google-Smtp-Source: ABdhPJwamKF+KKY2QuxjUXQr7kEVbBv816373+3AZawbSrH0MiN5TSY945N6BoB3zx8KxS1tgnuDtA==
X-Received: by 2002:a05:6a00:8ce:b0:510:9298:ea26 with SMTP id s14-20020a056a0008ce00b005109298ea26mr10088434pfu.55.1654258682051;
        Fri, 03 Jun 2022 05:18:02 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id w20-20020a627b14000000b0051853e6617fsm5301708pfc.89.2022.06.03.05.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:18:01 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Scott Wood <oss@buserror.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Miaoqian Lin <linmq006@gmail.com>,
        Nick Child <nick.child@ibm.com>, Nate Case <ncase@xes-inc.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/85xx: Fix reference leak in xes_mpc85xx_setup_arch
Date:   Fri,  3 Jun 2022 16:17:50 +0400
Message-Id: <20220603121752.23548-1-linmq006@gmail.com>
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

of_find_node_by_path() returns remote device nodepointer with
refcount incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 3038acf9091f ("powerpc/85xx: Add platform support for X-ES MPC85xx boards")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- update Fixes tag.
v1 Link: https://lore.kernel.org/all/20220603120907.19999-1-linmq006@gmail.com
---
 arch/powerpc/platforms/85xx/xes_mpc85xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index 5836e4ecb7a0..93f67b430714 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -130,6 +130,8 @@ static void __init xes_mpc85xx_setup_arch(void)
 	mpc85xx_smp_init();
 
 	fsl_pci_assign_primary();
+
+	of_node_put(root);
 }
 
 machine_arch_initcall(xes_mpc8572, mpc85xx_common_publish_devices);
-- 
2.25.1

