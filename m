Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053455A3384
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 03:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344902AbiH0BgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 21:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiH0Bf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 21:35:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1260DEB56
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:35:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88166B83210
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 01:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6984C433D6;
        Sat, 27 Aug 2022 01:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661564154;
        bh=FZdgvl+z5rvlO3Bk3GQBKq4odiPFkU2MmC2I/PED5a0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=02pOj+XPjfuCualHR+jl7BkRv3tY44bOGtpdm8NGc15OcRGIA8Pv8R1kVfJZ6GH6I
         P07Ui0asihnmZSjSwW1sIoQATNERkZWkRDFupultnyUi03CbKFMRZ5mgvXjDCoLVet
         +7XNB3B0+FFJXl9X48wzFlpVj6PQw/kAAAM7E0Jw=
Date:   Fri, 26 Aug 2022 18:35:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Feng Tang <feng.tang@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: deduplicate cacheline padding code
Message-Id: <20220826183553.4b923552ccddb07f0a78ac8b@linux-foundation.org>
In-Reply-To: <20220826230642.566725-1-shakeelb@google.com>
References: <20220826230642.566725-1-shakeelb@google.com>
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

On Fri, 26 Aug 2022 23:06:42 +0000 Shakeel Butt <shakeelb@google.com> wrote:

> There are three users (mmzone.h, memcontrol.h, page_counter.h) using
> similar code for forcing cacheline padding between fields of different
> structures. Dedup that code.
> 
> ...
> 
>  include/linux/cache.h        | 13 +++++++++++++
>  include/linux/memcontrol.h   | 13 ++-----------
>  include/linux/mmzone.h       | 24 +++++-------------------
>  include/linux/page_counter.h | 13 ++-----------

I'm looking for an obvious and reliable way in which those three
headers include cache.h.  Seems that mm_types.h's inclusion of cache.h
should be sufficient.  Direct inclusion of cache.h would of course be
safest.  I guess if it breaks, we'll hear about it ;)

