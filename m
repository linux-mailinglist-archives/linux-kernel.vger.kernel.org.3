Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE579514498
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355930AbiD2Iqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355901AbiD2Iqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4F9517E16
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651221790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LCV3P6hCzkrdCIrNXXA9bD+9VmWpW20bTzgfHeQMSC8=;
        b=BcbqRfxldAHb+EN6kxuAmPKGFolmFzYPC6sKuWFjulh5WhzZVQ4hqL4IaE0Rxn1aSov/sL
        PktNvXwV6ZrrM6nxgjd/5ZwgbF5zQiabAp1d9cktBK1e3CrkV/PPplhuzMMAGSbIlT1Z6X
        pCxymv2VwBcD/7+EXGkSrl08h6yhtho=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-hh6H30vuNQ2GcC7ouL_ctw-1; Fri, 29 Apr 2022 04:43:09 -0400
X-MC-Unique: hh6H30vuNQ2GcC7ouL_ctw-1
Received: by mail-wr1-f72.google.com with SMTP id s8-20020adf9788000000b0020adb01dc25so2800232wrb.20
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LCV3P6hCzkrdCIrNXXA9bD+9VmWpW20bTzgfHeQMSC8=;
        b=bgvRcJacABSaoyM2Gx8ztcfBazfGtX8B/af1BCfXQkkxgSLLSfa/y+Oc0gj0L90QWu
         AA2SP6Xz0ONoMdWF8oPD14XJP1s/W6YTfa+oAH0jLmqLmkU1QmmdZEMhoSokFKbaTn/v
         NqxCzH+ByY6gQ4gBMjF2BByKwGSlD6mOWsjxM2BjX4xAO/lm0rkCLviaVjs0wFeCUpjX
         D+Pbvw39k65RoyALta0U2sPTVRnQ2pDfRfnc2byOwIdb1kEoWX53YRUddgpcqPCBLfJk
         IQGv0CXHQ7GNqtspoxelde3rioV4C1X7BJ3/AmBy8yZqwq3Zi7cqc5FoC3G8xv/NXtcy
         MRXA==
X-Gm-Message-State: AOAM532EZkuAad48qHgUwPns+qujjbr1Ysavp0+yYpXchGna1Zp6oXto
        NddVa3Ys7eoIeTBVOb3PDqGbR3yEDNKOpx3Xex/HuWqmaMu2XlLN7dC1ln5B8iQ9pd2ZLkOTR5O
        D3YLzfQ7aun0j61NGn6+ztaFZdPBacO/gIJ+BnquFA+v43p8T/Jg4htvS4bbx5EE96YS1xtJA3U
        Q=
X-Received: by 2002:adf:d213:0:b0:20a:d703:154f with SMTP id j19-20020adfd213000000b0020ad703154fmr23745189wrh.604.1651221788155;
        Fri, 29 Apr 2022 01:43:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOOGOyZ1kriuI0rWlYEm4in0LjrxkZkAvL2COz8NgHTz+Sazyk8MTmZDUo3yafUN3PdSzrKA==
X-Received: by 2002:adf:d213:0:b0:20a:d703:154f with SMTP id j19-20020adfd213000000b0020ad703154fmr23745165wrh.604.1651221787882;
        Fri, 29 Apr 2022 01:43:07 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b00393f1393abfsm7199256wmq.41.2022.04.29.01.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 01:43:07 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [RFC PATCH v4 01/11] drm: Add a capability flag for simple framebuffer drivers
Date:   Fri, 29 Apr 2022 10:42:43 +0200
Message-Id: <20220429084253.1085911-2-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429084253.1085911-1-javierm@redhat.com>
References: <20220429084253.1085911-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRIVER_FIRMWARE flag denotes that a DRM driver uses a framebuffer
that was initialized and provided by the system firmware for scanout.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 include/drm/drm_drv.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index f6159acb8856..abab51705e36 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -94,6 +94,12 @@ enum drm_driver_feature {
 	 * synchronization of command submission.
 	 */
 	DRIVER_SYNCOBJ_TIMELINE         = BIT(6),
+	/**
+	 * @DRIVER_FIRMWARE:
+	 *
+	 * Denote a driver using a system framebuffer provided by the firmware.
+	 */
+	DRIVER_FIRMWARE                 = BIT(7),
 
 	/* IMPORTANT: Below are all the legacy flags, add new ones above. */
 
-- 
2.35.1

