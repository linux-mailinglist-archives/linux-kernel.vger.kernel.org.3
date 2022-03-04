Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4964CD154
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbiCDJjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239469AbiCDJiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03B31A6141;
        Fri,  4 Mar 2022 01:37:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6805BB827B1;
        Fri,  4 Mar 2022 09:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D077CC340F1;
        Fri,  4 Mar 2022 09:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386635;
        bh=vAgJ5N80A5lJFMuKJjz++XW3gGLCLo+78R7NXO7lmQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H1LgFQ2PidJocoaERw7arV7YrXss6Eo5jB+ucxiDfiWN2lk4NaXBXEi3Vy6DFzPt7
         PVryM5WI7n4tVOjJH4Bd0KodV4Dx3nT10raFo9oByxb/oYlLGM95KOIsiBJwSQuL/k
         FJOXdSOdhDs6jPbbS1KGJZQsLsh3/ewz9+4LUIw6XTI8hOu5aq2YP3IsT6SRZ9dKpa
         hr69iXLPxbQpBRa43RMdo27WbEK+htK7fhTaiGz8EDpYEbawXl7B4oxMUwCjxJigB5
         5g8UbLfNSYe4kq8pOoKdJNTwNvaICod4uovKy3HPaGnrSQ6hjq+IzdKYMKBoRrLDhG
         VlDjE1M76ZEZw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT)), linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [RFC PATCH v2.1 22/30] Documentation/x86: Introduce enclave runtime management section
Date:   Fri,  4 Mar 2022 11:35:16 +0200
Message-Id: <20220304093524.397485-22-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304093524.397485-1-jarkko@kernel.org>
References: <20220304093524.397485-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

Enclave runtime management is introduced following the pattern
of the section describing enclave building. Provide a brief
summary of enclave runtime management, pointing to the functions
implementing the ioctl()s that will contain details within their
kernel-doc.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 Documentation/x86/sgx.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
index 5659932728a5..6c66ce0ec69c 100644
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -128,6 +128,22 @@ pages and establish enclave page permissions.
                sgx_ioc_enclave_init
                sgx_ioc_enclave_provision
 
+Enclave runtime management
+--------------------------
+
+Systems supporting SGX2 additionally support changes to initialized
+enclaves: modifying enclave page permissions and type, and dynamically
+adding and removing of enclave pages. When an enclave accesses an address
+within its address range that does not have a backing page then a new
+regular page will be dynamically added to the enclave. The enclave is
+still required to run EACCEPT on the new page before it can be used.
+
+.. kernel-doc:: arch/x86/kernel/cpu/sgx/ioctl.c
+   :functions: sgx_ioc_enclave_relax_perm
+               sgx_ioc_enclave_restrict_perm
+               sgx_ioc_enclave_modt
+               sgx_ioc_enclave_remove_pages
+
 Enclave vDSO
 ------------
 
-- 
2.35.1

