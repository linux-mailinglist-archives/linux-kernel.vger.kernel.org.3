Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92A759EC29
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiHWTWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiHWTWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:22:03 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123671322F4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:03:02 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5EB662A12D4;
        Tue, 23 Aug 2022 18:03:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 30D362A1E7B;
        Tue, 23 Aug 2022 18:02:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661277779; a=rsa-sha256;
        cv=none;
        b=1w1EdcQ371jtiZE5ssyXEy5vEAlE0ICcJTJV8VbDpfNJYJzTcpuKB3jYeINBGpjf0H+JwG
        XK1lFBjmR5b2nGYq7CIL/qYlgIeQbNgXLs/jMToRKx4qSExoUbO4lAhMLOq7Ovfrnnh8Tq
        vr/L4LKDjc+HM+Rv5O1M/gbeqSIuTh452Q+gXERoOOoQ2bXrCJU1i7Lec1rF1Dm37EzOXY
        rV3V4liTFNjJ1KRMOLmFF0eEow8hn5jDwkj0Wchfo3nderlTGdK7QBW2nx9sc4pUpHppbk
        XmBcehPbertTRB/z7MOda0G1aQnQt5hQ892i0KIxozOJ8ZZWZEtIFBoYrnwVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661277779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=3YD8UxhoVF/0CdPFuuWxAVwema5lF831lGxRQpQLviU=;
        b=slTNJFpEAUiEk5ksFEmllc9CiE+1z+ivdSgvW8/pWGv48GmPBdC+A/gzzTYicRchzTDI1t
        8wiJoCsJQsket7hotSaTY0lHvJV6nWT+suHUPquY/pRY5S+uk/Fz02MMFcHikrY2Q91e8U
        zpdLITawLPIsyi7ha/FMFWmCwH5Kulg1B7O1ReH8C5LF52qexAvTlSmcfK5YC6lqW/qIqR
        RT5L/sDILAIwedeAKohmbR5aILSDrQGoQC6j+xnua6a8yIliJFs/noy2U0d1vw5RaSqZSm
        4Ex4E5bfehNfChhAAea9/hGdTLqhZy0HIGUJTjJ6w6pSMY7EbqRd4ioovTZagA==
ARC-Authentication-Results: i=1;
        rspamd-79945fd77c-6r7td;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trail-Rock: 109bada36d217795_1661277779684_1833396601
X-MC-Loop-Signature: 1661277779684:3521180439
X-MC-Ingress-Time: 1661277779683
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.38.149 (trex/6.7.1);
        Tue, 23 Aug 2022 18:02:59 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4MBxsV208vz1PZ;
        Tue, 23 Aug 2022 11:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661277774;
        bh=3YD8UxhoVF/0CdPFuuWxAVwema5lF831lGxRQpQLviU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=dm4tTMhqjgm+Qp5pgxAZLTdXJKdLu6mY8mIPx+RBSiU1bEPQlqeLkHoiYcM8df0a0
         OlIzzNOdxe2ZhZVEgkjcWJDHqv28283A8/VwJ/KUBTz8qE2MiHFGUiUaFJSbe129Qf
         bYSR3OfjP/kUi53ck3AEf0DuTvxgB6B47x1E8l8UYnqdt9mk1+DA1m716YnEU9dypN
         4W18xAMKwPQV9tV/Kq223SqH2RRD4AlXt+m1NphwDdDceUeWu07GVMLsf0a6rXpCi7
         48tD/1LBlhPhOkrPCT0xTaxsruFL9RbDDmbm/6tDYAB0gBgpkq87j6ffRC/N48PdLh
         KBTDFLjqkq89g==
Date:   Tue, 23 Aug 2022 10:44:51 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v13 47/70] perf: use VMA iterator
Message-ID: <20220823174451.lgdxhow6fkrdorva@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-48-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-48-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022, Liam Howlett wrote:

>From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
>The VMA iterator is faster than the linked list and removing the linked
>list will shrink the vm_area_struct.
>
>Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
