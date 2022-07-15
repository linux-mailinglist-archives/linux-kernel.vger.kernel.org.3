Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8462576368
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiGOOID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 10:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiGOOH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:07:59 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7CB6871A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:07:51 -0700 (PDT)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 26FE7SDI047462;
        Fri, 15 Jul 2022 23:07:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Fri, 15 Jul 2022 23:07:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 26FE7SnE047455
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 15 Jul 2022 23:07:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6d84da13-8c7b-129e-a40c-cadc80a609f4@I-love.SAKURA.ne.jp>
Date:   Fri, 15 Jul 2022 23:07:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] ARM: spectre-v2: fix smp_processor_id() warning
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Marc Zyngier <maz@kernel.org>, Tony Lindgren <tony@atomide.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <795c9463-452e-bf64-1cc0-c318ccecb1da@I-love.SAKURA.ne.jp>
 <e5bdea6c767d3a8260360afaddab5f7c@kernel.org>
 <YrMhVAev9wMAA8tl@shell.armlinux.org.uk>
 <421c1ca9-f553-4c0a-d963-2fdeb270dbcc@I-love.SAKURA.ne.jp>
 <fa786d1c-db06-f7f1-9ac9-6a468c1e8d81@I-love.SAKURA.ne.jp>
 <3188347c-3375-b728-cd08-ea4421d823cd@I-love.SAKURA.ne.jp>
 <YtFte2mTbfkMkRpJ@shell.armlinux.org.uk>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YtFte2mTbfkMkRpJ@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/07/15 22:36, Russell King (Oracle) wrote:
> On Fri, Jul 15, 2022 at 10:09:01PM +0900, Tetsuo Handa wrote:
>> syzbot is reporting that CONFIG_HARDEN_BRANCH_PREDICTOR=y +
>> CONFIG_DEBUG_PREEMPT=y on ARM32 causes "BUG: using smp_processor_id() in
>> preemptible code" message [1], for this check was not designed to handle
>> attempts to access kernel memory like
>>
>>   ----------
>>   int main() { return *(char *) -1; }
>>   ----------
>>
>> . Although Russell King commented that this BUG: message might help finding
>> possible exploit attempts [2], this is not a kernel's problem that worth
>> giving up fuzz testing.
> 
> But shutting up a valid warning when the real problem is still there is
> also not acceptable.

Then, at least for now can we stop emitting the BUG: string? I showed an idea at
https://lkml.kernel.org/r/fa786d1c-db06-f7f1-9ac9-6a468c1e8d81@I-love.SAKURA.ne.jp
but I got no response.

Since syzkaller stops fuzz testing upon encountering BUG: or WARNING: string,
ARM32 might be failing to find other bugs for 491 days due to this problem.

If you don't want to stop emitting this BUG: string, we might want to teach
syzkaller to build ARM32 kernels with CONFIG_HARDEN_BRANCH_PREDICTOR=n.

