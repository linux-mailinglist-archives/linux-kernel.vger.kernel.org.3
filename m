Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F91597B82
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242644AbiHRCaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiHRC3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:29:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113092E6B7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:29:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC028B81FFF
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 02:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E97C433D6;
        Thu, 18 Aug 2022 02:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660789790;
        bh=IbHRphQ2b92jhpElJ6AvJaGXNhM8PpSwQuoZJ6b/O7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gT4QxK02c4TRCU8K+zu5foxMlZRli3U213tr9VRnbmnSRuzMsqx7zKZSLeOBXjLO/
         XsGCcxtWbe/yQJQGvFni2mbMOVi3xKaxRCWwmiwdy2Nu4eK/ijDzk/1rjfTvJznDvH
         RnpQGAIDC4uQb/9vCScAv4xA2SH7+Dqy0M9cwObajnk6qAvINSYMt05zJlgX8ZSPxG
         ICASJVgcB2PS/2J6QSRHbVZNFlEbj8tYkLRy4hEkCZN/xneeDMm0hvV9dbE2JKx12w
         1TUHLPfCK4lKmq9B1U7gsIOQzXyrqo4FxYSliRxGvKnWRftwVrMt+cBNedx5k0wbLG
         IrVmxuryaDpDw==
From:   SeongJae Park <sj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Validate if the pmd entry is present before accessing
Date:   Thu, 18 Aug 2022 02:29:47 +0000
Message-Id: <20220818022947.94345-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d7f85c9f-ca36-4731-e51c-840907cf1660@linux.alibaba.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On Thu, 18 Aug 2022 09:05:58 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> 
> 
> On 8/18/2022 12:09 AM, SeongJae Park wrote:
> > Hi Baolin,
> > 
> > 
> > Thank you always for your great patch!
> > 
> > On Wed, 17 Aug 2022 14:21:12 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> > 
> >> The pmd_huge() is used to validate if the pmd entry is mapped by a huge
> >> page, also including the case of non-present (migration or hwpoisoned)
> >> pmd entry on arm64 or x86 architectures. Thus we should validate if it
> >> is present before making the pmd entry old or getting young state,
> >> otherwise we can not get the correct corresponding page.
> > 
> > Maybe I'm missing something, but... I'm unsure if the page is present or not
> > really matters from the perspective of access checking.  In the case, DAMON
> > could simply report the page has accessed once for the first check after the
> > page being non-present if it really accessed before, and then report the page
> > as not accessed, which is true.
> 
> Yes, that's the patch's goal to make the accesses correct. However if 
> the PMD entry is not present, we can not get the correct page object by 
> pmd_pfn(*pmd), since the non-present pmd entry will contain swap type 
> and swap offset with below format on ARM64, that means the pfn number is 
> saved in bits 8-57 in a migration or poisoned entry, but pmd_pfn() still 
> treat bits 12-47 as the pfn number on ARM64, which may get an incorrect 
> page struct (also maybe is NULL by pfn_to_online_page()) to make the 
> access statistics incorrect.
> 
> /*
>   * Encode and decode a swap entry:
>   *	bits 0-1:	present (must be zero)
>   *	bits 2:		remember PG_anon_exclusive
>   *	bits 3-7:	swap type
>   *	bits 8-57:	swap offset
>   *	bit  58:	PTE_PROT_NONE (must be zero)
>   */
> 
> 
> Moreoever I don't think we should still waste time to get the page of 
> the non-present entry, just treat it as not-accessed and skip it, that 
> keeps consistent with non-present pte level entry.
> 
> Does that make sense for you? Thanks.

Yes, that totally makes sense.  Thank you very much for the kind answer.  I
think it would be great if we could put the detailed explanation in the commit
message.  Could you please update the commit message and post v2 of the patch?
Anyway,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ
