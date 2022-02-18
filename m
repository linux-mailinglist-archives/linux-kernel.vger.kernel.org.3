Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714B24BBEF6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbiBRSGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:06:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238926AbiBRSG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:06:28 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A841BB70F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 10:06:11 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d27so15889667wrc.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 10:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3KaTariYV0C3i6+yVXZQ7J2aZwcXvr21FEejBAHFaW4=;
        b=YZ8SStJqY7FsgEWsyC7xMxTiGbidFgvLISSc0jXfre0ZOa1galQjJk4OnAmWGx4WFw
         GG49nLskCccayh3YVmsjdSMmwdsaaqd6WFoGTO+RA2mVlVWHLEQdlMrKN4NU8WA5Zo+p
         olHqfPTR6EK+jQOhWEFf5+3DMH3zWNt6ion/RKDWIeHVdNFEbvGkvG+ZU3yHm0ugB4H3
         C+4sc8Q+TDBq49Q1la3tmqdPo/CRKqDRpP6iBLPEYYE2J7dVikwXonka5k7XqgfOkAkQ
         GEVn3EhVemH5gOnZg2H9YroO6xtLz5SZSBPen96YxaVFXItqpAkNBZzJehLrCP4CmmdF
         hn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3KaTariYV0C3i6+yVXZQ7J2aZwcXvr21FEejBAHFaW4=;
        b=47et8jPptKQiOKjSSjMr1hSiIjRed1SAFZXF+jLLbCxRm1hDNxdBSmmK7w2IwSyN6W
         jHXpdw+rq0f9wt/e2XZYLaTjr2AaiDuccAsrajkE8q/R9WbrAHwTkSYkh8T/fK8OJW6M
         K/c8nGPKktV2vFE/gEz1B3lrhcz+9VWuxILvnNkygB+5MaR3cnzavFg+OqIq6BI4RJSJ
         x/aoKUS4iFEkAIU1Q8pVBvYYOIbCvmbVgkyzpH7je/EAf3B76Mz6qtTB0pVcuaGwmF2z
         QDXJnqyMacYAft2qpwkvVENLgU0bb+SlY7VJ6Lr1YYcLax7Sh99pR8Ejm+OFyFzbswC3
         coMQ==
X-Gm-Message-State: AOAM531p37n8o+vf1PaYfJqTNBwgbmvFVeciT+APhcRGCiWkarobnI+R
        WGBbTBwHGR71i7Hha1dL9t8erA==
X-Google-Smtp-Source: ABdhPJwbPs1OfKawo+AirCzhb9XpYZ3/m6UvxRu8E/M3BysiGFEu0ERrRCkYimIFfiky2jUhMjoTgw==
X-Received: by 2002:a5d:590a:0:b0:1e4:b619:52ab with SMTP id v10-20020a5d590a000000b001e4b61952abmr6749432wrd.242.1645207570193;
        Fri, 18 Feb 2022 10:06:10 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id b18sm34527364wrx.92.2022.02.18.10.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:06:09 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: [PATCH] efivars: Respect "block" flag in efivar_entry_set_safe()
Date:   Fri, 18 Feb 2022 19:05:59 +0100
Message-Id: <20220218180559.1432559-1-jannh@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the "block" flag is false, the old code would sometimes still call
check_var_size(), which wrongly tells ->query_variable_store() that it can
block.

As far as I can tell, this can't really materialize as a bug at the moment,
because ->query_variable_store only does something on X86 with generic EFI,
and in that configuration we always take the efivar_entry_set_nonblocking()
path. So I'm not marking this for stable backporting.

Fixes: ca0e30dcaa53 ("efi: Add nonblocking option to efi_query_variable_sto=
re()")
Signed-off-by: Jann Horn <jannh@google.com>
---

 drivers/firmware/efi/vars.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index abdc8a6a3963..cae590bd08f2 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -742,6 +742,7 @@ int efivar_entry_set_safe(efi_char16_t *name, efi_guid_=
t vendor, u32 attributes,
 {
 	const struct efivar_operations *ops;
 	efi_status_t status;
+	unsigned long varsize;
=20
 	if (!__efivars)
 		return -EINVAL;
@@ -764,15 +765,17 @@ int efivar_entry_set_safe(efi_char16_t *name, efi_gui=
d_t vendor, u32 attributes,
 		return efivar_entry_set_nonblocking(name, vendor, attributes,
 						    size, data);
=20
+	varsize =3D size + ucs2_strsize(name, 1024);
 	if (!block) {
 		if (down_trylock(&efivars_lock))
 			return -EBUSY;
+		status =3D check_var_size_nonblocking(attributes, varsize);
 	} else {
 		if (down_interruptible(&efivars_lock))
 			return -EINTR;
+		status =3D check_var_size(attributes, varsize);
 	}
=20
-	status =3D check_var_size(attributes, size + ucs2_strsize(name, 1024));
 	if (status !=3D EFI_SUCCESS) {
 		up(&efivars_lock);
 		return -ENOSPC;

base-commit: 83e396641110663d3c7bb25b9bc0c6a750359ecf
--=20
2.35.1.473.g83b2b277ed-goog

