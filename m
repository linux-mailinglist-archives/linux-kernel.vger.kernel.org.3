Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86F552BEAB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbiEROXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238584AbiEROXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 116F4252B1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652883814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xEnVe+thJMrj0C89/i9QBXS8K26hkY9sQCbQCmrjIxg=;
        b=D9MGNU+wxdLBcrQwKvjxhr7UNSsynGH2erWhzIhQ85+saYU9pakJ8rzUK9fsWLaxTNPtsX
        PtG7tJyteymBk64Dx6SnTHO+zzMZK9qV7i3uM6gboaS9OFLaeT2Q9ZEhCc5pkU1yuTaYKj
        TUCMd05ptBnIcsyRVzv1/3SWDp8Sbc4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-nCy9_tE7OFCLLZye584mzg-1; Wed, 18 May 2022 10:23:33 -0400
X-MC-Unique: nCy9_tE7OFCLLZye584mzg-1
Received: by mail-pf1-f199.google.com with SMTP id w83-20020a627b56000000b005182702c297so1237515pfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xEnVe+thJMrj0C89/i9QBXS8K26hkY9sQCbQCmrjIxg=;
        b=26U1CHKidZ497Gjw0sTj6sY0UdnYfimG5vQezi/1yb7HnhdRCsot/QQfqnTCXyyV4T
         6G0oG4WKoEYtu9LUFxf9B09ULuD4Q/2ZPXIj6s6VBsjNtQDhxElQqMqf0ecfhGQ3RKaE
         RBN9zTwV+IYn8VxGTOhNVe/zMnu3LiddNaJuMRZ/c9rCoViyOO32JMvs8lrJW+7jcscv
         nlb8PXEbcCaESwnYuzOg5Vb87fw/AOT1ad59tGmk6JNxuRIG7P8YmtaPrszgRLNLPCCF
         I0D9xmlz+hr4Wz567g6hDwmX+1m1VufyiqU1ZLbPeJGV8eFItyrmxH11BTJvmrCvDMN7
         ugig==
X-Gm-Message-State: AOAM5308iPpP212KqhYDcuhC9vcVQqcNG1tq3+VNiP7pxjIYRq8LWRaK
        6jRvxJRgsQtALxXKb1t9Lviig6Mt76iq+tktH9bTbclOEaeOXD8srWh3WYOCyAyLVUab0xDKguG
        T5tbkxMy24CbAEwSU1DxTuYANj3rTVsVEkVT2IW1QzCO4gDSVunW/Ny4JjATVwd8wWZAWG5sJ6Q
        ==
X-Received: by 2002:a17:90b:1c8e:b0:1bf:364c:dd7a with SMTP id oo14-20020a17090b1c8e00b001bf364cdd7amr225184pjb.103.1652883811595;
        Wed, 18 May 2022 07:23:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7BLP1J1H8f7oD1TY5TGuF+QDjgPJtGJ1rzPMQGjEi3Mxt4eMzgGqbzqjFJq4C8NXIHPKx2A==
X-Received: by 2002:a17:90b:1c8e:b0:1bf:364c:dd7a with SMTP id oo14-20020a17090b1c8e00b001bf364cdd7amr225147pjb.103.1652883811225;
        Wed, 18 May 2022 07:23:31 -0700 (PDT)
Received: from [10.72.12.136] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r19-20020a63ce53000000b003c6a80e54cfsm1620634pgi.75.2022.05.18.07.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 07:23:30 -0700 (PDT)
Subject: Re: [PATCH] ceph: remove redundant variable ino
To:     Colin Ian King <colin.i.king@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220518085508.509104-1-colin.i.king@gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <5398e036-8150-ffd0-844e-719257c6e2f7@redhat.com>
Date:   Wed, 18 May 2022 22:23:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220518085508.509104-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/18/22 4:55 PM, Colin Ian King wrote:
> Variable ino is being assigned a value that is never read. The variable
> and assignment are redundant, remove it.
>
> Cleans up clang scan build warning:
> warning: Although the value stored to 'ino' is used in the enclosing
> expression, the value is never actually read from 'ino'
> [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   fs/ceph/mds_client.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 00c3de177dd6..20197f05faec 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -437,7 +437,7 @@ static int ceph_parse_deleg_inos(void **p, void *end,
>   	ceph_decode_32_safe(p, end, sets, bad);
>   	dout("got %u sets of delegated inodes\n", sets);
>   	while (sets--) {
> -		u64 start, len, ino;
> +		u64 start, len;
>   
>   		ceph_decode_64_safe(p, end, start, bad);
>   		ceph_decode_64_safe(p, end, len, bad);
> @@ -449,7 +449,7 @@ static int ceph_parse_deleg_inos(void **p, void *end,
>   			continue;
>   		}
>   		while (len--) {
> -			int err = xa_insert(&s->s_delegated_inos, ino = start++,
> +			int err = xa_insert(&s->s_delegated_inos, start++,
>   					    DELEGATED_INO_AVAILABLE,
>   					    GFP_KERNEL);
>   			if (!err) {

Merged into ceph-client/testing branch. Thanks!

-- Xiubo


