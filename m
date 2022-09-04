Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007515AC7CC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbiIDVqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiIDVov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:44:51 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F1330569
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:56 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id s11so3868383ilt.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=58gChvxjBedxDU/dSXgKq8f75Aq/PMP0VWOkECUeGr8=;
        b=J2tQsdq2kkHf85Z9ASRTiHs9OI3ZDVILIcK9yZOObu9+KlrqqjVNIjRz1rl5rphOwC
         2Qfnz0oI/RsX3V70MD8E8G/yZztrNm2ZfOZnCp9690q1IH4JJ+adDmarycETlY/12rhr
         Db+6+SqEctFD/7m0SrX4AuGqEeuaJOmohsGrTlCLPTPTc/eFNhQn9dKNl96NeOx5rxdC
         vum//49JpYe1Z4oGVnwyv1uBitMZ8t5aokHuE388ICOZLGyjaZC6ZUwl7qnvJ1ZVUgUl
         OCs0CimfeNixxoHVLc+cIByGyUxmeix8tj9SCyBEQkzsOFFYl2FMPL60Yd7P36fczO+9
         Pthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=58gChvxjBedxDU/dSXgKq8f75Aq/PMP0VWOkECUeGr8=;
        b=SkSiGK73jNuad5Uz2i40yZXm+WpZBDP2kK90HVI9kfgt5kBfVy69K2lU/wTUxwwAGR
         VxRpyKmmuMSw5pYUWpvqwGEeir8upPnflVkPe9C0G4A7Cfu3N3mWrBrGTC0HmxhJV6iL
         F35jryZEve4E6snxSBIcX3c3dC961UOE6j6EnR2odW2gRSBUwc6YD5qWxu31COV26wCg
         e3ZTbFTlDHUClxYvoT+R5nBp6JFjcY4i33erCIDncZoNzUdIy74offcmxlQGQGCISvk5
         D5S3OtzoqHXjedDHaOq8psRamq+vSkvWVNAo+aflgsnHBTtPoWsCdnjw0lxdYADSPsIX
         FUlQ==
X-Gm-Message-State: ACgBeo3PbfEcL5Qdj8K0rYJN2/Vyy7WmBcvHXCrKFHfPhlTF92p5DTel
        zBbS84YALbi9/TCezgs0vvU=
X-Google-Smtp-Source: AA6agR61bCYoBFhO606MrMj2e5JJ9ontZpH/7gcxtdHyPlYtKYvvYkTqL53A1Ak5xf1hQmk380rWDQ==
X-Received: by 2002:a05:6e02:16cd:b0:2ea:e75b:f357 with SMTP id 13-20020a056e0216cd00b002eae75bf357mr19038138ilx.110.1662327776105;
        Sun, 04 Sep 2022 14:42:56 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:55 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 48/57] dyndbg: add .gnu.linkonce slot in vmlinux.lds.h KEEPs
Date:   Sun,  4 Sep 2022 15:41:25 -0600
Message-Id: <20220904214134.408619-49-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904214134.408619-1-jim.cromie@gmail.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
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

Add linker symbols and KEEPs for .gnu.linkonce.dyndbg and
.gnu.linkonce.dyndbg_sites sections, placing them in front of their
respective dyndbg and dyndbg_sites sections.

This placement gives us a known relative offset (ie -1) from the start
of the vector to the header, letting us use container_of to get it.
The _index added previously allows determining &descs[0] from any
desc[N].

The .gnu.linkonce. collapses possible multiple declarations into a
single allocation, with a single address.

todo: will need similar for modules.lds.h

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1e7ee65e8591..20fdea9efd78 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -348,9 +348,13 @@
 	__start___dyndbg_classes = .;					\
 	KEEP(*(__dyndbg_classes))					\
 	__stop___dyndbg_classes = .;					\
+	__dyndbg_header = .;						\
+	KEEP(*(.gnu.linkonce.dyndbg))					\
 	__start___dyndbg = .;						\
 	KEEP(*(__dyndbg))						\
 	__stop___dyndbg = .;						\
+	__dyndbg_site_header = .;					\
+	KEEP(*(.gnu.linkonce.dyndbg_sites))				\
 	__start___dyndbg_sites = .;					\
 	KEEP(*(__dyndbg_sites))						\
 	__stop___dyndbg_sites = .;					\
-- 
2.37.2

