Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F9C51FE68
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbiEINjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiEINi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:38:57 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DAE24C760
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:35:04 -0700 (PDT)
Date:   Mon, 9 May 2022 22:34:53 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652103302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q9HiAaC4YBMcUQ0+C1EKSJEM8bPqXy5gdXi8GIux1ts=;
        b=IEi6/agEu3wE2SDiCGuc2P+dXVFd36JGkqsBM3WbzoPsH/2hTctYPsBl/ZSAvTd7UYpJkO
        fK7MZApyS82Zt72JVUyrTyDHOlTdCkdEdV610CRPIXPZ/mFoQmwMEkb9jGNqxlchUyMt9t
        26okPKmgc8CYL/oM6Kz3Yn/RAyMG1zU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v1 4/4] mm, memory_hotplug: fix inconsistent
 num_poisoned_pages on memory hotremove
Message-ID: <20220509133453.GA2511740@u2004>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <20220427042841.678351-5-naoya.horiguchi@linux.dev>
 <828cc111-40e8-88ed-bb50-fb185e5f0304@huawei.com>
 <20220428040556.GA3945421@hori.linux.bs1.fc.nec.co.jp>
 <4cae9c00-a048-2c0a-9a45-d7abb956fde7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cae9c00-a048-2c0a-9a45-d7abb956fde7@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 03:16:01PM +0800, Miaohe Lin wrote:
> On 2022/4/28 12:05, HORIGUCHI NAOYA(堀口 直也) wrote:
> > On Thu, Apr 28, 2022 at 11:20:16AM +0800, Miaohe Lin wrote:
> >> On 2022/4/27 12:28, Naoya Horiguchi wrote:
> >>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> >>>
> >>> When offlining memory section with hwpoisoned pages, the hwpoisons are
> >>> canceled. But num_poisoned_pages is not updated for that event, so the
> >>> counter becomes inconsistent.
> >>
> >> IIUC, this work is already done via clear_hwpoisoned_pages when __remove_pages.
> >> Or am I miss something?
> > 
> > Actually I had the same question when writing this patch, and found that
> > __remove_pages() seems to be called from device memory or HMM, but not from
> 
> It seems remove_memory (which calls __remove_pages) will be called as .detach callback of
> memory_device_handler in drivers/acpi/acpi_memhotplug.c. So the hwpoison info will also be
> clear for that memory ?

Sorry, you're right.  That code path also calls __remove_pages() and
clear_hwpoisoned_pages(). So most major usecases of memory hotremove seems
not to be affected by the reported problem.

Thanks,
Naoya Horiguchi
