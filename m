Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D91D54D2E2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346321AbiFOUtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiFOUth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:49:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45AF54F96
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90D3EB82177
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBFEC3411A;
        Wed, 15 Jun 2022 20:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655326174;
        bh=KSQ9c1G5/sgy0ACm7XqfABcNHNsUc0e55Tg89/Z10ww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rgg8tyuaX3XDBxsfzFICcJc/ltR0sB9XY0QDTk1xYmwTplADHt5KxPaKRsqeuaK9w
         WdFgLoZcEocE19N3O1L9bUNhjUKHwFte7KULkh3geehZARxBpWz+I9aTcUSYAmL+5L
         Wf1jQA4/QaIxGQx6v/ZBYPVLzpL6va1kQwWlGv/U=
Date:   Wed, 15 Jun 2022 13:49:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     HORIGUCHI =?UTF-8?B?TkFPWUE=?= (=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=) 
        <naoya.horiguchi@nec.com>
Cc:     zhenwei pi <pizhenwei@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v6 1/1] mm/memory-failure: disable unpoison once hw
 error happens
Message-Id: <20220615134933.66f3ba7f3b169b936b2128de@linux-foundation.org>
In-Reply-To: <20220615103406.GA1669251@hori.linux.bs1.fc.nec.co.jp>
References: <20220615093209.259374-1-pizhenwei@bytedance.com>
        <20220615093209.259374-2-pizhenwei@bytedance.com>
        <20220615103406.GA1669251@hori.linux.bs1.fc.nec.co.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 10:34:06 +0000 HORIGUCHI NAOYA(堀口　直也) <naoya.horiguchi@nec.com> wrote:

> On Wed, Jun 15, 2022 at 05:32:09PM +0800, zhenwei pi wrote:
> > Currently unpoison_memory(unsigned long pfn) is designed for soft
> > poison(hwpoison-inject) only. Since 17fae1294ad9d, the KPTE gets
> > cleared on a x86 platform once hardware memory corrupts.
> > 
> > Unpoisoning a hardware corrupted page puts page back buddy only,
> > the kernel has a chance to access the page with *NOT PRESENT* KPTE.
> > This leads BUG during accessing on the corrupted KPTE.
> > 
> > Suggested by David&Naoya, disable unpoison mechanism when a real HW error
> > happens to avoid BUG like this:
> > 
>
> ...
>
> > 
> > Fixes: 847ce401df392 ("HWPOISON: Add unpoisoning support")
> > Fixes: 17fae1294ad9d ("x86/{mce,mm}: Unmap the entire page if the whole page is affected and poisoned")
> > Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> 
> Thank you very much.
> 
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

I added cc:stable to this.  But the dual Fixes: are going to confuse
people regarding which kernel versions need the fix.  Can we be more
specific?


