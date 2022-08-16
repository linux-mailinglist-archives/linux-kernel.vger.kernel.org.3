Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561EC595651
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiHPJb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiHPJa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:30:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC42ABC32
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:51:29 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660636287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U8zrBlsX24GUIa6NkHshgjy/77P8hZoQ1quBK5XwT24=;
        b=H77GSPlCvzKbNwiKUqP9jje1hBVeSPgS1XRcUNDxFROuGVNC/3Mc+I+LG4e/DXiVIik00E
        G3310ysKP/9aSgNMaK2KGsByi7tbIuqaQ+LOmhUiHiBTvARKIxncFf+tyeuUEozNoO2CSb
        etapm0oyX8Yz6Z14e9yaeIUE7TImlC1ZBF5BmBRK5CtnuFKrihn1D95x51I2dqWHSb7zsv
        hPcq7ZgcfEQxdDMMgvIdXOZfd+0Nia15C80CbbrSCbuaEOmJvhL7DUYKNsZUF+JSikLf41
        oTtqhcw1KK+LUS5+TZ50NY+XjPCqXW5rEf7OKwaykElJ+m8riN3Z/0qoaHz7ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660636287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U8zrBlsX24GUIa6NkHshgjy/77P8hZoQ1quBK5XwT24=;
        b=BolLcF6YC+ao0LM8yfsVwJcKoB0BE1Rr2NwIUDLsUCuQ6kIG08QH5+YLVDwe/rVXKuNjPh
        VVFtGJIeRS7/fZAg==
To:     linux-kernel@vger.kernel.org
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] checkpatch: Print an error if rwlock.h is included directly.
Date:   Tue, 16 Aug 2022 09:51:18 +0200
Message-Id: <20220816075118.173455-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rwlock.h shouldn't be included directly in source code. PREEMPT_RT uses
a different implementation and this rwlock.h include breaks it.

Add an error message if linux/rwlock.h is included.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79e759aac543b..d130db6726414 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5749,6 +5749,12 @@ sub process {
 			}
 		}
=20
+# rwlock.h must not be included directly. It will be included via spinlock=
.h if needed.
+		if ($rawline =3D~ /\#\s*include.*\<linux\/rwlock\.h/) {
+			ERROR("INCLUDES_BAD_HEADER",
+				"Please don't include rwlock.h directly, use spinlock.h if needed.\n" =
. $herecurr);
+		}
+
 # warn if <asm/foo.h> is #included and <linux/foo.h> is available and incl=
udes
 # itself <asm/foo.h> (uses RAW line)
 		if ($tree && $rawline =3D~ m{^.\s*\#\s*include\s*\<asm\/(.*)\.h\>}) {
--=20
2.37.2

