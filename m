Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925BC4BBF4E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbiBRSRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:17:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbiBRSQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:16:59 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E28B32;
        Fri, 18 Feb 2022 10:16:41 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id p9so15892947wra.12;
        Fri, 18 Feb 2022 10:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=60WfrxgVMKQI4zJcrOBqZYpPlE/wCIZ8P+dtpfYXPkI=;
        b=fiIiBcLWdP+8+IT79yBp5InVJ72o+Pi2rARnrcsVrF/Wic68xivQH9tJNHtJ8erna4
         qnpJ+rZt6UvniUuQcq7z7uc/PC+6AL2Zad5TiG3ZVFX6ih4xoxzqzdi33is+W936ae95
         xeW4DX30A3vGQ0aCoZSToCMtxXRHNJkbI0Yd+PC0JUpn0nDNhImu61ldaR0qLhcSR+Jy
         2DRE+I70k/PAm601odyuS6Y9RtWFeqXBYQ3yjvVnELsN4KGTHDNPiHHiUUquHEjywp31
         xi/lDJFVf7k8A6ZHjrlNuJhYDF7zmzc/ioaustDTiKpSZmjCxY6McRAS9Z1byx7Xiv3r
         rmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=60WfrxgVMKQI4zJcrOBqZYpPlE/wCIZ8P+dtpfYXPkI=;
        b=ff/DZVPM9sqLjiZifp3YjOuhYXBtkr/mJHqUzJmChfkY2FQ+EGRvVFX97sEHMMytxY
         V5eL07ZGwiS4T+LX9myQJDl/h+tjoTIC57aOCXD23TEfNols1brmT8f9YQwGda37PErp
         OrHEWzquSywRhPFG9MaSufOVjLM+N4SJi2HYRocspxbl32hifdvr0g7wflmoAh/4ksM9
         I4wd60lkmg7r32+U9JAeTcfq4GrzfB/faXk+8esb1GQ1uvQBVFL0nyKVF5VkDUofIHv/
         oKsd5idQHgmyQQfrNdfX5QHP3l3gEynzTSo1FWxSTpn4dG05zYliIRxj0oKMHH6GR79f
         CpIg==
X-Gm-Message-State: AOAM5313EXRVdQsnd2j87q0ZCjxoTxF5dN5eryasWk55tcMG9sJOyrE/
        tN2lpFTbf1DlQMPBkmOLqyE=
X-Google-Smtp-Source: ABdhPJzkA8jJy2xMB1ke00Fe2OJZPVG0khdRBVSZDzdbyFv7GWWNj70xhDzGRSPr6OM6yvtknvTleQ==
X-Received: by 2002:a05:6000:1881:b0:1e8:f75c:591d with SMTP id a1-20020a056000188100b001e8f75c591dmr5353507wri.257.1645208200437;
        Fri, 18 Feb 2022 10:16:40 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id b2sm20978639wri.35.2022.02.18.10.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:16:40 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/11] scripts: kernel-doc: Add the basic POD sections
Date:   Fri, 18 Feb 2022 19:16:18 +0100
Message-Id: <20220218181628.1411551-2-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
References: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The NAME section provides the doc title, while SYNOPSIS contains
the basic syntax and usage description, which will be printed
in the help document and in the error output produced on wrong script
usage.

The rationale is to give users simple and succinct enlightment,
at the same time structuring the script internally for the maintainers.

In the synopsis, Rst-only options are grouped around rst, and the rest is
arranged as in the OPTIONS subsections (yet to be translated into POD,
check at the end of the series).

The third of the basic sections, DESCRIPTION, is added separately.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 3106b7536b89..c8fbf1d3d5aa 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -16,6 +16,31 @@ use strict;
 ## This software falls under the GNU General Public License.     ##
 ## Please read the COPYING file for more information             ##
 
+=head1 NAME
+
+kernel-doc - Print formatted kernel documentation to stdout
+
+=head1 SYNOPSIS
+
+ kernel-doc [-h] [-v] [-Werror]
+   [ -man |
+     -rst [-sphinx-version VERSION] [-enable-lineno] |
+     -none
+   ]
+   [
+     -export |
+     -internal |
+     [-function NAME] ... |
+     [-nosymbol NAME] ...
+   ]
+   [-no-doc-sections]
+   [-export-file FILE] ...
+   FILE ...
+
+Run `kernel-doc -h` for details.
+
+=cut
+
 # 18/01/2001 - 	Cleanups
 # 		Functions prototyped as foo(void) same as foo()
 # 		Stop eval'ing where we don't need to.
-- 
2.30.2

