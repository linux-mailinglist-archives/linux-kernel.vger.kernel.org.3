Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219F859F118
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiHXBjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiHXBja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:39:30 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C3E8C035
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:39:28 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 082FA7E15C1;
        Wed, 24 Aug 2022 01:39:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a225 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 58D167E144A;
        Wed, 24 Aug 2022 01:39:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661305167; a=rsa-sha256;
        cv=none;
        b=YM8/iN0AEuuGYPyJrF7uRM2ywMduzfIJWbBmrJvEP1L+IcGTsdeM97xekt3ckJcx1jcgI/
        IkYL9dEYEbBkIT5Ho9A5JfJm3Q57/zJTOYYgkfg0H+PcimsUWR0Y6NLmBLKAfw+w7atp7u
        BLv5HkQw7jQvbVgV2d2h4KAmvwmaNbb4nCvGVYRB0QQGE3QxXPPKi7WfH27F4w2lNrfM3C
        20TMkvBRFkY9RtLDU3LrROqElQoh9KtVhXxjcx3lgbqPg6N1UWQHpQVooA+LnMTk1Nnnoo
        nnt2dGHzJRFDY9GwQz2lnX+VeK05z23be+dNNbaHg5k+qUUlBE80C0WOZ0GIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661305167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=J+hEYIEjvOwz2IyYKQJbNRKzS/JVrt+rHjvP+egv3pQ=;
        b=lZs79j5/qHvG3TUe27KhIHgmNldv7Adf2suCPr2Fan8MjAHmvRfwCZ9AANfcyfCxpxpUv8
        ze4zLjkfViK34iaJPG92KNArlZJ/rGtzr93q0AjaEhRUFB4blq+ymfQap/cJRvV5xX9XVa
        qHUPjt0Y9UyHLpncEhoEToBkqQhjhuBS1oIi49xmc8bdmCQQk3UWeXLkkGqr25I7wHpaYE
        KcRdDT5/0j5VPcLgNbvCNYTP62wd6uwdybYnRs0vXAn28gQ6PrBJq0kHg9AriNzkcrter0
        3lA2MpxfQXvyxnkLYMufUKkXm2EoKC5ZlcoSpMBpNGLhLwZ+jwbXlrLxEJxAgg==
ARC-Authentication-Results: i=1;
        rspamd-5cbff9fff7-bjsdh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Glossy-Dime: 1021f1c555efe553_1661305167619_443955144
X-MC-Loop-Signature: 1661305167619:473570999
X-MC-Ingress-Time: 1661305167619
Received: from pdx1-sub0-mail-a225 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.147.30 (trex/6.7.1);
        Wed, 24 Aug 2022 01:39:27 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a225 (Postfix) with ESMTPSA id 4MC80G5py6z1jh;
        Tue, 23 Aug 2022 18:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661305167;
        bh=J+hEYIEjvOwz2IyYKQJbNRKzS/JVrt+rHjvP+egv3pQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=SWusiSuECsjBEl+LRWPfdW7Nc75nB1HAFFk+Gf60fCn9oUUWMiTQ/9Ap6yZXd/fqn
         R9c9AUoIS9Z3AlUc9L7RIqQ7NXbbDHskgPcOwcgl43EWIv6ZaUK3/Yaas1CzGpA4qy
         VN0FE4p21Hd98YYzI4uvPX9EuqSxtjfMHdbH4sp1WtR2cnLaeRiSbda39ptQos6BQ1
         oh8V6bBb4GrXBFkDCQUUAmLX7SQTHHfueXnxT/IHI5gFMQkVkX1GDGZVBso9pj8Pf4
         4RsKts3RfuWjXGNgxw9HTnNvQ4EEKQdq+yvuP4AKp3+tCIREYjm87GW70ONENRhqt5
         43C/NrLEss2hg==
Date:   Tue, 23 Aug 2022 18:21:21 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v13 42/70] fs/proc/base: use maple tree iterators in
 place of linked list
Message-ID: <20220824012121.aj2qkzrmdyywu45t@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-43-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-43-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022, Liam Howlett wrote:

>From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

-ENOCHANGELOG.

>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>---
> fs/proc/base.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/fs/proc/base.c b/fs/proc/base.c
>index 93f7e3d971e4..0b72a6d8aac3 100644
>--- a/fs/proc/base.c
>+++ b/fs/proc/base.c
>@@ -2350,6 +2350,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
> 	GENRADIX(struct map_files_info) fa;
> 	struct map_files_info *p;
> 	int ret;
>+	MA_STATE(mas, NULL, 0, 0);
>
> 	genradix_init(&fa);
>
>@@ -2377,6 +2378,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
> 	}
>
> 	nr_files = 0;
>+	mas.tree = &mm->mm_mt;
>
> 	/*
> 	 * We need two passes here:
>@@ -2388,7 +2390,8 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
> 	 * routine might require mmap_lock taken in might_fault().
> 	 */
>
>-	for (vma = mm->mmap, pos = 2; vma; vma = vma->vm_next) {
>+	pos = 2;
>+	mas_for_each(&mas, vma, ULONG_MAX) {
> 		if (!vma->vm_file)
> 			continue;
> 		if (++pos <= ctx->pos)
>
>-- 
>2.35.1
>
