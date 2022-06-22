Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668AC554B59
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiFVNb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiFVNbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:31:53 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D51616F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:31:52 -0700 (PDT)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 25MDVTV7072219;
        Wed, 22 Jun 2022 22:31:29 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Wed, 22 Jun 2022 22:31:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 25MDVTRu072216
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 22 Jun 2022 22:31:29 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1a22993a-00c2-fdec-58e3-8c39159de67a@I-love.SAKURA.ne.jp>
Date:   Wed, 22 Jun 2022 22:31:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ARM: spectre-v2: fix smp_processor_id() warning
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Tony Lindgren <tony@atomide.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <795c9463-452e-bf64-1cc0-c318ccecb1da@I-love.SAKURA.ne.jp>
 <YrL7LIfOqtEJMoTX@shell.armlinux.org.uk>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YrL7LIfOqtEJMoTX@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/06/22 20:21, Russell King (Oracle) wrote:
>>  static inline void harden_branch_predictor(void)
>>  {
>> -	harden_branch_predictor_fn_t fn = per_cpu(harden_branch_predictor_fn,
>> -						  smp_processor_id());
>> +	harden_branch_predictor_fn_t fn;
>> +
>> +	preempt_disable_notrace();
>> +	fn = per_cpu(harden_branch_predictor_fn, raw_smp_processor_id());
>> +	preempt_enable_no_resched_notrace();
>>  	if (fn)
>>  		fn();
> 
> The idea is to get the function for the specific CPU, and then to run it
> _on_ that CPU, and in theory the CPU that took the fault. However, I
> seem to remember there are issues trying to achieve that, and I don't
> have a solution for it.

Hmm, since some ARM processors support Asymmetric Multiprocessing, whether
invalidation is needed depends on which processor was assigned, and that's
the reason smp_processor_id() is used?

I'm not familiar with hardware, but if a CPU assigned to current thread
changes, wouldn't sufficient invalidation take place? In other words, do
we need to worry about fn() call if the CPU that took the fault and the CPU
which runs the code after harden_branch_predictor() returned differs?

If some instructions for CPU-A is not supported by CPU-B, I guess that
reading instructions for CPU-A at per_cpu(harden_branch_predictor_fn) and
executing instructions on CPU-B at fn() causes problems. Is it guaranteed
that all instructions used by fn() are supported by all processors?
If it is not guaranteed, we would need to make sure that fn() runs on a CPU
which per_cpu(harden_branch_predictor_fn) was done for?

