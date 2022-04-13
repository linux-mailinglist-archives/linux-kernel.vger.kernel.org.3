Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F785500186
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 00:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbiDMWGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 18:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbiDMWGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 18:06:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAFE321
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 15:04:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0339CB82795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 22:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4867FC385A7;
        Wed, 13 Apr 2022 22:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649887466;
        bh=M42UimkzXE80vxa1qAP02iT+NFCIF1EgvaR5EBI4QG8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DVPonsQGL6eZmLwgmK7QOXsztBWhzECZLJmherYwMvcFRR1P0ErsfadtB2nWNhyPf
         RYaEV9p0ldaZViiw+r1+gKmctMi4Of7bgc5/nJfL9anwjojKx+Zg93USQyxU4tReQS
         cLheyrmwdz9ezfPE7k/RpZp3MC1XOcGae4BaQqgw=
Date:   Wed, 13 Apr 2022 15:04:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "liupeng (DM)" <liupeng256@huawei.com>
Cc:     <mike.kravetz@oracle.com>, <david@redhat.com>,
        <yaozhenguo1@gmail.com>, <baolin.wang@linux.alibaba.com>,
        <songmuchun@bytedance.com>, <liuyuntao10@huawei.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] hugetlb: Fix wrong use of nr_online_nodes
Message-Id: <20220413150422.e4fc3bda48a285bf7bdc5587@linux-foundation.org>
In-Reply-To: <692ee24c-a705-0c54-7cad-a9ecf49a8f15@huawei.com>
References: <20220413032915.251254-1-liupeng256@huawei.com>
        <20220413032915.251254-2-liupeng256@huawei.com>
        <20220412214238.84c20437a052458f6967e9fd@linux-foundation.org>
        <692ee24c-a705-0c54-7cad-a9ecf49a8f15@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 14:27:54 +0800 "liupeng (DM)" <liupeng256@huawei.com> wrote:

> 
> On 2022/4/13 12:42, Andrew Morton wrote:
> > On Wed, 13 Apr 2022 03:29:12 +0000 Peng Liu<liupeng256@huawei.com>  wrote:
> >
> >> Certain systems are designed to have sparse/discontiguous nodes. In
> >> this case, nr_online_nodes can not be used to walk through numa node.
> >> Also, a valid node may be greater than nr_online_nodes.
> >>
> >> However, in hugetlb, it is assumed that nodes are contiguous. Recheck
> >> all the places that use nr_online_nodes, and repair them one by one.
> >>
> > What are the runtime effects of this shortcoming?
> > .
> 
> For sparse/discontiguous nodes, the current code may treat a valid node
> as invalid, and will fail to allocate all hugepages on a valid node that
> "nid >= nr_online_nodes".
> 
> As David suggested:
> if (tmp >= nr_online_nodes)
> 	goto invalid;
> 
> Just imagine node 0 and node 2 are online, and node 1 is offline. Assuming
> that "node < 2" is valid is wrong.

So do you think we should backport thtis fix into earlier kernel releases?
