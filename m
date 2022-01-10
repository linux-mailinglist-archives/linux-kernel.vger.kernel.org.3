Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A36489FFC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243461AbiAJTOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiAJTOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:14:18 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBE4C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:14:18 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m4so16181203edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Gmfudw3uNaW8dG/Cr0qfZDjHjV8tFqTV080WA3cJIt8=;
        b=CgrCwN4hy9zkE/qqIB590Sz3q3LbhyPVUe6gj9Dw1poqFuWiO9pdXVpyOHbGIrGxl4
         p6A1QQhY6BGdFsi1cvw/MCiu/r4Np/hu7Td6HLqdx7BUZxB82Hnl/XIRPHg6HKmwAiXt
         ak1LbCx6Iy3bbiDKY4++abKCdemFDwBCiJw2gtnLY1g1HB86sWdRgvpEUWV/oSTpCenQ
         DXJKmAsweC7I2ieJe/GKSb60jEmOOVZet4ctSVeqYi680T/A601f1jlCH7d1NYK6DxDa
         WnlmwqFKEudylN/eZWntRLDWiGzPO/HtPtfGoF5o6E0vILmDp4Ic2CqyLkHdPVa57/56
         1Cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Gmfudw3uNaW8dG/Cr0qfZDjHjV8tFqTV080WA3cJIt8=;
        b=5xCMfSEpBfJMZLTY1G7VSd8LbOjGCj9F+Wfea5DuL1psoJPqVUy58gjhU05goWKP57
         nEIP4fmV8kiArW4uXQh15xK5L2ffLO49I6qIqEVMWS6Su43prNbMsPwU+74l6SI7ny8/
         E+1bUldIyHNw4+Zg8xaDx/xpTNf9/Aby0KRHoDJsuUIarE153xhYuggXqPxY7bGkdqsM
         FdLnbcoQthLhu+Dqe3Dczzk3ZP3oCGxB9YBGJAWeCCrcNPwtGkpWuUIePnCZoP6dEY5K
         Tkxlr/FSPaIpQ8+wDS93GA1AOwiJs+DtpsonNFOS7IBDRB1/k32G4eIwn1jMH01jXdtB
         7ZXA==
X-Gm-Message-State: AOAM531NGOP+tETGeLQnRsZj9ELL2E3m6UZA8PXCShQeFlviaB1kCCis
        ZXG/JAkClpOFo0Wh5hgVvHrhvkot8FZxFtzQy0iA
X-Google-Smtp-Source: ABdhPJzSLV9R46iM0971tYMcAo81BFrStQNbtK/d+YbwlkqH6Oh5Wbm6L2ZJN0XhTpf7XRwO3x1kraxygiXkn4oj014=
X-Received: by 2002:a05:6402:3584:: with SMTP id y4mr1061714edc.232.1641842056945;
 Mon, 10 Jan 2022 11:14:16 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Jan 2022 14:14:05 -0500
Message-ID: <CAHC9VhTNyMFo6PW0FQKy6hTiVug-9ACQWazj0AJcih9YN2Sbyg@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v5.17
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Four audit patches for v5.17:

- Hardened the code through additional use of the struct_size() macro
and zero-length arrays to flexible-array conversions.
- Ensure that processes which generate userspace audit records are not
exempt from the kernel's audit throttling when the audit queues are
being overrun.

Please merge.

-Paul

--
The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

 Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20220110

for you to fetch changes up to ed98ea2128b6fd83bce13716edf8f5fe6c47f574:

 audit: replace zero-length array with flexible-array member
   (2021-12-20 14:53:27 -0500)

----------------------------------------------------------------
audit/stable-5.17 PR 20220110

----------------------------------------------------------------
Paul Moore (1):
     audit: ensure userspace is penalized the same as the kernel when under
            pressure

Xiu Jianfeng (3):
     audit: use struct_size() helper in kmalloc()
     audit: use struct_size() helper in audit_[send|make]_reply()
     audit: replace zero-length array with flexible-array member

include/uapi/linux/audit.h |  2 +-
kernel/audit.c             | 22 +++++++++++++++++++---
kernel/audit_tree.c        |  2 +-
kernel/auditfilter.c       |  4 ++--
4 files changed, 23 insertions(+), 7 deletions(-)

--
paul moore
www.paul-moore.com
