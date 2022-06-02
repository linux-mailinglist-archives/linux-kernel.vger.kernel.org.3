Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B895A53BDCC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbiFBSNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiFBSNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:13:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A28312D1A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 11:13:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFEF8616D1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 18:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A6AC385A5;
        Thu,  2 Jun 2022 18:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654193622;
        bh=TQCbTyESjzKocFJ0uHcl7XKEvJfqI5iTnWmUWKSmWA4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VlRGNEn0vm1qYmNdTZwu0UeX/BSvILFmfMDNz9L4PZ/bALKOqVpDL0oO8pFJdbZQf
         cKZA/bh8Z3c0J40YeuyBxy+ybLwWLcTveg2HEA2IJp/RH/N4noxBrMhcF9wWygH9mr
         pWkk0wGpvr3sHR9J37QbaWnrW313/TarOb3saYzI=
Date:   Thu, 2 Jun 2022 11:13:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jakub =?UTF-8?B?TWF0xJtuYQ==?= <matenajakub@gmail.com>
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, kirill@shutemov.name,
        riel@surriel.com, rostedt@goodmis.org, peterz@infradead.org
Subject: Re: [PATCH 1/2] [PATCH 1/2] mm: refactor of vma_merge()
Message-Id: <20220602111341.6674e4d862d6d925b0eebcb3@linux-foundation.org>
In-Reply-To: <20220602145642.16948-2-matenajakub@gmail.com>
References: <20220602145642.16948-1-matenajakub@gmail.com>
        <20220602145642.16948-2-matenajakub@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Jun 2022 16:56:41 +0200 Jakub Matěna <matenajakub@gmail.com> wrote:

> Refactor vma_merge() to make it shorter and more understandable.
> Main change is the elimination of code duplicity in the case of
> merge next check. This is done by first doing checks and caching
> the results before executing the merge itself. The variable 'area' is
> divided into 'mid' and 'res' as previously it was used for two purposes,
> as the middle VMA between prev and next and also as the result of the
> merge itself. Exit paths are also unified.
> 

Thanks, but unfortunately the code you're working on here has changed
greatly in Liam's mapletree patchset.  Could you please take a look at
the mm-unstable branch at
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm and decide if you
want to tackle it?

