Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06CB46DD03
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbhLHUa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:30:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236691AbhLHUaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638995213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EYF7r/pmImhVQd495UHmqBKGV7u0nO0O8zYszmb4pjc=;
        b=Wy2F8bkwVjpTcp8iC6e3PPeqhD1B044yLY/O+C+NbeMEZy+9DFgrf9Cm6uwfZNN+74L1sB
        7YLGLA7r7ys7EeZcScBDWJNxB3WMuu5QV7RuOmT1H72XU8KGYtD2/Oe4iBaK6w2MG69GFZ
        nlYVN+acRjDbefg2bw8yKnowouz1kyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-17-i0Gw5O3qXOM2hU91kcA-1; Wed, 08 Dec 2021 15:26:50 -0500
X-MC-Unique: 17-i0Gw5O3qXOM2hU91kcA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3769A81EE62;
        Wed,  8 Dec 2021 20:26:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA97518369;
        Wed,  8 Dec 2021 20:26:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1638952658-20285-1-git-send-email-huangzhaoyang@gmail.com>
References: <1638952658-20285-1-git-send-email-huangzhaoyang@gmail.com>
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: judging context via current_is_kswapd instead of gfp_flag
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2868724.1638995206.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 08 Dec 2021 20:26:46 +0000
Message-ID: <2868725.1638995206@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huangzhaoyang <huangzhaoyang@gmail.com> wrote:

[adding linux-cachefs to the cc list]

> Kswapd uses GFP_KERNEL as gfp_flag which make the judgment of
> context is unexpected. fix it by using current_is_kswapd.
> =

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  fs/afs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index eb11d04..6c199d5 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -485,7 +485,7 @@ static int afs_releasepage(struct page *page, gfp_t =
gfp_flags)
>  	 * elected to wait */
>  #ifdef CONFIG_AFS_FSCACHE
>  	if (PageFsCache(page)) {
> -		if (!(gfp_flags & __GFP_DIRECT_RECLAIM) || !(gfp_flags & __GFP_FS))
> +		if (current_is_kswapd() || !(gfp_flags & __GFP_FS))
>  			return false;
>  		wait_on_page_fscache(page);
>  	}

I have several of these in my fscache-rewrite branch, spread across a numb=
er
of filesystems.  Should I fix all of them the same way?

fs/9p/vfs_addr.c:               if (!gfpflags_allow_blocking(gfp) || !(gfp=
 & __GFP_FS))
fs/afs/file.c:          if (!gfpflags_allow_blocking(gfp) || !(gfp & __GFP=
_FS))
fs/nfs/file.c:          if (!gfpflags_allow_blocking(gfp) || !(gfp & __GFP=
_FS))
fs/nfs/fscache.h:               if (!gfpflags_allow_blocking(gfp) || !(gfp=
 & __GFP_FS))

David

