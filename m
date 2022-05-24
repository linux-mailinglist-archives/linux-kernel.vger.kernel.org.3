Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B7E53305A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbiEXSWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiEXSWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:22:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13608A303
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:22:51 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b5so9501486plx.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQ+IbxSoOWzvPpARlGDJuulp1WoAC1KNhcEUFQJVWLw=;
        b=YjX69PtOZfBAOveJE2bEYXqX+lWjUI0Kve/NDLqWuJsbYa9sTtwXg7YmPazee+niuT
         DW/VnXFP7ghPET8wm9rpnVi65J1KKjmpS9fWCO1txRyaVipScC494vSLj3km98F8+4RQ
         rsMiM4eaRCEWfEpoUoFPOjI+04QW1UXV1ggAhdaE0B9ONGHQbEe2/cNItxChTymcoH/M
         WnC8PRpqnMnbI+rjdvefwXoxgHJ40snKdlcF1u4Lf+WC+5UUzH9/PpupmhMvLC3dHP4g
         T7b7/g6IvIRZenL49Obh2mL5fP5fQZQZ09p0GDlvEZ6HsVUhRjV7KnPQxf6S6b1iFdIp
         u9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQ+IbxSoOWzvPpARlGDJuulp1WoAC1KNhcEUFQJVWLw=;
        b=QouDqZ+r1GEnWl6Ii1XWK8ydX7KLkZFFlXB1sNVdL19JfHP2VvqQ97IiJYwLVEbghk
         jM2qPVtI2GLgo9XLXfSeQXfHYq++AjEe1yXdKhjooOXyGW/aTbZOYXDfLnC/0IAelsLf
         iHzO/XjeaOc8kPL7vxUUp01g6ths4UZwy3sB83CJ80xuY1x8j6VDnXsiiBIYGGOBoDDM
         KEwlDgUT8RIgxc6+e0HK82rMKbiwjZUDaXm/sBJ9Q9MxqpUeBdbPlRSUGJkcmRrhr3O5
         lBSaQS1C7aiEiWDr6jQc51ZFIOycmDhuLl+3QWKUfAMVZp5dHgGpA1cPCYLTUVWryYOE
         BVhg==
X-Gm-Message-State: AOAM531jwubfnMSisRlZOXuv2GWEWme43bY/FudGijKf5jGclid/DBdJ
        CiImq8u08YvNl+VfIZrlRew=
X-Google-Smtp-Source: ABdhPJw0pevw6L+J31pXA4AxzQC3sqeoJYUUppDxbwh0wnw4ck8awuR3dLEj2ejuHKgnYOaW5JOO5A==
X-Received: by 2002:a17:90a:b017:b0:1df:6f31:c273 with SMTP id x23-20020a17090ab01700b001df6f31c273mr5831197pjq.167.1653416571356;
        Tue, 24 May 2022 11:22:51 -0700 (PDT)
Received: from ubuntu.localdomain ([103.230.148.185])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b0015e8d4eb2b8sm7595714plh.258.2022.05.24.11.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 11:22:51 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     akpm@linux-foundation.org, shakeelb@google.com,
        vasily.averin@linux.dev, mhocko@suse.com, manfred@colorfullife.com
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH] ipc: Remove dead code in perform_atomic_semop()
Date:   Tue, 24 May 2022 11:22:44 -0700
Message-Id: <20220524182244.42987-1-gautammenghani201@gmail.com>
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

Remove the line which is dead code. Fixes the clang scan warning:
warning: Value stored to 'result' is never read [deadcode.DeadStores]
                result = curr->semval;

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 ipc/sem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index 0dbdb98fdf2d..156824bcda47 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -766,7 +766,6 @@ static int perform_atomic_semop(struct sem_array *sma, struct sem_queue *q)
 	for (sop = sops; sop < sops + nsops; sop++) {
 		curr = &sma->sems[sop->sem_num];
 		sem_op = sop->sem_op;
-		result = curr->semval;
 
 		if (sop->sem_flg & SEM_UNDO) {
 			int undo = un->semadj[sop->sem_num] - sem_op;
-- 
2.25.1

