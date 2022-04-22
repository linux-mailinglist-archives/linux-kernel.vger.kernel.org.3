Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642BA50AFE6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbiDVGET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiDVGER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:04:17 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D517A4F9FE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:01:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s14so8607018plk.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qV9vbQDU/KegsjTpwvOeQzuPHBDHRU9NkTUmfe4BtOM=;
        b=E60OpJIMR6X62J2F5nuw4yDNTkHOyZ11wmmlaC8a/PdQ0v3AAPFzAH9i1m0KF1SP89
         0skofww5qoUW+zR4z4qwD+L/8j5AbYclkfQ3R5krfJeHrFOZMg/Dml0zgwxT7bX9ulb0
         UpBP5ScMBSNmGTr+2uFkqVDLtgYkqujeqUm7mIy96UtD1dsnNbw/zOUhD0SQKyFMkCEy
         ZIqWVVVOfKeOpgBY89enYHG38qzTkHEMdF5GRIns8aD2OYZBzumySwlFsXEzNUfuDa6D
         CJdkr3a7LGC340qbJ4/U+N7n+GSy0G1yTRH78bZTVnd/QJvTteuRxzludieLme4ziMu5
         r72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qV9vbQDU/KegsjTpwvOeQzuPHBDHRU9NkTUmfe4BtOM=;
        b=MLNbkIugSzE2iLK3AxXq1L7UASNeq80idoJbe8QrbsNKKnOB7rAGu2gCzK4B1G/Zp9
         z0AnMlRKTa34Gv+4b9z9hwC1I0EkkFBy98T8H4QwgiOKJwqdOSIrdNw6+ZZtxir1kPgp
         tj9gJ2RI/4litZE5JakpqkYif3BCRBn5paBNeKhSM+qxwP+sg9NsAg1hzgK+zaAuhz66
         qVW1sdR+i1aQNYk7CGvEfsH+h8h4m4Nmf0Pcpx6fU4alp6O48ZYlircWZGlV6pRuzJG4
         qz2oPF040OO1zLVKq9MbUmCj9ad86BwOXcnSZVa+3E1DiEdKR7HO9yOPRrsA3WhlhEaa
         cfOg==
X-Gm-Message-State: AOAM533eoKxA/B6Guuwk/jjXqlDnLbeXVNzzZdzNZmatyUUufOksN+lX
        KT+D3xUvAtvfr+aoF949XgU=
X-Google-Smtp-Source: ABdhPJxmHc2+7DensBM27RMw0lX++k/HB+Saw3G963hFQN+fDA/0+8ohL5KesEMbM9hgjOMRFEJ1Yg==
X-Received: by 2002:a17:90a:178e:b0:1d2:e998:85e1 with SMTP id q14-20020a17090a178e00b001d2e99885e1mr14342960pja.234.1650607278946;
        Thu, 21 Apr 2022 23:01:18 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-116-20.tpgi.com.au. [193.116.116.20])
        by smtp.gmail.com with ESMTPSA id y16-20020a637d10000000b00381268f2c6fsm998607pgc.4.2022.04.21.23.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 23:01:18 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Song Liu <songliubraving@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 0/2] Request to test fix for "x86/Kconfig: select HAVE_ARCH_HUGE_VMALLOC with HAVE_ARCH_HUGE_VMAP)"
Date:   Fri, 22 Apr 2022 16:01:04 +1000
Message-Id: <20220422060107.781512-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

If it's not too much trouble would you be able to run your test case
https://lore.kernel.org/all/14444103-d51b-0fb3-ee63-c3f182f0b546@molgen.mpg.de/
on upstream tree plus these two patches to see if any errors persist?

To be clear, you shouldn't see such issues with upstream now, but I
would like to see if they are solved with this fix when we re-enable
huge vmalloc for drivers.

Thanks,
Nick

Nicholas Piggin (2):
  mm/vmalloc: huge vmalloc backing pages should be split rather than
    compound
  Revert "vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLOW_HUGE_VMAP"

 arch/Kconfig                 |  6 ++--
 arch/powerpc/kernel/module.c |  2 +-
 arch/s390/kvm/pv.c           |  7 ++++-
 include/linux/vmalloc.h      |  4 +--
 mm/vmalloc.c                 | 53 +++++++++++++++++++-----------------
 5 files changed, 41 insertions(+), 31 deletions(-)

-- 
2.35.1

