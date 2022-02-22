Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8174BF742
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiBVLcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiBVLb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:31:59 -0500
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593BD19E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1645529488;
        bh=0Ms03xWBc+9VrtD4C/QoIp1ZOw2mnrwmYzl37UBKzPc=;
        h=From:To:Cc:Subject:Date;
        b=NO/4JptqKjfmD2FQGqa805MYzw3d3v2LZH194MFNBKqesQnatRioyjciyeVoYD97l
         7s/fnIQCAUVCxmVcYXIJ7jBI6Fcmih7gOvlvHBCWqGXc71jPezyO1+M7UEkmPgnf44
         /FNuLYbFmXW0aVvr6WASCMBoiSFZ3rRjb5mi86+4=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrszc7.qq.com (NewEsmtp) with SMTP
        id 791A02AE; Tue, 22 Feb 2022 19:30:17 +0800
X-QQ-mid: xmsmtpt1645529417tdyhv1w0j
Message-ID: <tencent_22C6C2E595DEFED1417A98A5736539482809@qq.com>
X-QQ-XMAILINFO: OE2SNMSfMbmOqWTaLvPkh1gzQ6LQ3QWbRi+ykRMCw6wayFRA56vcRnp4jqOcUy
         r8eInt09NooaESLAgWeFLhZtuOa05vyguPZzHdzvcIfdhBBvQV5TgYlISohQe50GjzlrrHGVYyPl
         VzifWo8oknq8HhPnCaic+n2M0XKZmgWiCETP7yRvqMsRZXhhNgrJ1Grt/Bl6JJ2UGafJbdmOiGo9
         GYK9A8OyivVV6v3zE0AX8E6DrNrMWSldHe0jhivEwEb7GfoLZEeTzhclTgyAK9Tfgafkz/SXf50Y
         xkTxjT8aFxSXAa1zx0LQa2AfXJLhY5QZdPIcrjSkLbt7akmgQKt8EcZbA4tTk1Gw3aWWIGTYQR1R
         WCoiIbXNYS6SfQrMcbydCLK2iape5LgtIxvEXDE8gkO55yjaldWjOpOxSr3rtb0PXqap/dcWfcs3
         0Noi/HcqCU2oyCOZssZMIFcixw4Z+vnlj976xzLmjNDkEjfua5yC3JatB8jw1Zelg2LOTntTd1ls
         b3ZKe7p197WOfVi0E7yR0RqrkAUujNk4WR1naxyqwL4nPYpeQ22MgMgfeckrm+nLXjzfwAO39OW3
         ozSRW76iMBVliUgk9V11egDp7S7fzMEJJXn3n1B8tIv51XZW8x4PNYU0+KwTK++mGo3KC7p0VZBL
         ryTX6EEtByOIpths6V9Pt70rHZxPL2w81FZMLC20QQW4FQ52EadYgrA/3h4fzrTfJ1r4b+wrlUhj
         fl/HDEkQKaK7ZFcEiZnaFzm4EXkstdU+LZE9wuz7xkL3d8UQ+cMZPqXNTdUJoVQmAeRjCSnZjEXU
         ILdD39TWlLGiER20h3UZt768wmry3fORvCfaaFM7e8HHYv9aAvN1E0dlz0+cDPlPn8OQ003uEZne
         Trxd+tjdSMzDRAFA8MmxvU9Koz3rHk/rbfmYB/Sk2q
From:   xkernel.wang@foxmail.com
To:     sumit.semwal@linaro.org, christian.koenig@amd.com
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] dma-buf: check the return value of kstrdup()
Date:   Tue, 22 Feb 2022 19:30:05 +0800
X-OQ-MSGID: <20220222113005.3812-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kstrdup() is a memory allocation function which can return NULL when
some internaly memory errors happen. It is better to check the return
value of it to prevent further wrong memory access.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/dma-buf/selftest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma-buf/selftest.c b/drivers/dma-buf/selftest.c
index c60b694..2c29e2a 100644
--- a/drivers/dma-buf/selftest.c
+++ b/drivers/dma-buf/selftest.c
@@ -50,6 +50,9 @@ static bool apply_subtest_filter(const char *caller, const char *name)
 	bool result = true;
 
 	filter = kstrdup(__st_filter, GFP_KERNEL);
+	if (!filter)
+		return false;
+
 	for (sep = filter; (tok = strsep(&sep, ","));) {
 		bool allow = true;
 		char *sl;
-- 
