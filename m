Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043DD4FE6B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358060AbiDLRTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358025AbiDLRTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:19:38 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7F451E7D;
        Tue, 12 Apr 2022 10:17:19 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 15so10101172ljw.8;
        Tue, 12 Apr 2022 10:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0tAAZ8nWND6iWQe5ckcG8uvHfods3CtU4lwfTyOmYaI=;
        b=P+jLBKX0lpPGEJDenTcQ8nNR+S8cat/m2iEWf1NP4gAjPnwzidmQpPgPHBcCc4kKe2
         w/uuwItrGWEfPC+Eea2i1u2p0oYg+7WXUtAkc8pr59ThryB46qQTbKRrt2qWHAZ6p8R2
         wBjR0NBO1MiBXJXzBITpSe2d5KIn+aZ1b0IWOLMqzhIgeNJwExfCz15XJ6Su3WVvNkfq
         GNpLNbHcfJtY/6g2zMraF7OGNH1qoIFt+UqRhPjO/22lD95420U7AdFBqX4QXfbaoo7h
         QIM1C8ky5Tu2axePg360V/K69JACeM9D+OD7zXIDllY41OYLRBYyFrpaQihW+es9bGar
         NgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0tAAZ8nWND6iWQe5ckcG8uvHfods3CtU4lwfTyOmYaI=;
        b=vmv0s0+fNz2svAJQNcoVR10DYxz5oZm4xd6mrd4y4Cwky9ACdrQbBhZUU7jELxZz8r
         cgUYP7md/905fsmHDF5DmE8p0MKpvfv6IkHnpFgx+jBr4CLris1PKQwqk98OqXjE6lq3
         YEmni7YdDOQCdDqNu6lFm8RiJRB4lEYFxKaG12A0lop0k37tPoQ3y5uu8snnxQ1G59mJ
         kuOk+NIwH2QlEVED3qIhqGqd5yipBHFl1lIaaXAt+zDvhXEknSZMx0WNpTK5lxhW3BZH
         du0UagPi4aov3gQYsQOobeK36whuwkTvCDVMp44OdkGZac+FWm+4Z0A3emLPIsTmiQL+
         MUIA==
X-Gm-Message-State: AOAM533Qq9q28bl3ErhFw9RITMep5zGQShMdpuu9b3NaK9WWDFYrmXmZ
        nU6IZvuIzp0v/DzTTLQPcI8=
X-Google-Smtp-Source: ABdhPJwgTaQRDKsBOqNhTp5LfrDR6NAQoC+bYFVClkNqwTwLa6OF3EsvEX3doFC23IUc4gZlPWIIFA==
X-Received: by 2002:a2e:8094:0:b0:24b:5f25:8bda with SMTP id i20-20020a2e8094000000b0024b5f258bdamr8792373ljg.122.1649783837515;
        Tue, 12 Apr 2022 10:17:17 -0700 (PDT)
Received: from morzel-asus.lan (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id m2-20020a05651202e200b0046ba665cd6dsm723928lfq.141.2022.04.12.10.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 10:17:17 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v2 4/5] block/partitions/atari: Remove redundant assignment
Date:   Tue, 12 Apr 2022 19:16:50 +0200
Message-Id: <20220412171651.19812-4-michalorzel.eng@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220412171651.19812-1-michalorzel.eng@gmail.com>
References: <20220412171651.19812-1-michalorzel.eng@gmail.com>
MIME-Version: 1.0
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

Get rid of redundant assignment to a variable part_fmt from function
atari_partition. It is being assigned a value that is never read until
the end of function.

Reported by clang-tidy [deadcode.DeadStores]

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
Changes since v1:
-move the change into a separate patch
-add analysis
---
 block/partitions/atari.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/partitions/atari.c b/block/partitions/atari.c
index da5994175416..9655c728262a 100644
--- a/block/partitions/atari.c
+++ b/block/partitions/atari.c
@@ -140,7 +140,6 @@ int atari_partition(struct parsed_partitions *state)
 				/* accept only GEM,BGM,RAW,LNX,SWP partitions */
 				if (!((pi->flg & 1) && OK_id(pi->id)))
 					continue;
-				part_fmt = 2;
 				put_partition (state, slot,
 						be32_to_cpu(pi->st),
 						be32_to_cpu(pi->siz));
-- 
2.25.1

