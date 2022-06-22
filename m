Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139E05550E8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiFVQKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359220AbiFVQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:10:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAE33C71A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:10:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 66ACA21B8F;
        Wed, 22 Jun 2022 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655914251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dLNCSuzgjE1irfejW+XQU6PJClEFaQlN1EssbDqEWZE=;
        b=ddEJwwo53MebTNELEsUYrQtqkyRVDUa9qirmRSQ4fMI0zQojNEw4VWpDeZecZb11hNRvVz
        szP8D2+RV5mAugoe6drgBCliA41Ra1zyUftEEF/LYW/i4DzLfS4ALbuxif7BKRZDyEAV/S
        QNKJCamoAb+V8Y0uQ/67w9VaTL3WuBU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1187E134A9;
        Wed, 22 Jun 2022 16:10:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FVLyAgs/s2JzCwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 22 Jun 2022 16:10:51 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 0/2] x86: fix brk area initialization
Date:   Wed, 22 Jun 2022 18:10:46 +0200
Message-Id: <20220622161048.4483-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The brk area needs to be zeroed initially, like the .bss section.

Juergen Gross (2):
  x86/xen: use clear_bss() for Xen PV guests
  x86: fix setup of brk area

 arch/x86/include/asm/setup.h |  3 +++
 arch/x86/kernel/head64.c     |  4 +++-
 arch/x86/xen/enlighten_pv.c  |  8 ++++++--
 arch/x86/xen/xen-head.S      | 10 +---------
 4 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.35.3

