Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07591508ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381285AbiDTRsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243437AbiDTRsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C12C945AF1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650476757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W3NAe+4do7OzwFXlslJ1yxbsun/Vq+K/0OpwWY5c86Y=;
        b=LbMromMblwqh32MhnadJ0rXgb9q6AVDRY/AhinJ12X+qoc/bMDFLCNrG6JBA1LnkON67ku
        L67CB50CZxiHswm+uA1outhgDBlNslIurbHLRrq/WXIsv8+2W4RntzTzcmjWDJ+Av16HLc
        z8IRo5zwR1cfBmQ2C2+laiVj2XhfgWU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-e_KNliv9NKS4afXVA19Y6Q-1; Wed, 20 Apr 2022 13:45:56 -0400
X-MC-Unique: e_KNliv9NKS4afXVA19Y6Q-1
Received: by mail-qv1-f70.google.com with SMTP id ke23-20020a056214301700b0044bba34469eso963834qvb.17
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W3NAe+4do7OzwFXlslJ1yxbsun/Vq+K/0OpwWY5c86Y=;
        b=OcB924CHIDZTmaAogzcKfDVlhRJLaJRYSW0sysTkXww3yPvmFRaJ9jTvh9STsteL54
         SPyQz+E/2fEfrrgJ//eCBAWDakjBEr2ml5fORKIsvKPbQyO1hZ8/HiLMSUjSgY0JjP3i
         243gOTvZb7fugteYyYNquAZKJiNL2RTYt3BqTj9SyLTLK0XKy0WX8iGZpgLT68+00iVM
         2eERak6dimcXLtvYAbp/LdfdadUJ2MepdG39g9vVplDCf2R2qb+QZle0OM/aEU9cWwW8
         xDvMbM4k7jp9vxdGE9TpwHaGt1Mz1wp3O8/CxoHp7T2pmuk0yjGmpR/6ZZ6BgrP8dd0D
         L2IQ==
X-Gm-Message-State: AOAM530lIjL0bG1hYI+LCqQ0naEBwEVJ7VCmf9QkRqz9voza1V0Xdfqw
        laXxTmFtCkVpaDzeTOj2njehuLELLHRJJK87DU4bx27+YrhJTGvlaAfYrG6vRcThpwBhqirClfE
        WpknhNW8obne609ABZmUJYZYI
X-Received: by 2002:a05:6214:5185:b0:443:a821:31fc with SMTP id kl5-20020a056214518500b00443a82131fcmr16587285qvb.129.1650476755311;
        Wed, 20 Apr 2022 10:45:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYAEQ1WmpR2JrVhqp2P3DD9igLq38fXCUMcnoHblogOvHnqs0AXZEApIUEBRvAIyTJ3afR3w==
X-Received: by 2002:a05:6214:5185:b0:443:a821:31fc with SMTP id kl5-20020a056214518500b00443a82131fcmr16587273qvb.129.1650476755110;
        Wed, 20 Apr 2022 10:45:55 -0700 (PDT)
Received: from fedora.redhat.com (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id s15-20020a05620a29cf00b00680ca4b3755sm1867721qkp.119.2022.04.20.10.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 10:45:54 -0700 (PDT)
From:   Adrien Thierry <athierry@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Adrien Thierry <athierry@redhat.com>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] staging: bcm2835-audio: delete TODO
Date:   Wed, 20 Apr 2022 13:44:00 -0400
Message-Id: <20220420174401.305964-1-athierry@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete TODO since all tasks were completed:

1 - fixed here:
https://lore.kernel.org/all/20220408150359.26661-1-athierry@redhat.com/

2 - there are no remaining checkpatch.pl errors or warnings

Signed-off-by: Adrien Thierry <athierry@redhat.com>
---
 drivers/staging/vc04_services/bcm2835-audio/TODO | 10 ----------
 1 file changed, 10 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/bcm2835-audio/TODO

diff --git a/drivers/staging/vc04_services/bcm2835-audio/TODO b/drivers/staging/vc04_services/bcm2835-audio/TODO
deleted file mode 100644
index b85451255db0..000000000000
--- a/drivers/staging/vc04_services/bcm2835-audio/TODO
+++ /dev/null
@@ -1,10 +0,0 @@
-*****************************************************************************
-*                                                                           *
-*                           TODO: BCM2835-AUDIO                             *
-*                                                                           *
-*****************************************************************************
-
-1) Revisit multi-cards options and PCM route mixer control (as per comment
-https://lore.kernel.org/lkml/s5hd0to5598.wl-tiwai@suse.de)
-
-2) Fix the remaining checkpatch.pl errors and warnings.
-- 
2.35.1

