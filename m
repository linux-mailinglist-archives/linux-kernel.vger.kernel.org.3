Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8702591EBD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbiHNGop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiHNGoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:44:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E829B61B12;
        Sat, 13 Aug 2022 23:44:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so4335037pjf.2;
        Sat, 13 Aug 2022 23:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=dBUCfl7ovG2Vsq0YOjmDbDDGATwn6CqcVymMcfKmnSs=;
        b=FKsOdyc5fE03yIQ938uyXVkFPPLWlmI+mHCJYM9b2ZddFry7ju2Lv6wXMPIKolLO8J
         /9y0NWkzEVb0LFj8bjENZcbCEN6MQESAA2L3OJcA3AOhIdngKyvSDmNM98s1MeexRj6u
         DiDDi4z8d1jAFhXYMQychq986/wC1U9dYqKA99mg9ym+g1qoLORAJz063/RHMVZVAuYC
         4ZgyTwHOYsf8bzbm1JFJqYCCEQDmyn/DOz0fpq0RiJfAR1ppgwbDfQcox/zEQFe9/Vmr
         ofLThdJojpkZy1uXWNklM008BGyYjeX3Kqcc4xL6ZGPdkPgSbga0NQg9xbNgfye2cT5Y
         4uMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=dBUCfl7ovG2Vsq0YOjmDbDDGATwn6CqcVymMcfKmnSs=;
        b=DzYoCgFiJo7Cg4E2+qixdBhmseBDaXvKc1C9Oao9xGDDNfVTOeGp9ydwj2nJ+T/6rk
         zTgLVYHQKfzNU+25ZixkUpaW0kCP21zyS7nbgJEglyTpdl/PYD9sZI78lq9ZMDbr48UV
         DnhgKLIyoBWdENMK+ds/mP9P/StI4YCRaL9PI2VEDMBCCrIFit4S6L3i3KWQjLlWebmg
         WbIIVUvyO0c9kSnar7VHOzQOn+GoPCUaj0DfvSWkhIcC0gLnEq8ym+0nuxt5OmkfY83g
         Oae1oBLFSr5vtM25RE3wWwNCJnzNpIHkqeqVGOa38rZIggsdtvA3WDo6+y09s9cm4K5D
         FVag==
X-Gm-Message-State: ACgBeo0JHtHLD9J56EkPA0ndmrzXaCC+ZLB3qjSTtcAEaK0vq+IPo1lL
        2EIqZqhyWeAymYiaIXD5guk=
X-Google-Smtp-Source: AA6agR4YfgZpeOqTRAry23FZ3DnqYEvL7edsuLVry2wHV73DxeZGeiOKjIV+/K/qxsm0955JJtNHeQ==
X-Received: by 2002:a17:902:cec8:b0:16f:8081:54bc with SMTP id d8-20020a170902cec800b0016f808154bcmr10969618plg.139.1660459470590;
        Sat, 13 Aug 2022 23:44:30 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id o27-20020aa7979b000000b0052d481032a7sm4593778pfp.26.2022.08.13.23.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 23:44:30 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        khalid@gonehiking.org, willy@infradead.org, hare@suse.com
Cc:     anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        91tuocao@gmail.com
Subject: [PATCH 4/9] scsi: a3000: move spin_lock_irqsave to spin_lock in interrupt handler
Date:   Sun, 14 Aug 2022 14:43:32 +0800
Message-Id: <20220814064337.32621-5-91tuocao@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220814064337.32621-1-91tuocao@gmail.com>
References: <20220814064337.32621-1-91tuocao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it is unnecessary to call spin_lock_irqsave in a interrupt handler.

Signed-off-by: Tuo Cao <91tuocao@gmail.com>
---
 drivers/scsi/a3000.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/a3000.c b/drivers/scsi/a3000.c
index 2c5cb1a02e86..f34c436459d5 100644
--- a/drivers/scsi/a3000.c
+++ b/drivers/scsi/a3000.c
@@ -36,14 +36,13 @@ static irqreturn_t a3000_intr(int irq, void *data)
 	struct Scsi_Host *instance = data;
 	struct a3000_hostdata *hdata = shost_priv(instance);
 	unsigned int status = hdata->regs->ISTR;
-	unsigned long flags;
 
 	if (!(status & ISTR_INT_P))
 		return IRQ_NONE;
 	if (status & ISTR_INTS) {
-		spin_lock_irqsave(instance->host_lock, flags);
+		spin_lock(instance->host_lock);
 		wd33c93_intr(instance);
-		spin_unlock_irqrestore(instance->host_lock, flags);
+		spin_unlock(instance->host_lock);
 		return IRQ_HANDLED;
 	}
 	pr_warn("Non-serviced A3000 SCSI-interrupt? ISTR = %02x\n", status);
-- 
2.17.1

