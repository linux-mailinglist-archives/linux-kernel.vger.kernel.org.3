Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C254B5E37
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiBNXYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:24:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBNXYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:24:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA2E13C9D8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:24:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48409B816DD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F46C340E9;
        Mon, 14 Feb 2022 23:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1644881049;
        bh=r0YrWh5FR1nHnNrxO+yE63GaWZtTclxK9OBUPdLb4D8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qqqkJhBik2hY3zZ5fXpl58TX1cENJ/7Zcjw4WS8oyiQdBwE2MeufhIjUufFqQMSKj
         94ECCbzr0KM+AcQSB5yWAhuelD5IsLnZGC3AgdKJQSxqRcDNU9adB2tVnSvJJ86T1Y
         oMCrct6SR7P07jUh3bxXCVufzCLcnvIcWhF+g25I=
Date:   Mon, 14 Feb 2022 15:24:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, Miaohe Lin <linmiaohe@huawei.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH v2] mm: clean up hwpoison page cache page in fault path
Message-Id: <20220214152407.67e0d7dd1a532252c9dd203e@linux-foundation.org>
In-Reply-To: <20220212213740.423efcea@imladris.surriel.com>
References: <20220212213740.423efcea@imladris.surriel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: [PATCH v2] mm: clean up hwpoison page cache page in fault path

At first scan I thought this was a code cleanup.

I think I'll do s/clean up/invalidate/.

On Sat, 12 Feb 2022 21:37:40 -0500 Rik van Riel <riel@surriel.com> wrote:

> Sometimes the page offlining code can leave behind a hwpoisoned clean
> page cache page.

Is this correct behaviour?

> This can lead to programs being killed over and over
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

Is this worth a cc:stable?


