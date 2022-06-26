Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C3755B284
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 16:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiFZOq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 10:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiFZOq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 10:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18B24DFD8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 07:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656254781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5EXh2xkTs1zBkhfCl8CTHqf9DxClLVCKfcSwd9L8zzg=;
        b=FrJpvHXIW1OTGgisNIeazetbem2rm2qB2+C/sXSDLMmDnxDbQdtSry2Ox1SBD3WlexL7ky
        TAxMasRrSYmdcmnOjaWRU9dNXXKSLikNsHgXuUIT9+pSBqhR+A1/OlVJQU+4KmBLpVF9gE
        pZWLMgODLEtYv4WyNTWisNF85cTBcHc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-DKJpAloiNqylPxl0ZyhtRg-1; Sun, 26 Jun 2022 10:46:20 -0400
X-MC-Unique: DKJpAloiNqylPxl0ZyhtRg-1
Received: by mail-qk1-f199.google.com with SMTP id m15-20020a05620a290f00b006a74cf760b2so7897759qkp.20
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 07:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5EXh2xkTs1zBkhfCl8CTHqf9DxClLVCKfcSwd9L8zzg=;
        b=uO9ev9sryG612iViA2XVCxU3tKPGSjtYG8CDkDtAN3ksiBNhjW+eszR7dfsqVKlshz
         3lcwaMX1RSv7XGk0vf7R7Sux7Vsk+Itl1Ql/WUSt4rlF7F5RH2qrKHjfpgbWBu5OknjK
         Es010jf7reN9JuF38TP5C8R2efFox12USTo/U88FQSTitp6KxdSgN1fD0ffffGM1OuNg
         2OnBXpYSFX5dPis23H/yZ9Jn6X0EUFKFBuGiKcE76DKHeE/gAIfPPwLGHSWk067zckz6
         LhEN5cRUeQAPegkgsEZquLLbR5rC96lOfeezJJraKV3XrceduRPwf902EaLTNJZsVTfW
         78Lg==
X-Gm-Message-State: AJIora+sUL/eGOCeLErFqk+DdRwmyU7qg2CQaX6WTFQqFoHbPZ9Jv7kb
        Q/U/qSJmwJF+2ToTanDm9R7996GFcfWsymxQk1LQaQ3+I15evixK+Lg8AEZxmXxzyW8pbex74/H
        KWjhufKNIGWHVMhugM1BtBqat
X-Received: by 2002:a05:6214:1c49:b0:470:5f70:4ab1 with SMTP id if9-20020a0562141c4900b004705f704ab1mr6041404qvb.13.1656254780312;
        Sun, 26 Jun 2022 07:46:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vwKpbQh1t2Fwl4Ge8LmFUOf/3X70OZcbrAYYkN7/IZ4bcE826TN7H5F8YkD5GlSQNHaim5WA==
X-Received: by 2002:a05:6214:1c49:b0:470:5f70:4ab1 with SMTP id if9-20020a0562141c4900b004705f704ab1mr6041396qvb.13.1656254780138;
        Sun, 26 Jun 2022 07:46:20 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85916000000b00317bcb6ad2csm5343266qty.17.2022.06.26.07.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 07:46:19 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, Qingqing.Zhuo@amd.com, mario.limonciello@amd.com,
        nicholas.kazlauskas@amd.com, aurabindo.pillai@amd.com,
        maira.canal@usp.br
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: change to_dal_irq_source_dnc32() storage class specifier to static
Date:   Sun, 26 Jun 2022 10:46:15 -0400
Message-Id: <20220626144615.2227149-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse reports
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn32/irq_service_dcn32.c:39:20: warning: symbol 'to_dal_irq_source_dcn32' was not declared. Should it be static?

to_dal_irq_source_dnc32() is only referenced in irq_service_dnc32.c, so change its
storage class specifier to static.

Fixes: 0efd4374f6b4 ("drm/amd/display: add dcn32 IRQ changes")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
index 3a213ca2f077..b1012fa1977b 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
@@ -36,7 +36,7 @@
 
 #define DCN_BASE__INST0_SEG2                       0x000034C0
 
-enum dc_irq_source to_dal_irq_source_dcn32(
+static enum dc_irq_source to_dal_irq_source_dcn32(
 		struct irq_service *irq_service,
 		uint32_t src_id,
 		uint32_t ext_id)
-- 
2.27.0

