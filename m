Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D87651C467
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354277AbiEEQBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381560AbiEEQBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:01:18 -0400
X-Greylist: delayed 519 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 08:57:15 PDT
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588B25C667
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:57:14 -0700 (PDT)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 7E18621BEE;
        Thu,  5 May 2022 15:48:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id E73062002D;
        Thu,  5 May 2022 15:48:32 +0000 (UTC)
Message-ID: <ed8f50726d0a8b8e5dc9da14ce64039891b77b53.camel@perches.com>
Subject: Re: [PATCH] checkpatch: warn about flushing system-wide workqueues
From:   Joe Perches <joe@perches.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 05 May 2022 08:48:31 -0700
In-Reply-To: <738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp>
References: <d34dac10-c12f-8bda-35c4-9cb158781db2@I-love.SAKURA.ne.jp>
         <a6288570ed3534b0316723061f5604e3871accef.camel@perches.com>
         <6e4ed62e-888b-6e7a-c13d-67656f39ca94@I-love.SAKURA.ne.jp>
         <738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: arimd99ims9sz1xexr6t1zgiaym4ssx6
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: E73062002D
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18U2wAxqfm+TPfR8ZOIlZZ2wsrQkLgB3BM=
X-HE-Tag: 1651765712-606268
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-05 at 22:42 +0900, Tetsuo Handa wrote:
> On 2022/04/25 9:33, Tetsuo Handa wrote:
> > On 2022/04/25 8:45, Joe Perches wrote:
> > > And it's probably more readable using separate lines and it looks as
> > > if the 3rd test is unnecessary as it could be combined with the 2nd.
> > > 
> > > 		if ($line =~ /\bflush_scheduled_work\s*\(/ ||
> > > 		    $line =~ /\bflush_workqueue\s*\(\s*system(_\w*)?_wq\s*\)/) {
> > 
> > We don't need to worry about possibility like
> > 
> > 	flush_workqueue(system_module1_wq);
> > 
> > ? Then, we can simplify like you suggested.
> 
> I initially thought that also doing static checks by scripts/checkpatch.pl
> is better than only doing runtime WARN_ON(). But not all patches are checked
> by scripts/checkpatch.pl . Thus, as an attempt to check without exemptions,
> I now think that doing static checks via BUILD_BUG_ON() is better than
> scripts/checkpatch.pl . I sent below patch to linux-next.git , and so far
> it seems working (I mean, no build failure reports caused by compilers).
> 
> Subject: workqueue: Wrap flush_workqueue() using a macro
> 
> A conversion to stop flushing kernel-global workqueues is in progress.
> Wrap flush_workqueue() and inject BUILD_BUG_ON() checks, in order to
> prevent users who are not aware of this conversion from again start
> flushing kernel-global workqueues.
[]
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
[]
> @@ -2813,6 +2813,7 @@ static void warn_flush_attempt(struct workqueue_struct *wq)
>   * This function sleeps until all work items which were queued on entry
>   * have finished execution, but it is not livelocked by new incoming ones.
>   */
> +#undef flush_workqueue
>  void flush_workqueue(struct workqueue_struct *wq)

The #undef flush_workqueue could be removed by using

void (flush_workqueue)(struct workqueue_struct *wq)
{
	...
}


