Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B9B4E4175
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbiCVOh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbiCVOhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:37:24 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818A18118D;
        Tue, 22 Mar 2022 07:35:56 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id o6so24227535ljp.3;
        Tue, 22 Mar 2022 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4QFC7wD2f8NyrU+V9IfhPZZ4570NNl/bW6dl2S6xb70=;
        b=aqQvPSoYUzAWoKP+RCT+gNjGBZouHYy4cFxwXmHNsxpveBX1AbqI4qAQseLuM16i9l
         u3fUgLs14FkrsUZV5PAu92WLy2W7ULyVESU8Od7eevwqlJG1O2iwho79otrCaVJMgs15
         nJRcjDXvz3nfTywN3ul13P3FUZdpkjxWVIKqvrgYh/Gw424bntpDaAu09W1ZBFAlJ0As
         NKf6pgToW0daQpmrOXBKlEpi39dIUSR87VgSc4qCzD0aXO3s+ULvPnen/HFzPMjN1d4r
         C3rOafuAoNgVHMfomlFwB6O+4tTQXJ7gL7sloP6o8jLc/Y5wQenhFy3YwXrKJrpCDhv3
         WDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4QFC7wD2f8NyrU+V9IfhPZZ4570NNl/bW6dl2S6xb70=;
        b=L4vLJHa7j+08wzdebbXHfRe3Antx1ESi5/YpObp7H2VCOSS9/rrvfOpKhmlH1+GJuk
         +41zwuAmWGbV+Epw5MYwIWjFgzBi4ujfH9M/HJOAh+5m9bVGQ8QzeZL6kJ5MiwwSOPie
         fe9ygWd1idKBYabrfqbSYC9V5uQzyt1TNYe5iyjWf3Dxx6xyeyC6dxajYVpt11SvluVe
         DYoC6aNXvOmlTODq4OuuWBWZAT0ozcchTVXPDjWkGNTqQxPMMnZ27x5wUhSfg6zrN+x+
         WpdQNdpF4CrvFy5isPvwJRb2qRjfMgk2pqx84xTl+k7p350qmkhSbwYWN2PKhBVLNfxC
         icRw==
X-Gm-Message-State: AOAM531UzJvgN4pxCoamU0IMEXGEeNEB3n+AOgGmZhXhIMtza3I4Nqso
        +niaPZ5I/tD6qMvEMe0Hwcp0vLcroK2CvJ5iSs49gpEL
X-Google-Smtp-Source: ABdhPJxJQKTW5hv1D0gmq2yXlJ4T7YlsKgTYCESts6Cvaqq0CfEzlbpWzWt3qw7q55yP02e5yHf9+9pFbabmZ666h8M=
X-Received: by 2002:a05:651c:1597:b0:247:f79c:5794 with SMTP id
 h23-20020a05651c159700b00247f79c5794mr18473828ljq.398.1647959754588; Tue, 22
 Mar 2022 07:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220320135015.19794-1-xiam0nd.tong@gmail.com> <CANT5p=qEmVtgC5gD5G3D1o+7mxLMpQawnh0DSY+dLD-Dyrw5Uw@mail.gmail.com>
In-Reply-To: <CANT5p=qEmVtgC5gD5G3D1o+7mxLMpQawnh0DSY+dLD-Dyrw5Uw@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 22 Mar 2022 09:35:43 -0500
Message-ID: <CAH2r5mv0mEYDofMrOrkpqE1PLYt9rYa9fAi-cjihR3x2MF0v3w@mail.gmail.com>
Subject: Re: [PATCH] cifs: fix incorrect use of list iterator after the loop
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     Xiaomeng Tong <xiam0nd.tong@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Shyam Prasad N <sprasad@microsoft.com>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven French <sfrench@samba.org>, jakobkoschel@gmail.com
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

cc:stable too?

On Tue, Mar 22, 2022 at 1:09 AM Shyam Prasad N via samba-technical
<samba-technical@lists.samba.org> wrote:
>
> On Mon, Mar 21, 2022 at 3:50 PM Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:
> >
> > The bug is here:
> > if (!tcon) {
> >         resched = true;
> >         list_del_init(&ses->rlist);
> >         cifs_put_smb_ses(ses);
> >
> > Because the list_for_each_entry() never exits early (without any
> > break/goto/return inside the loop), the iterator 'ses' after the
> > loop will always be an pointer to a invalid struct containing the
> > HEAD (&pserver->smb_ses_list). As a result, the uses of 'ses' above
> > will lead to a invalid memory access.
> >
> > The original intention should have been to walk each entry 'ses' in
> > '&tmp_ses_list', delete '&ses->rlist' and put 'ses'. So fix it with
> > a list_for_each_entry_safe().
> >
> > Fixes: 3663c9045f51a ("cifs: check reconnects for channels of active tcons too")
> > Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> > ---
> >  fs/cifs/smb2pdu.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> > index 7e7909b1ae11..f82d6fcb5c64 100644
> > --- a/fs/cifs/smb2pdu.c
> > +++ b/fs/cifs/smb2pdu.c
> > @@ -3858,8 +3858,10 @@ void smb2_reconnect_server(struct work_struct *work)
> >         tcon = kzalloc(sizeof(struct cifs_tcon), GFP_KERNEL);
> >         if (!tcon) {
> >                 resched = true;
> > -               list_del_init(&ses->rlist);
> > -               cifs_put_smb_ses(ses);
> > +               list_for_each_entry_safe(ses, ses2, &tmp_ses_list, rlist) {
> > +                       list_del_init(&ses->rlist);
> > +                       cifs_put_smb_ses(ses);
> > +               }
> >                 goto done;
> >         }
> >
> >
> > base-commit: 14702b3b2438e2f2d07ae93b5d695c166e5c83d1
> > --
> > 2.17.1
> >
>
> Hi Xiaomeng,
> Good catch.
> Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
>
> Steve, This one needs to be marked for CC stable 5.17+
>
> --
> Regards,
> Shyam
>


-- 
Thanks,

Steve
