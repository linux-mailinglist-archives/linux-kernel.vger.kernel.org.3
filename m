Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2284E7CA6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiCYVOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 17:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiCYVOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 17:14:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99A432EEB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:13:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 573CFB828FB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 21:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF56C340ED;
        Fri, 25 Mar 2022 21:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648242794;
        bh=4/qvwLbF144DV002vGnw2JVaZn3rO4oCb6NnlPXDKRM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N2MCE449O+Nqn5lrRgfBrtwaW18IZdu4ofPJ+Ae7OGHw+5/7RLV2pABU2kEMc0NMI
         cYGtEESnzFEJnPq68PCsLwUntvzuQVaziKubf7t4L8OZSmDPnXKWkgWE2VfuLF24Zd
         iYBR77U7KSbMUnhWZ7KkGeaQXm2sNhgZdMAwIuwY=
Date:   Fri, 25 Mar 2022 14:13:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, andrey.konovalov@linux.dev,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v6 27/39] kasan, mm: only define
 ___GFP_SKIP_KASAN_POISON with HW_TAGS
Message-Id: <20220325141312.b71069800f279445749e79f5@linux-foundation.org>
In-Reply-To: <CA+fCnZeG5DbxcnER1yWkJ50605_4E1xPtgeTEsSEc89qUg4w6g@mail.gmail.com>
References: <cover.1643047180.git.andreyknvl@google.com>
        <44e5738a584c11801b2b8f1231898918efc8634a.1643047180.git.andreyknvl@google.com>
        <63704e10-18cf-9a82-cffb-052c6046ba7d@suse.cz>
        <YjsaaQo5pqmGdBaY@linutronix.de>
        <CA+fCnZeG5DbxcnER1yWkJ50605_4E1xPtgeTEsSEc89qUg4w6g@mail.gmail.com>
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

On Wed, 23 Mar 2022 14:36:29 +0100 Andrey Konovalov <andreyknvl@gmail.com> wrote:

> If my suggestion sounds good, Andrew, could you directly apply the
> changes? They are needed for these 3 patches:
> 
> kasan, page_alloc: allow skipping memory init for HW_TAGS
> kasan, page_alloc: allow skipping unpoisoning for HW_TAGS
> kasan, mm: only define ___GFP_SKIP_KASAN_POISON with HW_TAGS
> 
> As these depend on each other, I can't send separate patches that can
> be folded for all 3.

It's all upstream now, so please send along a fixup patch.
