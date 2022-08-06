Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1ECF58B6CA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiHFQZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiHFQZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:25:35 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C36011461
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 09:25:34 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s206so5104741pgs.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FpRML5FM7z0q20RyQQ3Ksaz1Bp1mVVRpaiFCWoESebI=;
        b=SYK4ZlgIr9eRjmImdozBr1Er95Hpb183FLl1WmZOoT/hmx1oznn4IEH+4sZgTsITDe
         Jbbu8iWKh61Z3o19R3jNU30AOlf/7mkIHa5NoprcmKIBA2geuRGt4Ssuqi83T2FMNi1M
         /oT5Ys/zOXkuWTaXajq76Wlyd39Sg50TxBrGvPfACYej1WV1F8bc+ow3111dTGpZy/vl
         borTfKp//mA/v6GzRnAqQ3v8tXMbbJqsEnlrQQQ/mO7QcYy6Zphbh+wHtR0/0XH3960c
         ySXPNwgaqtIEOqGbLJltYARNPabPNIEW9zs2Hjv1ylJAjBB9XO0OtMVqevNj1LejCsEe
         SfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FpRML5FM7z0q20RyQQ3Ksaz1Bp1mVVRpaiFCWoESebI=;
        b=xC4/wqCpxfpeuMVPeC9Zlwp5Jl96lK7Lr3ir8FjvQNa3MwjYSklIibGDDDFmwMn5qO
         hzYBSN80+k8jhUpGdGr66YYYBiTXt/TaOuw1M928iqMUI52flWqzIby8utVbVhGdRNXN
         4ckGLIL+ZGuwQM+qFbYJhP0Bdd0INKGgfGt5miPgzBfs2597KA/Jbee901NQGnWXvGZv
         ELRDhWRX2jLWcNqi9uu6shQTsPNNNGtRDnTDB6HOl0Vuh8l+q9fQZkPDCMyuImgNG39N
         oYPo0sDOgCiZembuc//YOqhO/IS1SOQ7eDYhq2iR6qwwPi9NczrZfXCtmGnX7z14QvJI
         7lbA==
X-Gm-Message-State: ACgBeo2fWtZZD8TXRnZ5qTNeFSLR1683kbEeSXTfifaaN981WyolfTka
        xqEPUI4VfRms/vNbqaD8BsI=
X-Google-Smtp-Source: AA6agR6F32DLoFeS/le46RtJyB6ofXPLEFyPdCXRVyFSziywcYwNA6QpmRdZvjdLoGIdkJX7pUgh3w==
X-Received: by 2002:a05:6a00:2190:b0:52b:fe5f:5939 with SMTP id h16-20020a056a00219000b0052bfe5f5939mr12039594pfi.83.1659803134119;
        Sat, 06 Aug 2022 09:25:34 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a2f0100b001f04479017fsm4990927pjd.29.2022.08.06.09.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 09:25:33 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH RESEND V3 4/6] rslib: Fix kernel-doc style for rs_modnn()
Date:   Sun,  7 Aug 2022 00:25:08 +0800
Message-Id: <20220806162510.157196-5-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220806162510.157196-1-zhangboyang.id@gmail.com>
References: <20220806162510.157196-1-zhangboyang.id@gmail.com>
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

This patch fixes the style of kernel-doc of rs_modnn().

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 include/linux/rslib.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index cd0b5a7a5698..e92923fff3bc 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -107,7 +107,8 @@ struct rs_control *init_rs_non_canonical(int symsize, int (*func)(int),
 /* Release a rs control structure */
 void free_rs(struct rs_control *rs);
 
-/** modulo replacement for galois field arithmetics
+/**
+ * rs_modnn() - Modulo replacement for galois field arithmetics
  *
  *  @rs:	Pointer to the RS codec
  *  @x:		the value to reduce
-- 
2.30.2

