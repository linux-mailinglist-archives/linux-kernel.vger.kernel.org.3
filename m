Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E02E51ACBE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376912AbiEDS31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376846AbiEDS3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:29:10 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D315E5F72
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:00:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p10so3641401lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 11:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X7nnFcBo5MIhDYQNnEavKTW+QBw/a5S/8r1dgvWPgx4=;
        b=HydzbIEsqYx4gbpn6Of0F/idsQ70FsOBI/yLQ3l1wlbBjcoSGQqp8LilhBOa//uEDx
         EWnmRcF4BEWKWbTlT+gtSe5/NRwGYnfkr6Qy6WpkKKFSMAkUba/bzP88tFQGiyyP5qzR
         slNInsc4mTa9BKrS4jYwCcQzeao9bKelEatb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X7nnFcBo5MIhDYQNnEavKTW+QBw/a5S/8r1dgvWPgx4=;
        b=OegFPa0Dmqe7LJrhXq5cCdlrd830bvv3ihsn2UwkSzfaFq2qZKRY9juMpFLaXg4mu7
         0BT3FUSuhEoqyNJG7xlf+gMiut3UYNEhqGL/FaH/LMvcryc9c3jU7l3gMVLD6EgjzJ39
         0hNxIadNXPXAy+jfzDjQGSwfQqtRktBn5bt8zp+IazXzrBHkTvSM+PPbxaV+2OZ+jwE4
         OtIbUCCHRBwWIrGVWVkOK+WfHlUVgTJWcexhURt9HdxdLLOb0My3NWBIiYQBukxmKTpt
         bQ81wdJCfDBoC4V9CGjzIkUM0RQkcvAK8K2oulQFNnx4Tx+YUO4GW0Uzy3egmKFvKUtk
         7t2A==
X-Gm-Message-State: AOAM531U2bzv10UhIzXKQ9d9TAAwFWuxboKOLH55P06/Mu4llCoUV5Vk
        +uIQ1dwTn3UBSUkuzrOCLXgtICB/YY9dHmIc
X-Google-Smtp-Source: ABdhPJy26XgB0YuGbz3a6R5b+oAHICvQfjDNYnyCCgiek2b53lKX2wfiGl/7Ch/SKxnOGjMm+60IVA==
X-Received: by 2002:ac2:4add:0:b0:471:fc6d:a71d with SMTP id m29-20020ac24add000000b00471fc6da71dmr14907779lfp.350.1651687219881;
        Wed, 04 May 2022 11:00:19 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id z19-20020a05651c11d300b0024f3d1daea5sm1736148ljo.45.2022.05.04.11.00.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 11:00:18 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id b18so3659759lfv.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 11:00:17 -0700 (PDT)
X-Received: by 2002:a05:6512:3c93:b0:44b:4ba:c334 with SMTP id
 h19-20020a0565123c9300b0044b04bac334mr15264136lfv.27.1651687217327; Wed, 04
 May 2022 11:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
 <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
 <YnI7hE4cIfjsdKSF@antec> <YnJI4Ru0AlUgrr9C@zx2c4.com> <YnJOCbLtdATzC+jn@zx2c4.com>
 <YnJQXr3igEMTqY3+@smile.fi.intel.com> <YnJSQ3jJyvhmIstD@zx2c4.com>
In-Reply-To: <YnJSQ3jJyvhmIstD@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 May 2022 11:00:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgb_eBdjM_mzEvXfRG2EhrSK5MHNGyAj7=4vxvN4U9Rug@mail.gmail.com>
Message-ID: <CAHk-=wgb_eBdjM_mzEvXfRG2EhrSK5MHNGyAj7=4vxvN4U9Rug@mail.gmail.com>
Subject: Re: [PATCH v2] hex2bin: make the function hex_to_bin constant-time
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Stafford Horne <shorne@gmail.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 3:15 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> > Alignment? Compiler bug? HW issue?
>
> Probably one of those, yea. Removing the instruction addresses, the only
> difference between the two compiles is: https://xn--4db.cc/Rrn8usaX/diff#=
line-440

Well, that address doesn't work for me at all. It turns into =D7=90.cc.

I'd love to see the compiler problem, since I find those fascinating
(mainly because they scare the hell out of me), but those web
addresses you use are not working for me.

It most definitely looks like an OpenRISC compiler bug - that code
doesn't look like it does anything remotely undefined (and with the
"unsigned char", nothing implementation-defined either).

             Linus
