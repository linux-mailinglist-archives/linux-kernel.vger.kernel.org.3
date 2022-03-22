Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985624E38B5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 07:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbiCVGJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 02:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbiCVGJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 02:09:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7890EDFA5;
        Mon, 21 Mar 2022 23:07:21 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id yy13so34047660ejb.2;
        Mon, 21 Mar 2022 23:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1hm+docfkUVqEam48lSJ/XtpRGXyQocEIR0nX5W2ZtM=;
        b=VywcMOvEZFwLhpkST2+FlCVyLxNDV0cChbksFCwU8GKcB0RIFZRTZXsWrBSl6KqT4i
         PUZ/EeRnH/koriftEd/z89xhuf5wo4Gi68p05x221zllgBBYSPBJOIKmIXMSojLsMiId
         o8B7fswqMyzlAUiGzX0vV4RmxVFy9NlZ3gkU0q6A1mwwXEgh0sQ6uYaPasUq32rMX12j
         ugAmGJ9ZCyKPg+Sb496yHdkwhcf+o+vDVaAc09v423HDsALdDWOfUiN+mag7XnedL8HI
         8HnZx5Jokft+D06Yj9NVXOvUYH5kKRYeJER9UFZZe4UNoxMwUeK7IGZX60BtL4bZxHlF
         0mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1hm+docfkUVqEam48lSJ/XtpRGXyQocEIR0nX5W2ZtM=;
        b=NzdpHmFTkVUPcdnfNEFcjrTC4RyDmP1+wmJRktXTv9CitynRNCL9EloNmj5QJdaWvd
         pFTIrPSC8xoSAqmlQ9T76+xvMx5eJkl+CAxamrGyO4EUq2tmsmMA1hXMn5LX1P6it/1N
         jcduJbYuPzsh1aImYmx/igixd+yWu40JZefGpzPjIztdyBfHPRPqDKC9ckmPHrWnwdjO
         H8wP5TnDJXx4KusAKRn5f/vCltRXFvmm4RVKusn1I/qmQpjg3Ft81rnTlfhsY7jYIbtO
         zmTkceqojijpcKKtI5vt3Jq44+hN3iAhDUFtS5LXozQb+9gH6jEujY4se34edsSNYM/y
         1pvQ==
X-Gm-Message-State: AOAM531S+YIJcUwvol0hXt8utE5asJJ06EC67SzhRyPlBISO83Elbq1n
        vGT2/ja+yBzHREnOZ+fURft4b3j/BSIPLqjYSjGe8qr4
X-Google-Smtp-Source: ABdhPJyK/wsqhsSQyJvOrciSXA3uBP98YcKlsmdsB31Cxv9jYH4FgXeH3iTdG9GXePOmDPRombY3tIpaa9KFnEDxPSs=
X-Received: by 2002:a17:907:2ce3:b0:6df:d80f:ca1 with SMTP id
 hz3-20020a1709072ce300b006dfd80f0ca1mr13595196ejc.61.1647929239809; Mon, 21
 Mar 2022 23:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220320135015.19794-1-xiam0nd.tong@gmail.com>
In-Reply-To: <20220320135015.19794-1-xiam0nd.tong@gmail.com>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Tue, 22 Mar 2022 11:37:08 +0530
Message-ID: <CANT5p=qEmVtgC5gD5G3D1o+7mxLMpQawnh0DSY+dLD-Dyrw5Uw@mail.gmail.com>
Subject: Re: [PATCH] cifs: fix incorrect use of list iterator after the loop
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     Steven French <sfrench@samba.org>, sprasad@microsoft.com,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>, jakobkoschel@gmail.com
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

On Mon, Mar 21, 2022 at 3:50 PM Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:
>
> The bug is here:
> if (!tcon) {
>         resched = true;
>         list_del_init(&ses->rlist);
>         cifs_put_smb_ses(ses);
>
> Because the list_for_each_entry() never exits early (without any
> break/goto/return inside the loop), the iterator 'ses' after the
> loop will always be an pointer to a invalid struct containing the
> HEAD (&pserver->smb_ses_list). As a result, the uses of 'ses' above
> will lead to a invalid memory access.
>
> The original intention should have been to walk each entry 'ses' in
> '&tmp_ses_list', delete '&ses->rlist' and put 'ses'. So fix it with
> a list_for_each_entry_safe().
>
> Fixes: 3663c9045f51a ("cifs: check reconnects for channels of active tcons too")
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
>  fs/cifs/smb2pdu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index 7e7909b1ae11..f82d6fcb5c64 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -3858,8 +3858,10 @@ void smb2_reconnect_server(struct work_struct *work)
>         tcon = kzalloc(sizeof(struct cifs_tcon), GFP_KERNEL);
>         if (!tcon) {
>                 resched = true;
> -               list_del_init(&ses->rlist);
> -               cifs_put_smb_ses(ses);
> +               list_for_each_entry_safe(ses, ses2, &tmp_ses_list, rlist) {
> +                       list_del_init(&ses->rlist);
> +                       cifs_put_smb_ses(ses);
> +               }
>                 goto done;
>         }
>
>
> base-commit: 14702b3b2438e2f2d07ae93b5d695c166e5c83d1
> --
> 2.17.1
>

Hi Xiaomeng,
Good catch.
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>

Steve, This one needs to be marked for CC stable 5.17+

-- 
Regards,
Shyam
