Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C5F501AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344406AbiDNSUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344390AbiDNSUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:20:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40501E3393
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649960261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kxJOB8TLKClBreQifns7iXdSNc4svJwozv5ZA8+0Dto=;
        b=FtWNJzIzY+KaheBXAwGZXbf+d/b3g7PGN/Fl0xZG5QsTSY7COm1GKasLorJbHSmnTq1I4y
        rSr+2vR2rTnp/iXYrGTOmLtpIoarenlC9G3VkTxbj0psoGY0Y7jjn6sW7haMPA89YcLrYy
        LtMUWyuzyHIpI+39lmDRf1rMOQUzyMA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-CoOzWP0sOJW81M-5UXesHA-1; Thu, 14 Apr 2022 14:17:40 -0400
X-MC-Unique: CoOzWP0sOJW81M-5UXesHA-1
Received: by mail-qt1-f197.google.com with SMTP id e5-20020ac85985000000b002e217abd72fso3733662qte.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kxJOB8TLKClBreQifns7iXdSNc4svJwozv5ZA8+0Dto=;
        b=UtQ89zJynlE/K0R2Kik14TcXxH1sqFrcjizFBkoX872h9sH/nT12LkiZLTQWt4XwfW
         wKSAAD7UWBkrfMw+GrF4E2j7HxjpfjzAy4QbtfroIT+7QwX3wLu+UNsFFukJi7CT8Ol2
         ywuNkU2WOGC6A+2JqSTJyEdqxdCnx1mgv2cHDH3OYZVrQN1sLh4h3PeD9nzyIGRCNVbO
         0yUQRIASwoRlKrOpRPIJGB4D/j+TM7T4fYj5v9q75SjS8rRrtAl23tHJ1jIB1YC8k4vF
         YWBRbr14rKjm/zGeUELge6/eZtJcR6JEBZVFmktWItID9PqOJxP/fZN9hHlmQG+eQiGK
         wxIQ==
X-Gm-Message-State: AOAM532Ag9Ohpa8IlbxNJKBs6Sl8Q2T22xqkrM5SEmBLTV+HZHuhrVQV
        28aECP+x5hitOam8NO11UdzAalpHzhr4jwRE9EqEa3DAmgRszaDKRu165uH8Az+dnU/QOaKyGU+
        ExxBWFFbBwgajkszZdluySqyA
X-Received: by 2002:a05:622a:1386:b0:2e1:e812:f4c with SMTP id o6-20020a05622a138600b002e1e8120f4cmr2717495qtk.653.1649960259675;
        Thu, 14 Apr 2022 11:17:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKJ6fUk2dQLqhc/W+maJVV1WH54z+1gN66BkwtgvBzcQ1RBqSQotzU8pjT5mVlR0KXtdPZWg==
X-Received: by 2002:a05:622a:1386:b0:2e1:e812:f4c with SMTP id o6-20020a05622a138600b002e1e8120f4cmr2717478qtk.653.1649960259476;
        Thu, 14 Apr 2022 11:17:39 -0700 (PDT)
Received: from fedora.redhat.com (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id h5-20020ac85845000000b002edfd4b0503sm1701816qth.88.2022.04.14.11.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 11:17:39 -0700 (PDT)
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
Subject: [PATCH v2 1/5] staging: bcm2835-audio: fully describe config symbol
Date:   Thu, 14 Apr 2022 14:16:18 -0400
Message-Id: <20220414181622.102049-2-athierry@redhat.com>
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

Explain SND_BCM2835 config option in more detail to fix checkpatch
warning:

WARNING: please write a help paragraph that fully describes the config
symbol
FILE: drivers/staging/vc04_services/bcm2835-audio/Kconfig:2

Signed-off-by: Adrien Thierry <athierry@redhat.com>
---
 drivers/staging/vc04_services/bcm2835-audio/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/Kconfig b/drivers/staging/vc04_services/bcm2835-audio/Kconfig
index d32ea348e846..307f2d6a9599 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/Kconfig
+++ b/drivers/staging/vc04_services/bcm2835-audio/Kconfig
@@ -5,5 +5,7 @@ config SND_BCM2835
 	select SND_PCM
 	select BCM2835_VCHIQ
 	help
-	  Say Y or M if you want to support BCM2835 built in audio
-
+	  Say Y or M if you want to support BCM2835 built in audio.
+	  This driver handles both 3.5mm and HDMI audio, by leveraging
+	  the VCHIQ messaging interface between the kernel and the firmware
+	  running on VideoCore.
\ No newline at end of file
-- 
2.35.1

