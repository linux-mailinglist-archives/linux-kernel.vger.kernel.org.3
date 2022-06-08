Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A8E543EA0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbiFHV3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbiFHV3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:29:31 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B714833F;
        Wed,  8 Jun 2022 14:29:25 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id i66so29669817oia.11;
        Wed, 08 Jun 2022 14:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1aA75xK9qAQzBCllcUuoOOyNNMGtWcE8UwGkQz93Ka4=;
        b=Tg4iUn7wnvpBYXfPSbIfqDsrMztAR6dttfRp7HkHN+uZvw8azEXrwxXMpKe8cSkFUG
         n/nBJea3+ZtffFDGpRRxJyfAhEnNJt4X2Jrxd2attlzKUJWbbpDZc9ShjEt6/wSZb6nv
         Z9E0QHlMx2MvnE1dAqJS0DPJVPGL0nL5A92YPceBIDofdBaXOBfzEec0pThpgKO1HeDZ
         KDTRXpbPi1C9q0HpTyZke9i5GqAy4NuRgiV3ctU9SwhzWf83uKGluYzVQHUEFiw1UHTQ
         MIMR/ZryBihwc3kMD7OIVbNfFKdXCMR6oS7PXdIsspE24trmJaQKIC9UlmU2iPng2ogJ
         k4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1aA75xK9qAQzBCllcUuoOOyNNMGtWcE8UwGkQz93Ka4=;
        b=qBCtBD6ZouwZ9/vMtxkUa8hGihGBuO2rTir7iw7UEvEsuwiFCVL0YJJHj+GvqI9wlh
         TT8TjKEixJttTcu0fe05lRvGa9C7j7SkdIcnN9IGNc2DGet3VGoVZpIRHvCwvpM7Bk2u
         XuapBziB5yM44Cp6cRj/LZw7fRipwDk6r/dr1SLvIh+Pjt3sydAiKvmv3zN+psjBlfdm
         UoutaZKRiFZrXYJJtOZ/4ZwuFjTUfaB0s8cD+dvLTL/lQwMK6s79NmSE23Ngcky4SCX7
         MxlsB0IRuQguT25qbzjnFjeEK8HORezE0RsKrrN9jSoD8wVFbopfIBkaaraLTuIcgaRd
         CvFw==
X-Gm-Message-State: AOAM533PXjOyBACKQio5q2lzccoKRID5Jq/vqcwVCO33uoEcr3e9a9HF
        HB4PSp1k/wqlajdN8lxjpqo=
X-Google-Smtp-Source: ABdhPJylTlZZg+TGCmsSvzYFYAZyrdwMlNLEtmBGggs6en7gzeze9GeWlPOn6R04052sY/aUbJjlHw==
X-Received: by 2002:a05:6808:2196:b0:32e:e0b0:fe6c with SMTP id be22-20020a056808219600b0032ee0b0fe6cmr1195889oib.55.1654723765169;
        Wed, 08 Jun 2022 14:29:25 -0700 (PDT)
Received: from grumpy-vm.hsd1.tx.comcast.net ([2601:2c3:480:7390:e5f7:48da:3306:a654])
        by smtp.gmail.com with ESMTPSA id g22-20020a9d6c56000000b0060b128b935csm5393971otq.39.2022.06.08.14.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 14:29:24 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, balalic.enver@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     markgross@kernel.org
Subject: [PATCH v3 1/1] Resolve WMI query failures on some devices
Date:   Wed,  8 Jun 2022 16:29:23 -0500
Message-Id: <20220608212923.8585-2-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608212923.8585-1-jorge.lopez2@hp.com>
References: <20220608212923.8585-1-jorge.lopez2@hp.com>
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

WMI queries fail on some devices where the ACPI method HWMC
unconditionally attempts to create Fields beyond the buffer
if the buffer is too small, this breaks essential features
such as power profiles:

         CreateByteField (Arg1, 0x10, D008)
         CreateByteField (Arg1, 0x11, D009)
         CreateByteField (Arg1, 0x12, D010)
         CreateDWordField (Arg1, 0x10, D032)
         CreateField (Arg1, 0x80, 0x0400, D128)

In cases where args->data had zero length, ACPI BIOS Error
(bug): AE_AML_BUFFER_LIMIT, Field [D008] at bit
offset/length 128/8 exceeds size of target Buffer (128 bits)
(20211217/dsopcode-198) was obtained.

ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT, Field [D009] at bit
offset/length 136/8 exceeds size of target Buffer (136bits)
(20211217/dsopcode-198)

The original code created a buffer size of 128 bytes regardless if
the WMI call required a smaller buffer or not.  This particular
behavior occurs in older BIOS and reproduced in OMEN laptops.  Newer
BIOS handles buffer sizes properly and meets the latest specification
requirements.  This is the reason why testing with a dynamically
allocated buffer did not uncover any failures with the test systems at
hand.

This patch was tested on several OMEN, Elite, and Zbooks.  It was
confirmed the patch resolves HPWMI_FAN GET/SET calls in an OMEN
Laptop 15-ek0xxx.  No problems were reported when testing on several Elite
and Zbooks notebooks.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 drivers/platform/x86/hp-wmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 0e9a25b56e0e..d3540dd62d06 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -290,14 +290,16 @@ static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
 	struct bios_return *bios_return;
 	union acpi_object *obj = NULL;
 	struct bios_args *args = NULL;
-	int mid, actual_outsize, ret;
+	int mid, actual_insize, actual_outsize;
 	size_t bios_args_size;
+	int ret;
 
 	mid = encode_outsize_for_pvsz(outsize);
 	if (WARN_ON(mid < 0))
 		return mid;
 
-	bios_args_size = struct_size(args, data, insize);
+	actual_insize = max(insize, 128);
+	bios_args_size = struct_size(args, data, actual_insize);
 	args = kmalloc(bios_args_size, GFP_KERNEL);
 	if (!args)
 		return -ENOMEM;
-- 
2.25.1

