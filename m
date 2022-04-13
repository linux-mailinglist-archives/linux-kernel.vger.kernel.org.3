Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2514FEE56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 06:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiDMEpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 00:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiDMEpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 00:45:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9543D12ACB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 21:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AD70B82075
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716F5C385A4;
        Wed, 13 Apr 2022 04:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649824959;
        bh=BO4/OgfkvQXwuWlu6YluOvcDnCx28FhpevAMGxUUcZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=shlE7lCEhNaqsAU6Qrd654pmXjf3ofBQxnj+KuFvMeeGwYBZkxovxz2Zi/98xyPZz
         q2CUs71OykxdbRQBCBnvYiJY/POcd2e2OAsoIEF2Y03SjsS3Wabedt6oPz6pnDFvIE
         UYMSM67lIk82yfgw6hlXsf5pFS7ho4M3qyrwgq0g=
Date:   Tue, 12 Apr 2022 21:42:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peng Liu <liupeng256@huawei.com>
Cc:     <mike.kravetz@oracle.com>, <david@redhat.com>,
        <yaozhenguo1@gmail.com>, <baolin.wang@linux.alibaba.com>,
        <songmuchun@bytedance.com>, <liuyuntao10@huawei.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] hugetlb: Fix wrong use of nr_online_nodes
Message-Id: <20220412214238.84c20437a052458f6967e9fd@linux-foundation.org>
In-Reply-To: <20220413032915.251254-2-liupeng256@huawei.com>
References: <20220413032915.251254-1-liupeng256@huawei.com>
        <20220413032915.251254-2-liupeng256@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 03:29:12 +0000 Peng Liu <liupeng256@huawei.com> wrote:

> Certain systems are designed to have sparse/discontiguous nodes. In
> this case, nr_online_nodes can not be used to walk through numa node.
> Also, a valid node may be greater than nr_online_nodes.
> 
> However, in hugetlb, it is assumed that nodes are contiguous. Recheck
> all the places that use nr_online_nodes, and repair them one by one.
> 

What are the runtime effects of this shortcoming?
