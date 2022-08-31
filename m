Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89ECC5A73AB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiHaB5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiHaB5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:57:00 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02905B2CED
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:56:58 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A56F822EAE;
        Wed, 31 Aug 2022 01:56:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a286 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 25A3E22E72;
        Wed, 31 Aug 2022 01:56:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661911014; a=rsa-sha256;
        cv=none;
        b=xO3IkS87YwBtRoSUGGCFz2LRpX/L/20FsBxeGX4GMaOvzZzmiY0WJMCV5T3mA0NP297BnZ
        o4p1Gos1Dmr0q67CYlZ15vcqpc3rZfc89wOEX/n31f0+K9EDYkgV6PsOKTmSD6+VNgdOka
        JAy07itK0qZ2CNLACJfDA1HGXwYX75LyFKL4yDMCZdNEl7T9jjAm812aCJZ75oLnII9bVq
        9y4IeNJLh3MYEmrqaVO5dpF+DL275b0X2mGHQ/95LbtOReQd8HNRx5CbFcsyYdaeWBmSZ+
        yAXSURFg2QIGwxq83pR41ibNlc+2aXvdFslwRbfHyemKXFyXQavvmZead3S27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661911014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=ZN7Ytuq32pRkJb4PmGUU8hb38GCToK3+YmkySuG5VU0=;
        b=D/RxLn4Ta8DxgU6am8pTZYWqIznkZ2uwyRBY6nGcVn8wMnoFatZx373VfyJ205XJiTVdZC
        GpVCElcwSiX4K1qK9KvH1q5DQHRIZ5xN20lSSb2DHFeRTF22QRvTO65lV2yOJtj/O4Td1L
        Fbmz7XcKlyVz9r2y0pKzCL+SMQdZLas1M1PHYauzgfUuiGFxdKMmCt9CMK6zy2PsiLpqAI
        h9zr8RKDlor8yT2sskX+yyv1dF9WZXzw6JnLcwDzOrG+lTHCj1vTCSE+OMyMTMCERE2OKo
        XUzJcMoF5xS47x6uwdQmSf24kcB257SYuznFWEz8uPnaWbh/2jm2FwucsMPy6Q==
ARC-Authentication-Results: i=1;
        rspamd-64cc6f7466-5vgs7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Industry-Invention: 6f7c437a6dd53293_1661911015433_1687040406
X-MC-Loop-Signature: 1661911015433:1581247722
X-MC-Ingress-Time: 1661911015433
Received: from pdx1-sub0-mail-a286 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.121.210.155 (trex/6.7.1);
        Wed, 31 Aug 2022 01:56:55 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a286 (Postfix) with ESMTPSA id 4MHS390LQmzF3;
        Tue, 30 Aug 2022 18:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661911013;
        bh=ZN7Ytuq32pRkJb4PmGUU8hb38GCToK3+YmkySuG5VU0=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=HyXP5LLuEdFKOdtH513iF6MmTsbkFhAGZzJQr2yVsNmqvM4FZe66o0HI25Aj8Zs9F
         gn1/tiWzElBPJoHcgEGW1IwoG9jYqZlZQ3NA1EV396ZNj7UXgS33poNDkRTGj56At2
         X1lG5h4QANKtw5SNLcprwVYVCc73m3yX8ROhxO4KssDoG64gd6DKHhSbE55MQR+8fd
         HjqyZ0fa3iB03yQNLN54QKOkuCyw0AwKBwdzO1FAOYyzfcHPYSyky3Wf8j7xp5RdJH
         T4mdfXh5EFZ/SXpso4bfd2BLEqIkaTRIg1yK46+D7/0lt4tCnf+5HtUJzqq2R/kB5E
         sWoGZlhm+UfAg==
Date:   Tue, 30 Aug 2022 18:38:24 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v13 10/70] mmap: use the VMA iterator in
 count_vma_pages_range()
Message-ID: <20220831013824.agj34mjj6q6z5zlq@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-11-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-11-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022, Liam Howlett wrote:

>From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
>This simplifies the implementation and is faster than using the linked
>list.
>
>Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>Acked-by: Vlastimil Babka <vbabka@suse.cz>
>Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
