Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912D15317A4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiEWUSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbiEWUPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:15:54 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F53EA889F
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:14:44 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y12so16470353ior.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2vp0MMS/nvxu6duSf/XEnD4yOQ25zTvmWT7ui8yftHI=;
        b=EdZ3EoZNsBfIF3vb1gybA4QEABs1GgsVjZAOwUbNskNs6gqaa+1mGIdZsiVE3FWno9
         RAdfS9kwfjSlmHdIz2H/oeCWvq6WF7SVHGywATmRIsSOSbcMalHoMxseo68lHAskg1ZN
         rNJXRKMV18WA/dqlhvDFrjgqD41e0Rh7HqGPZvzaibysFy5K7GZfVPQwgyjdgyzX71T0
         encoD5PY9rOu17eULUcVOyjbAKauaKhI+Q+eu7UP9oLA0K46GseesCox5CtiREtXR8Fh
         rbuJ2xTvT/vnR+ONmFcpQ+0jgzQT5n2FiF78UWKT6WN8EIuvsncu5ELomMUqgaHu+cFh
         ilrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2vp0MMS/nvxu6duSf/XEnD4yOQ25zTvmWT7ui8yftHI=;
        b=e4MgP/ha+DfsemDejwW/PZ/9r8HcJuNfDwKV6jowWq107UqzGJxKWzGJdWrto3S2pD
         HzpubYXavg5zd4eJesdFk+5rvllfd9FVdpljOg1jJFJG42+NgjBMdFXxckKeuzMZ3drZ
         ohZexpaSFVEqfOkd6RRPrF6aKaOQmvQeQUYLlOW4yWrurRTZDHS+3wSYjsW4mMghNKuU
         JuXxU+k50cMYH+3XwVpmWkAP3an84QajzWrdn5EeenpPvgkgbI9Nxk5o429Ywfapnczw
         MtS0Mr+djXXdgwdBXben5SbMcIi0HA/tDCgZGSCsIggJe3sAOcSmLkRIq5ooyg5YfGT0
         zCCg==
X-Gm-Message-State: AOAM531e5M7MVFXqYcuO9x5mz6ByV4EkE5MjHjg2GDM4gqOH8EhxJxMV
        q1lTBZxkoC9KXe4HOAU5o77NJNhS5aEXVaEoX8FuZw==
X-Google-Smtp-Source: ABdhPJzXVZsMlIcsfTWmHEvgkX+Yekfi/Nst5WNbxO8+xV3NtL2uQPX45xtzoDCC87H6sQybG3k4+UaeXo/yeImQbr4=
X-Received: by 2002:a02:90ce:0:b0:32e:e2ce:b17c with SMTP id
 c14-20020a0290ce000000b0032ee2ceb17cmr615703jag.268.1653336883586; Mon, 23
 May 2022 13:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220521075736.1225397-1-zenczykowski@gmail.com> <CAADnVQJcDvyeQ3y=uVDj-7JfqtxE+nJk+d5oVQrBhhQpicYk6A@mail.gmail.com>
In-Reply-To: <CAADnVQJcDvyeQ3y=uVDj-7JfqtxE+nJk+d5oVQrBhhQpicYk6A@mail.gmail.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date:   Mon, 23 May 2022 13:14:31 -0700
Message-ID: <CANP3RGcn6ta7uZH7onuRwOzx_2UmizEtgOTMKvbMOL8FER0MXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: print a little more info about maps via cat /sys/fs/bpf/pinned_name
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BPF Mailing List <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 12:32 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, May 21, 2022 at 12:57 AM Maciej =C5=BBenczykowski
> <zenczykowski@gmail.com> wrote:
> >
> > From: Maciej =C5=BBenczykowski <maze@google.com>
> >
> > While this information can be fetched via bpftool,
> > the cli tool itself isn't always available on more limited systems.
> >
> > From the information printed particularly the 'id' is useful since
> > when combined with /proc/pid/fd/X and /proc/pid/fdinfo/X it allows
> > tracking down which bpf maps a process has open (which can be
> > useful for tracking down fd leaks).
> >
> > Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> > ---
> >  kernel/bpf/inode.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > index 4f841e16779e..784266e258fe 100644
> > --- a/kernel/bpf/inode.c
> > +++ b/kernel/bpf/inode.c
> > @@ -257,6 +257,9 @@ static int map_seq_show(struct seq_file *m, void *v=
)
> >         if (unlikely(v =3D=3D SEQ_START_TOKEN)) {
> >                 seq_puts(m, "# WARNING!! The output is for debug purpos=
e only\n");
> >                 seq_puts(m, "# WARNING!! The output format will change\=
n");
> > +               seq_printf(m, "# type: %d, key_size: %d, value_size: %d=
, max_entries: %d, id: %d\n",
> > +                          map->map_type, map->key_size, map->value_siz=
e, map->max_entries,
> > +                          map->id);
>
> Maybe use cat /sys/fs/bpf/maps.debug instead?
> It prints map id.

Is this something that was very recently added?
I'm not seeing it on my 5.16 machine with bpffs mounted at /sys/fs/bpf.
