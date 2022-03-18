Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81094DDC82
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbiCRPNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbiCRPM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:12:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0015CD0A9A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:11:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B0DD91F392;
        Fri, 18 Mar 2022 15:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647616299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LgAHhMnQFl/XoppBx9vQUXM93wpw76rIne61nM1b/o4=;
        b=MzOoT2+bBFPmPIi2HiKcQkl46umVRcz4ojhuX57f5xpYZWM2NNIwhoj7Ot0aJddeVkuFZO
        HoEDaUrIQLwi9cXPeB6GsnwCQQ9OhOB0MzKlEhRSNA9U5S2fxH/NvJdUIxVJvt4yklQjVl
        Tyx17f8iTllsExwzrAhzHDG4nvG0Ncw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647616299;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LgAHhMnQFl/XoppBx9vQUXM93wpw76rIne61nM1b/o4=;
        b=QAldZ+evzxhWb8i231IDECz/SSBbl4Uh75rCix/648sD70ffupk/r4jqlJIEoSuGifj4F0
        A92z8YdmuhD2gqCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D6A313B67;
        Fri, 18 Mar 2022 15:11:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CWMTISuhNGLrWgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 18 Mar 2022 15:11:39 +0000
Message-ID: <845449c1-d19a-5c9e-4ccb-352dff9ec473@suse.cz>
Date:   Fri, 18 Mar 2022 16:11:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mm: compaction: fix compiler warning when
 CONFIG_COMPACTION=n
Content-Language: en-US
To:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, nigupta@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1647608518-20924-1-git-send-email-quic_charante@quicinc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1647608518-20924-1-git-send-email-quic_charante@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/22 14:01, Charan Teja Kalla wrote:
> The below warning is reported when CONFIG_COMPACTION=n:
> 
>    mm/compaction.c:56:27: warning: 'HPAGE_FRAG_CHECK_INTERVAL_MSEC'
> defined but not used [-Wunused-const-variable=]
>       56 | static const unsigned int HPAGE_FRAG_CHECK_INTERVAL_MSEC =
> 500;
>          |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix it by moving 'HPAGE_FRAG_CHECK_INTERVAL_MSEC' under
> CONFIG_COMPACTION defconfig. Also since this is just a 'static const
> int' type, use #define for it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/compaction.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index b4e94cd..4d86d04 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -26,6 +26,11 @@
>  #include "internal.h"
>  
>  #ifdef CONFIG_COMPACTION
> +/*
> + * Fragmentation score check interval for proactive compaction purposes.
> + */
> +#define HPAGE_FRAG_CHECK_INTERVAL_MSEC	(500)
> +
>  static inline void count_compact_event(enum vm_event_item item)
>  {
>  	count_vm_event(item);
> @@ -51,11 +56,6 @@ static inline void count_compact_events(enum vm_event_item item, long delta)
>  #define pageblock_end_pfn(pfn)		block_end_pfn(pfn, pageblock_order)
>  
>  /*
> - * Fragmentation score check interval for proactive compaction purposes.
> - */
> -static const unsigned int HPAGE_FRAG_CHECK_INTERVAL_MSEC = 500;
> -
> -/*
>   * Page order with-respect-to which proactive compaction
>   * calculates external fragmentation, which is used as
>   * the "fragmentation score" of a node/zone.

