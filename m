Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2C44BBE14
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbiBRRPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:15:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbiBRRPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:14 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710054C42A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=HL7fchLHOUn1lU/xbyxdwpFAdDeltvtUJ5iRLeT0/Ss=; b=j9JMA7UR84F9NElKXsIRaoJNlv
        RDnz8RQeKKmoB1RShzmROUzfSfhZFRS6mO6isaMc0Q2asFDL1QFTABGRJ2dKtZgS0KCiFy41VFXGM
        csLbjaSn+MLlwpjfDR+kTe0EfU/1okHcZD81uE3x4wQDpk/mBD9TFW5QXq43hPZZL2HDbJENOZO+x
        Z+l512gUh/iBBuCqZbvEBs6xjmhQjQYmRbj3J1gQci/SvmWH3KUv3cYX7bsh8qX2KCY0AjlcNY00p
        0H3qgpgZEreB/cweCSknUshemwUEnqweOMZN3N+zj7T3hl8mCwJtONgZjHany6dtWWML2GfGoeLHG
        LGhi+79Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6qA-00AsBX-D1; Fri, 18 Feb 2022 17:14:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C2816300EEF;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3094D206D2385; Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Message-ID: <20220218171409.219284012@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 11/29] x86/ibt,crypto: Add ENDBR for the jump-table entries
References: <20220218164902.008644515@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -195,6 +195,7 @@ SYM_FUNC_START(crc_pcl)
 .altmacro
 LABEL crc_ %i
 .noaltmacro
+	ENDBR
 	crc32q   -i*8(block_0), crc_init
 	crc32q   -i*8(block_1), crc1
 	crc32q   -i*8(block_2), crc2
@@ -203,6 +204,7 @@ LABEL crc_ %i
 
 .altmacro
 LABEL crc_ %i
+	ENDBR
 .noaltmacro
 	crc32q   -i*8(block_0), crc_init
 	crc32q   -i*8(block_1), crc1
@@ -237,6 +239,7 @@ LABEL crc_ %i
 	################################################################
 
 LABEL crc_ 0
+	ENDBR
 	mov     tmp, len
 	cmp     $128*24, tmp
 	jae     full_block


