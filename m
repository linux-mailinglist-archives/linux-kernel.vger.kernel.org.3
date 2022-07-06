Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663A5567C27
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 04:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiGFCzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 22:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGFCzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 22:55:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DC0E020
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 19:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74F1A61927
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFE6C341C7;
        Wed,  6 Jul 2022 02:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1657076136;
        bh=aZe8FghVjL3+BWsHGygyWWsDx2e7R00gyJLLEN8krq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XNVyorfq726NBsGrpN6mGHeBsxpTSAitFOiLHGyYh7mgvyqBBP3kMZNARjKHb8jAS
         lRBRON2JEKnmC8ZyaEbiztcOtljZfbYTmZ5UXzrpvUFSVb50dpSO/SpM14UG90GlEi
         WAvlW3N1Xe+eoEkcBZRVM+yZM/7z2zaHvtd8ZixE=
Date:   Tue, 5 Jul 2022 19:55:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH] maple_tree: Fix use of node for global range in
 mas_wr_spanning_store()
Message-Id: <20220705195535.a32ce0de9b45fe73eea72c82@linux-foundation.org>
In-Reply-To: <20220706020526.1869453-1-Liam.Howlett@oracle.com>
References: <20220706020526.1869453-1-Liam.Howlett@oracle.com>
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

On Wed, 6 Jul 2022 02:05:37 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> When writing a range with a NULL which expands to 0 - ULONG_MAX, don't
> use a node to store this value.  Instead, call mas_new_root() which will
> set the tree pointer to NULL and free all the nodes.
> 
> Fix a comment for the allocations in mas_wr_spanning_store().
> 
> Add mas_node_count_gfp() and use it to clean up mas_preallocate().
> 
> Clean up mas_preallocate() and ensure the ma_state is safe on return.
> 
> Update maple_tree.h to set alloc = NULL.

Cool.

How are we looking now?  Any known issues still being worked on?
