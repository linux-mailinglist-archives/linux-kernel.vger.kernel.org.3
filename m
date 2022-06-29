Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9F9560057
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiF2Mnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiF2Mnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6C1B205D3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656506628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OmA8ryz4EUHmnXkTfJJODlFrNaNAuQY6oTIThj4GH3c=;
        b=YaA5lzUoCkPj28YR7DVHl5gfz1fqes5lugh8cY4SZAcy2AUxNpdR+5ZneMgncfKAVa+/sJ
        Tid7S7UgJ86GGwouX7IFmzgiMV07G2SYJhD1+Ilij7PcRoxQSOZ8DDZcqcvHXPM6H1qL7P
        CBCjfq8eeELNPM2BcAtKybSvyR8ZH3M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-I_p-E_OdPrOHhQWlJZe_9Q-1; Wed, 29 Jun 2022 08:43:46 -0400
X-MC-Unique: I_p-E_OdPrOHhQWlJZe_9Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 572DB185A7A4;
        Wed, 29 Jun 2022 12:43:45 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98C0B18EAA;
        Wed, 29 Jun 2022 12:43:41 +0000 (UTC)
Date:   Wed, 29 Jun 2022 20:43:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     wuchi <wuchi.zero@gmail.com>
Cc:     maorg@nvidia.com, hch@lst.de, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/scatterlist: use matched parameter type when call
 __sg_free_table
Message-ID: <YrxI9+ytGZdXlRZ7@T590>
References: <20220629030241.84559-1-wuchi.zero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629030241.84559-1-wuchi.zero@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 11:02:41AM +0800, wuchi wrote:
> commit <4635873c561a> (scsi: lib/sg_pool.c: improve APIs for
> allocating sg pool) had change @(bool)skip_first_chunk of
> __sg_free_table to @(unsigned int)nents_first_chunk, so use unsigend
> int type instead of bool type (false -> 0) when call the function in
> sg_free_append_table and sg_free_table.
> 
> Signed-off-by: wuchi <wuchi.zero@gmail.com>
> ---
>  lib/scatterlist.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> index d5e82e4a57ad..c8c3d675845c 100644
> --- a/lib/scatterlist.c
> +++ b/lib/scatterlist.c
> @@ -240,7 +240,7 @@ EXPORT_SYMBOL(__sg_free_table);
>   **/
>  void sg_free_append_table(struct sg_append_table *table)
>  {
> -	__sg_free_table(&table->sgt, SG_MAX_SINGLE_ALLOC, false, sg_kfree,
> +	__sg_free_table(&table->sgt, SG_MAX_SINGLE_ALLOC, 0, sg_kfree,
>  			table->total_nents);
>  }
>  EXPORT_SYMBOL(sg_free_append_table);
> @@ -253,7 +253,7 @@ EXPORT_SYMBOL(sg_free_append_table);
>   **/
>  void sg_free_table(struct sg_table *table)
>  {
> -	__sg_free_table(table, SG_MAX_SINGLE_ALLOC, false, sg_kfree,
> +	__sg_free_table(table, SG_MAX_SINGLE_ALLOC, 0, sg_kfree,
>  			table->orig_nents);
>  }
>  EXPORT_SYMBOL(sg_free_table);

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

