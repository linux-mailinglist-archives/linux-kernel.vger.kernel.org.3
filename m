Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED6153F776
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbiFGHnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiFGHnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:43:17 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166342E093;
        Tue,  7 Jun 2022 00:43:17 -0700 (PDT)
Date:   Tue, 07 Jun 2022 07:43:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1654587793; x=1654846993;
        bh=D9FtRQsL64UZzeNlDSZGhV3sxAUQRz/jzb9A2KCTcNc=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
         Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=i6mTSUcTRPosAWilhmCAwd5mvCKSmf+X6domJ9XNYgWu3XZzkkHWiVAPQ03pqcISA
         tvSLTTF7a5+Gzy6Tus1NrtlT1gSep4rDK0fETn2N0fjRn6lTsWtnDabdtEGZRZKN6g
         0S2tL+Cisllizz5L7QOdUeg4rnan6P/LgWgQuLb6H5Tlnx82IONYb+5d5XXKkZNZ2o
         Hi82zZiQC3r6/3hsEFJ/3C5s1bKKgMmKKGbBcMGjEZ6ZeblGYJL+0hikwtSRCbTVTZ
         zqQhMPWsNgvfbK+UBnqDrghDbTOJ/SX9UJvlSeVBs/KjBiAT9HnkgYnhEjzWietluv
         M5C1LbFSYs61w==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     dmitry.torokhov@gmail.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, rydberg@bitmath.org,
        zhengyongjun3@huawei.com, linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht, andi@etezian.org,
        stephan@gerhold.net, nikita@trvn.ru
Reply-To: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [RESEND PATCH] input: stmfts: Add #define STMFTS_RETRY_COUNT 3
Message-ID: <20220607074249.21763-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add #define STMFTS_RETRY_COUNT 3 to retry stmfts_command() 3 times.
Without it, STMFTS_SYSTEM_RESET or STMFTS_SLEEP_OUT may return -ETIMEDOUT
to failed attempt due to no event received for the completion.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 drivers/input/touchscreen/stmfts.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen=
/stmfts.c
index c175d44c52f3..730035f5c62c 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -68,6 +68,7 @@
 #define STMFTS_DATA_MAX_SIZE=09(STMFTS_EVENT_SIZE * STMFTS_STACK_DEPTH)
 #define STMFTS_MAX_FINGERS=0910
 #define STMFTS_DEV_NAME=09=09"stmfts"
+#define STMFTS_RETRY_COUNT=093
=20
 enum stmfts_regulators {
 =09STMFTS_REGULATOR_VDD,
@@ -317,19 +318,20 @@ static irqreturn_t stmfts_irq_handler(int irq, void *=
dev)
=20
 static int stmfts_command(struct stmfts_data *sdata, const u8 cmd)
 {
-=09int err;
+=09int err, retry;
=20
 =09reinit_completion(&sdata->cmd_done);
=20
-=09err =3D i2c_smbus_write_byte(sdata->client, cmd);
-=09if (err)
-=09=09return err;
-
-=09if (!wait_for_completion_timeout(&sdata->cmd_done,
-=09=09=09=09=09 msecs_to_jiffies(1000)))
-=09=09return -ETIMEDOUT;
+=09for (retry =3D 0; retry < STMFTS_RETRY_COUNT; retry++) {
+=09=09err =3D i2c_smbus_write_byte(sdata->client, cmd);
+=09=09if (err)
+=09=09=09return err;
=20
-=09return 0;
+=09=09if (wait_for_completion_timeout(&sdata->cmd_done,
+=09=09=09=09=09=09msecs_to_jiffies(1000)))
+=09=09=09return 0;
+=09}
+=09return -ETIMEDOUT;
 }
=20
 static int stmfts_input_open(struct input_dev *dev)
--=20
2.30.2


