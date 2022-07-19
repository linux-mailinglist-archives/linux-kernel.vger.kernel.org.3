Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882D75790D6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbiGSC1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiGSC1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 212533AE74
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658197671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1KL4MutqoRxmcuscCUXm8t63mCy8nNQ4Lfka4AKoNx0=;
        b=hG70k8sBr2RPUq9AQNzTz5JhB6ISFMPcV6p5dqLUGieqwG2+BHRQTGQujrvtoR2youbxgD
        U7D05hiJ13bPuTElP2Q1UhUyirkLnVrkjBxyP/7DBmM1l1R8JijI3YqFv7zloBycwP1EBb
        8Rmhnvi098q/IjVh+OUYvnALlRUzu5s=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-ZMnvrwSENcusL6pIuAgz3Q-1; Mon, 18 Jul 2022 22:27:50 -0400
X-MC-Unique: ZMnvrwSENcusL6pIuAgz3Q-1
Received: by mail-qt1-f200.google.com with SMTP id c22-20020ac81116000000b0031d25923ea8so9465533qtj.17
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1KL4MutqoRxmcuscCUXm8t63mCy8nNQ4Lfka4AKoNx0=;
        b=5UYUKnqrnVvcCRjcCW0Wx0cLvNK+jaD1oe+7dw1yJUm+6NAAsHnTe6p+8OZ2OX5eIJ
         u2aD51+O+WgVNDI+ikuNBTnbNavto/W01C5Tr7P12Tz6NEfNPhKsrDVeh1fkJiq+uNkB
         FmaOtgwnqB8RirRWpy8mPCHnEGOooAYWjNOejR5HzyIwWtgcFN78bbLgL37ssRQJgPsh
         Ft1mTOd5dZuPbz9on7r+iMtj//d3icD/l8hqtSbXFSEqz77X67dmcNkEP50l7lbH0dUt
         sXnd/q+cPyC7isa9Z5MNoizTgE0CiH1wqRhXJzQCfCCk97ShiK/AawTeDws8D4EoMipm
         xO6A==
X-Gm-Message-State: AJIora+E7pA8E22UdMxqIY+vkRcR4d1edliWsY8FOT9Ixhs1Lp8FK8xZ
        a50LZ9GPezXDlcUWYASJfl8ZrQhjmq37W7DJ7MRJOOc93LUEJFSXoBv1tz1YFbOtmTrERbLpFWq
        M4niw7ulbnjwOBfNacPEUlPnE
X-Received: by 2002:a05:620a:1709:b0:6b5:ea99:472 with SMTP id az9-20020a05620a170900b006b5ea990472mr5057299qkb.486.1658197670161;
        Mon, 18 Jul 2022 19:27:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ty8pdYwfjbYzRjWEOQJipds9y50FEPqRin97qcIsTsIGvs6byCrwYyZCr+0bFlBiC/FlTvCg==
X-Received: by 2002:a05:620a:1709:b0:6b5:ea99:472 with SMTP id az9-20020a05620a170900b006b5ea990472mr5057291qkb.486.1658197669972;
        Mon, 18 Jul 2022 19:27:49 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g14-20020a05620a40ce00b006af3bc9c6bbsm14304615qko.52.2022.07.18.19.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 19:27:49 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     linus.walleij@linaro.org, sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] power: supply: ab8500: remove unused static local variable
Date:   Mon, 18 Jul 2022 22:27:43 -0400
Message-Id: <20220719022743.305189-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp_check reports
[drivers/power/supply/ab8500_chargalg.c:493]: (style) Variable 'ab8500_chargalg_ex_ac_enable_toggle' is assigned a value that is never used.

From inspection, this variable is never used. So remove it.

Fixes: 6c50a08d9dd3 ("power: supply: ab8500: Drop external charger leftovers")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/power/supply/ab8500_chargalg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index ae4be553f424..05146d436a6a 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -490,8 +490,6 @@ static int ab8500_chargalg_kick_watchdog(struct ab8500_chargalg *di)
 static int ab8500_chargalg_ac_en(struct ab8500_chargalg *di, int enable,
 	int vset_uv, int iset_ua)
 {
-	static int ab8500_chargalg_ex_ac_enable_toggle;
-
 	if (!di->ac_chg || !di->ac_chg->ops.enable)
 		return -ENXIO;
 
-- 
2.27.0

