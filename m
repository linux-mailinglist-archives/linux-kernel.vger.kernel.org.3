Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960814BF2BD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiBVHkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBVHka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:40:30 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5168E125CA3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 23:40:06 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z15so5379163pfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 23:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=NjlSIvkhTVirW9AjcVgK/bv/kP1TeZNvmGeoPnvDvqU=;
        b=ofmhMbr92zX+t9ys9oSMqbuaURU/LN5aS0R7G8Fau6OATgdwtRcVds3ix83KQGSXmN
         EWuw4uwYnIKFJPpsd5W3S3NpIlKFs+YVHXlXFhedKqay9xtiedhH9bD1oQlGCjSI+atY
         bfogCYxMQSZe2oUlYtC5j8XBQdrukCZdzopc8b6glF1y4v0AS2HhtGxka4L+jzdrl2d8
         ClM1c/7NuaXtoII4vHx7XSeXG5zPOW9vcr++GsN4HVXx90toIuA0MB0cQaLOYR0t9D94
         ZvEn+qIQfIXaBZLtKz21NKPmZ0sDeP3yruezvXWbhpu5gv5CyJJiAPUPPulWZnt8CnMH
         lNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NjlSIvkhTVirW9AjcVgK/bv/kP1TeZNvmGeoPnvDvqU=;
        b=F7maTPcBjeOgaEH+qCWiemZICQ2Oo6enUSq5m6WQRbr41tDJq5al163RMgoZJrJFWJ
         TCjNDGSrW8T4ft55D0jZalKpCotxtGd9yvEEFLOITwbM87ZrTZb7KIJI415Gnu2ZL5Yc
         4IfStnhRnLEzQrQjlpj+wLe74YDIu4JVF48ZPXa/313ApgNBxQW3DCxXjhMYvC+v01GM
         cPn4tTGitliB+B3QVD7z+9Ctgzg3ljipTYPDkMUEiDhYUXX2mzUO8V5kXy447sprh3Eu
         xA4Ewink0iPs3Qbm5CpEapD8BQh2RxKc3FMaUAIEhyZfyWAq1bwVdCJW4BCHiEXLcYaG
         mf3g==
X-Gm-Message-State: AOAM531sGq8zafDtRqt+fcTIcrn+1VUB76O5N20qkdV9zZfW2MIfbHXe
        mWEQiiXVFAWgZqaYRENbYXA=
X-Google-Smtp-Source: ABdhPJxoTcUTBDauTM4MFsu+I1xV6Z81CHLb149pntUgDpj3gFmUQHRwGwlYdff+JKX2jnYcUXGoRQ==
X-Received: by 2002:a63:2bc1:0:b0:35e:c54b:3be0 with SMTP id r184-20020a632bc1000000b0035ec54b3be0mr18820358pgr.105.1645515605832;
        Mon, 21 Feb 2022 23:40:05 -0800 (PST)
Received: from ubuntu.huawei.com ([119.3.119.21])
        by smtp.googlemail.com with ESMTPSA id x2sm1635827pje.24.2022.02.21.23.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 23:40:05 -0800 (PST)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH v1] vt_ioctl: fix potential spectre v1 in VT_DISALLOCATE
Date:   Tue, 22 Feb 2022 15:39:54 +0800
Message-Id: <20220222073954.20212-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In VT_ACTIVATE an almost identical code path has been patched
with array_index_nospec. In the VT_DISALLOCATE path, the arg is
the user input from a system call argument and lately used as a index
for vc_cons[index].d access, which can be reached through path like
vt_disallocate->vc_busy or vt_disallocate->vc_deallocate.
For consistency both code paths should have the same mitigations
applied. Also, the code style is adjusted as suggested by Jiri.

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/tty/vt/vt_ioctl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 580136986..8c685b501 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -898,11 +898,13 @@ int vt_ioctl(struct tty_struct *tty,
 		if (arg > MAX_NR_CONSOLES)
 			return -ENXIO;
 
-		if (arg == 0)
+		if (arg == 0) {
 			vt_disallocate_all();
-		else
-			return vt_disallocate(--arg);
-		break;
+			break;
+		}
+
+		arg = array_index_nospec(arg - 1, MAX_NR_CONSOLES);
+		return vt_disallocate(arg);
 
 	case VT_RESIZE:
 	{
-- 
2.17.1

