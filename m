Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA53553DA49
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 07:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349127AbiFEFcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 01:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiFEFcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 01:32:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E799D41F97
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 22:32:40 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so3586183pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 22:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0nS6GixGg0X/K0hARwKVVjwZtlk3sOYNjMOr3Fp274I=;
        b=DC8iPQcOCYF6u8bsWeP5y1eXm1SdBW9Xw5KxTrNQ36MGP6Qt6ueiiKz4w4P48A8oQ4
         iFLNeAxpdqoDvVEmlnJgh6N5A7fhMwvDu/rkFdS6ahCREBeMIh09E+vnIN6ICfjCrmry
         Xy6N0MxWc3yJvleJzGu3TLOJwKKXxCGqdDneF8aXiV1zZO5h0jXdHR7RlAIvzE09hkKe
         0jvtAROlvxBa9WmV+WuvzCP3JSMpFuLrs6c+hkvGuhO2od7sgYNXH8pBCHuDp27QDopt
         TZeDTykzML5stnA1b925cRN4L81egGsUINn8VJ9mUgZnpB9Chj/Af2MsfYD8TjJ14BpJ
         +37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0nS6GixGg0X/K0hARwKVVjwZtlk3sOYNjMOr3Fp274I=;
        b=CDO9FhqhR5byWjkDWzOXQ0q8BeGOKTu0VmBzi2MBo7aD5KCivZHR6ve43wvLwc36JZ
         w9VUE6q/d9yhP18nKYB77dCiFMeaMqzPbSB7hFXRTPzyl1pFZ+q0q1uAjGk+WDclooBG
         g6snT0ZvTyRvviB2exYuzMhzF0peFN0TGbTmSb1wjhcamR8f3S30IXSU16+GXB3/7iYa
         PUAtCNm11v7ajsxYdGWnr4Mp9dRMqRZ13WatTbd9SrJ6A2CQxblBOH39tgES0VV3ORGA
         JvbFtNpE5fe5gBICXVgA8KNKBw34rYLsT2SKVsNvKVkZuzcB601y35hmh3vaPmWgDoR7
         S7zw==
X-Gm-Message-State: AOAM532q1bwxWdEHkR+hc0CX4wzBe6OPdLJHL/kIto8RlF5oqoK+Uqih
        QeHJK+70MNTP6PM3GaBAYp4=
X-Google-Smtp-Source: ABdhPJy8kLoluj27W3hJN/R+Mte0wZHenNHtyFccibnXmjSpD+q7PklVpGrImgzUnmAOhCUDR0wgrw==
X-Received: by 2002:a17:902:e1cc:b0:164:1517:e8bf with SMTP id t12-20020a170902e1cc00b001641517e8bfmr18236330pla.98.1654407160432;
        Sat, 04 Jun 2022 22:32:40 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id m6-20020a1709026bc600b0016370e1af6bsm5262068plt.128.2022.06.04.22.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 22:32:39 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Ammar Faizi <ammarfaizi2@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Nick Child <nick.child@ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/xive: Fix refcount leak in xive_get_max_prio
Date:   Sun,  5 Jun 2022 09:32:23 +0400
Message-Id: <20220605053225.56125-1-linmq006@gmail.com>
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

of_find_node_by_path() returns a node pointer with
refcount incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: eac1e731b59e ("powerpc/xive: guest exploitation of the XIVE interrupt controller")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/powerpc/sysdev/xive/spapr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index 7d5128676e83..d398823d138e 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -717,6 +717,7 @@ static bool __init xive_get_max_prio(u8 *max_prio)
 	}
 
 	reg = of_get_property(rootdn, "ibm,plat-res-int-priorities", &len);
+	of_node_put(rootdn);
 	if (!reg) {
 		pr_err("Failed to read 'ibm,plat-res-int-priorities' property\n");
 		return false;
-- 
2.25.1

