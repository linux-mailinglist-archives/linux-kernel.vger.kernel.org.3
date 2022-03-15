Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602754DA3C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351597AbiCOUMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239744AbiCOUML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 546CC5677B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647375057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gzuNLYDsbc4LQ+eCCeLM8v+rRX11qjhaA0tgT5aZNJM=;
        b=EJOLkyW7icR8jwWy649bPGCzJ4FbXT8OATL2xVvjh38VNwotNkNNGdyL35EIFwJZg+auUk
        9kASOvyxPc8QYgu3raEZ8JY1jpZ4o7R37seKgyq/oasvKQ5O5HDs6dbNotuoOumm6qOigw
        3XEle8wtQUhqP2BsaX2QSnt9DH7sO64=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-PgLVNBV0MSGnPeLqvvLEjQ-1; Tue, 15 Mar 2022 16:09:43 -0400
X-MC-Unique: PgLVNBV0MSGnPeLqvvLEjQ-1
Received: by mail-qt1-f198.google.com with SMTP id k11-20020ac8604b000000b002e1a4109edeso104153qtm.15
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzuNLYDsbc4LQ+eCCeLM8v+rRX11qjhaA0tgT5aZNJM=;
        b=oWCLtsAXw0L9vHixuTp8u2EPPu4rVp7oI4EieP/Jj+0UPDqtISulWaBJbvgUYSYwvW
         L3n1pS7x2ocgNNste2whBJRgkHbvHirPE9QeEwL7+h/wWlI9MwrTQzsMj+FoiCnvxtXZ
         TeJrah0tVDmPKSqJjr6y7fP+lI4KUsSO5far92GmGeY5VmBjcceGMc8vXL+4875GTWQL
         j4iVWStedTAa/hpiyLumDMD2UPhFB5RllX8XguyNK2z8M/j/6Rcvm7xt/0D/kJlQvMtR
         Z05V4EZMKIZQ4YGZW/Fg+/uzG2NKZ59bnM8DaAdZjJEyXSCz4D3vfpXlOAoj5/Tx+/yI
         86Yg==
X-Gm-Message-State: AOAM532V4GcRQauZPqgAVXlfRVLGjvZkn1T37WWLFx4nJDMxLrzK2i9c
        uWlILOKK1EqXtq5NAF043vybpSNwgmPkTjkeTgr2Xv/6pWgEKsC5mL3BfDwKiAWlYVf7iM/rJFT
        KzZnKjEv5nbvK/A3XzRSESJ/5K2jsKATAacp0P0SgYmQ19hdI7NqGR2MsWFBfapjzgzatCEW5pn
        Lu
X-Received: by 2002:a05:6214:2021:b0:435:c2f0:817c with SMTP id 1-20020a056214202100b00435c2f0817cmr22526842qvf.1.1647374982712;
        Tue, 15 Mar 2022 13:09:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQGJ2hEhXw4BbiMPJAtVDm4Wh2ugdd8oUEZ2eae1W1C3kjSaJzxn/pmqNT6dQ+bbCeD+X7BA==
X-Received: by 2002:a05:6214:2021:b0:435:c2f0:817c with SMTP id 1-20020a056214202100b00435c2f0817cmr22526815qvf.1.1647374982483;
        Tue, 15 Mar 2022 13:09:42 -0700 (PDT)
Received: from fedora.hitronhub.home (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id 197-20020a3703ce000000b0067af869ffa6sm9582433qkd.127.2022.03.15.13.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 13:09:42 -0700 (PDT)
From:   Adrien Thierry <athierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Adrien Thierry <athierry@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gaston Gonzalez <gascoar@gmail.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH 1/2] dt-bindings: soc: bcm: bcm2835-vchiq: Add support for bcm2711
Date:   Tue, 15 Mar 2022 16:09:28 -0400
Message-Id: <20220315200929.74952-2-athierry@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315200929.74952-1-athierry@redhat.com>
References: <20220315200929.74952-1-athierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatible string for BCM2711. This is the chip used on the
Raspberry Pi 4.

Signed-off-by: Adrien Thierry <athierry@redhat.com>
---
 .../devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
index e04439b3355b..599bd283df1b 100644
--- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
@@ -27,6 +27,12 @@ properties:
               - brcm,bcm2836-vchiq
           - const: brcm,bcm2835-vchiq
 
+      - description: BCM2711 based boards
+        items:
+          - enum:
+              - brcm,bcm2711-vchiq
+          - const: brcm,bcm2711-vchiq
+
   reg:
     description: Physical base address and length of the doorbell register pair
     minItems: 1
-- 
2.35.1

