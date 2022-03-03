Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8684CB886
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiCCIQT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Mar 2022 03:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiCCIQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:16:17 -0500
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC6A171292;
        Thu,  3 Mar 2022 00:15:30 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 3106A20D5C35
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Denis Glazkov <d.glazkov@omp.ru>
CC:     Denis Glazkov <d.glazkov@omp.ru>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Mehmet Kayaalp" <mkayaalp@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: [PATCH] KEYS: fix memory leak when reading certificate fails
Thread-Topic: [PATCH] KEYS: fix memory leak when reading certificate fails
Thread-Index: AQHYLtbXK3D575r57ECuz2QMV/HRKg==
Date:   Thu, 3 Mar 2022 08:15:28 +0000
Message-ID: <20220303081428.12979-1-d.glazkov@omp.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.11.133]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MISSING_HEADERS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the `read_file` function of `insert-sys-cert.c` script, if
the data is read incorrectly, the memory allocated for the `buf`
array is not freed.

Fixes: c4c361059585 ("KEYS: Reserve an extra certificate symbol for inserting without recompiling")
Signed-off-by: Denis Glazkov <d.glazkov@omp.ru>
---
 scripts/insert-sys-cert.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/insert-sys-cert.c b/scripts/insert-sys-cert.c
index 8902836c2342..b98a0b12f16f 100644
--- a/scripts/insert-sys-cert.c
+++ b/scripts/insert-sys-cert.c
@@ -251,6 +251,7 @@ static char *read_file(char *file_name, int *size)
 	if (read(fd, buf, *size) != *size) {
 		perror("File read failed");
 		close(fd);
+		free(buf);
 		return NULL;
 	}
 	close(fd);
-- 
2.25.1
