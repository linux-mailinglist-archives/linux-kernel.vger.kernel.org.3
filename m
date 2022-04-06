Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7F54F66AF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbiDFRLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiDFRKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:10:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48F73DF345
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:40:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 727D921122;
        Wed,  6 Apr 2022 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649256006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1G9qEMHZUw63JVLa0+mZAeByv1ssvC0NaTlEWKkeF5A=;
        b=C8lHpt+qleyGP8AzMVnzq4Tv61oq7LleGDGCm5jEtu7ZEEqVYKvlrI0Ss42XHba9ZhflyG
        0l1nE0ixL/sSRnFTWIbj0Fkjh+Jykw1pI5Y/McwJ9AFRLZLAk2pVnBNihQZHM4yDKELRXY
        kyuSMoIN3OG7dMUYt22RWadMSyA9iac=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 06CF1A3B88;
        Wed,  6 Apr 2022 14:40:06 +0000 (UTC)
Date:   Wed, 6 Apr 2022 16:40:04 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 07/12] printk: move buffer definitions into
 console_emit_next_record() caller
Message-ID: <Yk2mREN3JGjcpjRZ@alley>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <20220405132535.649171-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405132535.649171-8-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-04-05 15:31:30, John Ogness wrote:
> Extended consoles print extended messages and do not print messages about
> dropped records.
> 
> Non-extended consoles print "normal" messages as well as extra messages
> about dropped records.
> 
> Currently the buffers for these various message types are defined within
> the functions that might use them and their usage is based upon the
> CON_EXTENDED flag. This will be a problem when moving to kthread printers
> because each printer must be able to provide its own buffers.
> 
> Move all the message buffer definitions outside of
> console_emit_next_record(). The caller knows if extended or dropped
> messages should be printed and can specify the appropriate buffers to
> use. The console_emit_next_record() and call_console_driver() functions
> can know what to print based on whether specified buffers are non-NULL.
> 
> With this change, buffer definition/allocation/specification is separated
> from the code that does the various types of string printing.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

I feel slightly sad that we replace the safe sizeof(buffer)
with a hardcoded size. But the change makes sense. And I think
that it is not worth passing the size as parameters.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
