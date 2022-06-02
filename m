Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BC753B4A8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiFBH5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiFBH5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32B24D19D3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654156666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1HOMdIfsoKxBYgZZnfljgLJ5NTDgYDEwfsVjpojtcs0=;
        b=HskyZtEh2rON5vlZpRiI3BwOaCZYsFUrhYEbOR2PewLkYZe2cfmVYZXkxI/vDQnbzRaDXN
        L8Dud3VZ/KpXeEXw63rEkbc1HTYwIhXQNHYqToCnT2umbqc6uAxNmZ29tS37fVQJQYyhYs
        jv8GPOypLuOEuTPIC3GwK7P9bq3xUXA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-lZqK6Hn1PRqZd4zmF0KBng-1; Thu, 02 Jun 2022 03:57:45 -0400
X-MC-Unique: lZqK6Hn1PRqZd4zmF0KBng-1
Received: by mail-wm1-f71.google.com with SMTP id bg7-20020a05600c3c8700b0039468585269so2051344wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 00:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1HOMdIfsoKxBYgZZnfljgLJ5NTDgYDEwfsVjpojtcs0=;
        b=33wfdD0mKSfGaZ3Exvo4tKjSsxGY3cVV3D+hRFDdux/fohZMPsVy6L8aGoZ01gR9Z4
         Vk2nbFDeWsOIcLS7W5ZijgB8Oq4CCkBa7qou5IqtWXd8o6s4PAnDLBw1lFeBJUnjIoIe
         j0HkCA/Uj+qEmbriNORcoU1w/Y+oju7ThSsRapZlhlb46mEK/qkHNvgs0re2fw/JTVUi
         UiPjwCce/2htIb0sNAfb0/pW2+rNHBOyC5g8n4BueL/qvr7cnr9D17LiaYAWkUf8dzhI
         3gbDSTu6NBTNjeggD3uux7QmS8V8CPT3DC0/Huh8lU60GBiVN0W3PBjYrjlY+qi3WyMJ
         k7tQ==
X-Gm-Message-State: AOAM531ow/HcFma0BayVJRMzIMNNW/EYL1bsdWdy6LB0H0hKBW3vOjsE
        xnBU8tK2n723mmzJgQL5Ie3DTBNngIDRguDv+ICeJIY+5kw0qM9Dm1+gNeVoNFMgG+t7I7jZEiB
        uZbBbXpY3HYSSmm9Z3tCLsRSC/QDhVjvhuGK0yL+h
X-Received: by 2002:a5d:538f:0:b0:211:8016:dda3 with SMTP id d15-20020a5d538f000000b002118016dda3mr2612068wrv.349.1654156663976;
        Thu, 02 Jun 2022 00:57:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztroxVQ+L+TlYB55/pnJ/TTAcbLv8DLnq1jYqDDGg+CrtPlFNEcuy5UAtjra0hyH73xuPS6h57MzlFJbqrNpg=
X-Received: by 2002:a5d:538f:0:b0:211:8016:dda3 with SMTP id
 d15-20020a5d538f000000b002118016dda3mr2612059wrv.349.1654156663817; Thu, 02
 Jun 2022 00:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220602071939.278344-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220602071939.278344-1-chi.minghao@zte.com.cn>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 2 Jun 2022 09:57:32 +0200
Message-ID: <CAHc6FU6hiOHS-b7Ft0AwL+aOZwwgE6WjiJuN1ZRi2k2aH6Si8Q@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Remove redundant NULL check before kfree
To:     cgel.zte@gmail.com
Cc:     Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 9:19 AM <cgel.zte@gmail.com> wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> kfree on NULL pointer is a no-op.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  fs/gfs2/file.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 2cceb193dcd8..d8f1239344c1 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -1066,8 +1066,7 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
>                 gfs2_glock_dq(gh);
>  out_uninit:
>         gfs2_holder_uninit(gh);
> -       if (statfs_gh)
> -               kfree(statfs_gh);
> +       kfree(statfs_gh);
>         from->count = orig_count - written;
>         return written ? written : ret;
>  }
> --
> 2.25.1
>

Added to for-next, thanks.

Andreas

