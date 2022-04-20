Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CD75083F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346893AbiDTIt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbiDTIt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:49:27 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BFB17AB4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:46:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r13so2055664ejd.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QArLsIT6s7ntTWKM79ixwz9SubeDVO+01rJZYCmJhAI=;
        b=OsIBgFMwkBRs8Cs9x6FSqYpOYCxffAMrLFyciN8d4alWeBg0B3naUc5D4lFt/Zy5Z9
         oxz4hmz/fUARL5SRiGrU028x2VvNTvV/TBWLe1Q/FYgxlrp1wdw+oMovghLTMQBmUkoc
         t9MRNC/qpOZo7ivU/O8sfIN/GdojfxQ/EBbgVbG7RDOJ3Vwe3LAwR87JZD2Cxg3RtiQ+
         dCnuIJnxIAwyOyoAyZBlBipC7Grg5tMl/6yhiA7djiSTZ66M/CqoiretBkcZ8n+bloU5
         LY5FImBBanm5ZjvtSm4jLVzdtXO/yr2/RHHXZpsjl2SaFS3+um/PgcSfDuQC1WnNg3Ki
         OT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QArLsIT6s7ntTWKM79ixwz9SubeDVO+01rJZYCmJhAI=;
        b=nHOnJYrYQpWajwINij1vKbVPpjqbCKjvfaJ9HCWdO/ZE0qcPzsqu5ew/5F1w16lNz8
         L1ph6qgb/TAoXCgeqmhB+wyzNnaCtsX0JB9Yr7KWXMcJF0gTrTv1Xkm+6I+FUuj/YokO
         F5aEECh8PYN22kgXszBZfGbLBis4uMHZzRVPiE5HduZByNDEzN9bK1n6Vro7iw8o6bCv
         Ev9iSskY0DUmtVuBm6t9Cf0iASUtcBJTbiS0IKFFHbse4As0038SffSo6BC/y48lGDbK
         irML7hY6lNfD1F1hU9zS/e3mHqioqXf29d4N9SzU9XjvuilkpIGcPhRRJFg3nbf+3KPN
         OO3w==
X-Gm-Message-State: AOAM530MNNnAGoDoi3njBz0X3QpW97QNS1tSim/uHKPr4u4Xo6yYj4sH
        4oJhJaG//DExw6d/UKZH9wCoWmR9FcNXUBNcwB4=
X-Google-Smtp-Source: ABdhPJxDX2Ox5D1qveJJ6puhBQK4jNgpG+yRgcrayoM/GjnIN4VQYO0yVUePdYt8VF0a6RX+J3+SnMl5GmeYMKU8AZg=
X-Received: by 2002:a17:907:7f9f:b0:6ef:a120:4ea6 with SMTP id
 qk31-20020a1709077f9f00b006efa1204ea6mr13428222ejc.607.1650444400170; Wed, 20
 Apr 2022 01:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220419071855.23338-1-guozhengkui@vivo.com> <7cb4d3be-925f-05bd-78fe-67a69dfee18d@deltatee.com>
In-Reply-To: <7cb4d3be-925f-05bd-78fe-67a69dfee18d@deltatee.com>
From:   Alexander Fomichev <fomichev.ru@gmail.com>
Date:   Wed, 20 Apr 2022 11:46:28 +0300
Message-ID: <CAEKnZG4qTOn8mbTNPaaHbkttnfLz9Nc88DpCcm84T32hiPA5uQ@mail.gmail.com>
Subject: Re: [PATCH] ntb_perf: fix doubletest cocci warning
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Guo Zhengkui <guozhengkui@vivo.com>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        "open list:NTB DRIVER CORE" <ntb@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        zhengkui_guo@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, nice catch.
I'll include it into the next patch version.

Regards,
Alexander.

=D0=B2=D1=82, 19 =D0=B0=D0=BF=D1=80. 2022 =D0=B3. =D0=B2 18:50, Logan Gunth=
orpe <logang@deltatee.com>:
>
>
>
> On 2022-04-19 01:18, Guo Zhengkui wrote:
> > `!data->ops.init` has been repeated triple. The original logic is to
> > check whether `.init`, `.run` and `.clear` callbacks are NULL or not.
> >
> > Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
>
> This appears to be a patch against Alexander's patch which has not been
> accepted yet. Posting a note on his patch so he fixes it for the next
> posting would be preferable.
>
> Logan
>
> > ---
> >  drivers/ntb/test/ntb_perf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> > index c106c3a5097e..dcae4be91365 100644
> > --- a/drivers/ntb/test/ntb_perf.c
> > +++ b/drivers/ntb/test/ntb_perf.c
> > @@ -1451,7 +1451,7 @@ static void perf_ext_lat_work(struct work_struct =
*work)
> >  {
> >       struct perf_ext_lat_data *data =3D to_ext_lat_data(work);
> >
> > -     if (!data->ops.init || !data->ops.init || !data->ops.init) {
> > +     if (!data->ops.init || !data->ops.run || !data->ops.clear) {
> >               struct perf_ctx *perf =3D data->perf;
> >
> >               data->status =3D -EFAULT;
