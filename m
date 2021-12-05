Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD9A468E14
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 00:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbhLEXYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 18:24:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238369AbhLEXYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 18:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638746440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hK0QBS87o0g6GNYF9ivg//RsE+IVbpD3iv/yoRCRKJU=;
        b=WcIzipCui0bzzNjzFOYl0lqPq4C8DSOWY50F7nTnPx3ROylxyr2sA+c4d1TwZX8QuWuvGN
        dZPJDGYSwYfe7C3243cIT79LMGd6ak3tPJa+c2P1Tagw7P76a0iEmX+vQDqMqIGLk3Tynn
        D0rWieAdkZwm+V+/ssCldLrb0JJmF8U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-3atOh0slM1i0cl0hEHskzA-1; Sun, 05 Dec 2021 18:20:39 -0500
X-MC-Unique: 3atOh0slM1i0cl0hEHskzA-1
Received: by mail-ed1-f71.google.com with SMTP id n11-20020aa7c68b000000b003e7d68e9874so6792148edq.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 15:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hK0QBS87o0g6GNYF9ivg//RsE+IVbpD3iv/yoRCRKJU=;
        b=unuUG0lK80/WYwyofipIiQCBrMvo082tzosD9lLoLr6/dKXZfY4a8+3fvFekbWdsKX
         hsxo49eAgmvHz4QwE919PXTw4exJWBadd3vsJmrm7m91nmSCjUH+zDysyMPGrArK0o/Z
         lBK8q1+C1XDeD5IShldvrS5F+2DOjmHmshX6rSuc+40GUY00zRUgOPdXhOtZoZ89couG
         tqiB1oS3Rp8Pj/rtsMnIw9N3ePDRsH/jwB9FiD1aKe6E8eM11OesweI1AscuyIHHar5d
         8TzRlrv7QhdY724S/W885xJhWHfIe3M6/FhjXZ5/Ql/vNbEJdIC8MKsiGTYN/KqcGWyH
         PBBg==
X-Gm-Message-State: AOAM53193k6jq8/4Z3GJtrtDLvsif8a3DaRT0lVP3MDY3Q1Q+Xk1iHrM
        JiDNRKnwOHCfpWjPFNOCMohGsAreQKUWbIPZDsCH8/kwsouMwW5bDfJVYowE7BXBA543diGF+bs
        5YAQwCdWCDYFwQKpTSEYEGuuZ
X-Received: by 2002:aa7:d051:: with SMTP id n17mr50047118edo.79.1638746438229;
        Sun, 05 Dec 2021 15:20:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0WJzlZ4nCPh81JpGU8R5ec3yvqmlr00Mdw/zRKlg+P9OZGjRYDZj7uokNfQ72sk3+xAarsw==
X-Received: by 2002:aa7:d051:: with SMTP id n17mr50047092edo.79.1638746438079;
        Sun, 05 Dec 2021 15:20:38 -0800 (PST)
Received: from krava.redhat.com ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id e4sm6002054ejs.13.2021.12.05.15.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 15:20:37 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 0/3] ftrace: Add ftrace-direct-multi-modify sample module
Date:   Mon,  6 Dec 2021 00:20:33 +0100
Message-Id: <20211205232036.51996-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
this patchset adds ftrace-direct-multi-modify.ko kernel module
that shows the usage of modify_ftrace_direct_multi API. Plus
two additional small fixes for ftrace direct code.

thanks,
jirka


---
Jiri Olsa (3):
      ftrace: Use direct_ops hash in unregister_ftrace_direct
      ftrace: Add cleanup to unregister_ftrace_direct_multi
      ftrace/samples: Add module to test multi direct modify interface

 kernel/trace/ftrace.c                       |   8 +++++++-
 samples/Kconfig                             |   8 ++++++++
 samples/ftrace/Makefile                     |   1 +
 samples/ftrace/ftrace-direct-multi-modify.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 samples/ftrace/ftrace-direct-multi-modify.c

