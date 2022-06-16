Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2815154D9A1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350856AbiFPFSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347612AbiFPFSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:18:37 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769A25A154;
        Wed, 15 Jun 2022 22:18:36 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id r12so239997vsg.8;
        Wed, 15 Jun 2022 22:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ltNAWX61JuCuigJLPZVgMKzroH11G2+Vzg60kDmifHk=;
        b=k/EOWoFKI0M9x8I09qMqFQTE3MksqepoThUzwZb2sylMyASY8Nu7caf/0XEiYG9ZlM
         HalxfZuNK//f0mzWiuq9oC7uhhfbHl2Sx/9ZIaQjdqztSdQY61sRjUyFqXUWZPThC4Bh
         JzZtquE4qHA0S0Jdvd7dJkEsw/lswA41Ex09lhH1SZ40XNkvRg8O2cGIcIOTqK4Ydb1L
         03N6C1h9qrz6E4IhHs/bxriVmmco0L8j0Tf/3Y4T70V/L9AVp4CMFVHAQl5z7pBsYrIj
         +wJ9GI2ugv1Vn4sqZ6Zs9CUp7dYwZZCxrB9GPW5GUT3oA0ramwKLj219DoqcVSSNYp6O
         kTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ltNAWX61JuCuigJLPZVgMKzroH11G2+Vzg60kDmifHk=;
        b=CboeC27LejErIf+WmrL8Uz1JY32D0cQl21G2xGh7ZGL1PlhMCpeNOrKcn5peL6Iy8M
         G/03ydQlZlga73OSnMwVOVLykj0FtE3n7uor0bce5Aot8M89Tz/npuxPkajNEVbSeKO+
         gThl9/I1TGkrDwITmFjKdERLmCuHO9fHuWRy1hWYQ2ocEO/8qGp/nevGbRYao1bPYyQY
         a0OzMJYIjZ6SW9zhBxpHgUvmHtY5z8HR3zVSJabaltbp69kWn0ymlPANEK/jCpd6UFOl
         Uepl8tspvi0c0WAs2TenmmOx73R5w7ErGLP5Z+hKdPqQzyxK/BcnHiGRpO09HMobgYlc
         kSbw==
X-Gm-Message-State: AJIora/QHYu+XH6x5tSKPPT7dx/Eqm254pwgyFDYkPyfwKlwlVnN8/xN
        CPlZGFydfz/GdeNU8/3s1rVyXzlI4UcAuyVhuIF6FCo1oPk=
X-Google-Smtp-Source: AGRyM1uz/IDVYUqG4KSZDG8R306p0aOhV0JSvU88111zt7LXFZrXgyncRvMfE85FsTZRBpMRQRbITqMXp7Xy14WLEI0=
X-Received: by 2002:a67:70c4:0:b0:349:d442:f287 with SMTP id
 l187-20020a6770c4000000b00349d442f287mr1445668vsc.2.1655356714874; Wed, 15
 Jun 2022 22:18:34 -0700 (PDT)
MIME-Version: 1.0
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Thu, 16 Jun 2022 13:18:23 +0800
Message-ID: <CACXcFmmw8bzSr-pmTauMS7a=036eW0=1KLdwAD1MOB_fY-7VRg@mail.gmail.com>
Subject: [PATCH] random Remove setting of chacha state to constant values.
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, "Ted Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting parts of the state to known constants is needed in
some Chacha applications to ensure that blocks can be processed
in parallel and that when needed (e.g. when encrypting disk
blocks) the algorithm can jump to an arbitrary part of the
output stream. In an RNG these are not required, and setting
the constants wastes cycles.

If (as we hope) the enemy does not know the state, then
this is more secure since it makes the chacha outputs
depend on more unknown bits.

If they can peek at the state or infer parts of it from
outputs, knowable values cannot possibly be worse than
known ones. This at least prevents them from using
pre-computed tables based on the known constants.

Signed-off-by: Sandy Harris <sandyinchina@gmail.com>
---
 drivers/char/random.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 655e327d425e..6df9e656a157 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -249,9 +249,7 @@ static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],

     BUG_ON(random_data_len > 32);

-    chacha_init_consts(chacha_state);
     memcpy(&chacha_state[4], key, CHACHA_KEY_SIZE);
-    memset(&chacha_state[12], 0, sizeof(u32) * 4);
     chacha20_block(chacha_state, first_block);

     memcpy(key, first_block, CHACHA_KEY_SIZE);
-- 
2.25.1
