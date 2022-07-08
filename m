Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24AF56B412
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbiGHIHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbiGHIHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB97480489
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 01:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657267625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLYylxtBEzg+YALLvd9LbEGO9M2fLeX5WQLfMpASEEo=;
        b=DOqRngZ61b9VZs13h0DOY9S7gl25CXfCoq2QlMtZJigBlxdWoJZbuUkrm7lxIrQeQyQyFA
        uDuDCzK32GjGe4I9y1EYw9PLu7LXmujgSp9b4k/9bl9r8eXFNJOBliKFt9tzUBqZhiP9pb
        WwvoN2EEXReqIWI6AXVxEC7NXxLETIM=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-fFRG49PDMeqpOvQq2XBPKQ-1; Fri, 08 Jul 2022 04:07:04 -0400
X-MC-Unique: fFRG49PDMeqpOvQq2XBPKQ-1
Received: by mail-ua1-f72.google.com with SMTP id l7-20020ab053c7000000b003791afd560cso6120518uaa.21
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 01:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HLYylxtBEzg+YALLvd9LbEGO9M2fLeX5WQLfMpASEEo=;
        b=yEkXpBGafvzPy3cjXdD3p6SwYo3WQdptRapiIxf95/XxWdTdXxzf6KuRZ6PIQ7NZTj
         675vbftVTc35mVoSUmqnBZB1YdeQEKNgdYc32TcRjl8XGQt2D+gRNVWG+XDghE9H+74y
         7u0tQh5ZvSRtohjG68kUmYrT9o0quLhIqXZ/dTy6Uf3oZe8gWjDTFM3m8V89dlru9/CF
         NS4XlPumhJSvglDG74x4uR6JoS+HmasNuamvOHzYz92Zvx4KxwcGcjWEV/1muzQf4ryR
         +eKiOamPMdRoW3VlwB6Yps493MW2VCKepHL38heZOr8utaAGsmegQ0yOV5bl5Bz+8lF/
         YR9A==
X-Gm-Message-State: AJIora9wOJlg62/xbEXUdNFKrrEN1j57DWcKZIFtPwN0qGnMmduzSSXI
        dg0Q1T9TG5rC9M0dMV5GjPz1VbSPmLHSMkKZxxmWEaNrsKm1PTFQmEFroAwDs5wEk4uZoF2CAkc
        vVAUrL6Ug/SegCn+fWB2NbP3tLjSod1OcFULmnM9V
X-Received: by 2002:a67:c894:0:b0:324:c5da:a9b5 with SMTP id v20-20020a67c894000000b00324c5daa9b5mr806352vsk.33.1657267624149;
        Fri, 08 Jul 2022 01:07:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vtSsw27PcDf3CxP61G0rXLMhfXJ7efh8iTUreeYkPunA27DUyKMkZxBK+PdSsgScu9YO7PPUz6YnRJa2vV24Y=
X-Received: by 2002:a67:c894:0:b0:324:c5da:a9b5 with SMTP id
 v20-20020a67c894000000b00324c5daa9b5mr806338vsk.33.1657267623936; Fri, 08 Jul
 2022 01:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220531081412.22db88cc@kernel.org> <1654011382-2453-1-git-send-email-chen45464546@163.com>
 <20220531084704.480133fa@kernel.org> <CAKgT0UfQsbAzsJ1e__irHY2xBRevpB9m=FBYDis3C1fMua+Zag@mail.gmail.com>
 <3498989.c69f.1811f41186e.Coremail.chen45464546@163.com>
In-Reply-To: <3498989.c69f.1811f41186e.Coremail.chen45464546@163.com>
From:   Maurizio Lombardi <mlombard@redhat.com>
Date:   Fri, 8 Jul 2022 10:06:53 +0200
Message-ID: <CAFL455=ZcU_fyM9kiuZUJeVmRv9Jx_FmURcweCrTXheRoKkSqg@mail.gmail.com>
Subject: Re: Re: [PATCH v2] mm: page_frag: Warn_on when frag_alloc size is
 bigger than PAGE_SIZE
To:     =?UTF-8?B?5oSa5qCR?= <chen45464546@163.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st 1. 6. 2022 v 14:49 odes=C3=ADlatel =E6=84=9A=E6=A0=91 <chen45464546@163.=
com> napsal:
> Can we just add code to the relatively slow path to capture the mistake
> before it lead to memory corruption?
> Like:
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e6f211d..ac60a97 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5580,6 +5580,7 @@ void *page_frag_alloc_align(struct page_frag_cache =
*nc,
>                 /* reset page count bias and offset to start of new frag =
*/
>                 nc->pagecnt_bias =3D PAGE_FRAG_CACHE_MAX_SIZE + 1;
>                 offset =3D size - fragsz;
> +               BUG_ON(offset < 0);
>         }
>

Personally, I'm not really convinced this is the best solution.
The next time a driver abuses  the page_frag_alloc() interface, the
bug may go unnoticed for a long time...
until a server in production runs into OOM and crashes because it hits
the BUG_ON().

And why should the kernel panic? It's perfectly able to handle this
condition by failing
the allocation and returning NULL, and printing a warning maybe.

Maurizio

