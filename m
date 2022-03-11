Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226E14D6400
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349458AbiCKOpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350334AbiCKOoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:44:34 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33550142361
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:43:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j26so13309535wrb.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=boKU/a4CJ2ryMq3B7IEVcU17hRGdK89wnwI0kITSIaA=;
        b=arspGenadkzN9DuF1gN5kaWrpN55uLvOiAnuidC0K8+XtXsS1Lyl4+SgL2eNTT+1mh
         LQdjR3PLji0YYvGFT9OGpYrWGYj9mJngin+gXHgChskdl3W/d1oKKd78fINbWQOIYPVy
         Svs37AondZ6JZzMc8WmWte6gBwx88/ytMU/xyfLr9TQmeZVo4g0kcvoK97ge4Nj4rKLg
         d4thwkWknCmU5ou2vWkGl+ZVoSLY+NYCGfHmp/ThfHhfxcBFMCYlOeMMKSQwLArgacG3
         mU+QIewkRCCuyFcsX0GUPyeknO71xi82txCfQRZR9WJGUzT+5mB+LUIICCmYAcrKX1bR
         qrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=boKU/a4CJ2ryMq3B7IEVcU17hRGdK89wnwI0kITSIaA=;
        b=kop10Kju+beNWxupPaXIR/2SxvCMXvmD2DFILTrj9P3lL02x8JS1X050u0GhBa3fYY
         rEyB5ZAekgkmRWtujHH46YzjsYpTr2tzfdhNQXlUDJG1mn4NLwxm9UdnsNFtzYnXfwqO
         MTfKofCoQo4/Z8jzrehKJQITwGjHZc48s6DVifS73nesrLZV2DeDXoF2LColmO+cQ70E
         OzLkQ9lbPocXe2vFVNhBqawPcY5UBIOwk5A+apfSstzQPDSICqJ3nbkeRicPuSeLOboF
         S9WOd31k9EW+rIcQEpptNVIzSENNpDj9HBfY8MJkJxqmgR8cDcn2c96YTzvYB/PfpXBr
         smbw==
X-Gm-Message-State: AOAM533Z6v2mDBAaZQ0khs8+ceMp1WjcYC+vr86iVVJk8GOT54d2ykQn
        vQKPAUpIxTsapnb/C1RAMQ==
X-Google-Smtp-Source: ABdhPJzxBYefVPpSW9ZIhR9W52AUI0TfvYH7y08wQOv9Wcfl2Fsh9Wmow8utLDaROxU9SriHaiWqPg==
X-Received: by 2002:adf:d21a:0:b0:1f0:2598:bace with SMTP id j26-20020adfd21a000000b001f02598bacemr7401572wrh.132.1647009806790;
        Fri, 11 Mar 2022 06:43:26 -0800 (PST)
Received: from localhost.localdomain ([46.53.250.95])
        by smtp.gmail.com with ESMTPSA id e20-20020adfa454000000b001f01a14dce8sm6877637wra.97.2022.03.11.06.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 06:43:26 -0800 (PST)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: [PATCH 2/5] x86/alternative: bump MAX_PATCH_LEN
Date:   Fri, 11 Mar 2022 17:43:09 +0300
Message-Id: <20220311144312.88466-2-adobriyan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311144312.88466-1-adobriyan@gmail.com>
References: <20220311144312.88466-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacement instructions are raw data, there is no need to reserve
space for the NUL terminator.

Signed-off-by: Alexey Dobriyan (CloudLinux) <adobriyan@gmail.com>
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 6c9758ee6810..1e6fd814dd08 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -35,7 +35,7 @@ int __read_mostly alternatives_patched;
 
 EXPORT_SYMBOL_GPL(alternatives_patched);
 
-#define MAX_PATCH_LEN (255-1)
+#define MAX_PATCH_LEN 255
 
 static int __initdata_or_module debug_alternative;
 
-- 
2.34.1

