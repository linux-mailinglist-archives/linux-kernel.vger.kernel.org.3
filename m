Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787394F4876
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiDEVjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573312AbiDESwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:52:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7259B1AAB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:50:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27FB1618E1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81310C385A7;
        Tue,  5 Apr 2022 18:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649184645;
        bh=SEYzK4vSPeMJtzy43JQGZXAJd12jPg80CMxvL3TbA+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ftuf1iTnz8Nu5ZYDyk8s11y7iQSVnmZXMjBWjZkkG+vjWMk+7bJATzu15mgn0PQPN
         c7WdUa//KVMOS/YfTc5PpI3Fs3Of6n8MCsI/AAMODdDuo4m88I0tklSSIkFOr9pUKp
         zjJuNazMQLa4iMionLKyXyV3Rk6Haa8ZNHlf9GOvAuFhNT7aQ2ChjU8CoVO+zIZYLS
         tqEpjwrlwwaIBXdeQ8TJmdAbpj4M7J/naaKnah3PHJIwmrvmfNR0CnHb18iNEoW6bO
         Y17bP3EuCu908PqsT/LplVGE/crve5mY7xNBBXisSKQFOg8FiZNoK99SU5QVo8NpD6
         gJxk7Z1YyKTug==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nboGJ-001tpg-Fx; Tue, 05 Apr 2022 19:50:43 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        David Decotigny <ddecotig@google.com>
Subject: [PATCH v3 3/3] irqchip/gic-v3: Always trust the managed affinity provided by the core code
Date:   Tue,  5 Apr 2022 19:50:40 +0100
Message-Id: <20220405185040.206297-4-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405185040.206297-1-maz@kernel.org>
References: <20220405185040.206297-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, john.garry@huawei.com, wangxiongfeng2@huawei.com, ddecotig@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the core code has been fixed to always give us an affinity
that only includes online CPUs, directly use this affinity when
computing a target CPU.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index cd772973114a..2656efd5d2b6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1624,7 +1624,7 @@ static int its_select_cpu(struct irq_data *d,
 
 		cpu = cpumask_pick_least_loaded(d, tmpmask);
 	} else {
-		cpumask_and(tmpmask, irq_data_get_affinity_mask(d), cpu_online_mask);
+		cpumask_copy(tmpmask, aff_mask);
 
 		/* If we cannot cross sockets, limit the search to that node */
 		if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&
-- 
2.34.1

