Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1620472815
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242734AbhLMKH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241297AbhLMKDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:03:17 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D55C09CE4B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:50:05 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y13so49646375edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SNaPD4txBcBTeRtU9QDE/cr6Tf7raUPC4eWzWstn6dU=;
        b=GwnXUEDrN8geUjFIGzsJwTqnanWjeb/bQWJ3DW7YY2Nv1rJBf6GDN0lXTjB2L8SvQr
         +FsPYSKscIPv0XTCahi/82xay8tgJl2WcronvJ8WeG5lN0ek9Fd40a+m0h5PsX789flN
         oceT5oFlEP2xyT4DUtqjAcEgR3iN2mzagSztkIkSi0P/ZI0kuW3vJLMZZS685WzjogeU
         ocdnYr5lcEVtcOKFC6LkWlX9VTeh+uV27u6b6BacH3PBvLd6YKagLSNKoNlcSJ34ytRS
         Q/pDhNyphFK2ngM6pjq/1XDUlY0z5sbOL7EmK7y4H+h2mpbgnmwwn/MzafKl5EbATmdB
         KD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SNaPD4txBcBTeRtU9QDE/cr6Tf7raUPC4eWzWstn6dU=;
        b=FX6drjcq4/UCulgqTb6erNyUhiR1rCn/hy/g6cg7L934ZMeFowzqmKzYxW3WgGf0Us
         F69d1Emo/uUM3Z1mfSg7CBuoD+rPJeBDzFqObnc9vosNxz0TJp0hc5f/RrV0hQgeaObe
         QxBToBiF9hX2XL/bQRs4jMYvxUSV75iM+ITWExBGCgg81F9hd5MjTWbQzXxQwoY4zx5u
         AEPjvMu/x98NjNlu/JZTH9QW6RmLzWsNQSyrOsyb5vsWt/AmuqqPL48LqGxZVWRCWUfH
         fMCSLVxoSIVs19zLERZUW+kX71UjAFSWXxo6C9L9DomNrCD3vw79drGJioExPPLVoDLS
         Dv9Q==
X-Gm-Message-State: AOAM531pzJVBeKcJ8kicY9v49wlHqNqfv3fT45A7a4Hv+phw4k9xMDmk
        uBfMpG7fbfy6EIJ1QI4Ae/8=
X-Google-Smtp-Source: ABdhPJyHDOAWR44PF/QZ7CDFmnTpRb4Dbt3Ln1Tb2dy3NHTsubJNt+EVgI8mlcFUYkuDZnE/EJFfyA==
X-Received: by 2002:a05:6402:84f:: with SMTP id b15mr57572835edz.342.1639389003992;
        Mon, 13 Dec 2021 01:50:03 -0800 (PST)
Received: from oberon.zico.biz.zico.biz ([83.222.187.186])
        by smtp.gmail.com with ESMTPSA id qb21sm5789774ejc.78.2021.12.13.01.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 01:50:03 -0800 (PST)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] tracing: Introduce configurable ring sub buffer size
Date:   Mon, 13 Dec 2021 11:49:57 +0200
Message-Id: <20211213095002.62110-1-tz.stoyanov@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tstoyanov@vmware.com>

Currently the size of one sub buffer page is global for all buffers and it
is hard coded to one system page. The patch set introduces configurable
ring buffer sub page size, per ring buffer. A new user space interface is
introduced, which allows to change the sub page size of the ftrace buffer, per
ftrace instance.

[Resend to LKML]

v4 changes:
 - Do not change the sub buffer size of the temp event buffer per CPU,
   trace_buffered_event. That size if fixed to one system page.
v3 changes:
 - Fixed ring buffer readers and writers to work with custom sub buffer page
   size.
v2 changes:
 - Split code refactoring in a separate patch.
 - Changed the logic to work with order of system pages, instead of page
   size.
 - Fix freeing of the allocated pages, to take into account the actual order.
 - Code clean ups.
 - Bug fixes.

Tzvetomir Stoyanov (VMware) (5):
  [RFC] tracing: Refactor ring buffer implementation
  [RFC] tracing: Page size per ring buffer
  [RFC] tracing: Add interface for configuring trace sub buffer size
  [RFC] tracing: Set new size of the ring buffer sub page
  [RFC] tracing: Read and write to ring buffers with custom sub buffer
    size

 include/linux/ring_buffer.h          |  17 +-
 kernel/trace/ring_buffer.c           | 345 ++++++++++++++++++++-------
 kernel/trace/ring_buffer_benchmark.c |  10 +-
 kernel/trace/trace.c                 |  84 +++++--
 kernel/trace/trace.h                 |   1 +
 kernel/trace/trace_events.c          |  50 +++-
 6 files changed, 392 insertions(+), 115 deletions(-)

-- 
2.31.1

