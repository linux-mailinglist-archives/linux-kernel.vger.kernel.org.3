Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA381564117
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 17:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiGBPjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 11:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiGBPjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 11:39:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55205DECE
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 08:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656776355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W8c1SlBUxYM10s99ei02CiGdLvmIh2XzeBEOuTV4Qx0=;
        b=hbhtL05wyru6slnFu1bov3q5TuTegd420prjIM/5Sofp9Vsa/H+r0lw7HRtntbmvf734dT
        faM+ZdHUfUHCGDd9J9i5r2h1cQuPc/JRbOJO02ACGGnF/+MMRqMaEqHkqI0RMpqetaAsHc
        GwzWh3W5hZPgVlTvJNWPvT69eneEoVc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-S68NykaLMdqItGpYlPvlxg-1; Sat, 02 Jul 2022 11:39:14 -0400
X-MC-Unique: S68NykaLMdqItGpYlPvlxg-1
Received: by mail-qk1-f200.google.com with SMTP id q184-20020a378ec1000000b006b14460be35so4628796qkd.22
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 08:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W8c1SlBUxYM10s99ei02CiGdLvmIh2XzeBEOuTV4Qx0=;
        b=mDbjIAHEv4IePKr5Dqy2tp9Lpk4fs6++QeybcaKyNLUyOyk4JV7oi8GRCc5puc3Bke
         lCXlwxktzJnz49BJi0eWyHoPxtNsDEqPRrc8fZxLDIp9XJIL4hMf3LvFpdpc9fSheHom
         GytEGnyP20BlBbaCcvoMNjpd3YDMQPzIlCrk10mLEMg9bedNWHoQl83gdk1IhjiaCSZx
         t16cFrKqjBzQDNUpyv0Pkh/PMNn7cS7CQlcAnQEm8j8G+grLvVMK4+RJMufyRtQNB3bH
         YG56StiFP/V4m+L7DCm4B6K1pgekTOIkQ503WXqutSDVP+EqbLbgmQOFIh4U5SOPu5lR
         QrAg==
X-Gm-Message-State: AJIora88Qt5Mwasu9diWWTcLlLuSUEW5lwHINeK86oCxQ9M3Hu9UwUPn
        Hgg/z9ogdSTmc3rzFz/dORWj1G6FGP5lZ05lWwJalEkC4PKkFxd42J7wHtRH9bPUxcrZSz7j07Y
        KKE+6X/x2oBlSJSEzbDw0PODj
X-Received: by 2002:a37:4549:0:b0:69f:556c:4e38 with SMTP id s70-20020a374549000000b0069f556c4e38mr13936449qka.202.1656776353549;
        Sat, 02 Jul 2022 08:39:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s4kMDCJkO3l6rc/tzkcDONaBzbN/O5Ul2p3pH701RTsQYUDroNVnzGAdCYv5GPNqp46q1+Vw==
X-Received: by 2002:a37:4549:0:b0:69f:556c:4e38 with SMTP id s70-20020a374549000000b0069f556c4e38mr13936437qka.202.1656776353290;
        Sat, 02 Jul 2022 08:39:13 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x9-20020a05620a448900b006a708baa069sm14569688qkp.101.2022.07.02.08.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 08:39:12 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau/bios: set info only when the return is not 0
Date:   Sat,  2 Jul 2022 11:39:04 -0400
Message-Id: <20220702153904.1696595-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang static analysis reports
drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c:68:17: warning: The right operand of '*' is a garbage value [core.UndefinedBinaryOperatorResult]
        switch (!!data * *ver) {
                       ^ ~~~~
A switch statement with only a default should be reduced to an if.

If nvbios_pmuEp() returns 0, via the data variable, the output info parameter
is not used.  So set info only when data is not 0.

The struct nvbios_pmuE only has the type and data elements.  Since both of these
are explicitly set, memset is not needed.  So remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c
index b4a308f3cf7b..49e2664a734c 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c
@@ -64,12 +64,9 @@ nvbios_pmuEp(struct nvkm_bios *bios, int idx, u8 *ver, u8 *hdr,
 	     struct nvbios_pmuE *info)
 {
 	u32 data = nvbios_pmuEe(bios, idx, ver, hdr);
-	memset(info, 0x00, sizeof(*info));
-	switch (!!data * *ver) {
-	default:
+	if (data) {
 		info->type = nvbios_rd08(bios, data + 0x00);
 		info->data = nvbios_rd32(bios, data + 0x02);
-		break;
 	}
 	return data;
 }
-- 
2.27.0

