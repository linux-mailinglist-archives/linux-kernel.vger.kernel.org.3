Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6892502047
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348564AbiDOCMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbiDOCMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:12:00 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDEEE0E3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:09:33 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B95EA560CD5;
        Fri, 15 Apr 2022 02:09:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2B575560FEB;
        Fri, 15 Apr 2022 02:09:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649988572; a=rsa-sha256;
        cv=none;
        b=ej0QQefeNcxxoi7XPekYKjR12ktfDgwIe6oGfvsXK6SBF9a7v4U4ozSYcTv1N0K/67Jjol
        Hrg3gdP980QNj47N4RnJDQKDLQmJjfoqAwXSskvyDdsvt2SfcXWTJc6VPy23+BN0ihv1by
        MOcneCLnitVkS7CJfqiJizOBES21ylg8xZCmyaEgiidl8ARGr1ESbSa1KWuBud/u7eP5TN
        7vBbq8hmlxshxwvzhk9QzhS/U9UkhOqQ3/iCJxnhVoRR6dkeNgiEdvl6IW0fgVAnwW/ae9
        /op3++UW31z9XsjuCldbGUmmLHJzBO+d44XpoS/0Y8rrqMgjR0Veb1A0MzrLHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649988572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=y/CtK1gEBEC/Kw2WPYqZH9dnFhfpNqnlY6v92/MuI4o=;
        b=xXg0jzihQP537jJO5GB8hiVAK2axmKC8Q88F8bW2WStimubn20rVkLZ7nWEYWiilLzfT/F
        ZcfsyU8zQDKaDKbMPe+qi9mNUEcTerrCzZGDbniElxgUHuz1JG3Th3G5VXuiW3ZJinl1gt
        hINU2r33rNkZMcGD8NBhPxz8Q28eFmyw0Jd+ziK9UOV51PSJaJyS0ClyBP4JD3vJs/0aCK
        EKf4+2amM8QYWd0LN8Efad9yVu3vld6m6sw2HEtqrWj8bayl0Nu0LE4n9AoZlXo4iTNxZQ
        HKy30vmA4VsLilKq/TA6QnLTSIBuZkl3WBr3fyj7J8RRH2v4upvAqbsj6guftg==
ARC-Authentication-Results: i=1;
        rspamd-b69d6888c-26779;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.106.158.161 (trex/6.7.1);
        Fri, 15 Apr 2022 02:09:32 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Well-Made-Scare: 66490a1a1715cb50_1649988572538_3954983236
X-MC-Loop-Signature: 1649988572538:2937066910
X-MC-Ingress-Time: 1649988572538
Received: from offworld (unknown [104.36.29.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4KffsQ67gQz21;
        Thu, 14 Apr 2022 19:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649988571;
        bh=i8OD/SgEbmNj3IrkAtgDlN9p2e7lNCpA2O2Cn1jCdQw=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=O0jSIqTKFTMJCN2KiuWEkdAiRmALylGK3IKhrkKs7fSOdnx3v2SasLIMZQjnn8xMl
         oHV7dtDZ6EGfWczw3KzGX/XUuGrsd/L6Yqt3Wy6XyCO3Zjp9RWnTxMQC6m+GHnvSsA
         u7omsklgN+8P+OTY9Y+yZK6Jc5sz4yHjP0YuS2HS23tIuYq4uE5Bn9EgpGROEqOYTb
         OkiQUZRhLYJJOxYJpCk58NwCdpCw1G+mxZ3WOcWcgNpoDDwO3uZhV4KOYjgV3oxq4w
         AKNVISOoO0ZoVBLKwkeczBTB/eEOzyImO2pUGrpCK7JdUwt5QYqE7yUNf+l0MSHdVv
         VPElCLxWMhxIg==
Date:   Thu, 14 Apr 2022 19:09:27 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peng Liu <liupeng256@huawei.com>
Cc:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, songmuchun@bytedance.com,
        liuyuntao10@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] hugetlb: Fix wrong use of nr_online_nodes
Message-ID: <20220415020927.x7ylevbd5uaevfyt@offworld>
Mail-Followup-To: Peng Liu <liupeng256@huawei.com>, mike.kravetz@oracle.com,
        david@redhat.com, akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, songmuchun@bytedance.com,
        liuyuntao10@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220413032915.251254-1-liupeng256@huawei.com>
 <20220413032915.251254-2-liupeng256@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220413032915.251254-2-liupeng256@huawei.com>
User-Agent: NeoMutt/20201120
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022, Peng Liu wrote:

>Certain systems are designed to have sparse/discontiguous nodes. In
>this case, nr_online_nodes can not be used to walk through numa node.
>Also, a valid node may be greater than nr_online_nodes.
>
>However, in hugetlb, it is assumed that nodes are contiguous. Recheck
>all the places that use nr_online_nodes, and repair them one by one.
>
>Suggested-by: David Hildenbrand <david@redhat.com>
>Fixes: 4178158ef8ca ("hugetlbfs: fix issue of preallocation of gigantic pages can't work")
>Fixes: b5389086ad7b ("hugetlbfs: extend the definition of hugepages parameter to support node allocation")
>Fixes: e79ce9832316 ("hugetlbfs: fix a truncation issue in hugepages parameter")
>Fixes: f9317f77a6e0 ("hugetlb: clean up potential spectre issue warnings")
>Signed-off-by: Peng Liu <liupeng256@huawei.com>
>Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

... but

>---
> mm/hugetlb.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>
>diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>index b34f50156f7e..5b5a2a5a742f 100644
>--- a/mm/hugetlb.c
>+++ b/mm/hugetlb.c
>@@ -2979,7 +2979,7 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
>	struct huge_bootmem_page *m = NULL; /* initialize for clang */
>	int nr_nodes, node;
>
>-	if (nid != NUMA_NO_NODE && nid >= nr_online_nodes)
>+	if (nid != NUMA_NO_NODE && !node_online(nid))

afaict null_blk could also use this, actually the whole thing wants a
helper - node_valid()?
