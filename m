Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FC1501961
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242570AbiDNRDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241739AbiDNRCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:02:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D1BF9546
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4X+Jq1i8p1Zvr7xXgePsT13L/w0211RpRgQvinilEoU=; b=ixL+7Ua9Xbp8XciRqWrCDg1iLL
        DUVWPGpnNP9uiPaABHJAOWuXQYanOJUEG4uMJ+Lcyk00lTlcVvQb1LYfkJFQMku2pCoiNVJItwatL
        hHdXbL96u/agQihpdkz/NDSbHTqKgu634M0Estw0JaYG+r/PZCuosn8h06/E8YN3GJBkYZwjSwPJI
        0wJyOurYrF7rvtenvsLNV1wIGNnBTYRUlNmp+NVu6PGB2U0bqFZQ6c/A7VS3Im7txF/GnSa4yOYZL
        2W1aj+KVdAPdQnTxoeholZ6TxMJm0HN9vWirmh09HtR91owJDRlhmGVInohuvBvdtOYkjy3CVntk/
        F53M07sw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nf2Sj-00545G-Io; Thu, 14 Apr 2022 16:36:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4F5AD30031E;
        Thu, 14 Apr 2022 18:36:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2943C32321547; Thu, 14 Apr 2022 18:36:51 +0200 (CEST)
Date:   Thu, 14 Apr 2022 18:36:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 02/18] objtool: Support data symbol printing
Message-ID: <YlhNo026PgjJuCIU@hirez.programming.kicks-ass.net>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <097057f88605aa67b0e3ec573fcf394ae7ac4d6f.1649891421.git.jpoimboe@redhat.com>
 <YlfHy011VP2oPFjV@hirez.programming.kicks-ass.net>
 <20220414152148.cwdefx744kymqcut@treble>
 <Ylg+bewBpaqqYgeB@hirez.programming.kicks-ass.net>
 <20220414153854.rqkt465xn4vzndr7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414153854.rqkt465xn4vzndr7@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 08:38:54AM -0700, Josh Poimboeuf wrote:

> > Yes, I'd not seen that yet, what's that for? The Changelog alludes to
> > something, but I don't think it actually does get used later.
> 
> Nick had asked for something like that, it's just a way to avoid doing
> math every time we look at a warning, i.e. to convert func+offset to
> sec+offset.
> 
> But it's kind of ugly and I'm not 100% happy with it.
> 
> Maybe it should be behind an option (--sec-offsets)?

Can do I suppose... Myself, I have this script:

$ cat objdump-func.sh
#!/bin/bash

OBJ=$1; shift
FUNC=$1; shift

objdump -wdr $@ $OBJ | awk "/^\$/ { P=0; } /$FUNC[^>]*>:\$/ { P=1; O=strtonum(\"0x\" \$1); } { if (P) { o=strtonum(\"0x\" \$1); printf(\"%04x \", o-O); print \$0; } }"

That prints a symbol relative offset next to the section, something
like:

$ ./objdump-func.sh defconfig-build/vmlinux.o pick_next_task_idle
0000 00000000000a9eb0 <pick_next_task_idle>:
0000    a9eb0:  41 54                   push   %r12
0002    a9eb2:  4c 8b a7 28 09 00 00    mov    0x928(%rdi),%r12
0009    a9eb9:  53                      push   %rbx
000a    a9eba:  48 89 fb                mov    %rdi,%rbx
000d    a9ebd:  66 90                   xchg   %ax,%ax
000f    a9ebf:  66 90                   xchg   %ax,%ax
0011    a9ec1:  4c 89 e0                mov    %r12,%rax
0014    a9ec4:  5b                      pop    %rbx
0015    a9ec5:  41 5c                   pop    %r12
0017    a9ec7:  c3                      ret    
0018    a9ec8:  e8 00 00 00 00          call   a9ecd <pick_next_task_idle+0x1d> a9ec9: R_X86_64_PLT32   __update_idle_core-0x4
001d    a9ecd:  eb f0                   jmp    a9ebf <pick_next_task_idle+0xf>
001f    a9ecf:  4c 89 e0                mov    %r12,%rax
0022    a9ed2:  83 83 b8 0b 00 00 01    addl   $0x1,0xbb8(%rbx)
0029    a9ed9:  5b                      pop    %rbx
002a    a9eda:  41 5c                   pop    %r12
002c    a9edc:  c3                      ret    
002d    a9edd:  0f 1f 00                nopl   (%rax)

