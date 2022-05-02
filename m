Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC7B51768D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386899AbiEBSec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386896AbiEBSeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:34:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7F326160
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651516253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2jB/3zr/hOAAqCnoexjZJZZ3VWJxDNXF2l2/CCgwTtU=;
        b=NP9UcBOHUelFC7R+NAfmfV5eejjwMv1iJgSk6FNPuq70IqkJLF4ayv75ER+ijxEwQ5W/li
        usmfNsNCf4isrJ3YhzmQ7Iw8W8l0lMZ6p/dcI28/HFRR2ECkU40SyWTNaBR7AN9VHSgeBF
        r/ylh7VIk8LBnFm+L1cvi9oTRwsqS88=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-tUPB_VM9Mr2sRok-O7lYKQ-1; Mon, 02 May 2022 14:30:52 -0400
X-MC-Unique: tUPB_VM9Mr2sRok-O7lYKQ-1
Received: by mail-qv1-f72.google.com with SMTP id p3-20020a05621421e300b004562c4a6b08so11660755qvj.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 11:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2jB/3zr/hOAAqCnoexjZJZZ3VWJxDNXF2l2/CCgwTtU=;
        b=IqLN+POMqmZX3Qwvo7MAVrWDw0OlcYm0lBfdI92VSL+sX7PC7BD5YsmTOdy1Rb/Tek
         nwQ0awsb62fvH7i6UGzcCl0h/EWrjYT4t51MpLRO7CDlGpVuEhvKPJH04+frciaNFTMm
         gqZYfOOcnUbdh+JTZH90fhYT7VhLEMtR57+PjC+0Vo96J6mS/7IBemNmU9CXHPPtP/j5
         O7a+Ot7fP47XeELgd0iuIB2pWx40NzM1y0E112FR88k4TtqhisebSTklXiS44nkrqJew
         wzzh6FNTN+jkggGilIkLVEQ6t7YRnejhH7OW5iMV+9QTVfhJa6KL6yPNG+z6m5d9yFwT
         GErg==
X-Gm-Message-State: AOAM533F56334rNvNElykn+7cclIqd7aF3vpeHg92ZtomS27XmweCo77
        BHpf2+zHQcG9AQ99ajKx1cDjAY5OqZ/l3D4yr1OdZmT0VnokbXnLbeK9DwpmmnFMbUWZkPJfgAy
        V1X5R9cxiKiWVjBdjuDvIvPJn
X-Received: by 2002:a05:620a:1902:b0:5f1:8f5d:b0f2 with SMTP id bj2-20020a05620a190200b005f18f5db0f2mr9595652qkb.60.1651516252190;
        Mon, 02 May 2022 11:30:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3CJBU92TjpturzqseBQ/Q0w/mIcCijpWAzznSsZQjXuIVQUluXrP1ZKrWbC/jmzJriC7Z4w==
X-Received: by 2002:a05:620a:1902:b0:5f1:8f5d:b0f2 with SMTP id bj2-20020a05620a190200b005f18f5db0f2mr9595627qkb.60.1651516251874;
        Mon, 02 May 2022 11:30:51 -0700 (PDT)
Received: from fedora.hitronhub.home (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id h12-20020ac846cc000000b002f39b99f68esm4412204qto.40.2022.05.02.11.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 11:30:51 -0700 (PDT)
From:   Adrien Thierry <athierry@redhat.com>
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Adrien Thierry <athierry@redhat.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: vchiq_arm: add reference to vchiq device in vchiq_state
Date:   Mon,  2 May 2022 14:30:40 -0400
Message-Id: <20220502183045.206519-2-athierry@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502183045.206519-1-athierry@redhat.com>
References: <20220502183045.206519-1-athierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a reference to the vchiq device in the vchiq_state structure. This
allows the device structure to be passed around, which will be useful in
order to get rid of the global g_dev structure.

Signed-off-by: Adrien Thierry <athierry@redhat.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c    | 4 +++-
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h    | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 0596ac61e286..e6e0737c85fc 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -519,7 +519,7 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 	*(char **)&g_fragments_base[i * g_fragments_size] = NULL;
 	sema_init(&g_free_fragments_sema, MAX_FRAGMENTS);
 
-	err = vchiq_init_state(state, vchiq_slot_zero);
+	err = vchiq_init_state(state, vchiq_slot_zero, dev);
 	if (err)
 		return err;
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 8f99272dbd6f..0d5c39d7c6e2 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2142,7 +2142,7 @@ vchiq_init_slots(void *mem_base, int mem_size)
 }
 
 int
-vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero)
+vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, struct device *dev)
 {
 	struct vchiq_shared_state *local;
 	struct vchiq_shared_state *remote;
@@ -2169,6 +2169,8 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero)
 
 	memset(state, 0, sizeof(struct vchiq_state));
 
+	state->dev = dev;
+
 	/*
 	 * initialize shared state pointers
 	 */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 82b7bd7b54b2..352017ff5309 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -315,6 +315,7 @@ struct vchiq_slot_zero {
 };
 
 struct vchiq_state {
+	struct device *dev;
 	int id;
 	int initialised;
 	enum vchiq_connstate conn_state;
@@ -458,7 +459,7 @@ extern struct vchiq_slot_zero *
 vchiq_init_slots(void *mem_base, int mem_size);
 
 extern int
-vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero);
+vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, struct device *dev);
 
 extern enum vchiq_status
 vchiq_connect_internal(struct vchiq_state *state, struct vchiq_instance *instance);
-- 
2.35.1

