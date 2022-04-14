Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99878501AE4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344490AbiDNSU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344434AbiDNSUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4586AEA377
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649960270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HlSZzKp73Fayw7krLRtWU5sPNWnQq78trEkuE6TU4hM=;
        b=JAVL4NQzXAn0HIfhukVEkTGKao3oBb8d/5eg52Lx1XOOP4jg1NMC2WveamR0ZvN3aMaBkn
        ksG134Q/es8oLc9WlVkd9bCwir+S7OHDf6kWQFcYfrKnkiX4swxmdm+h31E7OMTy3Lcn6L
        2OdYGlxAQaYt1Njd5P3S1jO/5la/B9o=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-Y8FWSJ6ONuWek7LI6kVInA-1; Thu, 14 Apr 2022 14:17:47 -0400
X-MC-Unique: Y8FWSJ6ONuWek7LI6kVInA-1
Received: by mail-qk1-f197.google.com with SMTP id y13-20020a05620a44cd00b0069c35f1ea3eso3847505qkp.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HlSZzKp73Fayw7krLRtWU5sPNWnQq78trEkuE6TU4hM=;
        b=8SAGm7lLFC93+h9/+UT0IuxIV9Bal7i1fRYrH6U/fk50SlDB2i8l3xnZT6SkW1jLn2
         lIDZDBiCXazePfvvct77nT5vpDZyxWyl1csfNJ4Cib+0AirYA2YRRk0TJvoUz+nCSZsO
         bevr6gB5LDL0mZEDsPQbzE3/P2nbO7IDbeeKcLqtA+JbabVq5aQop0QN/XCXqnxNZGEe
         XwSgHhaVcliZ5UIJ52m6xqyM1k1ZIWr19AMqcrM/T9qt4yRJC1OvcABbxnhd+cN1yK+u
         OriQ5ENkwqKcmcdjWW+xI/Mhc39S6zVyD0pkBvmmi9onKsTM+JfRsTfzmh0oeXD64vsy
         n19w==
X-Gm-Message-State: AOAM531nBh4kWIjEAQ2JLnhUPZ156zsRjAyuEs7rMmVO0kXqgck1GJeS
        itaXxpQxGOqiwPUhLA71h1qdw9dvRllnsCWMVhJ9Mi8snVErkGLUp+tjiqOk4meyg3aiAHhin6d
        Frh/Rw4SfA6w4Bdso8UK9Mz+d
X-Received: by 2002:a05:620a:3706:b0:69c:41fc:ae9d with SMTP id de6-20020a05620a370600b0069c41fcae9dmr2884116qkb.307.1649960267100;
        Thu, 14 Apr 2022 11:17:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbDkwZn4LTf/pzuq9ks/ZEKFR/wwVxem3IAa/T4H3Fr2doVaKqBcWNZSrnxRotfDf19d2/4Q==
X-Received: by 2002:a05:620a:3706:b0:69c:41fc:ae9d with SMTP id de6-20020a05620a370600b0069c41fcae9dmr2884105qkb.307.1649960266903;
        Thu, 14 Apr 2022 11:17:46 -0700 (PDT)
Received: from fedora.redhat.com (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id h5-20020ac85845000000b002edfd4b0503sm1701816qth.88.2022.04.14.11.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 11:17:46 -0700 (PDT)
From:   Adrien Thierry <athierry@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <mripard@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrien Thierry <athierry@redhat.com>
Subject: [PATCH v2 5/5] staging: bcm2835-audio: fix mutex definition without comment
Date:   Thu, 14 Apr 2022 14:16:22 -0400
Message-Id: <20220414181622.102049-6-athierry@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414181622.102049-1-athierry@redhat.com>
References: <20220414181622.102049-1-athierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix issue reported by checkpatch:

CHECK: struct mutex definition without comment
FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835.h:64:

Signed-off-by: Adrien Thierry <athierry@redhat.com>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index 51066ac8eea5..38b7451d77b2 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -61,7 +61,7 @@ struct bcm2835_chip {
 
 	unsigned int opened;
 	unsigned int spdif_status;
-	struct mutex audio_mutex;
+	struct mutex audio_mutex; /* Serialize chip data access */
 
 	struct bcm2835_vchi_ctx *vchi_ctx;
 };
-- 
2.35.1

