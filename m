Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8025373CD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 06:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbiE3EEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 00:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiE3EEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 00:04:25 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F1DBC3A
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 21:04:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LBMH50Q5zz4xD2;
        Mon, 30 May 2022 14:04:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1653883457;
        bh=x0svsTO+jOFwH/KVWpk821pyzNznqc/zH685jsc3xAo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UCycBCGZN4FwwG9NtPjTOTY9Z6WdyBcbaCY1PV8XmA12shhVCHuzIe5pdqh2qYFyk
         PvtxE+XWmWXjkR889bgopN8vT1jB3UHEMi7kCJEHHylLZwHJy4YWI6hcRkKXK3da3R
         kqDNRTvZol2gq/YWneJ5EK/RWA4uYCtAO1l2ZY3ixLtsy3wr87J4ZWsCsNQDfZ8MJk
         qQTb9AyVIt7AFnTWq0hZOGBdZY0as/KlU0ZmYbT6HjW2OB2YKu0E8IB1/VqHkWB0z6
         u6COQPyxQl+Wdp58uKjrK4Dj8FYXNKb93F/LQ7zUWabwIGqegG1utiF9qIwyF5SzSU
         a+TD/72hO8qWA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4] mm: Avoid unnecessary page fault retires on shared
 memory types
In-Reply-To: <20220527193936.30678-1-peterx@redhat.com>
References: <20220527193936.30678-1-peterx@redhat.com>
Date:   Mon, 30 May 2022 14:04:12 +1000
Message-ID: <87mtezll8j.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:
> I observed that for each of the shared file-backed page faults, we're very
> likely to retry one more time for the 1st write fault upon no page.  It's
> because we'll need to release the mmap lock for dirty rate limit purpose
> with balance_dirty_pages_ratelimited() (in fault_dirty_shared_page()).
>
...

>  arch/powerpc/mm/copro_fault.c |  5 +++++
>  arch/powerpc/mm/fault.c       |  5 +++++

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
