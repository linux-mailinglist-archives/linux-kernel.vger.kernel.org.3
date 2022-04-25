Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B8350E0B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbiDYMvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiDYMvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88A80FAF7F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650890910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N3u12wuLEP305W7IcqSlnc/KS4m0t+UufQFeHSMO7Og=;
        b=P1Tyrdse5a7cgQMSjko/IXTmc2mebZLuig6JnYbgAj384vA+dVPV6eAb1ASe6le6WlIPKG
        Pgn7zsTlkmZDS8qAoG6i/Y8J3ODvb5+wD9evf972zps6mRFm0RPG4eixd0xzCVgsCOKjit
        cbq8JGflr5/k3gJARyF8p9wE0s9YmPo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-FVBNLz_pMsWSqAlIrr3jIA-1; Mon, 25 Apr 2022 08:48:27 -0400
X-MC-Unique: FVBNLz_pMsWSqAlIrr3jIA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F55285A5BC;
        Mon, 25 Apr 2022 12:48:27 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2566140C1241;
        Mon, 25 Apr 2022 12:48:27 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 23PCmRVk003883;
        Mon, 25 Apr 2022 08:48:27 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 23PCmRVa003879;
        Mon, 25 Apr 2022 08:48:27 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 25 Apr 2022 08:48:27 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Milan Broz <gmazyland@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dm integrity: fix error code in dm_integrity_ctr()
In-Reply-To: <YmaMgPr8bM/0PFUi@kili>
Message-ID: <alpine.LRH.2.02.2204250846510.1699@file01.intranet.prod.int.rdu2.redhat.com>
References: <YmaMgPr8bM/0PFUi@kili>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for finding it.


On Mon, 25 Apr 2022, Dan Carpenter wrote:

> The "r" variable shadows an earlier "r" that has function scope.  It
> means that we accidentally return success instead of an error code.
> Smatch has a warning for this:
> 
> 	drivers/md/dm-integrity.c:4503 dm_integrity_ctr()
> 	warn: missing error code 'r'
> 
> Fixes: 7eada909bfd7 ("dm: add integrity target")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

add:

Cc: stable@vger.kernel.org
Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>

> ---
>  drivers/md/dm-integrity.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
> index 36ae30b73a6e..3d5a0ce123c9 100644
> --- a/drivers/md/dm-integrity.c
> +++ b/drivers/md/dm-integrity.c
> @@ -4494,8 +4494,6 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned argc, char **argv)
>  	}
>  
>  	if (should_write_sb) {
> -		int r;
> -
>  		init_journal(ic, 0, ic->journal_sections, 0);
>  		r = dm_integrity_failed(ic);
>  		if (unlikely(r)) {
> -- 
> 2.35.1
> 

