Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6F3505D50
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346833AbiDRRPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243248AbiDRRPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:15:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F9C205C8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:12:24 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c23so12886518plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/2OFYylqasmzeU1qJiJNk2O+Lo1+pTXh0ZD78JfLVrE=;
        b=MkjthCTS9kcaPTZFWJxui77ku3unqDoX/oILr/p2MIjw0eIoAeCtUR9F/fMIi46YtX
         B3Bo8XOIREjzN/H6ev1VqhBfjgDaMDbqVPtJzO6dIlI4Chs3CiDmNJKjJMHX4uQjyNCB
         aJ7gajPvTVZh2zlcfv29FtnLIfVFWyytgO/Ct5zTN75ZxV53rfz1luJTR5U7BXN6W8hq
         fHsCE/V5/pzqqe7KlH98/QKw12ICSn9lBqrw7Zy2yhA4yCGtNAF/3ykk+AWcvgEf1bak
         BT8sMFde+cqTl+F3gUgKolyb4F3HBSCOAfKzEd9MtxS555mKS6UgNudSHpoKEUff9Vg3
         Gn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/2OFYylqasmzeU1qJiJNk2O+Lo1+pTXh0ZD78JfLVrE=;
        b=aOEfXbkx6CxuNPppvB2sj96eUR9JvqYXpsXnTbsPxutTupDqa1a2ev1mmff16D7m1a
         00dIvUOBGyVY9NNS7pTdsTzRJHIgTtV7qGVbSgvoONJccBJyKTA8LyJrtFF+86bonLxF
         juwaxQXQucJkYkiEX7BD2h6rkppqA7DCqU1iKh5YlAIe6nzUEMINtTGFQPG4WXzpZy1Y
         DpZtfLfY6Q+lkENZW10OdsZppYmYX1kizfJpk3HMpOWSmHILzhGcDwsfFXDHYqc1bQpA
         Kl6h2PLRukLfaRMwpJITAuAVMXJVhZ9uaLwpzEUH+NW1Wh4eueSU3grf6tOuxwZmfiZs
         cfFQ==
X-Gm-Message-State: AOAM531CMeWC6md2fWKZpp6FO5pOfYsVt9Eqnwk+LZvKByU2LO5VkELt
        +HqIz1tonSQxfrGBskW6edY=
X-Google-Smtp-Source: ABdhPJyvEUNnOYBPUmU4UaahbmB2x+kDn8Ilu4ZhTISURVk8LRGhq4dNKxcqY+mZVW4/jgfm4CpLhw==
X-Received: by 2002:a17:90b:3508:b0:1cb:8e7d:a63 with SMTP id ls8-20020a17090b350800b001cb8e7d0a63mr19444258pjb.183.1650301944192;
        Mon, 18 Apr 2022 10:12:24 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:3f09:380c:8f11:5a8a])
        by smtp.gmail.com with ESMTPSA id e16-20020a63ee10000000b0039d1c7e80bcsm13637138pgi.75.2022.04.18.10.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:12:22 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/5] xtensa: enable context tracking and VIRT_CPU_ACCOUNTING_GEN
Date:   Mon, 18 Apr 2022 10:12:00 -0700
Message-Id: <20220418171205.2413168-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series adds context tracking on xtensa and enables
HAVE_VIRT_CPU_ACCOUNTING_GEN allowing to build full tickless kernel.

Max Filippov (5):
  xtensa: drop dead code from entry.S
  xtensa: move trace_hardirqs_off call back to entry.S
  xtensa: use abi_* register names in the kernel exit code
  xtensa: enable context tracking
  xtensa: enable HAVE_VIRT_CPU_ACCOUNTING_GEN

 .../time/context-tracking/arch-support.txt    |   2 +-
 .../time/virt-cpuacct/arch-support.txt        |   2 +-
 arch/xtensa/Kconfig                           |   2 +
 arch/xtensa/kernel/entry.S                    | 120 +++++++++---------
 arch/xtensa/kernel/traps.c                    |  11 +-
 5 files changed, 66 insertions(+), 71 deletions(-)

-- 
2.30.2

