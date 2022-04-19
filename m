Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F37506329
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347342AbiDSEGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347285AbiDSEGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:06:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BB9240A1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:03:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16F2461158
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113E7C385A5;
        Tue, 19 Apr 2022 04:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650341033;
        bh=xhfzTucOQ3hmK/38S4jkVF5T/mzWkY07l0x1ixVkzkw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q4zP8XmxFdYO3yLCJQQsSZi3Zf/IHCjWAXeIp9NXHWuv1SXDmPT6fq2jVqZjk3evs
         W9CwuS+lF9clvgwAjxRW2WSifAjpGEG2xpfJfIvggL1tExpVtnSQgbKQSobBih/J+C
         8F79ECi2KOMr903EkBeUyIhSWJlUl1/nqqkCnFuI=
Date:   Mon, 18 Apr 2022 21:03:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peng Liu <liupeng256@huawei.com>
Cc:     <mike.kravetz@oracle.com>, <david@redhat.com>,
        <yaozhenguo1@gmail.com>, <baolin.wang@linux.alibaba.com>,
        <songmuchun@bytedance.com>, <liuyuntao10@huawei.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v4] hugetlb: Fix wrong use of nr_online_nodes
Message-Id: <20220418210352.1d1d90aeba477d598bd6f0be@linux-foundation.org>
In-Reply-To: <20220416103526.3287348-1-liupeng256@huawei.com>
References: <20220413032915.251254-2-liupeng256@huawei.com>
        <20220416103526.3287348-1-liupeng256@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Apr 2022 10:35:26 +0000 Peng Liu <liupeng256@huawei.com> wrote:

> Certain systems are designed to have sparse/discontiguous nodes. In
> this case, nr_online_nodes can not be used to walk through numa node.
> Also, a valid node may be greater than nr_online_nodes.
> 
> However, in hugetlb, it is assumed that nodes are contiguous. Recheck
> all the places that use nr_online_nodes, and repair them one by one.

oops.

What are the user-visible runtime effects of this flaw?
