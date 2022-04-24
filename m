Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1056D50D608
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 01:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239943AbiDXXsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 19:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiDXXsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 19:48:45 -0400
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D7C20185
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 16:45:43 -0700 (PDT)
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 0B7121219FB;
        Sun, 24 Apr 2022 23:45:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id D1B0020012;
        Sun, 24 Apr 2022 23:45:40 +0000 (UTC)
Message-ID: <a6288570ed3534b0316723061f5604e3871accef.camel@perches.com>
Subject: Re: [PATCH] checkpatch: warn about flushing system-wide workqueues
From:   Joe Perches <joe@perches.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Apr 2022 16:45:40 -0700
In-Reply-To: <d34dac10-c12f-8bda-35c4-9cb158781db2@I-love.SAKURA.ne.jp>
References: <d34dac10-c12f-8bda-35c4-9cb158781db2@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: D1B0020012
X-Stat-Signature: xke3tbwg3cjbbi7h4o31n41csjub7oix
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX190vxVkwu4uE2s7cH8JtoTiEAREo6ECN7Q=
X-HE-Tag: 1650843940-363246
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-25 at 08:31 +0900, Tetsuo Handa wrote:
> Flushing the system-wide WQ has possibility of deadlock, for the caller
> waits for completion of all works in that WQ even if the caller cannot
> wait for completion of one of works due to locking dependency. Since
> it is difficult to catch such attempts using lockdep, try to catch also
> using checkpatch.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7226,6 +7226,13 @@ sub process {
>  			     "Deprecated use of '$deprecated_api', prefer '$new_api' instead\n" . $herecurr);
>  		}
>  
> +# check for flushing system-wide workqueues
> +		if ($line =~ /\bflush_scheduled_work\b\s*\(/ || $line =~ /\bflush_workqueue\b\s*\(\s*\bsystem_wq\b\s*\)/ ||
> +		    $line =~ /\bflush_workqueue\b\s*\(\s*\bsystem_(highpri|long|unbound|freezable|power_efficient|freezable_power_efficient)_wq\b\s*\)/) {

Several of the uses of \b are not necessary.

And it's probably more readable using separate lines and it looks as
if the 3rd test is unnecessary as it could be combined with the 2nd.

		if ($line =~ /\bflush_scheduled_work\s*\(/ ||
		    $line =~ /\bflush_workqueue\s*\(\s*system(_\w*)?_wq\s*\)/) {

> +			ERROR("DEPRECATED_API",
> +			      "Flushing system-wide workqueues is dangerous and will be forbidden - see https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236\@I-love.SAKURA.ne.jp\n" . $herecurr);



