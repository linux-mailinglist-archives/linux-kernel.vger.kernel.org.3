Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69FA50205C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348623AbiDOCSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348651AbiDOCRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:17:48 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704F64EF7B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:15:21 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8C2E52C1605;
        Fri, 15 Apr 2022 02:15:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id ED6B62C15B3;
        Fri, 15 Apr 2022 02:15:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649988916; a=rsa-sha256;
        cv=none;
        b=csg3VAjWrKlmuUdFIJIaXfkQ5aEm6nJd/0gf6KbM2hD2lC8RniXRRweYovGxKcj5H3ZpO+
        xJi31RfFxKAwKDQt7IuGuYa4sx1lpDQ4f0fcx1CgXQU7WNtslqxV08qoc3EP4hMHyD1vxp
        NUgkoS83SCHPv7RRmhLYvPHpfC1BxTFc1/xwH6AuJaFT2CndH+KtvrNhYmjUcd5ww0O8qY
        m65n+XIOFZGl3TZrtW40B3nl3DaJIjtnXvRWgbCuK/0QX3kLcYGZyc1vsYnia8o4WIhuD/
        OnBW8bUrecideCli5cBZgzkSO6qjWDbhtFgrM9czE15ZutKu7YGLh1fGHVTVgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649988916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=dz5Wwxtt/F+rPapsz8dcTMyUJ8q7Bm+tkN212GU+u9c=;
        b=4pMJDFR57ueK17Vf+MYnVFaCL59GD022C5ulxPIDreqnrw0X9kVyHzr30qDHb500P0u7uu
        pMW55fd0EC4t35C1cEmUnuYzWZxg/1XSQRVS/PWSxlDsJZZgQr4MzqVkl2XcBivg6DhIll
        PAtafiM/pZwy3sEC+SbkWTp9NNGp9Ddv4//PHk/ATC0cagTX5jICgPMc8T+b+1lNTyzrW9
        iuwsA15KujsEvukXrqMBUbA0JHqb01zokqWnS9efERc2iiz5lBqhnIsMLFkFsB0hQaAO2O
        1bKuEQ0Y1I4ot3+ACYVGCgzra7b/RVSy2bfDoSvEsLEyzYtfNBFLQCGIiMK41g==
ARC-Authentication-Results: i=1;
        rspamd-5f678fb567-s2k5n;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.121.210.130 (trex/6.7.1);
        Fri, 15 Apr 2022 02:15:20 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Tart: 11e5f22a6a91453f_1649988920393_1356613706
X-MC-Loop-Signature: 1649988920393:1604594317
X-MC-Ingress-Time: 1649988920392
Received: from offworld (unknown [104.36.29.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4Kfg025ddvz21;
        Thu, 14 Apr 2022 19:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649988915;
        bh=Y3YjnHSEipQJUkJVNY24AKUsVbAZTAEmNGpqaDGCzgA=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=CxDyXtYc9ZEqRjmlofOKEFmgKOF82yFZef5LtdVlgdfeVExRn+WepZJsh8hyQIDu/
         05a24ZquNyWE1BRI8b48MlG8pE5pDBMyNEObTsJuV0Qk0KyHREDzFdDpT9xxvxgYqO
         +tKUz8i7vgjP0X4fuqgA0GMuf/7fG6n2MVHqacfeCMThwye3zri6VasMm25K2gihyi
         i+7lZUzDA0bLXExd3Rk3zh5LE0pgvRpejmphqvEmJ9mVXO1nTxVnR/rnpNSRAad556
         UWfBMvptiewYm2N3VL0BJMPkYDPTejvZLUcwAnooSxjjDXcEIAKgMs8rVDDvOyaV8I
         FPv6OxRRPT60w==
Date:   Thu, 14 Apr 2022 19:15:11 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peng Liu <liupeng256@huawei.com>
Cc:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, songmuchun@bytedance.com,
        liuyuntao10@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] hugetlb: Clean up hugetlb_cma_reserve
Message-ID: <20220415021511.umtrspqwovitnrtm@offworld>
Mail-Followup-To: Peng Liu <liupeng256@huawei.com>, mike.kravetz@oracle.com,
        david@redhat.com, akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, songmuchun@bytedance.com,
        liuyuntao10@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220413032915.251254-1-liupeng256@huawei.com>
 <20220413032915.251254-5-liupeng256@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220413032915.251254-5-liupeng256@huawei.com>
User-Agent: NeoMutt/20201120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022, Peng Liu wrote:

>Use more generic functions to deal with issues related to online
>nodes. The changes will make the code simplified.
>
>Signed-off-by: Peng Liu <liupeng256@huawei.com>
>Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> mm/hugetlb.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>index 2e4d8d9fb7c6..4c529774cc08 100644
>--- a/mm/hugetlb.c
>+++ b/mm/hugetlb.c
>@@ -6953,7 +6953,7 @@ void __init hugetlb_cma_reserve(int order)
>		if (hugetlb_cma_size_in_node[nid] == 0)
>			continue;
>
>-		if (!node_state(nid, N_ONLINE)) {
>+		if (!node_online(nid)) {

You could update mm/page_ext.c as well

>			pr_warn("hugetlb_cma: invalid node %d specified\n", nid);
>			hugetlb_cma_size -= hugetlb_cma_size_in_node[nid];
>			hugetlb_cma_size_in_node[nid] = 0;
>@@ -6992,7 +6992,7 @@ void __init hugetlb_cma_reserve(int order)
>	}
>
>	reserved = 0;
>-	for_each_node_state(nid, N_ONLINE) {
>+	for_each_online_node(nid) {

... and arch/ia64/kernel/uncached.c for this.
