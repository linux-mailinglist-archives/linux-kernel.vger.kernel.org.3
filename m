Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5385A3ACA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 03:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiH1Bk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 21:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1BkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 21:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7912F3B3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 18:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3886160F15
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417C4C433C1;
        Sun, 28 Aug 2022 01:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661650822;
        bh=FGNvzCOKkVqHq0tcUTWz3+S8SsHh6WDHwk+zUimYeVQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1urU150giWDG6/gr5BsNJrncuJn13s0LO5fKEKrOz3P/Jmo4Le07fed5aE8iGfild
         4O7zMnNW1sx5zN3y5UQqKNMmvUKTDPRYdhGE+yEsGtffQZ0qrXseA+bFPGlnO9Ltme
         4tw+9Ok9aiWY9CU4Ve8GIExoqjxYIiyHZlOkq6T8=
Date:   Sat, 27 Aug 2022 18:40:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, alex.sierra@amd.com,
        willy@infradead.org, hch@lst.de, Felix.Kuehling@amd.com,
        apopple@nvidia.com, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: re-allow pinning of zero pfns (again)
Message-Id: <20220827184021.4e100b9eda3a9141217ec60d@linux-foundation.org>
In-Reply-To: <033c2e8d-8ba9-3e0b-9dee-7d0973c708fa@nvidia.com>
References: <166015037385.760108.16881097713975517242.stgit@omen>
        <033c2e8d-8ba9-3e0b-9dee-7d0973c708fa@nvidia.com>
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

On Sat, 27 Aug 2022 17:59:32 -0700 John Hubbard <jhubbard@nvidia.com> wrote:

> 
> 	/* The zero page is always allowed to be pinned. */

Wow, that's really verbose :)

--- a/include/linux/mm.h~mm-re-allow-pinning-of-zero-pfns-again-fix
+++ a/include/linux/mm.h
@@ -1544,11 +1544,7 @@ static inline bool is_longterm_pinnable_
 	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
 		return false;
 #endif
-	/*
-	 * The zero page might reside in a movable zone, however it may not
-	 * be migrated and can therefore be pinned.  The vfio subsystem pins
-	 * user mappings including the zero page for IOMMU translation.
-	 */
+	/* The zero page may always be pinned */
 	if (is_zero_pfn(page_to_pfn(page)))
 		return true;
 
_

