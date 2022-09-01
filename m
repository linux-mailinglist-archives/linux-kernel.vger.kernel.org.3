Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6094F5AA0D7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 22:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbiIAUWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiIAUWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:22:48 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D2871984
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:22:46 -0700 (PDT)
Date:   Thu, 1 Sep 2022 16:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662063765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u0xu3/NRVBHMhSOs7YUmMQgOzAyvEoInn8uAGnxdBnc=;
        b=xsaNXg6ClTkia3N9XCApr+T7hOmEHqYeNBrhO//DyKKITB0Sngf4P/jvqL8CgjwQv0M9Rq
        ndURvyCQWXs3/iC9U9ZC29K0mosMU2lpgpleibzMM4+pr7N8WSZotbR5e8/06HczYiTuCm
        6zXrCs3c9F0nNmxW0qkBQKzpHYL8R48=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND 03/28] mm: introduce __find_vma to be used
 without mmap_lock protection
Message-ID: <20220901202239.tnnzlbermiyvkmih@moria.home.lan>
References: <20220901173516.702122-1-surenb@google.com>
 <20220901173516.702122-4-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901173516.702122-4-surenb@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:34:51AM -0700, Suren Baghdasaryan wrote:
> Add __find_vma function to be used for VMA lookup under rcu protection.

So it was news to me that the rb tree code can be used for lockless lookups -
not having looked at lib/rbtree.c in over 10 years :) - I still think it should
be mentioned in the commit message that that's what you're doing and why it's
safe, because it's not exactly common knowledge and lockless stuff deserves
extra scrutiny.

Probably worth a comment, too.

Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
