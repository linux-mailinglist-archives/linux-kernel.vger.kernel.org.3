Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501F15662F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiGEGLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGEGLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:11:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23B1E2BC4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 23:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657001491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QHsZpO8jdgHqT5SmUpNg14nO4ITXQI6OxQXT89xNPRM=;
        b=irs1qyMkJ2X+IedvehDsi12eCQn9wapZWD+VAC2Nn6nPDepO/6qNG4To4xPyQOsqWDUhjX
        KLU0zKfMeEiZja1nQppbTxkAar1xfMZrh7Okbj/Z3gd9XtZMDE20BRjz24Jza+QuGiZ4lf
        RyUXvjNAvrVgwTEBCXU3H1XvsDcSn68=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-iO6d705nNP2KYI9XqAc9Bw-1; Tue, 05 Jul 2022 02:11:28 -0400
X-MC-Unique: iO6d705nNP2KYI9XqAc9Bw-1
Received: by mail-pg1-f197.google.com with SMTP id o22-20020a637316000000b0040d238478aeso4406301pgc.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 23:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QHsZpO8jdgHqT5SmUpNg14nO4ITXQI6OxQXT89xNPRM=;
        b=Kp0PbJTL4DmaxVHY241+NUv0SG8oh2jwYPV19EPNusc9ORG6UDW/Dl8OYgUhDk8ph1
         GomQTo1NvZFDGAcX/ygZCCMYJConA9M30hFKgazEVFyU/c6Stiedt7Ijs5YyirgbSABn
         zr78IohlDy9RfJruqhZ8h7qUHw+EYVOXHJiUp7zKDKKTssUI0UeT9HqUf7FVI0MkexEz
         IhvAE6ZctkZxiecgQPOW2/8T2UgjaG0To1xS24OH647T1KymHpzvvnGrOzLQ73iHsQ6s
         NFgjDN90+IIu3cK621d14Svh520GIHKBYFoS1slbWgCs0VXU5Ea0kp7zmozwi5ADafPN
         Msbw==
X-Gm-Message-State: AJIora9baW5EFHy7CtwVLipzhHqwJ50CAAyRqQnMVF6GH/au/ooSqgLc
        RUVe5aRyjTRffHYnSR51WFfajwWdejCmZpqol95QearAC6Arc+roBdom1cl6SxhgJKUNpD10x8X
        brdgoBtyeiDtaAfJylSSuPmWp
X-Received: by 2002:a65:4907:0:b0:3fd:bc3e:fb0a with SMTP id p7-20020a654907000000b003fdbc3efb0amr27251710pgs.123.1657001486740;
        Mon, 04 Jul 2022 23:11:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sEko2VtAQRyg0mb3j/Cx6ZkF9nqsprjC9s4bqY54uQ4+IbeXbfDUKMsX2dsTHZgTrRxxklAQ==
X-Received: by 2002:a65:4907:0:b0:3fd:bc3e:fb0a with SMTP id p7-20020a654907000000b003fdbc3efb0amr27251698pgs.123.1657001486525;
        Mon, 04 Jul 2022 23:11:26 -0700 (PDT)
Received: from [10.72.12.186] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b0016be6e954e8sm2890275pli.68.2022.07.04.23.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 23:11:25 -0700 (PDT)
Subject: Re: [RFC PATCH] netfs: do not get the folio reference twice
To:     dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com
References: <20220705022219.286459-1-xiubli@redhat.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <2dcc7854-643c-0c77-b0b6-9443b9ee1dcd@redhat.com>
Date:   Tue, 5 Jul 2022 14:11:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220705022219.286459-1-xiubli@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/5/22 10:22 AM, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
>
> And also the comment said it will drop the folio references but
> the code was increasing it.
>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>   fs/netfs/buffered_read.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index 5b93e22397fe..a44a5b3b8d4c 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -396,9 +396,6 @@ int netfs_write_begin(struct netfs_inode *ctx,
>   	 */
>   	ractl._nr_pages = folio_nr_pages(folio);
>   	netfs_rreq_expand(rreq, &ractl);
> -
> -	/* We hold the folio locks, so we can drop the references */
> -	folio_get(folio);
>   	while (readahead_folio(&ractl))
>   		;
>   

Will drop this patch, the above fix it incorrect.

Thanks!

