Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3124FEA23
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 00:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiDLWbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 18:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiDLWb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 18:31:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6B935857
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 14:16:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80C6A61C58
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E136C385A5;
        Tue, 12 Apr 2022 20:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649797153;
        bh=uOj1EWKfp5MbqFPddwn3qYnZPGLBfwLvKU5JMyCXO24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q+3BNwbhWqkqibwxCe3UjkkhP7AbmEqGgm29CifeVvXrVG7BAh9jboSLyIgroSuct
         Tj3ohffGqKfpaPBXU44v99VxIDg2vogFB8CvqaFWbe4TNwaxUiiQzkIpr5t68Ie8fc
         2P41Y2YwstHn2Gd+tHNJ8nbrnIidz2n7We0HT7FM=
Date:   Tue, 12 Apr 2022 13:59:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm, page_alloc: check pfn is valid before moving to
 freelist
Message-Id: <20220412135912.93175db2ab4e83f4bb060dbf@linux-foundation.org>
In-Reply-To: <fb3c8c008994b2ed96f74b6b9698ff998b689bd2.1649794059.git.quic_sudaraja@quicinc.com>
References: <cover.1649794059.git.quic_sudaraja@quicinc.com>
        <fb3c8c008994b2ed96f74b6b9698ff998b689bd2.1649794059.git.quic_sudaraja@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022 13:16:23 -0700 Sudarshan Rajagopalan <quic_sudaraja@quicinc.com> wrote:

> Check if pfn is valid before or not before moving it to freelist.
> 
> There are possible scenario where a pageblock can have partial physical
> hole and partial part of System RAM. This happens when base address in RAM
> partition table is not aligned to pageblock size.
> 
> ...
>
> 
> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> Fixes: 4c7b9896621be ("mm: remove pfn_valid_within() and CONFIG_HOLES_IN_ZONE")

I made that 859a85ddf90e714092dea71a0e54c7b9896621be and added
cc:stable.  I'll await reviewer input before proceeding further.

> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2521,6 +2521,11 @@ static int move_freepages(struct zone *zone,
>  	int pages_moved = 0;
>  
>  	for (pfn = start_pfn; pfn <= end_pfn;) {
> +		if (!pfn_valid(pfn)) {

Readers will wonder how we can encounter an invalid pfn here.  A small
comment might help clue them in.

> +			pfn++;
> +			continue;
> +		}
> +
>  		page = pfn_to_page(pfn);
>  		if (!PageBuddy(page)) {
>  			/*

