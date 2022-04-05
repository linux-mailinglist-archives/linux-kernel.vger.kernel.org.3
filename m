Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784814F20EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiDECsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiDECqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:46:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7303F7DC6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:51:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DF8260DF4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 01:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B523FC2BBE4;
        Tue,  5 Apr 2022 01:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649123485;
        bh=FUZOU/Zn0+hZCBwK2e+4+p0g7CLULnGx2JfDvAvsADs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IpU2thuQeNKvYD6CYRgqr/cFuvGZb+Tpddf2ICMSZSIViQJXCFZVasjVw4SdeRjtt
         31SDzw45/X1ijxvol2oA981Bgm0i6wvclpyzHJJG+j3PZOdD7plY8fD2ffvO/H2cjW
         qXsjUWT/q4xsdAYI3mzSeGskOsTX8W8VwUnMLOgY=
Date:   Mon, 4 Apr 2022 18:51:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     HORIGUCHI =?UTF-8?B?TkFPWUE=?= (=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=) 
        <naoya.horiguchi@nec.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] mm/hwpoison: fix race between hugetlb free/demotion
 and memory_failure_hugetlb()
Message-Id: <20220404185123.5be4389d99a0e4665a775da1@linux-foundation.org>
In-Reply-To: <20220405014544.GA2583652@hori.linux.bs1.fc.nec.co.jp>
References: <20220404092131.751733-1-naoya.horiguchi@linux.dev>
        <20220404115333.8cf80b9d3a7a55993ed60c57@linux-foundation.org>
        <20220405014544.GA2583652@hori.linux.bs1.fc.nec.co.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022 01:45:45 +0000 HORIGUCHI NAOYA(堀口　直也) <naoya.horiguchi@nec.com> wrote:

> On Mon, Apr 04, 2022 at 11:53:33AM -0700, Andrew Morton wrote:
> > On Mon,  4 Apr 2022 18:21:31 +0900 Naoya Horiguchi <naoya.horiguchi@linux.dev> wrote:
> > 
> > > There is a race condition between memory_failure_hugetlb() and hugetlb
> > > free/demotion, which causes setting PageHWPoison flag on the wrong page.
> > > The one simple result is that wrong processes can be killed, but another
> > > (more serious) one is that the actual error is left unhandled, so no one
> > > prevents later access to it, and that might lead to more serious results
> > > like consuming corrupted data.
> > 
> > Should this fix be backported into stable kernels?
> 
> This is a bug fix, so eligible to send to stable. But I thought that this
> patch is larger than 100 lines (and hard to separeter to finer patches),
> which seems to violate the rule stated in
> Documentation/process/stable-kernel-rules.rst.
> 
> But actually this rule might not be strictly applied (some patches in
> v5.16.y do have more than 100 lines diff...). So if we can ignore this rule
> exceptionally, that's OK and I'll add CC to stable again.

I never actually knew about that rule ;)

Thanks, I added the cc:stable.

> The target commit of Fixed: tag is 761ad8d7c7b5 ("mm: hwpoison: introduce
> memory_failure_hugetlb()") which was introduced in 4.13, so most of active
> stable trees are affected.

Oh. That's good to know.  The original patch didn't have a Fixes: line.
I added that as well.

