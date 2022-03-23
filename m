Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004F14E4BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 05:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241779AbiCWEWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 00:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiCWEWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 00:22:02 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC8470870;
        Tue, 22 Mar 2022 21:20:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w7so701405lfd.6;
        Tue, 22 Mar 2022 21:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pc/hvVo0/6NKpglRsU7c5DEB6PgMyaUIQfdPH5do0+I=;
        b=B8/vZ43epAmy3zm8teeKI/qHOROvXFw2pqqi7vPAPsEBeqdMz8Pt+h2wZ75zku3TYT
         WbFHYje2B7Eya5XOrU0sGzEfJjtzxRE93umNgv0tFao6nRnN/QmNlr5CwVxFsI93yrko
         Tpmsc2fYdj/G7lzLS+knpFvtAmnbzsj+rXPPPleQHeB5Pa3NzRK0le7btPS3JN/L+pZw
         IOSWaV0xPtckwXx7Uy0KFi2gzLl5BdtQGDcuUwWzJzvnS/byEQ1G1I1gaNI6gGDZQfhe
         S6slYlZOiCR/YWzOPr6PtjElWmwZTS/9TPCEJswqoTSI7biWZ6b0VX8poP9b2E5q/tY4
         xQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pc/hvVo0/6NKpglRsU7c5DEB6PgMyaUIQfdPH5do0+I=;
        b=CwL6vMt4k1eBANIpumMOIhKspY49mT2f1bjjJE3QBim+jrLAbYKLcqih4gwPqb6sWz
         kD5GZV/sxd4ML0FhqcfHnyE+NnsfQpI/Yso/57pXI0L5xwJTcMHPZCogZymTpOEB1yuh
         I3I5tWnNVH54dkJiWAWl5dvAhD8VJJkjcZV4ZQbFfKlADm50g/Z296viatEmgZL/nF/0
         zFll4jE8/2wafDZLrFyFegh1ilZGQiizE2a35hHYWbwEBQ6MFKvrMNGjbmfsAOQU//JC
         3YCStg4r+iJZiB1dSufxaeYTS6QLzv0BsswTPAkAM2hEH/rNnVZ+5nj4PLKHx0Y0JMhg
         AtoQ==
X-Gm-Message-State: AOAM532wSEqb1MHbasdLodBGxYjNn0IgBx7x+jpL833TJ9NLjoDaXKDC
        pNRD/beV9NPDFMcSMzoY4WKihT619y4V+fI+U/k=
X-Google-Smtp-Source: ABdhPJwYUD5lEyXExITlf9Ho8r5Y0Xi7y7bkZfLHtNb1ieORDpPSd1WYv2KM4NKaeou5qsHbZLInXFMrkn3nqTaCftY=
X-Received: by 2002:a05:6512:b19:b0:446:f1c6:81bd with SMTP id
 w25-20020a0565120b1900b00446f1c681bdmr20966035lfu.320.1648009232002; Tue, 22
 Mar 2022 21:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220320135015.19794-1-xiam0nd.tong@gmail.com> <CANT5p=qEmVtgC5gD5G3D1o+7mxLMpQawnh0DSY+dLD-Dyrw5Uw@mail.gmail.com>
In-Reply-To: <CANT5p=qEmVtgC5gD5G3D1o+7mxLMpQawnh0DSY+dLD-Dyrw5Uw@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 22 Mar 2022 23:20:21 -0500
Message-ID: <CAH2r5mu-Ci=HL+BkeEYVkW8Qc9jCW7ma7a_yK4-70MgoJgJkhA@mail.gmail.com>
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

tentatively merged into cifs-2.6.git for-next pending additional testing

Also added cc:stable 5.17

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
