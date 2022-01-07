Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA74A4871DF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 05:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346098AbiAGEuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 23:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiAGEuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 23:50:04 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EB0C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 20:50:04 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c2so4248449pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 20:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LzthDVvjl7CF9H/T+a2owIZwZe6ZrsxG3BiFqGON8zI=;
        b=JL3dbmR0d8uTgeJx5D6hg0bTVHJj1PI9L9Cd+uexOXyeO97lJYkyIcST/HTpNTx32b
         W9Yv2GZlyXcB+OOeBYLgkEZi6odlR2RwAWpf4cjx527yTevXyn/ylnbV0NF+0phU0gr8
         05fq0l0pDl9DiuoIAPjsSSzKtwXuuSOiPgQh4G8J6x8bvrtTBxpxFPdll3/bnT4SDrHV
         o3FAvzvpo5qjOp5WY3P1V2FpAcBBGfaMGyhfDp4fdI2yh/bP3Jn+4BnzI/gl3RutMXMN
         Cnu79Vg4LjutMxy8w/Ghg4fcK7pxk/rX/+hH2nvJ++GB84cHKXLs9T2cYrX1N5VAGNVH
         PiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LzthDVvjl7CF9H/T+a2owIZwZe6ZrsxG3BiFqGON8zI=;
        b=QGE6kpB2tYF9IKY22qznHzKaQ0QjRKkNmdof2Xb9XVn1Jv3C6ZkkLWOmaBwLzLSn8y
         WVUezqL9JC+WHOsxqKpEb04JwhMEXFnM0/kUBV+WM7g0i7ZontFusCf1UPDxlzmYRZ9s
         ld4xi1zhOCp9WMjghYrfqdmGGEKHqC4lr2M1+ZQpekEXx62jMuxKzpcugOQHybJPYQUQ
         AIm1tfz/hkqV6/BM6+at4JF6kQJRZnoBg++kT84S1JVNdGAwt2KGIuUHdb1UmMSURC9X
         RppIL4WqZZn8QqXltVTWGJem0IbhZdoIzBqM0ZeIlMaOcnvp2D9Ja0NCnfK4mgNfdVsc
         Wpyw==
X-Gm-Message-State: AOAM531lr38gQ9Rx0T1FnsSrTskgPXM/a3qvylDGMRmOQIQC2/+dFBgf
        u/O5bt2Oz8hzSeMGKv0BLT/1aohM9Q==
X-Google-Smtp-Source: ABdhPJxjxYVyFSMiOzMX46H8fgjmE3va2E290zYCW7h1PO7RjWVAECuGhl5qlIstgd1koY4tyS6rTw==
X-Received: by 2002:a05:6a00:2316:b0:4bb:231c:1b92 with SMTP id h22-20020a056a00231600b004bb231c1b92mr63125675pfh.27.1641531003947;
        Thu, 06 Jan 2022 20:50:03 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id lp6sm8456115pjb.55.2022.01.06.20.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 20:50:03 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 0/3] tracing/filter: make filter_pred_pchar() survive the access to user space
Date:   Fri,  7 Jan 2022 12:49:48 +0800
Message-Id: <20220107044951.22080-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When
  echo "filename ~ \"cpu\"" > events/syscalls/sys_enter_openat/filter
  echo 1 > events/syscalls/sys_enter_at/enable
    
The kernel will run into a #PF (see [3/3].
This series resorts to copy_from_user() to cope with the access to user
space.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
To: linux-kernel@vger.kernel.org


Pingfan Liu (3):
  tracing/filter: degrade addr in filter_pred_string() from double
    pointer to pointer
  tracing/filter: harden the prototype of predicate_parse()
  tracing/filter: make filter_pred_pchar() survive the access to user
    space

 kernel/trace/trace.h               |  1 +
 kernel/trace/trace_events_filter.c | 38 ++++++++++++++++++++++++------
 2 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.31.1

