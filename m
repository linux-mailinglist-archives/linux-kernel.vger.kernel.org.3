Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D11651D7BA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383780AbiEFMc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392035AbiEFMcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:32:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B7D69735;
        Fri,  6 May 2022 05:27:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gh6so14219960ejb.0;
        Fri, 06 May 2022 05:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fe1JHUplZR5IUQaqAYF8p9Q8oDHY3OVbkMey3bjJMO8=;
        b=gWDa64RMBd7N2yJ51Vy6ho5N5Vm++jBsOrEOLmic9/Hqe112IA/Iv/Ncx+Lb8PxJrI
         9xUPJRcb/h7wJMDkFJDbptKeU7JoejFZtRUGndl+4S6ebQ1kUS/vMn/VH9ug6jK9SgPC
         QTaznMtWUmG7vHwNTchIBaMslSH07fInVI2ttzslmzdgYRdnEX5AxUpJnxUCktsGFPQe
         TyBgc/Y0Xcd0d/jjqomD1SfMDEVdl8A+1TLIQyxTI8rXlwN0oPx4f0gQ3UifLKC83A+J
         e9ZgkCVtZscKGI9Ssnlm7EoxxlSscgirpGu9EwnA1Gb4cKr5uGI3UG6UsIEsaO8lODXR
         nMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fe1JHUplZR5IUQaqAYF8p9Q8oDHY3OVbkMey3bjJMO8=;
        b=a8whoqAy5EJkzv0BU4ttNmGgFb34sKo+YOmX4lWX+LsGneM1Lu7JLTs+yxS/RASlbo
         /wHO0XDElBmszNjbyZdd7lerHXHc06gA7h4rn+2OGvXyA1URgKvifhwqtEM7B/kx12pT
         9w4T4uUEJX1Cwpf2wd3ZRJgWJLiSq6Kh/yy3dg+BdSHEaSNYKfDWBLRFRXRG2lIoCv4N
         6Dx0N1TIVwdh/REWSkmnEKQQ/ij3rfwOcg3xoInF5Oci7DrkR3kN9mJxn375qCxhPfDn
         R82JDF4LlSshWQdg7AXZyGfvvPy0bfvMTBW/J7P3hLW6RIXWKUoGRN6LnxQsD50+5Vmk
         MLeQ==
X-Gm-Message-State: AOAM533W8IxnWReu8yCcyjT/J/6NXNHKFeKvmrP0QRDN9V52vOrQM1KG
        jcIOJgE5/GNpMen6QyjIRgE=
X-Google-Smtp-Source: ABdhPJyg2dL+Bc9X3CwXpwBz53viUmGxMyEqZH1EB2Lu2BwxNNEUK43P7fWZq6sDl9EhL1wbdMSn2A==
X-Received: by 2002:a17:907:da6:b0:6f4:c257:750d with SMTP id go38-20020a1709070da600b006f4c257750dmr2728807ejc.669.1651840063228;
        Fri, 06 May 2022 05:27:43 -0700 (PDT)
Received: from luca020400-fedora.lan (93-51-1-159.ip298.fastwebnet.it. [93.51.1.159])
        by smtp.googlemail.com with ESMTPSA id k11-20020a056402048b00b0042617ba6383sm2178829edv.13.2022.05.06.05.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 05:27:42 -0700 (PDT)
From:   Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     Luca Stefani <luca.stefani.ge1@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        acpi4asus-user@lists.sourceforge.net (open list:ASUS NOTEBOOKS AND
        EEEPC ACPI/WMI EXTRAS DRIVERS),
        platform-driver-x86@vger.kernel.org (open list:ASUS NOTEBOOKS AND EEEPC
        ACPI/WMI EXTRAS DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] platform/x86: asus-wmi: Update unknown code message
Date:   Fri,  6 May 2022 14:25:35 +0200
Message-Id: <20220506122536.113566-1-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepend 0x to the actual key code to specify it
is already an hex value

Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 0e7fbed8a50d..35fe9641ba9b 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3114,7 +3114,7 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 
 	if (!sparse_keymap_report_event(asus->inputdev, code,
 					key_value, autorelease))
-		pr_info("Unknown key %x pressed\n", code);
+		pr_info("Unknown key code 0x%x\n", code);
 }
 
 static void asus_wmi_notify(u32 value, void *context)
-- 
2.35.1

