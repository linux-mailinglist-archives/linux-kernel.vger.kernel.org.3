Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CC4519E88
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348979AbiEDLyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiEDLy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:54:29 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4207F21E37
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 04:50:51 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id a22so724985qkl.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 04:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=N0qLrMUdkmKBPfEziSX/hNCjhprklRfQLQvu1qWvrOo=;
        b=iUmsmI1WPaZ54LUDWEqIywg7fvqroLNmgjvybdiVRqPyfsMUOuBWQT0+S8RWPgcmBN
         +sqcSzJZuWhbx/U6T+e96xXMGNTF7ubkK5xelVEe040su7wFbYo9NJMxtP6NYcPT/8Fz
         oPd6XKBGMGkobGVScnwvq+g6OmxxrvfpkSDTCbZLRhLeEACHVfOQRvImSgfXhO8KyufY
         ENMZvDvoeJXtisCOLFTxOMXSUmzbgS+aAwDr42H++7qEZrsQK7ZzFO2MI9WNUTa8S1sU
         gVymct8fIfOIPncDv1Cbzl9tQJZVMiEU/xpRPmG5Y66m0w++ZcRXA7UecQELGsriVXU1
         mb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition;
        bh=N0qLrMUdkmKBPfEziSX/hNCjhprklRfQLQvu1qWvrOo=;
        b=zwlHDlH2C+eG2U0a5TAZ8m6bYiDRRpdJ3IhdyGummovO2I25gyM/st+lk0PBx77rrq
         0cfOFqZWnZtSeVf5EV21Q7J6YTdFWU/RhEtYxtNpy/KS9LJrJoLwe3X/qfGcJ9MNcjGS
         FrFCbiadX211/b2/iQQp6Jz1amP7wAwilvuFRedXVIBdV5dVMxQId0bLJYGPvT0qhzhu
         U+2XrMYAtA7r0A+Qo1qGigHCBiCjmxAZ+eSOYeQ38O0eviB7AZd2Jrgclx669Nw2Bo/B
         nH304Gz8HfaW3In3N+kMoNtJeDYvjiRhBl0p1sQkrtsNTk0tvR+nctebQu3pp09BnHf6
         w1hA==
X-Gm-Message-State: AOAM532y3/ylGX+IZiS7NXQKuFCJuvV4IGQ6vAppxNMsbUVEhJVb2GOU
        A7tARybOH6gYD504rwqiEQ==
X-Google-Smtp-Source: ABdhPJy1syGyi7DFFq9iQSqT+hdshiI7n/y8gA/XAUshBDHkdBYidKapwbKZ4B8B4Pt/jmtVjRILZQ==
X-Received: by 2002:a05:620a:24c5:b0:69e:e777:4323 with SMTP id m5-20020a05620a24c500b0069ee7774323mr15575616qkn.465.1651665050240;
        Wed, 04 May 2022 04:50:50 -0700 (PDT)
Received: from serve.minyard.net ([47.184.144.75])
        by smtp.gmail.com with ESMTPSA id t11-20020a05620a004b00b0069fc13ce231sm7206864qkt.98.2022.05.04.04.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 04:50:49 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:149c:2dc6:c0ab:4341])
        by serve.minyard.net (Postfix) with ESMTPSA id 6F3511800BD;
        Wed,  4 May 2022 11:50:48 +0000 (UTC)
Date:   Wed, 4 May 2022 06:50:47 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 5.17 (second set)
Message-ID: <20220504115047.GC3767252@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ae085d7f9365de7da27ab5c0d16b12d51ea7fca9:

  mm: kfence: fix missing objcg housekeeping for SLAB (2022-03-27 18:47:00 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.17-2

for you to fetch changes up to 9cc3aac42566a0021e0ab7c4e9b31667ad75b1e3:

  ipmi:ipmi_ipmb: Fix null-ptr-deref in ipmi_unregister_smi() (2022-04-29 10:06:52 -0500)

----------------------------------------------------------------
Fix some issues that were reported

This has been in for-next for a bit (longer than the times would
indicate, I had to rebase to add some text to the headers) and these are
fixes that need to go in.

----------------------------------------------------------------
Corey Minyard (2):
      ipmi: When handling send message responses, don't process the message
      ipmi:ipmi_ipmb: Fix null-ptr-deref in ipmi_unregister_smi()

 drivers/char/ipmi/ipmi_msghandler.c | 7 ++++++-
 drivers/char/ipmi/ipmi_si_intf.c    | 5 +----
 2 files changed, 7 insertions(+), 5 deletions(-)
