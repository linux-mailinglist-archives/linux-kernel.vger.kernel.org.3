Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41F45576F0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiFWJqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiFWJqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:46:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5269C496AA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:46:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 14A8F1FD8A;
        Thu, 23 Jun 2022 09:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655977571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=IIvicZRTKlJOBgOc3++ZHzJfG9P22jzec6L0MnajaIo=;
        b=HPHaGgfyCZ84QyQjmgfwZPXBbLogxmzAtQTOZqyOqAI/F39MK0TO4DKhXNYcJSj4jo+eX1
        4LEt8gm8/e7JyZ+Gah81gPbuDHtiUtkXXTogbdVwTdSRavynFnglvqajH+3ROrBcVj3ETO
        NGKDudBRBG152w3cUPz/VLCVqB1q+AE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AED21133A6;
        Thu, 23 Jun 2022 09:46:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XCAtKWI2tGLmLwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 23 Jun 2022 09:46:10 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH v2 0/3] x86: fix brk area initialization
Date:   Thu, 23 Jun 2022 11:46:05 +0200
Message-Id: <20220623094608.7294-1-jgross@suse.com>
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
  x86: fix setup of brk area
  x86: fix .brk attribute in linker script

 arch/x86/include/asm/setup.h  |  3 +++
 arch/x86/kernel/head64.c      |  4 +++-
 arch/x86/kernel/vmlinux.lds.S |  2 +-
 arch/x86/xen/enlighten_pv.c   |  8 ++++++--
 arch/x86/xen/xen-head.S       | 10 +---------
 5 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.35.3

