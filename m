Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7E25166E7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 20:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349800AbiEASVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 14:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240872AbiEASVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 14:21:35 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E611549CA2
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 11:18:08 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CEF9A800C2C;
        Sun,  1 May 2022 18:09:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D131C8010C4;
        Sun,  1 May 2022 18:09:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1651428589; a=rsa-sha256;
        cv=none;
        b=CJYhUxCbGB/eL1q914IdlKFsLyurizZVCg2oKzPPTxPO+ehQaY6Z/4YKE996xv0Q7coJ0B
        4UcSLdPpH6DPMcys2kiZyrBMpPm85WYQBoSdQy670mJz9GkS+ZKMxD3m4srJwnl+/nfYgE
        IsLmtYo6IKLEfF3oA8Q35QedAC7/VeKnb88VeXBhQrYgLhDMWFfPHY6jVvf1KIDUANFWd/
        6r6sNYq9K2/ka/TB96T5+n/s2XUItT0TC9Ry9iJcZVyF7+fSV69RpCEho/gFLFNwqe+mNJ
        fU4mJMzbxcJM/v4TTbUmdxo8/AtyFaKiRUzcv0cQduoRDEmj6sTTvl3hZ3ZgDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1651428589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=tstCgkKX0CTUBfcePQvf8fcvcQvBK91nJ9jys4mKMuc=;
        b=pu91Nz2X+MMnfXTxRn+mFu77DIyciuyzxiH8xNMncQyyFTw2+R+H7CfvqTmbZm9yXvFRBK
        fGMKgVj91Em1/FfTt88Wii7G3qn/EZc/nEiaVZ9ijuZ0hBrQtTEAt/QNCmKmpbL1zDIJkn
        FXplFTz6sdO6yndo9EAnmmFW6sGbS/Go6dfDfdExhRwsP/5NaObrxGBErpv+QGN8qHAxDN
        9J7xguDUv7YAImjg/5ulSO7oZGqaOwvw42xL6tFKXSy09FZ5Z7h7mD37XDnVM3rFwR4jFM
        53TH5HL17Fjr7CwkE6di6A+BK5sSutA8o2dld/XFi2oY2f1nedB98qJeABGgVw==
ARC-Authentication-Results: i=1;
        rspamd-fdd564cbf-k8kdc;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eyes-Power: 4c4c5cf05ea0d7a7_1651428589288_404621652
X-MC-Loop-Signature: 1651428589288:957680797
X-MC-Ingress-Time: 1651428589288
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.199 (trex/6.7.1);
        Sun, 01 May 2022 18:09:49 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4KrvQ32sCZz18s;
        Sun,  1 May 2022 11:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1651428588;
        bh=tstCgkKX0CTUBfcePQvf8fcvcQvBK91nJ9jys4mKMuc=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=gPwxjdHdjY14Q0BfsIHWp6ETDoo4sLxfdo/Hzxs9oMu47uat3+ITnLVayg+oOmDXY
         8oit5X8JURtm366pyeG3aOzcTY0oPyubJonQHGlCu4y9wfvUL1sk41aVdpX/hVVSDk
         rdyJd9ai0OZbZbvVwvSuV/pF+sVh4suohK0W0lbeR6MkB6j80UrNfZROxNe6Vnp1n5
         3ey7TYXE6wI2RKgrvQpCVFIj+1vpvWR1VNNZBRBAPGOxrB1fb2wFdPXkauXlDduAp4
         pp8NxDAWnXJpcW72q8ic+/pE3EJlaxgAHswRq8wUtThMcaH4jBXTSMZP2Hg4TfPAt3
         RIV/OrJuYuGKw==
Date:   Sun, 1 May 2022 10:58:13 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Wei Xu <weixugc@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>, Jonathan.Cameron@huawei.com
Subject: Re: RFC: Memory Tiering Kernel Interfaces
Message-ID: <20220501175813.tvytoosygtqlh3nn@offworld>
Mail-Followup-To: Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>, Jonathan.Cameron@huawei.com
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
User-Agent: NeoMutt/20220408
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nice summary, thanks. I don't know who of the interested parties will be
at lsfmm, but fyi we have a couple of sessions on memory tiering Tuesday
at 14:00 and 15:00.

On Fri, 29 Apr 2022, Wei Xu wrote:

>The current kernel has the basic memory tiering support: Inactive
>pages on a higher tier NUMA node can be migrated (demoted) to a lower
>tier NUMA node to make room for new allocations on the higher tier
>NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
>migrated (promoted) to a higher tier NUMA node to improve the
>performance.

Regardless of the promotion algorithm, at some point I see the NUMA hinting
fault mechanism being in the way of performance. It would be nice if hardware
began giving us page "heatmaps" instead of having to rely on faulting or
sampling based ways to identify hot memory.

>A tiering relationship between NUMA nodes in the form of demotion path
>is created during the kernel initialization and updated when a NUMA
>node is hot-added or hot-removed.  The current implementation puts all
>nodes with CPU into the top tier, and then builds the tiering hierarchy
>tier-by-tier by establishing the per-node demotion targets based on
>the distances between nodes.
>
>The current memory tiering interface needs to be improved to address
>several important use cases:
>
>* The current tiering initialization code always initializes
>  each memory-only NUMA node into a lower tier.  But a memory-only
>  NUMA node may have a high performance memory device (e.g. a DRAM
>  device attached via CXL.mem or a DRAM-backed memory-only node on
>  a virtual machine) and should be put into the top tier.

At least the CXL memory (volatile or not) will still be slower than
regular DRAM, so I think that we'd not want this to be top-tier. But
in general, yes I agree that defining top tier as whether or not the
node has a CPU a bit limiting, as you've detailed here.

>Tiering Hierarchy Initialization
>================================
>
>By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
>
>A device driver can remove its memory nodes from the top tier, e.g.
>a dax driver can remove PMEM nodes from the top tier.
>
>The kernel builds the memory tiering hierarchy and per-node demotion
>order tier-by-tier starting from N_TOPTIER_MEMORY.  For a node N, the
>best distance nodes in the next lower tier are assigned to
>node_demotion[N].preferred and all the nodes in the next lower tier
>are assigned to node_demotion[N].allowed.
>
>node_demotion[N].preferred can be empty if no preferred demotion node
>is available for node N.

Upon cases where there more than one possible demotion node (with equal
cost), I'm wondering if we want to do something better than choosing
randomly, like we do now - perhaps round robin? Of course anything
like this will require actual performance data, something I have seen
very little of.

>Memory tiering hierarchy is rebuilt upon hot-add or hot-remove of a
>memory node, but is NOT rebuilt upon hot-add or hot-remove of a CPU
>node.

I think this makes sense.

Thanks,
Davidlohr
