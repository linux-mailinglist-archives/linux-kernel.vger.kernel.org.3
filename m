Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B424A5A73D4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiHaCSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiHaCSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:18:31 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A6989812
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:18:28 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id AFF6E4C1D5D;
        Wed, 31 Aug 2022 02:18:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a203.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 172894C2249;
        Wed, 31 Aug 2022 02:18:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661912306; a=rsa-sha256;
        cv=none;
        b=7f4Dne+bL21FR/GLVbSFG7b5+fq2y+lTCxIXDPoYgvqaIa0hGaH8kriUXt6wzkOD5OSdYV
        UcdiGO380Pk/phiTEIARjPNmYH36YWXpoXXR84GvDjDLFamS6qk07aRX9zeuCuDKSgvaZX
        COu3VDoRB1Bzo3N3kt3mW3bP7rvBNcwoz4NiOMVo8VO4LGxvUt08TNNRCBEbGsnkQNk7ul
        r4V4U0iPwb9dM/axZnkHaIQ46Cgg3cyVGmBjIoT0FXbNWJuBLIxRly8pf+cfcVAuD3ktm0
        dMzut9rFUV3nUcTFfg2Fykg2o97jWfxf3pVUEr4G+n97ZZ6auHiN1GE5Es193w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661912306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=t7OnImP1bfyBDEednyaV/FnQCrIzqAONmXN9OPLohag=;
        b=taZ9dBRU4znBR9VlX7tZOhiGPQ77cAjVs4rNTgfq312qdj8KthRjireItxEtz70GpS3YUq
        ore/IpxcCm7XaZUcf5THFhtwX4KqV8e9YSBap65XAxcS9YbyJ/WfcB414CNE2l+E1UDt/9
        1WMN0Wyx95NxDhhDJcUdCo/tavDuE/8MgD4xuV0KQ4VsleZeffYcb1E3uzhgz2AbU0EWX7
        fJ5z3ZJD4pX6H+ItR4yVGiJpwY4GmrIjrGF0SYkfdXXO00Rj07c2cjToqLynyg+CRE9Vqc
        Koam2LJj5aXXNJbzA0usvKZSUSjfWpBqUwEVc3QlRI0JJHYf4CSGcwwyCqFlJg==
ARC-Authentication-Results: i=1;
        rspamd-64cc6f7466-snj72;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Decisive: 1e3967cc5e97060b_1661912306433_81863881
X-MC-Loop-Signature: 1661912306432:2715110686
X-MC-Ingress-Time: 1661912306432
Received: from pdx1-sub0-mail-a203.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.121.28.249 (trex/6.7.1);
        Wed, 31 Aug 2022 02:18:26 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a203.dreamhost.com (Postfix) with ESMTPSA id 4MHSX13SF4z74;
        Tue, 30 Aug 2022 19:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661912305;
        bh=t7OnImP1bfyBDEednyaV/FnQCrIzqAONmXN9OPLohag=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=dPzF1Nr6OOJwj4ALICbjNvlnG+7LPwD2EcmJt75BietocU91m3eDnIaZAN+xbjdOF
         4g9709NApCDC/iHtb4QAMhi9CUb9MRqCcc7cboousKKp0uHfrc8QnvY5kYuvdCJfTl
         wAb8jMW3ITm4ulWhPeg5VQyOTgQ5R0RbYoj9masMEpraQp3+Y63lvPGiA/nmMbdKt0
         1/nj/Y+sjtglhY/achkXDgQvuHHk3r1JxUWinhKbp/EjZPPbFI3y/KtaKJaHTTvIhY
         8Y27j//80uVBf5PqYWaPX/x7vVKmnuQqgqWDHCJh29ZtB3O60pOQS8pcf9eZkeF6mE
         J7f5ypZC+OYcw==
Date:   Tue, 30 Aug 2022 18:59:57 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v13 61/70] mm/oom_kill: use maple tree iterators instead
 of vma linked list
Message-ID: <20220831015957.bfda7mtedus3ha6k@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-62-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-62-Liam.Howlett@oracle.com>
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

>From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
