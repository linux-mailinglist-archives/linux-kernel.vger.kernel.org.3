Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35C5591EBB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiHNGom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbiHNGob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:44:31 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD82460518;
        Sat, 13 Aug 2022 23:44:28 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id f192so4349206pfa.9;
        Sat, 13 Aug 2022 23:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=n7qz4yto1ktZFNeUhXN4QwZ2RPkWwBLjwxLu+TNsHm8=;
        b=c/Xc5xP4iiK4XaSBAFj8Gf8yPlb6joaklimQycaDAEjpCX+IqL4eLqbRPY7+V+nU/Q
         dRbfnuGXhZuVA0Akp9EuLG90+FjG/W+duHpCm/nVjoXrBoFhGgBrttdDEZFmOYHfNlJ9
         60fxAXHDcRnPpikbMtPYaXnJBMRg8oNKGECUh/5j1ZTRTudTlrCIhfgsbq9FgxcQmt/l
         pwgID2J+QyQ8oWVBXeqTNKMGs1kmur3ce65d2rWw34118iaoL+e5joqU8PniucG9Qv6/
         ZvPzjBYhLYuGOEBg0GxWiiQCSNISgY+o3xXtRYTnPJdTsLMsw84NeMQeRH4SLhGB6+ty
         VjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=n7qz4yto1ktZFNeUhXN4QwZ2RPkWwBLjwxLu+TNsHm8=;
        b=dVU14wcOh49puuv9BuVS57rFA/g6YQsiGQ2mFPSfYekvzUGbXyvJCweHRn/CUZm+9c
         qbCHi644sCNJT/hwCtuFK3AanN+nX8PcKbu4qGaaa04WM/BvxiF5nLtNgJpg90Ln4HQH
         JKZO1UguojC5CJXWut0T/7LA7Dn48BNr0yrq0YFjoOazmqvMm+DmNMLi2C7IewgWTbuP
         a8QRk4BpSdeX/PYNZQlz6GFjl86Kmcz15AqkNsazd801J18qMZwEJQqc2DcdBsdMdFUv
         q3ltWGkybC3SGXrORwPoCmefKo+H/1+8j/72UsXaRN0PrfKGfFJ0dlvrcgBrmJ1xgHCL
         PIjw==
X-Gm-Message-State: ACgBeo2KsRsSLFPmKiZQ9GNHd/Dn59FlqUhUqV+lrDihi8sEO+ZfuTSN
        CRDmWgwfh9Z/U8NvrGPzX2w=
X-Google-Smtp-Source: AA6agR4YO1de6C8oV19LEjufWPZJpJDTIQ6mn6LIU7ZfFUAlbvbutaC8aTb3smYe8GAjYZyHb1cfrQ==
X-Received: by 2002:a63:e410:0:b0:422:45b3:837 with SMTP id a16-20020a63e410000000b0042245b30837mr7718283pgi.175.1660459468362;
        Sat, 13 Aug 2022 23:44:28 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id o27-20020aa7979b000000b0052d481032a7sm4593778pfp.26.2022.08.13.23.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 23:44:28 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        khalid@gonehiking.org, willy@infradead.org, hare@suse.com
Cc:     anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        91tuocao@gmail.com
Subject: [PATCH 3/9] scsi: a2091: move spin_lock_irqsave to spin_lock in interrupt handler
Date:   Sun, 14 Aug 2022 14:43:31 +0800
Message-Id: <20220814064337.32621-4-91tuocao@gmail.com>
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
 drivers/scsi/a2091.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/a2091.c b/drivers/scsi/a2091.c
index 74312400468b..0a79ba0b20f7 100644
--- a/drivers/scsi/a2091.c
+++ b/drivers/scsi/a2091.c
@@ -34,14 +34,13 @@ static irqreturn_t a2091_intr(int irq, void *data)
 	struct Scsi_Host *instance = data;
 	struct a2091_hostdata *hdata = shost_priv(instance);
 	unsigned int status = hdata->regs->ISTR;
-	unsigned long flags;
 
 	if (!(status & (ISTR_INT_F | ISTR_INT_P)) || !(status & ISTR_INTS))
 		return IRQ_NONE;
 
-	spin_lock_irqsave(instance->host_lock, flags);
+	spin_lock(instance->host_lock);
 	wd33c93_intr(instance);
-	spin_unlock_irqrestore(instance->host_lock, flags);
+	spin_unlock(instance->host_lock);
 	return IRQ_HANDLED;
 }
 
-- 
2.17.1

