Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278E748F6BE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 13:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiAOM1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 07:27:03 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47508
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230457AbiAOM1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 07:27:02 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CFC5240033
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 12:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642249615;
        bh=UFY9nLmKMUjd2UvRZj5axFl/Fd7RYltbOVlAdEkhte4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=LkH7crKZUsCP1XtREfjJg6t5kyNpPqC6YEku8gWKC/XKCtvdWf88T6+2rkgomCNav
         nshayslL1ZEhk4z/ElBZf0EwqgScvTC93H4yQcGmOu/F7RuhQhzCtVNo0cp1Szss9y
         oGe8wizDnJUvnvBJaf4FhxcJlLH4pyxa5D/zy+26rQKPxkkguSslQFfWFjx0QHWq1u
         d2BoipqZwkhhXTQRcs0Xdr80tFXZcB/PM3GIvMjcI9H2dP0oavhMZ2c+AAsa46IIqe
         AKr7S0TTbMHTjGPg0IrCCfWdR41G5u0fattRof0/HKYfrOEfXKRdxq0LNp7LVaf8IN
         MCR1HuRjdrbCw==
Received: by mail-wm1-f71.google.com with SMTP id p14-20020a1c544e000000b003490705086bso3429262wmi.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 04:26:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UFY9nLmKMUjd2UvRZj5axFl/Fd7RYltbOVlAdEkhte4=;
        b=rCGcJ15X78oEsP8ywo+WLLpIj4nd6V08pVItqIL5+qPRBvyoq+oEiOcTV87hHW4/Pc
         2cEDF+i/1+Va2/fR6Pxhbg8vw9ezhfxejuzTnJy2RK/i9ZGTT84X4O9dl/FLXQgj23wc
         S8vzZc9t+CgDU/J7ImN0Yz2AKpdgyfDL7w+ZQGs6WKAdweIuozn64YLV4TBX3+Eb8+cZ
         WM/yAd2xQDIkJ3xApc+QeiKbe3RM7ep+awNUDAevN93lSoJZBDBns9JqB95VBU8M3XsU
         eC2YNWo8DT/18DQKBjWrTlhTSCGahUbxkumiQrzH7b1SvSuCCxj0E5In4F7VvTyoDbh6
         cGoQ==
X-Gm-Message-State: AOAM5304dl6iiFdz0wS+YxKC6ga4ZzbgKeyEuDCNirdW2KIrkSMZ1kDS
        uZuH4511R5wBGfpuerKPBxBPWsxRVBM8Roc4TTKT1KeGaj22d/fVzMPwqwdYa7vB/xZ71cGp0V2
        NoeKKbQRZlyNodHCk3oFSVnYY2rafb+HG7RPEYic5dA==
X-Received: by 2002:a5d:4301:: with SMTP id h1mr11658534wrq.511.1642249615291;
        Sat, 15 Jan 2022 04:26:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJJMFuj6liqoHgnsPIf4U94AbLpvbnNxrsqihhJ6QYj/aeAzghUu50bJ5RARQmO3BhD+yWuQ==
X-Received: by 2002:a5d:4301:: with SMTP id h1mr11658524wrq.511.1642249615073;
        Sat, 15 Jan 2022 04:26:55 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bk17sm7878476wrb.105.2022.01.15.04.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 04:26:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] nfc: llcp: fix and improvements
Date:   Sat, 15 Jan 2022 13:26:43 +0100
Message-Id: <20220115122650.128182-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch #1:
=========
Syzbot reported an easily reproducible NULL pointer dereference which I was
struggling to analyze:
https://syzkaller.appspot.com/bug?extid=7f23bcddf626e0593a39

Although direct fix is obvious, I could not actually find the exact race
condition scenario leading to it.  The patch fixes the issue - at least under
my QEMU - however all this code looks racy, so I have a feeling I am plumbing
one leak without fixing root cause.

Therefore I would appreciate some more thoughts on first commit.

The rest of patches:
====================
These are improvements, rebased on top of #1, although should be independent.
They do not fix any experienced issue, just look correct to me from the code
point of view.

Testing
=======
Under QEMU only. The NFC/LLCP code was not really tested on a device.

Best regards,
Krzysztof

Krzysztof Kozlowski (7):
  nfc: llcp: fix NULL error pointer dereference on sendmsg() after
    failed bind()
  nfc: llcp: nullify llcp_sock->dev on connect() error paths
  nfc: llcp: simplify llcp_sock_connect() error paths
  nfc: llcp: use centralized exiting of bind on errors
  nfc: llcp: use test_bit()
  nfc: llcp: protect nfc_llcp_sock_unlink() calls
  nfc: llcp: Revert "NFC: Keep socket alive until the DISC PDU is
    actually sent"

 net/nfc/llcp.h      |  1 -
 net/nfc/llcp_core.c |  9 +-------
 net/nfc/llcp_sock.c | 54 ++++++++++++++++++++++++---------------------
 3 files changed, 30 insertions(+), 34 deletions(-)

-- 
2.32.0

