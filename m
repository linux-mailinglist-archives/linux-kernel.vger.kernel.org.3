Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F914A0353
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351283AbiA1WLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:11:22 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:54006 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1351312AbiA1WLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:11:18 -0500
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jan 2022 17:11:18 EST
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20SK6qk6019747;
        Fri, 28 Jan 2022 16:01:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PPS11062020;
 bh=Y38zlJ4UqEHWdqufGAo7/SyWZeDxw+P8OUAJREwTN7Y=;
 b=CcYENQ2cdeasGh38kS7zSbuwtSlUB//3U/wOl3m4iPbBozNfT2IYoQQ2c0vNpr1Sf2rr
 bYnxIz/2I1LX+GoddRFzN6LdkN8kyxjSs2kwj1bpVnR+rDzKUkYl8J+LHlhazJfLubq4
 wUNwJIw2up5ntx0VdzpoSDyoeL9NyW5PLl7FqDWUibANjAOSL1jnaoT/bATTvq1/wV0E
 3ytMHpAdW5ys8voaXg/jYqlxadlGM/IWv4hWgCHclB7SJYKWQsb+bytl6051UfBYOPav
 lRuXxO3IbsHBTtkQjPB6DFXudwBhK+ijuHyFmiDkZTKGCjHAxI9S6/rA0iCUfbboOqFE rg== 
Received: from ni.com ([130.164.80.24])
        by mx0a-00010702.pphosted.com (PPS) with ESMTPS id 3dvb2khe8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 16:01:59 -0600
Received: from us-aus-exhub2.ni.corp.natinst.com (us-aus-exhub2.ni.corp.natinst.com [130.164.68.32])
        by us-aus-skprod3.natinst.com (8.16.1.2/8.16.1.2) with ESMTPS id 20SM1wPL005328
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 16:01:58 -0600
Received: from us-aus-exch4.ni.corp.natinst.com (130.164.68.14) by
 us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Fri, 28 Jan 2022 16:01:58 -0600
Received: from us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) by
 us-aus-exch4.ni.corp.natinst.com (130.164.68.14) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Fri, 28 Jan 2022 16:01:58 -0600
Received: from starthinker.amer.corp.natinst.com (172.18.68.32) by
 us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP Server
 id 15.0.1497.28 via Frontend Transport; Fri, 28 Jan 2022 16:01:58 -0600
From:   Brenda Streiff <brenda.streiff@ni.com>
CC:     <brenda.streiff@ni.com>, Masahiro Yamada <masahiroy@kernel.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] kconfig: let 'shell' return enough output for deep path names
Date:   Fri, 28 Jan 2022 16:01:28 -0600
Message-ID: <20220128220131.10956-1-brenda.streiff@ni.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Y_SjhD1U4DVN0zvX31VPAznAf8jZkn20
X-Proofpoint-GUID: Y_SjhD1U4DVN0zvX31VPAznAf8jZkn20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-28_08,2022-01-28_01,2021-12-02_01
X-Proofpoint-Spam-Reason: orgsafe
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'shell' built-in only returns the first 256 bytes of the command's
output. In some cases, 'shell' is used to return a path; by bumping up
the buffer size to 4096 this lets us capture up to PATH_MAX.

The specific case where I ran into this was due to commit 1e860048c53e
("gcc-plugins: simplify GCC plugin-dev capability test"). After this
change, we now use `$(shell,$(CC) -print-file-name=3Dplugin)` to return
a path; if the gcc path is particularly long, then the path ends up
truncated at the 256 byte mark, which makes the HAVE_GCC_PLUGINS
depends test always fail.

Signed-off-by: Brenda Streiff <brenda.streiff@ni.com>
---
 scripts/kconfig/preprocess.c                                  | 2 +-
 scripts/kconfig/tests/preprocess/builtin_func/Kconfig         | 3 +++
 scripts/kconfig/tests/preprocess/builtin_func/expected_stdout | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 0590f86df6e4..748da578b418 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -141,7 +141,7 @@ static char *do_lineno(int argc, char *argv[])
 static char *do_shell(int argc, char *argv[])
 {
 	FILE *p;
-	char buf[256];
+	char buf[4096];
 	char *cmd;
 	size_t nread;
 	int i;
diff --git a/scripts/kconfig/tests/preprocess/builtin_func/Kconfig b/script=
s/kconfig/tests/preprocess/builtin_func/Kconfig
index baa328827911..e9791a97f731 100644
--- a/scripts/kconfig/tests/preprocess/builtin_func/Kconfig
+++ b/scripts/kconfig/tests/preprocess/builtin_func/Kconfig
@@ -25,3 +25,6 @@ $(warning,$(shell,printf 'hello\nworld\n\n4\n\n\n'))
 # 'lineno' to the line number.
 $(warning,filename=3D$(filename))
 $(warning,lineno=3D$(lineno))
+
+# 'shell' can return more than 256 bytes of output
+$(info,$(shell,printf 'hello%01024dworld\n' '0'))
diff --git a/scripts/kconfig/tests/preprocess/builtin_func/expected_stdout =
b/scripts/kconfig/tests/preprocess/builtin_func/expected_stdout
index 82de3a7e97de..8e03e4dfe8f6 100644
--- a/scripts/kconfig/tests/preprocess/builtin_func/expected_stdout
+++ b/scripts/kconfig/tests/preprocess/builtin_func/expected_stdout
@@ -1 +1,2 @@
 hello world 0
+hello000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000world
--=20
2.20.1

