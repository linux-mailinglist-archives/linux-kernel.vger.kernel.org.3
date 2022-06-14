Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D253E54ADE2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240696AbiFNKES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiFNKEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:04:15 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6183124F1D;
        Tue, 14 Jun 2022 03:04:14 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a28so1360581uaj.10;
        Tue, 14 Jun 2022 03:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NUcA5veSvIKp9efGYaSuiwEPBAGLkgGB6k/vshTldpY=;
        b=Ow4jD17EtDtXtVVIuidII2cS96qWGVvJ+yE+rHXtaAD8sOPcq2wlB11vzXf5lI6kSQ
         fx6FeDAbXEbPlIwcG50VJmjIRsWklRlB1ROWabcb754n32jfxZisgZcFEm3WRxCnl7tZ
         xsHVcf78F9f36XZlWQoVxeUGmFDR3Sls2HUj5GiTRdhwixQus+rSz+p7Muf6BPpHVe9q
         WSnMCaVtYTIFI0Yq2nIdlJKswIr3tFHWh/mMKDXKV0nqQonNa3gaV+e7aO5RAG7sXSj/
         l1qaTeIOrkBcZ6VCp9GrxGika7uuXZ8NoPIeF8beogXYYZZVs2/5+C0B0rm8h/ycrpL6
         KieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NUcA5veSvIKp9efGYaSuiwEPBAGLkgGB6k/vshTldpY=;
        b=DuA9UqwXsMHWzC8rqm8DWL0kqeLnA13Jsq2Hi6gJXY3nm6Ythww/il7eH237p7VrCm
         Bogt8vUoYqNaECaowSRdEUPzudEBahkvDbW3EhQZRX5pjfDs5HPRwWq3LGsrIoE1DPGs
         y73+Rlbl288IHO7ABFZU+uSwSgnkZXUlpS+xWB640Tnck8Ula76JlzdtMSrCtsVLZnE0
         a69lw8eL2p5vFaGZvSiYUGDKnIW7LJEK/cyo0gcYQJ1sfVQ9TaZtq8IUvSWXLEz61O0R
         sNp3+W+KZ7bkE2v5XnMZ5EEfCdogFiBg5ezoZq3OuyftHbRYptkn2zJ3XiO5SmAGr2fy
         ZJeg==
X-Gm-Message-State: AJIora+NkOd019gDmXAGUr6ABzY3GYeOOeXo9+SgJ+vainj/GtKSq/U+
        wgtjZ1Z/4We0odBhlHfgQXOCJ1UX2kLqgZrqLQooHOc1bXs=
X-Google-Smtp-Source: AGRyM1v2Yi2H90p8cw7CGAp0Um+hE8UMBQoM8l+Pz+i3FA88fIHdwGzIpPTvtAckFXEXG2EZHdDkw42ADqdWqd6PkNc=
X-Received: by 2002:ab0:6d9a:0:b0:36e:5a86:92fb with SMTP id
 m26-20020ab06d9a000000b0036e5a8692fbmr1724054uah.38.1655201053486; Tue, 14
 Jun 2022 03:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220614071059.23696-1-liqiong@nfschina.com>
In-Reply-To: <20220614071059.23696-1-liqiong@nfschina.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 14 Jun 2022 12:03:56 +0200
Message-ID: <CAOi1vP-xXk7SSkaQJziv-9j=WfpXYdVieaBmfsJXTnPTYDTOjQ@mail.gmail.com>
Subject: Re: [PATCH] libceph: check pointer before assigned to "c->rules[]"
To:     Li Qiong <liqiong@nfschina.com>
Cc:     Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuzhe@nfschina.com,
        renyu@nfschina.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 9:12 AM Li Qiong <liqiong@nfschina.com> wrote:
>
> It should be better to check pointer firstly, then assign it
> to c->rules[]. Refine code a little bit.
>
> Signed-off-by: Li Qiong <liqiong@nfschina.com>
> ---
>  net/ceph/osdmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 2823bb3cff55..6ec5007f96dc 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -571,9 +571,9 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
>                         goto bad;
>  #endif
>                 r = kmalloc(struct_size(r, steps, yes), GFP_NOFS);
> -               c->rules[i] = r;
>                 if (r == NULL)
>                         goto badmem;
> +               c->rules[i] = r;
>                 dout(" rule %d is at %p\n", i, r);
>                 r->len = yes;
>                 ceph_decode_copy_safe(p, end, &r->mask, 4, bad); /* 4 u8's */
> --
> 2.11.0
>

This doesn't change anything as c->rules pointer array is zeroed out.
Anyway, applied.

Thanks,

                Ilya
