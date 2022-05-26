Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26439534DCC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347137AbiEZLFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347140AbiEZLDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:03:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74227CEBBC
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=KxQbiJqE39w/Lon9YPgjSqo+uuElTNOmGV5qdrOKQk4=; b=OfWcQTauF2cUYKfuw8V3lKOLxH
        q32aVFzEkb1trFn6LQo00OUWp1SgVsxSk0M9jVmQTGYCRTldUr0BpKwSIeIjnWSB9x+24u/u+0VlX
        DBESt37jPYSB1UDFSsDR1XzBjhxeu6+n1VZbsD+4413bkHWqQAo4qlIGUWLdhwweFvh6Vfccqf266
        XWNg1OaCan2swqRx+w6qHSIgA+nqjusrokCtEYuA3wRVyokiXwqa+0LbDysGXi0E2zrDq3C3IhNWU
        yaSCtiP363AhFqs6VbMMgTd9eyOM4FJ2pB5+70LmcP3Pp0gDHJLdSz7EJmDS/QvocFs8tYdZn7zIo
        wCXiHD/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuBGX-001sVe-Jm; Thu, 26 May 2022 11:02:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94D8A300331;
        Thu, 26 May 2022 13:02:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 708B6202226AF; Thu, 26 May 2022 13:02:50 +0200 (CEST)
Message-ID: <20220526105957.879581277@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 26 May 2022 12:52:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        elver@google.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, mark.rutland@arm.com,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 3/7] objtool: Mark __ubsan_handle_builtin_unreachable() as noreturn
References: <20220526105252.440440893@infradead.org>
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

  fs/ntfs3/ntfs3.prelink.o: warning: objtool: ni_read_frame() falls through to next function ni_readpage_cmpr.cold()

That is in fact:

000000000000124a <ni_read_frame.cold>:
    124a:       44 89 e0                mov    %r12d,%eax
    124d:       0f b6 55 98             movzbl -0x68(%rbp),%edx
    1251:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi        1254: R_X86_64_32S      .data+0x1380
    1258:       48 89 c6                mov    %rax,%rsi
    125b:       e8 00 00 00 00          call   1260 <ni_read_frame.cold+0x16>   125c: R_X86_64_PLT32    __ubsan_handle_shift_out_of_bounds-0x4
    1260:       48 8d 7d cc             lea    -0x34(%rbp),%rdi
    1264:       e8 00 00 00 00          call   1269 <ni_read_frame.cold+0x1f>   1265: R_X86_64_PLT32    __tsan_read4-0x4
    1269:       8b 45 cc                mov    -0x34(%rbp),%eax
    126c:       e9 00 00 00 00          jmp    1271 <ni_read_frame.cold+0x27>   126d: R_X86_64_PC32     .text+0x19109
    1271:       48 8b 75 a0             mov    -0x60(%rbp),%rsi
    1275:       48 63 d0                movslq %eax,%rdx
    1278:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi        127b: R_X86_64_32S      .data+0x13a0
    127f:       89 45 88                mov    %eax,-0x78(%rbp)
    1282:       e8 00 00 00 00          call   1287 <ni_read_frame.cold+0x3d>   1283: R_X86_64_PLT32    __ubsan_handle_shift_out_of_bounds-0x4
    1287:       8b 45 88                mov    -0x78(%rbp),%eax
    128a:       e9 00 00 00 00          jmp    128f <ni_read_frame.cold+0x45>   128b: R_X86_64_PC32     .text+0x19098
    128f:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi        1292: R_X86_64_32S      .data+0x11f0
    1296:       e8 00 00 00 00          call   129b <ni_readpage_cmpr.cold>     1297: R_X86_64_PLT32    __ubsan_handle_builtin_unreachable-0x4

000000000000129b <ni_readpage_cmpr.cold>:

Tell objtool that __ubsan_handle_builtin_unreachable() is a noreturn.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220502091514.GB479834@worktop.programming.kicks-ass.net
---
 tools/objtool/check.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -185,6 +185,7 @@ static bool __dead_end_function(struct o
 		"stop_this_cpu",
 		"__invalid_creds",
                "cpu_startup_entry",
+		"__ubsan_handle_builtin_unreachable",
 	};
 
 	if (!func)


