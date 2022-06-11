Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44BF547788
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 22:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiFKUdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 16:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiFKUdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 16:33:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1625C112C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 13:33:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE175B80B4D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 20:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AAFC34116;
        Sat, 11 Jun 2022 20:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654979617;
        bh=F7EHT9nZNVQPeqtZoCb685s4XBj+VIt+AKyBVKyAR8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b/zAgY8QdVjsqF7/QCSMna5TOmNv+PT2Q+hVV7LDXhuXgEABctZAXDkPzDEYdS99T
         /Uyvrf+ISelOhLCCUGO+gIdxx3CeSwT+xZxPGocc8G8ucXhBiEJkszNR/TkMdiEXQl
         APDF5E95LyAuBGog8WUrB9eFTPabRgYXJDmIjGk8=
Date:   Sat, 11 Jun 2022 13:33:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <aarcange@redhat.com>, <willy@infradead.org>, <vbabka@suse.cz>,
        <dhowells@redhat.com>, <neilb@suse.de>, <apopple@nvidia.com>,
        <david@redhat.com>, <surenb@google.com>, <peterx@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] mm/khugepaged: remove unneeded shmem_huge_enabled()
 check
Message-Id: <20220611133336.b582edd4c2c2df15f5561d2b@linux-foundation.org>
In-Reply-To: <20220611084731.55155-2-linmiaohe@huawei.com>
References: <20220611084731.55155-1-linmiaohe@huawei.com>
        <20220611084731.55155-2-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jun 2022 16:47:25 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> If we reach here, hugepage_vma_check() has already made sure that hugepage
> is enabled for shmem. Remove this duplicated check.

I updated this to

If we reach here, hugepage_vma_check() has already made sure that hugepage
is enabled for shmem, via its call to hugepage_vma_check().  Remove this
duplicated check.

