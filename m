Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A9E4EFCEC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 00:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348134AbiDAW7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 18:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbiDAW7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 18:59:16 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949F510EC77;
        Fri,  1 Apr 2022 15:57:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id o10so8831751ejd.1;
        Fri, 01 Apr 2022 15:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=odp8vPSrsGCDHTxBlCJBkUQlfDgPnsc40UuHFtd7eNs=;
        b=Rdjl0StWDvlqPSkcTdipx0AYfIMitNRwMshF2jIizp314PlvMyKpIVZ5ATCuArVjxd
         pNd1wV9Bq4DWPD7RUv62Pe6deVZeY1gSJmu9LgWcSJYbpyKvNiy9picZZfBemafEaEwt
         Q+QzDPIhGpqLKdea1kxahqQ6ENQbkR8RXAPMMxRaMElHgGZxwEt6iG60Wi73ZCgXpsoi
         Hy9vZ4CPFE4SQsEcbV1Gmjhh+tQihEHrRwNugEvC/oqPokMGA19Sn75uNvxum+P92YER
         KgsD0Tfna8D3VoGtysrgoEVSOwVTTCtWduBMDLVESnsPuYl4hTLuh0E5ms4GkQucPZHP
         V4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=odp8vPSrsGCDHTxBlCJBkUQlfDgPnsc40UuHFtd7eNs=;
        b=LWsMX+9cbPKbMRDKQVIuNReunNXWhWRJzCSITpIJQVbBAJt5Z95feWA8Tq9S5s/uoW
         EV5pLrqGPRBVaYp4m6mRez09H4dSLttz+qul9kFTn6jQsBhKtEQqLxj6fGmbWj3K2h/m
         N4BbOEdnqL2rhIDrZphV3g2djpFsmIYDJRrYJBmC87cv4U45h8tWeoD2uD6t/TM0gx3s
         XE9BIxCho2JAUK01721OQbga0tWqerHeSksMckuNspHsuAU6v+mcv/Vrk6AVBY5SlQgx
         hqGKRcrxHeyNa3Bn+sAmgSaLsqYTGjwocYZbMaeVDKeUQ0knv6adoCF8dnmhNOmfZguR
         RWIg==
X-Gm-Message-State: AOAM533J4cfMOaorxOmmdsBvFV7vWkSx6TbrbrRFrbggt//CHBNRBv1s
        gfrid0X7VCjTgKJVCoIqVk4=
X-Google-Smtp-Source: ABdhPJy0DDhX6Davch3/9HrXMB/nM7eaAOfaj9QoMrd0/uYX/HYU4JOPDBbTuGaT/mMkv1FHO3jnXg==
X-Received: by 2002:a17:907:72cc:b0:6e0:2d3:bcba with SMTP id du12-20020a17090772cc00b006e002d3bcbamr1743143ejc.642.1648853845046;
        Fri, 01 Apr 2022 15:57:25 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906144200b006ceb8723de9sm1465021ejc.120.2022.04.01.15.57.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Apr 2022 15:57:24 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 1/2] cifs: replace unnecessary use of list iterator
 variable with head
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <CAH2r5mv-GCwR74QEv4WncTN6KMHceCT+YcLX7SnmuZwO67DuFQ@mail.gmail.com>
Date:   Sat, 2 Apr 2022 00:57:21 +0200
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <863A56C1-E99D-4298-AC32-94F9F1E24F1F@gmail.com>
References: <20220331215541.883746-1-jakobkoschel@gmail.com>
 <CAH2r5mv-GCwR74QEv4WncTN6KMHceCT+YcLX7SnmuZwO67DuFQ@mail.gmail.com>
To:     Steve French <smfrench@gmail.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Steve,

> On 2. Apr 2022, at 00:44, Steve French <smfrench@gmail.com> wrote:
>=20
> It looks like this no longer applies cleanly.   Can you recheck
> fs/cifs/smb2pdu.c (function smb2_reconnect_server) and see if it
> applies now that it has changed e.g.

looks like this issue was already fixed in the meantime.
Feel free to ignore PATCH 1/2.

>=20
>=20
> /* allocate a dummy tcon struct used for reconnect */
> tcon =3D kzalloc(sizeof(struct cifs_tcon), GFP_KERNEL);
> if (!tcon) {
> resched =3D true;
> list_for_each_entry_safe(ses, ses2, &tmp_ses_list, rlist) {
> list_del_init(&ses->rlist);
> cifs_put_smb_ses(ses);
> }
> goto done;
> }
>=20
> You had this:
>=20
> --- fs/cifs/smb2pdu.c
> +++ fs/cifs/smb2pdu.c
> @@ -3858,7 +3858,7 @@ void smb2_reconnect_server(struct work_struct =
*work)
>  tcon =3D kzalloc(sizeof(struct cifs_tcon), GFP_KERNEL);
>  if (!tcon) {
>  resched =3D true;
> - list_del_init(&ses->rlist);
> + list_del_init(&pserver->smb_ses_list);
>  cifs_put_smb_ses(ses);
>  goto done;
>  }
>=20
> On Fri, Apr 1, 2022 at 2:23 AM Jakob Koschel <jakobkoschel@gmail.com> =
wrote:
>>=20
>> When list_for_each_entry() completes the iteration over the whole =
list
>> without breaking the loop, the iterator variable will *always* be a
>> bogus pointer computed based on the head element.
>>=20
>> To avoid type confusion use the actual list head directly instead of
>> the last iterator value.
>>=20
>> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
>> ---
>> fs/cifs/smb2pdu.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
>> index 7e7909b1ae11..4ac86b77a7c9 100644
>> --- a/fs/cifs/smb2pdu.c
>> +++ b/fs/cifs/smb2pdu.c
>> @@ -3858,7 +3858,7 @@ void smb2_reconnect_server(struct work_struct =
*work)
>>        tcon =3D kzalloc(sizeof(struct cifs_tcon), GFP_KERNEL);
>>        if (!tcon) {
>>                resched =3D true;
>> -               list_del_init(&ses->rlist);
>> +               list_del_init(&pserver->smb_ses_list);
>>                cifs_put_smb_ses(ses);
>>                goto done;
>>        }
>>=20
>> base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
>> --
>> 2.25.1
>>=20
>=20
>=20
> --=20
> Thanks,
>=20
> Steve

