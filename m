Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7054C357D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiBXTOz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Feb 2022 14:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbiBXTOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:14:54 -0500
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F5F22A2AF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:14:19 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 7DC08208A54C
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Denis Glazkov <d.glazkov@omp.ru>
CC:     Denis Glazkov <d.glazkov@omp.ru>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "David Howells" <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] insert-sys-cert: fix memory leak in the error handling block
Thread-Topic: [PATCH] insert-sys-cert: fix memory leak in the error handling
 block
Thread-Index: AQHYKbFY9tSzHb5Ryk2rPh8KT5ToJg==
Date:   Thu, 24 Feb 2022 19:04:28 +0000
Message-ID: <20220224190343.142692-1-d.glazkov@omp.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.11.137]
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
