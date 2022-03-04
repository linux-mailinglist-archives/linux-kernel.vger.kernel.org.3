Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AF84CD169
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbiCDJkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239216AbiCDJh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:37:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0689C1AA04F;
        Fri,  4 Mar 2022 01:36:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1900B827B1;
        Fri,  4 Mar 2022 09:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECFDC340E9;
        Fri,  4 Mar 2022 09:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386585;
        bh=RysmT+LMcL7CcpTbcFEHYgnbXGPnkMn9nXWQC+7jnwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1Lu1XiBXLAfS47x5JoNRhFXBRxeA60mOqx9qyQskBf/8h4u7xIjYB3IHNe9xpM4z
         KKndUrIen8ZKb2cIafCmhRx4YWhaAzIAMCqchHdCRogMreJwaMMAR1JVVaUaU/raRT
         Ew0QQq2jkR31VfRbpKzfKgZ+QtX/SsSRLlfhAj0lSRmxgZPyp9U3To6iKcMY0qDqCY
         z4SKI6Z86pKsxJmygN/CQwSnq8x5PHhea5bS2GzKctN27+AVy/K3iQQ6i7RbYSkzQD
         pdXo1YnTLrg1yt0Fvttw70EulSJCI+9M2fCS02jL35LuUbyoSDeGMJagjV+uGC/qNx
         5/TF1KdEJxXMw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT)), linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [RFC PATCH v2.1 05/30] Documentation/x86: Document SGX permission details
Date:   Fri,  4 Mar 2022 11:34:59 +0200
Message-Id: <20220304093524.397485-5-jarkko@kernel.org>
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

Provide summary of the various permissions involved in
managing access to enclave pages. This summary documents
the foundation for additions related to runtime managing of
enclave page permissions that is made possible with SGX2.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 Documentation/x86/sgx.rst | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
index 265568a9292c..89ff924b1480 100644
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -71,16 +71,34 @@ The processor tracks EPC pages in a hardware metadata structure called the
 which describes the owning enclave, access rights and page type among the other
 things.
 
-EPCM permissions are separate from the normal page tables.  This prevents the
-kernel from, for instance, allowing writes to data which an enclave wishes to
-remain read-only.  EPCM permissions may only impose additional restrictions on
-top of normal x86 page permissions.
-
 For all intents and purposes, the SGX architecture allows the processor to
 invalidate all EPCM entries at will.  This requires that software be prepared to
 handle an EPCM fault at any time.  In practice, this can happen on events like
 power transitions when the ephemeral key that encrypts enclave memory is lost.
 
+Details about enclave page permissions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+EPCM permissions are separate from the normal page tables.  This prevents the
+kernel from, for instance, allowing writes to data which an enclave wishes
+to remain read-only.
+
+Three permission masks are relevant to SGX:
+
+* EPCM permissions.
+* Page Table Entry (PTE) permissions.
+* Virtual Memory Area (VMA) permissions.
+
+An enclave is only able to access an enclave page if all three permission
+masks enable it to do so.
+
+The relationships between the different permission masks are:
+
+* An SGX VMA can only be created if its permissions are the same or weaker
+  than the EPCM permissions.
+* PTEs are installed to match the EPCM permissions, but not be more
+  relaxed than the VMA permissions.
+
 Application interface
 =====================
 
-- 
2.35.1

