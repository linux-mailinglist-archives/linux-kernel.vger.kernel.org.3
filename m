Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174F55ABA33
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 23:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiIBVh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 17:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIBVhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 17:37:54 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7632F4C83
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 14:37:53 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 2-20020a17090a0b8200b001fdb8fd5f29so1537124pjr.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 14:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=7p/pVhO//z9oA0+3ehhWhRYoWNhMazEWabTOfrMwCBI=;
        b=U1FspX5pOwKhMsjcfEYWr4CxrOAVY+erKLliXFVLjDu3sVyCqFx4ZJQODymf1S33Gn
         tYTcl5Z/41D/yViGp4Z/FGV8UcCPsuZyQ3HU6okNj5bU0RIkAdaOeWV8vU1u0doXK+Hx
         GPQ5vZLBwP/M872C1Y7kJQXecwH+Q6Ed2TaMsmNt7Cmgf1Gjlxb5mOW7rWqu7wkCcDsn
         apas//jQRnAZhnowwCsVjjICO8uszZRpBfjaUJTKVCa3wLgSsj3MRi4Egj0oALmkH/6N
         I5XjzJQtvasfatbOdAjMjyGJG+mh5X/SllQ/C4taSBumlS6FFnvYTnUB4oTN2nMai1eq
         0AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=7p/pVhO//z9oA0+3ehhWhRYoWNhMazEWabTOfrMwCBI=;
        b=drI99TU9uDscGDwZRu2ojnKQLxVgrUHISjiXL8ohG9fIqAcWsBru/WEmYIhixLOiEU
         yKTaXbqseUpGo1tQeqF3abHeFW20S8atwCOc7t+GWhSWqh2N5sDUUBQx2ueWFk6kntoh
         O2q1j1LSqIiPPzC33BgkYY45T9kK13jrIjqA0T2IVkbeNOeOAgwlpLJylBnu2Mv6TTLh
         pgH6/lpTYu/3pJvYg0fe9US4dc9RDyKayxLASdF4xmcqqnY9dG5zvO8RS7A69QzxqBO0
         1hZkVniUTuvFlg3NT2G416OtkbvxTZJhN9eaJyyORLB3DijSytyDFh3Dq0SRz6JlrDH1
         iZUQ==
X-Gm-Message-State: ACgBeo3w+XrhiZtSNECA5LzR6QvTnFH6UCf+Bqzgld6UmA2Wfhxt1kuv
        9cYE8xR5gl8LchR1LX3IWBTd7HIG
X-Google-Smtp-Source: AA6agR5XXMHOWPNcXrKkV85Ex9fZaKzKDDVsBUrKQW3EtDnjJ5uOdx4Ej5tXEX0NodrvKRD2/dRbCj7bsw==
X-Received: from fawn.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5795])
 (user=morbo job=sendgmr) by 2002:a17:902:b68f:b0:173:188f:5fa1 with SMTP id
 c15-20020a170902b68f00b00173188f5fa1mr36541046pls.155.1662154673445; Fri, 02
 Sep 2022 14:37:53 -0700 (PDT)
Date:   Fri,  2 Sep 2022 21:37:48 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220902213750.1124421-1-morbo@google.com>
Subject: [PATCH 0/2] fix clobbers list with ZERO_CALL_USED_REGS feature
From:   Bill Wendling <morbo@google.com>
To:     Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Cc:     Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ZERO_CALL_USED_REGS feature may zero out callee-saved registers. This needs
to be properly modeled by things like code alternatives. Otherwise, it's
possible that a callee-saved register would be expected to remain unchanged
past an ASM statement when in reality it isn't.

Bill Wendling (2):
  x86/paravirt: clean up typos and grammaros
  x86/paravirt: add extra clobbers with ZERO_CALL_USED_REGS enabled

 arch/x86/include/asm/paravirt_types.h | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

-- 
2.37.2.789.g6183377224-goog

