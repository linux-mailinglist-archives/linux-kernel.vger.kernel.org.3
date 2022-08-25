Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A959C5A168C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242010AbiHYQTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiHYQTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:19:47 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB34BD4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:19:45 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 927E7122D4E;
        Thu, 25 Aug 2022 16:19:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a253.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D0DFE122E16;
        Thu, 25 Aug 2022 16:19:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661444383; a=rsa-sha256;
        cv=none;
        b=EMMHL5zLrNMeNq4rKyCbwZEIEdDuiF8CXPyDRnkFWpwEYKJ71+/dW5xZEzPHePEXlDjT5L
        uWWQToN+z/K8qVhPVhkjF6arKagg8ZqJcLtMhIElTnuv+14PkPiZNZHn48eJxpKonMbIBl
        PP7/hXFYJRYhNVpU5q95bpDBzLsyRBM+oqOZ9Qy1eyX8iKTcZPiJumVsSpvBKCsg5Y1rve
        ANee1SboxGkCocaQPUJ7lh3CNFb534AkJdbgwEwPLaqmczzYmLBAKyqfUxYZb2VtiEcn3t
        8+5S28gclKVzI6Wx/5Nt67zXEck5OGbMBj8QIfBAX2ygCw+MCaAkya71zOnv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661444383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=QVBJKz2ABICt2qvSlRu5GJPjgPykUXXBeTUH0wKn+Gs=;
        b=5YBr43Ie5ZrHcnp+9Rwwck35+18pMKUg71yFONOl81O2FzJyiZeNGFh0225BFz0ZMJ6gw8
        LPvKal93ahYmo1nMaFFsNIXAX2rOgya4HNzVZrGcZNfTzX4qfP1hB2z85oT3v5en1HY0me
        ZR/nDqK5jhoenJ6cDb9JrqyrZcuyWB8sAJm3Q8N2V8ERV0GhFBROcc3ZlOuaGQQRMhmDV+
        MQMVY8J+lnGhSpN217auBoFz/FOoIU8oRKm9bhZO/8/xyKnrXs2WejgTtv5dYO6ws7FXy8
        n3LnQKFJvu7zJu12+3kEwfTwCd5x7nKZm2RyIiEyx1oGxM7E5l63D9yp628eJQ==
ARC-Authentication-Results: i=1;
        rspamd-64cc6f7466-rb2wq;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Dime-Exultant: 0ef5925667410d74_1661444384184_544200651
X-MC-Loop-Signature: 1661444384184:576276869
X-MC-Ingress-Time: 1661444384184
Received: from pdx1-sub0-mail-a253.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.199 (trex/6.7.1);
        Thu, 25 Aug 2022 16:19:44 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a253.dreamhost.com (Postfix) with ESMTPSA id 4MD7TW0ddyz7j;
        Thu, 25 Aug 2022 09:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661444383;
        bh=QVBJKz2ABICt2qvSlRu5GJPjgPykUXXBeTUH0wKn+Gs=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=mFafEIXw/ZVgaU1iTDGhCWcy02R/yIBrh7EttL0XV4y3LePAG6JRxBQE2FzNq70/T
         KRYc2i0ZZSCXi7AXVe0V5t6nJAcPsqEOO9uNvax4let9N9Y2a1cHVmekWW5uidoU7Y
         Gf6xYvwEPBUBGKAKCtMQ1LZSygXiiQGeIynEiBqIKfdNMUapRfnHHuCPM/k06HMrLr
         8lAiiM+Isu3DBBR9zID5zzSmDDiQootHyJj6F6zEjc/42hpVSgxBClWZhitYvlJs/t
         bF2zwdhUDHHWwyMBLlRH+QBBt1i7WtA6DFiOmg9n2StnPyJ3zm0sOD5pHygfqffQny
         aTdNdU9pUdHVA==
Date:   Thu, 25 Aug 2022 09:01:32 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fs/proc/base: use maple tree iterators in place of
 linked list
Message-ID: <20220825160132.w4bphicoifyh2an5@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220824012121.aj2qkzrmdyywu45t@offworld>
 <20220824151129.2023451-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220824151129.2023451-1-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2022, Liam Howlett wrote:

>From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
>Use mas_for_each to iterate the list of VMAs instead of a for loop
>across the linked list.

Hmm so why isn't this using the standard VMA_ITERATOR?

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
>-- 
>2.35.1
