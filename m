Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C35F55D26C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbiF0MSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbiF0MSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8481CBCAF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656332323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QeTRmruqb8PXfYbpUfjyc9E5QDPm7vrxIbGT7xAqTVw=;
        b=P0d/WGh8veYb0mJuYHRqI2u6Bn8le5BlyH5W4gvIfQwLbv9vOfiO9QHyQZpqMfgXOdmgzs
        b0EBA42PFhgrnf6OZaW2Q5xyy4c2C0oiGn31wkrMLId/ipGC6Mbu8zl/ciLN+Isz1PgNhc
        +/TiUb3Grw0n0noFnvr5L9edfooVtNA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-xikNpjArOeyswyKFwJcVkA-1; Mon, 27 Jun 2022 08:18:42 -0400
X-MC-Unique: xikNpjArOeyswyKFwJcVkA-1
Received: by mail-ej1-f69.google.com with SMTP id go10-20020a1709070d8a00b00722e8ee15b4so2345755ejc.22
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QeTRmruqb8PXfYbpUfjyc9E5QDPm7vrxIbGT7xAqTVw=;
        b=ttkpoyZw1X5XsSQ/QLKHm9jXM9jMsGHPhfGc06o7iQO72OlC3tkovMoCyLieylVm7y
         zRuuwrm3EDnzYjZYywzqqz+pnf7AEDw/n9rfuqejTdSxbaHv/l69Rt0ZDWSWpq0ZCzqw
         OyQVuEPgYXXl5ifJsaAZNavSqfbJbZDFop0UyRJbdJs7Uj/tBKl3GW9vLddWVYMWsKey
         L2NK0kbAAt/VPgja4wpNlQE97CWQIPqNSPtXKdAvVkf/fb3NAzYWkwtKIYUzRMG0qDCC
         cIdexOmB2xpQ73peLm7W3a01FovwgnxdQxlHy43lL8panQai/G68mRGuGt/OfRq7cVec
         WvHA==
X-Gm-Message-State: AJIora+AJ/zqt0e8ITBBqFlSLtlyIqj2or2HEW+Fb7oFVU/YqzxP1+ih
        DPob2znA171ADgt1q0Lr3/bfEj7Adafb092WHiBZmnW+C4ZRUohWb6HwiUOFGJy6MmzC/ZynB4D
        zqdp//6v99lvnArDAIzmh2v2t
X-Received: by 2002:a05:6402:320f:b0:435:7236:e312 with SMTP id g15-20020a056402320f00b004357236e312mr16272772eda.115.1656332320678;
        Mon, 27 Jun 2022 05:18:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tkzyK4X8BkQekizGdw2RIZ8xukoWzY0sSwXgAYAPhEmTwq0WxbjiOjIOET+0jJY1iqXoU9eg==
X-Received: by 2002:a05:6402:320f:b0:435:7236:e312 with SMTP id g15-20020a056402320f00b004357236e312mr16272566eda.115.1656332318612;
        Mon, 27 Jun 2022 05:18:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id b5-20020aa7cd05000000b0042bc5a536edsm7343465edw.28.2022.06.27.05.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 05:18:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BFDC7476CA0; Mon, 27 Jun 2022 14:18:36 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gregory Erwin <gregerwin256@gmail.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        stable@vger.kernel.org
Subject: Re: [PATCH v6] ath9k: sleep for less time when unregistering hwrng
In-Reply-To: <20220627120735.611821-1-Jason@zx2c4.com>
References: <20220627113749.564132-1-Jason@zx2c4.com>
 <20220627120735.611821-1-Jason@zx2c4.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 27 Jun 2022 14:18:36 +0200
Message-ID: <87y1xib8pv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> Even though hwrng provides a `wait` parameter, it doesn't work very well
> when waiting for a long time. There are numerous deadlocks that emerge
> related to shutdown. Work around this API limitation by waiting for a
> shorter amount of time and erroring more frequently. This commit also
> prevents hwrng from splatting messages to dmesg when there's a timeout
> and switches to using schedule_timeout_interruptible(), so that the
> kthread can be stopped.
>
> Reported-by: Gregory Erwin <gregerwin256@gmail.com>
> Tested-by: Gregory Erwin <gregerwin256@gmail.com>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Rui Salvaterra <rsalvaterra@gmail.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: stable@vger.kernel.org
> Fixes: fcd09c90c3c5 ("ath9k: use hw_random API instead of directly dumpin=
g into random.c")
> Link: https://lore.kernel.org/all/CAO+Okf6ZJC5-nTE_EJUGQtd8JiCkiEHytGgDsF=
GTEjs0c00giw@mail.gmail.com/
> Link: https://lore.kernel.org/lkml/CAO+Okf5k+C+SE6pMVfPf-d8MfVPVq4PO7EY8H=
ys_DVXtent3HA@mail.gmail.com/
> Link: https://bugs.archlinux.org/task/75138
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Gregory, care to take this version for a spin as well to double-check
that it still resolves the issue? :)

-Toke

