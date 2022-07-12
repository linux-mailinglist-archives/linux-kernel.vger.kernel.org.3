Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9F85717D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiGLLAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbiGLLAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDF4EAEF5E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657623607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kNMVeF/02lT2dmY8FaoFhGRKDgm+ksNOT8xFLoDv05I=;
        b=JJCT/hls6DeTsm6sn8SA5mB3eCd/UBmBTjL+yXXxH0zyXWYBHiIEn8f1jBYewxRAj9V4e8
        jEGKv3tzvBR9HmqwAIVEj1gYvaTKzYCWd/vZmmbuKuyMJG9jnDEZGaQygmUC8lAPx2fwux
        TBI9/wRLZK3dklfWgS01UX37aJexr6E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-gBPGUwdsMyW_i9Q20RzbaQ-1; Tue, 12 Jul 2022 07:00:06 -0400
X-MC-Unique: gBPGUwdsMyW_i9Q20RzbaQ-1
Received: by mail-wr1-f69.google.com with SMTP id j16-20020adfa550000000b0021d63d200a8so1294626wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kNMVeF/02lT2dmY8FaoFhGRKDgm+ksNOT8xFLoDv05I=;
        b=Ba8AT2sonoctGZ54XfZb4VE9Fjy53i899CGZWMLN8mvhrMowiWhbx1Bbx8KwbwR22j
         vQSRO5TCbum0mj68FuR7hbYBpmgIoGIOMhnzzb1K6vVmXLPxZxVZTcPKPvATZTYQXu7j
         42fedpzyfBlSSw+zH3EVuEL/pnO5dKkFPmTM/z4SQ0JJEnk7oVX6il52wTccEj3WmCeS
         jmUeCt8IoQnvBjuBsNk8cKLD86vX5klpsz6y9C5Vs77abNRAg/MZ0cRy2FIoXlnmCLFM
         l+u8brFsu5gliPci371jFeI1O5COfFVHetPSo+im3E+ClLoTXst5gStDohKT2vUB5W4B
         b3sA==
X-Gm-Message-State: AJIora/1B2iFvJRLEoxkU4zwxGOTLnsQAnixMKmheNLhT1hwKIMYpY+y
        cPbKjrTyuNO3XWKAaIQI86Ry21sKUVKLtbsOT5guseU7U8E4csVyvI43lEb6V4SLCHy/zR5zBqK
        nSeozsf/LudabV2tozHS/Unk=
X-Received: by 2002:a1c:2645:0:b0:3a2:e388:d883 with SMTP id m66-20020a1c2645000000b003a2e388d883mr3093792wmm.36.1657623605114;
        Tue, 12 Jul 2022 04:00:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vQfTXIVf7SsIUyHJE9Ixx/kLwBvhB1oAcm/zeNesHuWav8onrzZ/+UD0/TRdsNE108Tlmhgw==
X-Received: by 2002:a1c:2645:0:b0:3a2:e388:d883 with SMTP id m66-20020a1c2645000000b003a2e388d883mr3093766wmm.36.1657623604899;
        Tue, 12 Jul 2022 04:00:04 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d64e6000000b0021d887f9468sm8032260wri.25.2022.07.12.04.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:00:04 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     jan.kiszka@siemens.com, kbingham@kernel.org
Cc:     atomlin@atomlin.com, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/gdb: Ensure the absolute path is generated on initial source
Date:   Tue, 12 Jul 2022 12:00:03 +0100
Message-Id: <20220712110003.1400015-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Post 'make scripts_gdb' a symbolic link to scripts/gdb/vmlinux-gdb.py
is created. Currently 'os.path.dirname(__file__)' does not generate
the absolute path to scripts/gdb resulting in the following:

    (gdb) source vmlinux-gdb.py
    Traceback (most recent call last):
      File "scripts/gdb/vmlinux-gdb.py", line 25, in <module>
	import linux.utils
    ModuleNotFoundError: No module named 'linux'

This patch ensures that the absolute path to scripts/gdb in relation to
the given file is generated so each module can be located accordingly.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 scripts/gdb/vmlinux-gdb.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index 4136dc2c59df..8d84e5968d30 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -13,7 +13,8 @@
 
 import os
 
-sys.path.insert(0, os.path.dirname(__file__) + "/scripts/gdb")
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)) + "/scripts/gdb")
+print(sys.path)
 
 try:
     gdb.parse_and_eval("0")
-- 
2.34.3

