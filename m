Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3052159ECBA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiHWTre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiHWTqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:46:52 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8C7DAEC6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:50:25 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B32092A26CB;
        Tue, 23 Aug 2022 18:50:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id EB7AB2A2533;
        Tue, 23 Aug 2022 18:50:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661280624; a=rsa-sha256;
        cv=none;
        b=1gebAM9KOCLI7vwLj1rNHlGltGNX9aUvWo2fAP5nra8IeALcUTS81jRCsfdBZOMCVkJmAa
        2rjnsyuQZ2yGDnlZhAzJKNS6jz2pS5L2w0bF7tgXTWsR7Zk+xkW5vT2SHXOjg1ZBz6bZ7x
        z7D2mnbMS4cvlFtltFJBG5kCf27GVMNICk9d2fOlqYhwT8unHgFWzeZxJrjfV23QNLl56d
        CpndhIGtZABRkWB7F/4wdT3LJKbwgReI0Ovz3bKYWWZD6IDSnPfm51pIX7038Jk74gtDCJ
        OG3Ef/OE/pp74u2RncqePs3cPePwiZD47WMZ6f3/3l6CnLlYbd/q+8TE3QvzFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661280624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=3YD8UxhoVF/0CdPFuuWxAVwema5lF831lGxRQpQLviU=;
        b=awwh3YWqYstTr51tmLPaanCr3GrFERDSKC7LahxDqqoBW9f06N53hN8DS4FGBNJ6VUiV0k
        s4GIrPhOU17eSEAw9jS8rl3vOH7LqPmUPG7cNVVEJ17lEU/m1sGAZdl892w/NbqbHa54Od
        nxIsI7SXtCGlWHjeWr07l+gYlVnYgg8lUecfCQGJ4mrKYlXFtQpN4exyO1dbpNsxTExZbS
        hfi7iP0XYbLvXwG0fSfxXzpVum9VM5INW70/vE8EqbopXKR2q1x7hDwI1646qpWMF/M41Z
        q5cZY6PLqct8jZaGrJEfNALvhb/9TrXpyND4/BXVgcNpWHq5PyWLazXfsOPbfg==
ARC-Authentication-Results: i=1;
        rspamd-79945fd77c-5lkgm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Gusty-Bored: 19a6ca9e352b3b6c_1661280624565_3514318185
X-MC-Loop-Signature: 1661280624564:3096676863
X-MC-Ingress-Time: 1661280624564
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.110.28.247 (trex/6.7.1);
        Tue, 23 Aug 2022 18:50:24 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4MBywH0tbHz1Pc;
        Tue, 23 Aug 2022 11:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661280623;
        bh=3YD8UxhoVF/0CdPFuuWxAVwema5lF831lGxRQpQLviU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=RR6E4kYNiExeT2pXdKxZtx8OEtx1EWW/oDHgL6bnAZF97dfjPOA/dfYW5F1Z3EslU
         Qwn0mF1d0RUXeFOFV1OhKSTUWnB7BcQoGyWaTxQ7k0+0sVY/Vp0+xpZE015wPwvkyz
         TAuk739uB3GVS01HzJEuR4BFmPtH5Zfh1d8Jx6KJyuSITHulgTsIlVPqgS0exa35a/
         RrRh5/vn8XNaUe+qGa3uHuorgoQBYQ7S7CyDzqgNp8XxlnpVIHwSGWYs0Uopwr+58t
         MpEyP+cChi7sIIqa+1PrFAYSqbxfbuFr/l0it3rldZ/ViyrAD4Nl5h5QtJIr1UqCEG
         mqy2Kp6MxtDjw==
Date:   Tue, 23 Aug 2022 11:32:20 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v13 49/70] fork: use VMA iterator
Message-ID: <20220823183220.u3afmm2uevtkd5tf@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-50-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-50-Liam.Howlett@oracle.com>
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
