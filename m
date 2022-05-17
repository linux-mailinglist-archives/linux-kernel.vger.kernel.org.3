Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E35C52AEBA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 01:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiEQXjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 19:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiEQXjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:39:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A4952E48
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:39:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05131B81D66
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E868C3411F;
        Tue, 17 May 2022 23:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652830757;
        bh=aQy6tkYog1Mp778DJe+lW+xbkRM8taLZzQIq09aiLTA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1jSisTeT7F2wn8Pg7Jq0hHU1jm6tvO1jQr4nntqCqF3VIZj+bchU1iyxYn1QZd3PQ
         lI19nkHGCQlnz2KxobTVShI64XC8lcKQ8OVm27tPeyh+6dZ2whHNL+IvV+oIJCfsyG
         PA1Hwmb3LC15E7Mb7gwHRStYHTCtI4XnEC6pSEJ8=
Date:   Tue, 17 May 2022 16:39:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     NeilBrown <neilb@suse.de>, <willy@infradead.org>, <vbabka@suse.cz>,
        <dhowells@redhat.com>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/15] mm/swap: add helper swap_offset_available()
Message-Id: <20220517163916.71ab9aa1ec095bbc57b82f98@linux-foundation.org>
In-Reply-To: <9319a62b-f43d-8ee9-77b9-a1afee7dbc10@huawei.com>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
        <20220509131416.17553-12-linmiaohe@huawei.com>
        <165214355418.14782.13896859043718755300@noble.neil.brown.name>
        <9319a62b-f43d-8ee9-77b9-a1afee7dbc10@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 10:03:19 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2022/5/10 8:45, NeilBrown wrote:
> > On Mon, 09 May 2022, Miaohe Lin wrote:
> >> Add helper swap_offset_available() to remove some duplicated codes.
> >> Minor readability improvement.
> > 
> > I don't think that putting the spin_lock() inside the inline helper is
> > good for readability.
> > If the function was called
> >    swap_offset_available_and_locked()
> 
> Yes, swap_offset_available_and_locked should be more suitable as we do the spin_lock
> inside it. Will do this in next version.
> 

--- a/mm/swapfile.c~mm-swap-add-helper-swap_offset_available-fix
+++ a/mm/swapfile.c
@@ -775,7 +775,8 @@ static void set_cluster_next(struct swap
 	this_cpu_write(*si->cluster_next_cpu, next);
 }
 
-static inline bool swap_offset_available(struct swap_info_struct *si, unsigned long offset)
+static bool swap_offset_available_and_locked(struct swap_info_struct *si,
+					     unsigned long offset)
 {
 	if (data_race(!si->swap_map[offset])) {
 		spin_lock(&si->lock);
@@ -967,7 +968,7 @@ done:
 scan:
 	spin_unlock(&si->lock);
 	while (++offset <= READ_ONCE(si->highest_bit)) {
-		if (swap_offset_available(si, offset))
+		if (swap_offset_available_and_locked(si, offset))
 			goto checks;
 		if (unlikely(--latency_ration < 0)) {
 			cond_resched();
@@ -977,7 +978,7 @@ scan:
 	}
 	offset = si->lowest_bit;
 	while (offset < scan_base) {
-		if (swap_offset_available(si, offset))
+		if (swap_offset_available_and_locked(si, offset))
 			goto checks;
 		if (unlikely(--latency_ration < 0)) {
 			cond_resched();
_

