Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492EA55F05F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiF1Vcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiF1Vce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:32:34 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63783AA7B;
        Tue, 28 Jun 2022 14:32:33 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i67-20020a1c3b46000000b003a03567d5e9so8577696wma.1;
        Tue, 28 Jun 2022 14:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e5o0RO1o3C2mILdamTa9jqoyqij/R5DqmgtFxZkmgvw=;
        b=Drpq6Jf622qVqtSLedzPOxD+wUODaRpZDIhCGppz8csCq4zAI7/cEo1l672ZkxgTiz
         YoF/6VKbiIbYc+3WgO/Hh3s0s4ALEIWGkghEKPMvsArtenCrct2kCP7bAn9eTGSFxEA1
         9EYgOhbwxfVvUd4ZbR9pV9aQNwB6gVWNFn2uUbtjFbw/2stSok1f69wjN5iv2tDs+/QU
         aJgwskEzDZ2tZBJztzeQ4qosRs6qWbr5ZmrdDl2se1KJ8o57R/5syVElbhUm6ra5KKo5
         OW/QsLaif+Hrkyq4BwcswkLzw3l7uJRc9bPDr54UwEwdAQ/UGUOtJX1IUDh/ilF4AcwH
         1gPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e5o0RO1o3C2mILdamTa9jqoyqij/R5DqmgtFxZkmgvw=;
        b=6WEulTvATxQWYdhnQTrzdxas3xV0odx12xQpVeHEZW9EtOy/ELAVIljEO8IDBBMYLN
         GTacmdebRZs+w7lhd57SoBHVppJR2YzR19gs/qXZ9B/mbwlUpX10UY4rSUNgy2ySzWhr
         qaLXbfrEbdZOajptuJzsF+IG6iT16GkGPNplbhedXx/X21cczuzdKhIr5cl2MMptDdKw
         rO2hCBzf+hU/46kB6Xrsy4JxX/zuonM/4FzxUyuSY+eDW8p96u4/VL+Jm8VbexQMH0c/
         DZ0lnOnydl9e05zP+KsLYOriS6xY/DK/XsywiTTpiqpPNe/yAjbBvriV4XaSrz1XLTJc
         GdDA==
X-Gm-Message-State: AJIora+Cv2fmoQYca0NkGxIdkebCV3BmWVGqEl+jNYJTD+RT/cX6cQ0A
        MAXB7qA2iSZXCcjh85DDUoRqseJsbRyrMb8MCxM=
X-Google-Smtp-Source: AGRyM1vhq0vdwiaKnwcWI+wpOY5hAe08ANlKQlH12nQAhOH/I4LRm+G9d+QWw/hSUh+0Zs1ozUM7xQ==
X-Received: by 2002:a05:600c:3c8a:b0:3a0:4ad8:d3c4 with SMTP id bg10-20020a05600c3c8a00b003a04ad8d3c4mr1816767wmb.43.1656451952303;
        Tue, 28 Jun 2022 14:32:32 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d4305000000b00210bac248c8sm14672384wrq.11.2022.06.28.14.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 14:32:31 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: remove redundant initialization to variable mnt_sign_enabled
Date:   Tue, 28 Jun 2022 22:32:29 +0100
Message-Id: <20220628213229.354032-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable mnt_sign_enabled is being initialized with a value that
is never read, it is being reassigned later on with a different
value. The initialization is redundant and can be removed.

Cleans up clang scan-build warning:
fs/cifs/cifssmb.c:465:7: warning: Value stored to 'mnt_sign_enabled
 during its initialization is never read

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/cifs/cifssmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 6371b9eebdad..9ed21752f2df 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -462,7 +462,7 @@ cifs_enable_signing(struct TCP_Server_Info *server, bool mnt_sign_required)
 {
 	bool srv_sign_required = server->sec_mode & server->vals->signing_required;
 	bool srv_sign_enabled = server->sec_mode & server->vals->signing_enabled;
-	bool mnt_sign_enabled = global_secflags & CIFSSEC_MAY_SIGN;
+	bool mnt_sign_enabled;
 
 	/*
 	 * Is signing required by mnt options? If not then check
-- 
2.35.3

