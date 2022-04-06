Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC324F60C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiDFN4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbiDFN43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:56:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BF34994BF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:07:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DDD9D1F7AC;
        Wed,  6 Apr 2022 09:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649236021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JVuBtNXdCP+zuSEWmJnI3uDqUIOa0+UCoEQ4so8Wgwo=;
        b=nrszIvaqPBUVEmRsiTlyz8lqXk8bNSFdPvUtekx+L0MzbjzrKoc1DKHuPdsY7s4lY2csCL
        r8tgAVVBD46ZOlcntWWyfgzhC3Tj/GLXvrny2N3PbAp/X665yIv2q+I8bvU/+Bop5FKgt7
        eJE7cUnxacXsy/GRvlBuJjgj22X7sac=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B1A6EA3B82;
        Wed,  6 Apr 2022 09:07:01 +0000 (UTC)
Date:   Wed, 6 Apr 2022 11:07:01 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH printk v2 01/12] printk: rename cpulock functions
Message-ID: <Yk1YNdPj5KndMA5D@alley>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <20220405132535.649171-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405132535.649171-2-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-04-05 15:31:24, John Ogness wrote:
> Since the printk cpulock is CPU-reentrant and since it is used
> in all contexts, its usage must be carefully considered and
> most likely will require programming locklessly. To avoid
> mistaking the printk cpulock as a typical lock, rename it to
> cpu_sync. The main functions then become:
> 
>     printk_cpu_sync_get_irqsave(flags);
>     printk_cpu_sync_put_irqrestore(flags);
> 
> Add extra notes of caution in the function description to help
> developers understand the requirements for correct usage.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Looks good the me.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
