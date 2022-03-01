Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A6A4C8F36
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbiCAPhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiCAPhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:37:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AD6A9962
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 07:36:38 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1B5941F37E;
        Tue,  1 Mar 2022 15:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646148997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9NyWT2IV+ciU8G03hB2VlMhgsCF7jhGWWQzmMtBqb0k=;
        b=pRG/BmT7g0VNngYeNZ9+i7ysNVWpLwrdvEKHVw7E+CIZ/5VL4oD99l3nYDMtqUwGdIVKzI
        oYoNkJ55l83ODkpT79Xp7D/xFmLJLk3YzTLTtUmq/njQXyFBpGsbkBYswGXLygu2yP2vIS
        Wc9DJDmla5jHwzco9ONMZ1ItjYsx16g=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CDF65A3B81;
        Tue,  1 Mar 2022 15:36:36 +0000 (UTC)
Date:   Tue, 1 Mar 2022 16:36:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] printk: fix return value of printk.devkmsg __setup
 handler
Message-ID: <20220301153636.GA24138@pathway.suse.cz>
References: <20220228220556.23484-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228220556.23484-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-28 14:05:56, Randy Dunlap wrote:
> If an invalid option value is used with "printk.devkmsg=<value>",
> it is silently ignored.
> If a valid option value is used, it is honored but the wrong return
> value (0) is used, indicating that the command line option had an
> error and was not handled. This string is not added to init's
> environment strings due to init/main.c::unknown_bootoption()
> checking for a '.' in the boot option string and then considering
> that string to be an "Unused module parameter".
> 
> Print a warning message if a bad option string is used.
> Always return 1 from the __setup handler to indicate that the command
> line option has been handled.
> 
> Fixes: 750afe7babd1 ("printk: add kernel parameter to control writes to /dev/kmsg")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru

Good catch! I am learning something new every day :-)

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
