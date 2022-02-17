Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54ED64B9620
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 03:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiBQCzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 21:55:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiBQCzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 21:55:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F4B2A82F0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 18:54:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AA48B820CC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D06AC340EC;
        Thu, 17 Feb 2022 02:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645066496;
        bh=e6sQNtm0v2zWcewdkxMwUJXz1rBzzyDaIVcOGsQnXz8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jUysxnMsYWiv9peO3Df9BtpTtnwQzcuRDVqPKzp0riRCqWKtmRUB0X12sZx9OI2N5
         rOziFtfdyzBNr9lH0PzZkVjszwVrypvVIrnjxbX2Pdd5ki3vG9N/OU3CY3dUpEHOmP
         /GUAeIgS/tM38JfAAZ2HkXZ90Fw7m38k2x51VDhY=
Date:   Wed, 16 Feb 2022 18:54:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v4 1/4] mm: Don't skip swap entry even if zap_details
 specified
Message-Id: <20220216185455.c5af4f44f90b103971f34e1f@linux-foundation.org>
In-Reply-To: <20220216094810.60572-2-peterx@redhat.com>
References: <20220216094810.60572-1-peterx@redhat.com>
        <20220216094810.60572-2-peterx@redhat.com>
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

On Wed, 16 Feb 2022 17:48:07 +0800 Peter Xu <peterx@redhat.com> wrote:

> The "details" pointer shouldn't be the token to decide whether we should skip
> swap entries.  For example, when the user specified details->zap_mapping==NULL,
> it means the user wants to zap all the pages (including COWed pages), then we
> need to look into swap entries because there can be private COWed pages that
> was swapped out.

I assume "user" here means "caller".

> Skipping some swap entries when details is non-NULL may lead to wrongly leaving
> some of the swap entries while we should have zapped them.
> 
> A reproducer of the problem:
> 
> ...
>
> The issue seems to exist starting from the initial commit of git.

I'll add cc:stable to this one, thanks.
 

