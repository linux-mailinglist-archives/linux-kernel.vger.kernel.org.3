Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FF24B5DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 23:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiBNWsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 17:48:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiBNWsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:48:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF682E0BC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:48:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C8AC614DD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 22:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8137DC340E9;
        Mon, 14 Feb 2022 22:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1644878886;
        bh=1UJ2OiyXpKMgePt9yHkVQT3f1I3liwRx9crIh4pbdh8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TTulpw//oeAq9LWoFuC5gP5jQL2rV71B/LvOaSfLDYi5+JcxWtSosJsWToeGzIZd6
         YQY431PW1zqwb3wodRMXYkRQjnnxW3prhbhOn02wz4ZvstFcgEvnMSScLhYhA+0VzT
         gM6bugtF7m/BgrDrZ+3TXZxgJl/DswnHz+GuN4Y8=
Date:   Mon, 14 Feb 2022 14:48:05 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, CGEL <cgel.zte@gmail.com>,
        Minchan Kim <minchan@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH] mm: page_io: fix psi memory pressure error on cold
 swapins
Message-Id: <20220214144805.fa389f495fdfb07b40526f70@linux-foundation.org>
In-Reply-To: <20220214214921.419687-1-hannes@cmpxchg.org>
References: <20220214214921.419687-1-hannes@cmpxchg.org>
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

On Mon, 14 Feb 2022 16:49:21 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:

> Once upon a time, all swapins counted toward memory pressure[1]. Then
> Joonsoo introduced workingset detection for anonymous pages and we
> gained the ability to distinguish hot from cold swapins[2][3]. But we
> failed to update swap_readpage() accordingly, and now we account
> partial memory pressure in the swapin path of cold memory.
> 
> Not for all situations - which adds more inconsistency: paths using
> the conventional submit_bio() and lock_page() route will not see much
> pressure - unless storage itself is heavily congested and the bio
> submissions stall. ZRAM and ZSWAP do most of the work directly from
> swap_readpage() and will see all swapins reflected as pressure.
> 
> Restore consistency by making all swapin stall accounting conditional
> on the page actually being part of the workingset.

Does this have any known runtime effects?  If not, can we
hazard a guess?
