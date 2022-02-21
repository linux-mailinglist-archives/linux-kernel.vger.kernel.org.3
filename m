Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED8F4BDDF7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358395AbiBUM4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:56:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiBUM4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:56:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB791C10F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:55:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6A0981F38E;
        Mon, 21 Feb 2022 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645448146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/higosCrBUuXIuVYTJ7LCuG8ecVfQi49Y+r3KOpXDYw=;
        b=FhPRUsm/gmghU9uqZ6FAnV1p2ZSemf7kzM7clgU/oArWBxl2JP94Hh6zkd61ucx8piZeEi
        f9azSOSowLKhZznlft1Fgt/RG0RrOq1I+9nKNfvfDr7+LMb1q5Zf7OWtiocjjDqtwbHqUI
        CvG5AfXD9RLUnLkTqVKGxj+Dfl5faUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645448146;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/higosCrBUuXIuVYTJ7LCuG8ecVfQi49Y+r3KOpXDYw=;
        b=p4Hp/xKWbw3LFVNNbQYG7uyCOYZ2HzKX3LPvJcUObu2LihGJMvkgCfy2tv3T1mBs3dttG3
        p5IWTB9EYE1dJ/Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E20E013AD5;
        Mon, 21 Feb 2022 12:55:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kotdNNGLE2KjcgAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 21 Feb 2022 12:55:45 +0000
Date:   Mon, 21 Feb 2022 13:55:44 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mm: clean up hwpoison page cache page in fault path
Message-ID: <YhOL0BvxDjNCuuae@localhost.localdomain>
References: <20220212213740.423efcea@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212213740.423efcea@imladris.surriel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 09:37:40PM -0500, Rik van Riel wrote:
> Sometimes the page offlining code can leave behind a hwpoisoned clean
> page cache page. This can lead to programs being killed over and over
> and over again as they fault in the hwpoisoned page, get killed, and
> then get re-spawned by whatever wanted to run them.
> 
> This is particularly embarrassing when the page was offlined due to
> having too many corrected memory errors. Now we are killing tasks
> due to them trying to access memory that probably isn't even corrupted.
> 
> This problem can be avoided by invalidating the page from the page
> fault handler, which already has a branch for dealing with these
> kinds of pages. With this patch we simply pretend the page fault
> was successful if the page was invalidated, return to userspace,
> incur another page fault, read in the file from disk (to a new
> memory page), and then everything works again.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Although I would really loved to understand how we got there,
it fixes the problem, so:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs
