Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B5F5968DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbiHQFna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238570AbiHQFn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:43:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662B378585
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:43:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0900BB81AD3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314BAC433C1;
        Wed, 17 Aug 2022 05:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660715003;
        bh=eO0iTKHSzV5zu2OW1AHPVACUhzexWpCHKWbHsLA3IyE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iHLU9TKRjJwKkO5OE7I/ksAsyI6BY+LMp3cx1Q1cEP8beB2C4rA8Xn/U1TEMbLGWl
         wb77SXwP7DeBWpQIh1u4ML6uVyeTU9RHGVZLUgDDPsQf2grtXQjcrFLQUrAX3PcI9/
         sgfKzwSStjyTLI8rYImkTntzXfNiQDBKfDWWF3KQ=
Date:   Tue, 16 Aug 2022 22:43:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Wang, Haiyue" <haiyue.wang@intel.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v6 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Message-Id: <20220816224322.33e0dfbcbf522fcdc2026f0e@linux-foundation.org>
In-Reply-To: <BYAPR11MB3495F747CBF95E079E8FC8A5F76A9@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
        <20220816022102.582865-1-haiyue.wang@intel.com>
        <20220816022102.582865-2-haiyue.wang@intel.com>
        <20220816175838.211a1b1e85bc68c439101995@linux-foundation.org>
        <BYAPR11MB3495F747CBF95E079E8FC8A5F76A9@BYAPR11MB3495.namprd11.prod.outlook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 03:31:37 +0000 "Wang, Haiyue" <haiyue.wang@intel.com> wrote:

> > >  		}
> > 
> > I would be better to fix this for real at those three client code sites?
> 
> Then 5.19 will break for a while to wait for the final BIG patch ?

If that's the proposal then your [1/2] should have had a cc:stable and
changelog words describing the plan for 6.0.

But before we do that I'd like to see at least a prototype of the final
fixes to s390 and hugetlb, so we can assess those as preferable for
backporting.  I don't think they'll be terribly intrusive or risky?

