Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5095B1074
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiIGXfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIGXff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:35:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAD325589
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:35:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C017261B09
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 23:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137E2C433C1;
        Wed,  7 Sep 2022 23:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662593733;
        bh=H9RDF9OiTaoOA9yZu6oVkkKo3sgFcjeJpEoCasUhSiY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0ZI77c2SpLtuQWG8DwLDs3E9RL5BsOTZczG0Gj+11coXyTQcyLcCG7MUP+/UZvSSo
         PSjzwqBNxXBs1TFUTcOIzlK+QepJjN65E076vhbU+OaKEU8OVnK1Pqp5acOgs44VNp
         sO9aaGXjbmfIoEkKfkzKm+jP7h/Vzjs5A2PJNY+0=
Date:   Wed, 7 Sep 2022 16:35:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] mm/huge_memory: prevent THP_ZERO_PAGE_ALLOC increased
 twice
Message-Id: <20220907163532.413d52275e8a8d865e9321d2@linux-foundation.org>
In-Reply-To: <a694528c-f572-c651-24b3-77915053f992@huawei.com>
References: <20220905133813.2253703-1-liushixin2@huawei.com>
        <20220905130728.1e814d185b189faece6f2c2f@linux-foundation.org>
        <a694528c-f572-c651-24b3-77915053f992@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 09:52:23 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> On 2022/9/6 4:07, Andrew Morton wrote:
> > On Mon, 5 Sep 2022 21:38:13 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
> >
> >> If two or more threads call get_huge_zero_page concurrently, THP_ZERO_PAGE_ALLOC
> >> may increased two or more times. But actually, this should only count
> >> as once since the extra zero pages has been freed.
> > Well, for better of for worse,
> > Documentation/admin-guide/mm/transhuge.rst says
> >
> > thp_zero_page_alloc
> > 	is incremented every time a huge zero page is
> > 	successfully allocated. It includes allocations which where
> > 	dropped due race with other allocation. Note, it doesn't count
> > 	every map of the huge zero page, only its allocation.
> >
> > If you think this interprtation should be changed then please explain
> > why, and let's be sure to update the documentation accordingly.
> >
> > .
> Thanks for your explanation. I misunderstood the meaning of thp_zero_page_alloc before.
> Although the rules are clearly explained in the documentation, I think that this variable
> should only incremented when a huge zero page used for thp is successfully allocated and
> the pages dropped due race should skip increment. It seems strange to count in all allocations.
> 
> If there's something I still misunderstand, please point it out, thanks.

It seems strange to me also.  Perhaps there's a rationale buried in the
git and mailing list history.

