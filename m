Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8037D4DEAAA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 21:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244152AbiCSUfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 16:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbiCSUfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 16:35:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCD211BDBF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:33:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t1so13912342edc.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1j/LMABFlKxiQiqNjegxYwlhyzGKpOnQ73hq4DOupwE=;
        b=OhL3haaGthCsvRcFFsS4y9PSbMbS1jur2LY3uaicYJHh6mz0cs8cB914hTuLd1KYbX
         Rf5gHj8CefeqBeSoVvm0DEmZCPRnDGx78RnSNWAKWQrp5oKe6hV/QYEm1FHMPobWxC68
         G0wne6ppuXcDrmjl/B3+XEm6XpaW/uLvXkrlOz7al5QlnCgSofeGe009sv8yCOD5jCzO
         oGA5qewS0nN2pgYeh3fWXLlkDYEZj2JM32gWIM0E2QoDnALZvzRuuz2evW+8Hyj5TtPw
         nKS7Med5/e8K5fNXKiSjBLVlgaqfMyfOvdTYfDSYjRCEpnHmuOgWbOH9KZhhpPF1UEnU
         suRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1j/LMABFlKxiQiqNjegxYwlhyzGKpOnQ73hq4DOupwE=;
        b=f2rSppZweTgyMyXvHLMa4bFtkDJbWBg5qhnMxygXElT7AuerjZcxjyKgPO3c8j9l0G
         WGSUFMUc7t3wqQ2Bx12xtvHi0WI4g5A55GnRH5QMDPaiSy2LVyp2m0iRa7nEGu1V6TJa
         +LS8KMkeHRGJqQLy607RyHQEqVz4ASGMDHddQh7f3za2yS/sJIEsvTlk0TWIoc552Rg7
         y6ksZQiebZNZnliKmFJDU1NQctx2h7N87J/I9/lsg209skjFrC9XnDkky2ideZNBKG63
         DCup80iWBLKaNytBnj0EC90+Mw87J1TnelXo7TPvK6d9IDll9AkCz4wJwH7VJTpj/KTx
         I/Xg==
X-Gm-Message-State: AOAM533AF4EBjFZp7x+D0tlNLN4pR3guUwi3w40D3m83ZdadiFVCWP3U
        B/P5kErOODOPdYUqgk+R0H0=
X-Google-Smtp-Source: ABdhPJy33rKC4Gw1Jo82NEMpvN5QnC3XHUf5i9Rsa6zScCExBsILtOPJuQEzDBJV9m2/d7kA77hOVg==
X-Received: by 2002:a50:d711:0:b0:410:a51a:77c5 with SMTP id t17-20020a50d711000000b00410a51a77c5mr15801434edi.154.1647722032176;
        Sat, 19 Mar 2022 13:33:52 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id gl2-20020a170906e0c200b006a767d52373sm5174158ejb.182.2022.03.19.13.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 13:33:51 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Matt Porter <mporter@kernel.crashing.org>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: [PATCH] rapidio: remove unnecessary use of list iterator
Date:   Sat, 19 Mar 2022 21:33:44 +0100
Message-Id: <20220319203344.2547702-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

req->map is set in the valid case and always equals 'map' if the break
was hit. It therefore is unnecessary to use the list iterator variable
and the use of 'map' can be replaced with req->map.

This is done in preparation to limit the scope of a list iterator to
the list traversal loop [1].

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 7df466e22282..2cdc054e53a5 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -915,7 +915,7 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
 			goto err_req;
 		}

-		if (xfer->length + xfer->offset > map->size) {
+		if (xfer->length + xfer->offset > req->map->size) {
 			ret = -EINVAL;
 			goto err_req;
 		}
@@ -927,7 +927,7 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
 		}

 		sg_set_buf(req->sgt.sgl,
-			   map->virt_addr + (baddr - map->phys_addr) +
+			   req->map->virt_addr + (baddr - req->map->phys_addr) +
 				xfer->offset, xfer->length);
 	}


base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
--
2.25.1

