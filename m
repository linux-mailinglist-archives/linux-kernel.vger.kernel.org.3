Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F065D59B08B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 23:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiHTVRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 17:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHTVRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 17:17:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FE63340C
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 14:17:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C09BC60C0D
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 21:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11E7C433B5;
        Sat, 20 Aug 2022 21:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661030223;
        bh=Sb8q+wdl7LvC3K03D3hmnGvtwPPUklgx1RNisq/uZBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vaIY3p3qbtc5FEF/gv8e80FXAjxQrY4cgEWfZ8kn3457psduk9CsYcwGhWAh3tPPy
         t9r/Fh4+WG8kUNlye8P1KwmGGPyB+73hScPPXDXl8gke/9XTV+4fO4pZUeSYemhbPk
         H7ijKQ6ETGuT+VTsm7xzuxVZevSo8ZeNuzeJTiJw=
Date:   Sat, 20 Aug 2022 14:17:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     sj@kernel.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon: validate if the pmd entry is present
 before accessing
Message-Id: <20220820141702.e731f2aade5da8cbe0c78cba@linux-foundation.org>
In-Reply-To: <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
References: <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
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

On Thu, 18 Aug 2022 15:37:43 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> The pmd_huge() is used to validate if the pmd entry is mapped by a huge
> page, also including the case of non-present (migration or hwpoisoned)
> pmd entry on arm64 or x86 architectures. That means the pmd_pfn() can
> not get the correct pfn number for the non-present pmd entry, which
> will cause damon_get_page() to get an incorrect page struct (also
> may be NULL by pfn_to_online_page()) to make the access statistics
> incorrect.
> 
> Moreover it does not make sense that we still waste time to get the
> page of the non-present entry, just treat it as not-accessed and skip it,
> that keeps consistent with non-present pte level entry.
> 
> Thus adding a pmd entry present validation to fix above issues.
> 

Do we have a Fixes: for this?

What are the user-visible runtime effects of the bug?  "make the access
statistics incorrect" is rather vague.

Do we feel that a cc:stable is warranted?
