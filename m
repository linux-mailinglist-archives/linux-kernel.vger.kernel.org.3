Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6E659F122
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiHXBuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbiHXBuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:50:04 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D63FEE39
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:49:58 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6A036227A8;
        Wed, 24 Aug 2022 01:49:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a225 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CB62921B02;
        Wed, 24 Aug 2022 01:49:51 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661305791; a=rsa-sha256;
        cv=none;
        b=WW5z5lEU9noLsABoHpOYtdYsodXbS09xDkty1iJ8fjY0llT386Ys6Ks06PisjtZh0f04mp
        FwQriGUuQZDtZHMLCK6m+1HBcfyh1JBFckQhpn2NNNiiMVVwnj8PpRR8ARdjaqSHw+VQB1
        hgmXrrYu7fTqbKmoZ35gkX6DTHrnnDeZ2Gjxp//1u9WOHLsWl38+fYl7KDp8z8Yj8mNyr0
        cmBOWaW2ZOsrDBECTQP0RJwA+5muKXnvXUZRlOY1yoo/4LaTwLrx5KNBRAFhdfAHGKGWj/
        0A9bEq4WylfmoKlf2g4V5XTdwrV6bYJ12tP+72EZx/xedN6DQwurEEcLTpfULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661305791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=KyQrDQVpcvilEDqykRWXqrH3tFOoyA6DmQ/bB/u6eJI=;
        b=n5oNR76XbOhvjQua68LlgZWytQR+5I9QjIjB1mMRnTiSi0YO94M9024mrU8E/hx7IxtkVR
        viI1icKDSghDbE+6/KLUBMjgq7PSg0l3LUQ4+WepIZSwV9JqnS3LRshJ0YJAiF/g1ErQ5T
        6i3tpSAnBETzzRYKPUcEVj2wLGFKLRTEC9RBQXlE6RtwGsV2CRxeWzMpvkzhAXQ7GgvHtj
        dKgILfZxI7odjv7vVua34BMXXQ3DxJTQlcX2tmh13M0L2CoGgQA9KL0xYoYAyNlxh4ogcp
        HwHqdvm/WR2+ASa8G3cISp7Xs4YIzbb8cjU0EdAAeWmw8ynwUzlPuqEa6l/8Ng==
ARC-Authentication-Results: i=1;
        rspamd-7499696767-dvgzl;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Squirrel-Macabre: 241804060bb1b80c_1661305792116_504427177
X-MC-Loop-Signature: 1661305792115:2436232760
X-MC-Ingress-Time: 1661305792115
Received: from pdx1-sub0-mail-a225 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.108.161.97 (trex/6.7.1);
        Wed, 24 Aug 2022 01:49:52 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a225 (Postfix) with ESMTPSA id 4MC8DH0hWlz4S;
        Tue, 23 Aug 2022 18:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661305791;
        bh=KyQrDQVpcvilEDqykRWXqrH3tFOoyA6DmQ/bB/u6eJI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=RtIc/QDvpivM6t9vLzop3hUcEIKVvezNltDg/RgGbsK0vXigJ+v9BQMQOPiSKznyf
         DLh0cpzqh7J1vlILAW5IKQZ5eLqSaCEzQ40h65KeZQMvjKz7CzHvGE9ux79YlvjlH9
         OH8aT5hxDpyWxJUmcgkJN7+E6+3tm6UIZhK85XMlD794lbtZN75faoeh1w3711sAc6
         ujWz7T5772cdONYO7QCoJgh3UCfw8CPG/QFgIkBqC5QnEIDd6IFd99jZ7g6r4pP0Tn
         8OQDlqATpSjsRX8Sv/AR7pAAQIWzxxk3YWDd11UBryml0CEDWvSp+FlwVFmiIwYLOl
         +n5Ck0Jny4ATg==
Date:   Tue, 23 Aug 2022 18:31:46 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v13 38/70] optee: remove vma linked list walk
Message-ID: <20220824013146.qe3dkfpzfikijky6@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-39-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-39-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022, Liam Howlett wrote:

>From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
>Use the VMA iterator instead.  Change the calling convention of
>__check_mem_type() to pass in the mm instead of the first vma in the
>range.
>
>Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
