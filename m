Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292F9501AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344398AbiDNSUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344410AbiDNSUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:20:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0C9CE38BC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649960266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AzQ4QAAj2VuNQ/FqRmCllZ6Sxm9XylzBtMDsyAckXBk=;
        b=BgfOIJSbbqZV5JTIblxid1FB2L1Lr1bseOcJIHRwckO2XvM5UXLe5dUDirCcW3zPhFrWnp
        LFQY8pTkHLYYlH/+X3QoHvhYrYupTgHuPrs7kBjqyCZLGcGrMVGOD1nylG8UxUo6h6QoTn
        SBhHM7saQoUBn7iEQcz2yZSIBVnViHE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-zZ6hOq0sNtyKy_hhpp3yRw-1; Thu, 14 Apr 2022 14:17:44 -0400
X-MC-Unique: zZ6hOq0sNtyKy_hhpp3yRw-1
Received: by mail-qv1-f71.google.com with SMTP id kj4-20020a056214528400b0044399a9bb4cso5001560qvb.15
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AzQ4QAAj2VuNQ/FqRmCllZ6Sxm9XylzBtMDsyAckXBk=;
        b=RukPu96MIq/6SzUVeQCSYKqpb/U5B58lDUp1ByKdCrrBMWyyjvL7GqSLf3UoB75Dll
         D6GngcTGLARz3KT+5WEWOBJbPrj+/nIWf5lLsTTFY161l37lQ1udptcCI4SvCVsPjWIx
         ilCjCgoBlbu3px7u8tGEhlU7DTD11giP5UFuK+zyN0cATUcOvCOwiXbaSZcXwXsbwhuM
         QxSAbNSOReoHCAVn8Ms2XnNlAQ13Uy6NkJ8YBsnBs3ovF1kgmFjpCLdsf2YEsWWW3xI1
         KOV4tcLqwKPIbX6XhXFh6oStJ3RgpVBieYw1BheI23CfAoAIKQW6c7FHZynLbsIBn5H6
         YBqQ==
X-Gm-Message-State: AOAM530/TufKctzR37kG8CTHfmD5Tu3rg51hOQxLvIIwkGBhSFscKPfI
        5d7uiFHJTgaKKFdOsb/sKaCQzOBY/RvFUs/0gBj7PDTn5Pfoq1UiG+7F7PY9i1w48nxx8orSuLq
        4cFKn1O7o7fBNaUUQzBIyTYaQ
X-Received: by 2002:a05:622a:64f:b0:2e0:6a11:7b0d with SMTP id a15-20020a05622a064f00b002e06a117b0dmr2834095qtb.9.1649960264458;
        Thu, 14 Apr 2022 11:17:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQCBsCYIW9qTWEVzr2uXIjuRmjRtRNtV7/hcrHwq+Oi87WABK0If4z9cRP097Vex5PiCYcFA==
X-Received: by 2002:a05:622a:64f:b0:2e0:6a11:7b0d with SMTP id a15-20020a05622a064f00b002e06a117b0dmr2834072qtb.9.1649960264251;
        Thu, 14 Apr 2022 11:17:44 -0700 (PDT)
Received: from fedora.redhat.com (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id h5-20020ac85845000000b002edfd4b0503sm1701816qth.88.2022.04.14.11.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 11:17:44 -0700 (PDT)
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
Subject: [PATCH v2 4/5] staging: bcm2835-audio: fix mutex definition without comment
Date:   Thu, 14 Apr 2022 14:16:21 -0400
Message-Id: <20220414181622.102049-5-athierry@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414181622.102049-1-athierry@redhat.com>
References: <20220414181622.102049-1-athierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix issue reported by checkpatch:

CHECK: struct mutex definition without comment
FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c:14:

Signed-off-by: Adrien Thierry <athierry@redhat.com>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index d567a2e3f70c..e429b33b4d39 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -11,7 +11,7 @@ struct bcm2835_audio_instance {
 	struct device *dev;
 	unsigned int service_handle;
 	struct completion msg_avail_comp;
-	struct mutex vchi_mutex;
+	struct mutex vchi_mutex; /* Serialize vchiq access */
 	struct bcm2835_alsa_stream *alsa_stream;
 	int result;
 	unsigned int max_packet;
-- 
2.35.1

