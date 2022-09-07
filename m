Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB26D5AF960
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 03:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIGBSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 21:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIGBSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 21:18:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82891861C9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 18:18:17 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fv3so6912459pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 18:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=M21ssd+SCSSsGeh27JWFSofpx9BWcRpnZarG7AT/Oog=;
        b=KIp7sG710pR+n2lsiIIsKkJbaVjzrITBiMhGQFivaAzcpPBgTP91QkTJBvPLwVVvYK
         80W5WL97zPXhfm+AVq+PNCg6UvQCpg07CANHcX/eN0Uy5SzJW81AB/RMeq30HnAsQotU
         GDD/anS4eAQvEBJ+BXMo5D7dv6umuSzac9DNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=M21ssd+SCSSsGeh27JWFSofpx9BWcRpnZarG7AT/Oog=;
        b=yBaiLREq61xtAyK6R73TXMCat6lGbxOq3htJo4efw/i3H1v3ZOs2BlFEnHE8SSByGg
         Ae3MxY9ZHqvS3zN2mmPUEqUskiy8npXz/+Pv5yI6gxHb3QVYFFrSVtE1gSoG+V57YGOj
         GFGfLwav0/ET6EMPqhggD8dTgQ3yxEezJvdkB6NRxTMC8neh3+4Mu1ltzHhPScMl01dQ
         OPyGRGDKt9lM0zZzRjTUY4YjVMFnEkF7YmvJqh8rHnkYptbbhj+HgIuGfoetDkNdWrCE
         gQyn3jRhbsWKBHEEcKS3yVyLK0ZQpiPjSJUUSq1OmbgbUYzxtVbJJ+a5Rm1TGBkXr3fr
         DVYw==
X-Gm-Message-State: ACgBeo2JU/OvYc0QVwfV3uJWQqtwR6SEt1bV9Y1zLTEH4fbM7uzSZtyy
        Eq1gJd4jhSkl7C+EvaohwCkKZw==
X-Google-Smtp-Source: AA6agR67U5AZIaBfuvGuyZMN0SCDmBt4kBb19CNC0XD8eDVqoMBDP73Ihp3hsT/46KNNwQ/a9j6Weg==
X-Received: by 2002:a17:90b:3e81:b0:1fd:8357:cbc8 with SMTP id rj1-20020a17090b3e8100b001fd8357cbc8mr1327020pjb.48.1662513497037;
        Tue, 06 Sep 2022 18:18:17 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:acea:5f9a:4de:10c7])
        by smtp.gmail.com with UTF8SMTPSA id d13-20020a170902654d00b0017689960d10sm8321906pln.156.2022.09.06.18.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 18:18:16 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH] LoadPin: Require file with verity root digests to have a header
Date:   Tue,  6 Sep 2022 18:18:12 -0700
Message-Id: <20220906181725.1.I3f51d1bb0014e5a5951be4ad3c5ad7c7ca1dfc32@changeid>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LoadPin expects the file with trusted verity root digests to be
an ASCII file with one digest (hex value) per line. A pinned
root could contain files that meet these format requirements,
even though the hex values don't represent trusted root
digests.

Add a new requirement to the file format which consists in
the first line containing a fixed string. This prevents
attackers from feeding files with an otherwise valid format
to LoadPin.

Suggested-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
It could be argued that this change breaks existing users
of the LoadPin verity feature. The risk of this actually
happening seems very low given that the feature only
landed in v6.0, which hasn't been released yet.

 security/loadpin/Kconfig   |  7 ++++++-
 security/loadpin/loadpin.c | 16 +++++++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
index 994c1d9376e6..6724eaba3d36 100644
--- a/security/loadpin/Kconfig
+++ b/security/loadpin/Kconfig
@@ -33,4 +33,9 @@ config SECURITY_LOADPIN_VERITY
 	  on the LoadPin securityfs entry 'dm-verity'. The ioctl
 	  expects a file descriptor of a file with verity digests as
 	  parameter. The file must be located on the pinned root and
-	  contain one digest per line.
+	  start with the line:
+
+	  # LOADPIN_TRUSTED_VERITY_ROOT_DIGESTS
+
+	  This is followed by the verity digests, with one digest per
+	  line.
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 44521582dcba..de41621f4998 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -21,6 +21,8 @@
 #include <linux/dm-verity-loadpin.h>
 #include <uapi/linux/loadpin.h>
 
+#define VERITY_DIGEST_FILE_HEADER "# LOADPIN_TRUSTED_VERITY_ROOT_DIGESTS"
+
 static void report_load(const char *origin, struct file *file, char *operation)
 {
 	char *cmdline, *pathname;
@@ -292,9 +294,21 @@ static int read_trusted_verity_root_digests(unsigned int fd)
 
 	p = strim(data);
 	while ((d = strsep(&p, "\n")) != NULL) {
-		int len = strlen(d);
+		int len;
 		struct dm_verity_loadpin_trusted_root_digest *trd;
 
+		if (d == data) {
+			/* first line, validate header */
+			if (strcmp(d, VERITY_DIGEST_FILE_HEADER)) {
+				rc = -EPROTO;
+				goto err;
+			}
+
+			continue;
+		}
+
+		len = strlen(d);
+
 		if (len % 2) {
 			rc = -EPROTO;
 			goto err;
-- 
2.37.2.789.g6183377224-goog

