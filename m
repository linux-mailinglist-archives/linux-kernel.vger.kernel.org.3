Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C89D538A92
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 06:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243822AbiEaEcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 00:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243803AbiEaEcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 00:32:08 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892F96383;
        Mon, 30 May 2022 21:32:05 -0700 (PDT)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 24V4Vobr009329;
        Tue, 31 May 2022 13:31:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Tue, 31 May 2022 13:31:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 24V4Vnqx009323
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 31 May 2022 13:31:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9353ac77-f473-3f64-7e61-566807cd47e2@I-love.SAKURA.ne.jp>
Date:   Tue, 31 May 2022 13:31:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: linux-next: build warnings after merge of the tomoyo tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220531104424.0a467ba4@canb.auug.org.au>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220531104424.0a467ba4@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/31 9:44, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the tomoyo tree, today's linux-next build (powerpc
> ppc64_defconfig) produced these warnings:
> 
> drivers/scsi/mpt3sas/mpt3sas_scsih.c:12412:9: note: '#pragma message: Please avoid flushing system-wide workqueues.'

This is neither "warning:" nor "error:". This is a "note:" message which also appears with "make W=1" case.

> Also, my x86_64 allmodconfig build gained these:

Yes, currently there are many matches when building all modules.
But do developers build all modules?

> Linus will not be happy ...

Hmm, an important part which was missing in commit 771c035372a036f8 ("deprecate
the '__deprecated' attribute warnings entirely and for good") is that Linus
builds all modules and reads all messages during the build?

If that is the case, reporting "Please avoid flushing system-wide workqueues."
every time sounds noisy for him.

But since __deprecated became no-op in v4.19, I guess that developers abandoned
efforts for removing __deprecated usage.

  v5.18: 13 references
  v5.10: 12 references
  v4.19: 12 references
  v4.18: 20 references
  v4.10: 25 references
  v4.0:  25 references
  v3.10: 37 references

What I'm trying to do is to teach developers about possibility of problems
at compile time. __deprecated suits here but is no-op.

Something like console_loglevel which can be controlled on per directory
basis (so that developers can deeply listen to messages from only modules
they maintain) is needed for kernel build?

