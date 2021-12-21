Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A4B47C498
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhLUREH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhLUREG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:04:06 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2343C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:04:05 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id v190-20020a1cacc7000000b003456d598510so1522447wme.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5MCgdl+g0Q4ZtcQEoUIl/+nsdYtAzp+QkVH77bfwlh8=;
        b=ZnB62cmmp3Ga6E/YXGUSCpVYWJloDLQhi8e+P4UifTKNoC9UANpHEHtaRqKLg/ey4d
         2lOysISLdsELD1yXCIM4XwkWBzmDuloeTW5SBELgvLGF/8A+nxaGBKvoSv5+dgiLU0+b
         SjZWcQFh/yY1nFKr/cbab+5G+GZNWKXtbwBj9dCOjJwuGJYa9NLEag8NM43/LKLL5eFq
         MvyfAQZeiPH+Dfjz3pZc/ORzaLVlCrtz6+U9GRk0MNvPlpPut5hQ0Mlo342w+DjuygQF
         wwDhRXqEo61QM3zm9GPYPpSQodsr2gfN80QCHPwHZqZcdA6GL+VqaKtxvddkg35fQco7
         +LuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5MCgdl+g0Q4ZtcQEoUIl/+nsdYtAzp+QkVH77bfwlh8=;
        b=jkg4e1p8ra3/vTb+6Gxif8p0Y0QRbeBZ7+m1cM55/JGbl1FXSAJ5Z/2/czh0L9EtGn
         haxRgfgKYi53Uo7IQuBMxGw4cSz57wuSxwag2D9q0Wb5d/y0FEBylEj7g0SKH9lc44L6
         A3T/w6pli6wGIunjW5VnqHvFMpo/sNko022Qi7gJ9f9vAkbz2nS7uZyMLM4jjn3n4dA2
         Ln5BX+B7kZ+njWbb/5RDbMoveQ7RBXRE38T6p3KMAMR/myporcaC7kMUntQtz4+25fQL
         7QhRgnLKkN2IjewME7KLPDOVR4Ou629n5VgHHIxfLSLLa+QhiZI10DwMzbtI0D1sMBjF
         ELrw==
X-Gm-Message-State: AOAM5314RHSKxbtg3lDjOLSUDVD01hzXwD6Se3kU5TGmMWBWf9go2i96
        VwW7R+iXTfYngW/5+f42zenHIFZffMY=
X-Google-Smtp-Source: ABdhPJwY8NDgnXLwlYr81ZBG6T1EzLeME2JSgijK/EDXjzqIVClEx+3KQLv6mWb8I53IeNdnwCL+zzOLMIs=
X-Received: from nogikh-hp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:200d])
 (user=nogikh job=sendgmr) by 2002:a7b:ce83:: with SMTP id q3mr3537858wmj.37.1640106244487;
 Tue, 21 Dec 2021 09:04:04 -0800 (PST)
Date:   Tue, 21 Dec 2021 17:03:46 +0000
Message-Id: <20211221170348.1113266-1-nogikh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 0/2] kcov: improve mmap processing
From:   Aleksandr Nogikh <nogikh@google.com>
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     dvyukov@google.com, andreyknvl@gmail.com, elver@google.com,
        glider@google.com, tarasmadan@google.com, bigeasy@linutronix.de,
        nogikh@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subsequent mmaps of the same kcov descriptor currently do not update the
virtual memory of the task and yet return 0 (success). This is
counter-intuitive and may lead to unexpected memory access errors.

Also, this unnecessarily limits the functionality of kcov to only the
simplest usage scenarios. Kcov instances are effectively forever attached
to their first address spaces and it becomes impossible to e.g. reuse the
same kcov handle in forked child processes without mmapping the memory
first. This is exactly what we tried to do in syzkaller and
inadvertently came upon this behavior.

This patch series addresses the problem described above.

v1 of the patch:
https://lore.kernel.org/lkml/20211220152153.910990-1-nogikh@google.com/

Changes from v1:
- Split into 2 commits.
- Minor coding style changes.

Aleksandr Nogikh (2):
  kcov: split ioctl handling into locked and unlocked parts
  kcov: properly handle subsequent mmap calls

 kernel/kcov.c | 99 +++++++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 42 deletions(-)

-- 
2.34.1.307.g9b7440fafd-goog

