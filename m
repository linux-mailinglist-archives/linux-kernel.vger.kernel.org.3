Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4956A561310
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiF3HOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiF3HOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:14:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841081A065
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:14:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3549C1F910;
        Thu, 30 Jun 2022 07:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656573284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=w8JobtSvpzNoUpwJIImS2sf/s9H6qdugYtbCVXRzcT0=;
        b=JFb6EH83ripqdvoD961Q5CiVgMh8sDno1KZ5b6pIW5+KAGWd8xoxWWwBT1Of6BlatnmRl4
        vBiV4qmXv1K8NCPocoxFmfwWwn7DfVydWr2H4jUJLimfFQt4AVBxKY1VELUuG0TTjmjfD0
        oTfF+bbPZeE2ZmvbSfI4g1OX4OExjtY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC6F913A5C;
        Thu, 30 Jun 2022 07:14:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C4qFMGNNvWKvKgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 30 Jun 2022 07:14:43 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jpoimboe@kernel.org, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH v3 0/3] x86: fix brk area initialization
Date:   Thu, 30 Jun 2022 09:14:38 +0200
Message-Id: <20220630071441.28576-1-jgross@suse.com>
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
At the same time its memory should be covered by the ELF program
headers.

Juergen Gross (3):
  x86/xen: use clear_bss() for Xen PV guests
  x86: clear .brk area at early boot
  x86: fix .brk attribute in linker script

 arch/x86/include/asm/setup.h  |  3 +++
 arch/x86/kernel/head64.c      |  4 +++-
 arch/x86/kernel/vmlinux.lds.S |  2 +-
 arch/x86/xen/enlighten_pv.c   |  8 ++++++--
 arch/x86/xen/xen-head.S       | 10 +---------
 5 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.35.3

