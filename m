Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE97D4C2866
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiBXJnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiBXJnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:43:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DFE27DF19;
        Thu, 24 Feb 2022 01:43:02 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 58504212B6;
        Thu, 24 Feb 2022 09:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645695781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VhYBAe1gSGopgSRSOGMTGOmOvlVoIMiOWHRCXiap7/Q=;
        b=P1OoCH8Hysjd2HFJr+09bFIvyRIBq+BM0fJ3CCR0CtN2K6H83HzE2Px/uJJs+A7wa3CuRY
        +QJ3u5s/4vjmLZRyQytgjCjDBZc2CbBbNEJJnejBXcGyH6Lkpn+VjoyLhqVcwe18Rkbx2k
        f3LLmhPlGtAZPvxlMix5S8oq0NCJNm0=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F21E2A3B87;
        Thu, 24 Feb 2022 09:43:00 +0000 (UTC)
Date:   Thu, 24 Feb 2022 10:43:00 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] vsprintf: Fix %pK with kptr_restrict == 0
Message-ID: <YhdTJLHsSVPrta2R@alley>
References: <107476128e59bff11a309b5bf7579a1753a41aca.1645087605.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <107476128e59bff11a309b5bf7579a1753a41aca.1645087605.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-17 09:49:59, Christophe Leroy wrote:
> Although kptr_restrict is set to 0 and the kernel is booted with
> no_hash_pointers parameter, the content of /proc/vmallocinfo is
> lacking the real addresses.
> 
>   / # cat /proc/vmallocinfo
>   0x(ptrval)-0x(ptrval)    8192 load_module+0xc0c/0x2c0c pages=1 vmalloc
>   0x(ptrval)-0x(ptrval)   12288 start_kernel+0x4e0/0x690 pages=2 vmalloc
>   0x(ptrval)-0x(ptrval)   12288 start_kernel+0x4e0/0x690 pages=2 vmalloc
>   0x(ptrval)-0x(ptrval)    8192 _mpic_map_mmio.constprop.0+0x20/0x44 phys=0x80041000 ioremap
>   0x(ptrval)-0x(ptrval)   12288 _mpic_map_mmio.constprop.0+0x20/0x44 phys=0x80041000 ioremap
>     ...
> 
> According to the documentation for /proc/sys/kernel/, %pK is
> equivalent to %p when kptr_restrict is set to 0.
> 
> Fixes: 5ead723a20e0 ("lib/vsprintf: no_hash_pointers prints all addresses as unhashed")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

The patch has been committed into printk/linux.git, branch for-5.18.

Best Regards,
Petr
