Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040D550928C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352014AbiDTWQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiDTWQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:16:55 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086CB20BD4;
        Wed, 20 Apr 2022 15:14:06 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id 88149100004;
        Wed, 20 Apr 2022 22:14:02 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 20 Apr 2022 15:14:02 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 10/11] linux/interrupt: Fix prototype matching
 property
In-Reply-To: <202204191942.3C273AB@keescook>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-11-joao@overdrivepizza.com>
 <202204191942.3C273AB@keescook>
Message-ID: <2d7e424f13682295f655faf9b8c8f1cf@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Fix this CFI policy violation by removing the function pointer union 
>> in
>> the tasklet struct.
> 
> The good news is that tasklet is on the way out the door[1], so this 
> may
> quickly become a non-issue, but also to that end, this fix is hardly a
> problem for a deprecated API...

You are right, sorry for the noise. I looked a bit further and the 
problem I saw was actually caused by a compiler bug fusing similar 
instructions/basic blocks. It was fixed when I later stumbled on the 
problem again and added the following lines (668 and 669 in 
llvm/lib/CodeGen/MachineInstr.cpp) to the compiler, but without properly 
realizing what was actually behind the previous issue. Hopefully this is 
at least a good heads-up about possible pitfalls to other people (@Sami) 
implementing CFI in the compiler.

https://github.com/lvwr/llvm-project/commit/0a22ca42877fd156ce95145b11f29c642092dbb7#diff-92843a1f037a9a1e56f92242c4e1746a1166a6b7044ad47a0b4fd2f4b1c6a359R668-R669
