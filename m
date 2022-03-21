Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F804E27A9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347932AbiCUNgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345886AbiCUNgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:36:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C12D4131E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:34:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a8so29868170ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N8/CwtqN9kge4KyfLwif97kBN6bn65zBDJpOs3ol2XY=;
        b=N+pLfUCjyXYZ1IVBqh+pWSg52dJdjSZVdhekNwZCcOUqAU9NgtFBf5EXl0SZkvbqdb
         FlUfjIh9wfHQdouQEI2M6H7k5E/WNm1LYU9W1vv9rd3W92qZ5tamiKEIeu/HllwodkU2
         Hrtv5t6626Yp8Yr+xLGvJzDRhhXQuOeWENK0/sFpvPstCFF1uyeAnu6aVTq1KGNOpuhE
         Hhx9DfoQcqfC5z/IGDVXBuVQ5dYb+l+Ht28GfAd0uNdjGvX40Fy+Eg8lTENCjBexUBUu
         Xt2+6Bt+pSH7bc1titJe+IQRT9UAdCVNfEeKCSdnRj8XfH0QLgxcRniUBr14HMWCH5ez
         cU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N8/CwtqN9kge4KyfLwif97kBN6bn65zBDJpOs3ol2XY=;
        b=UhRhZH3a6jmO4XJ0jQ/W5h7g0kS7HpGWRbrOvv04/dpZ9OBlOLJCXxOU65hj/3+Ccf
         KHiUbRz8pP3b+A/O+aDacH7U3+67t+4ksH6ncmEU3kVmLxMYNeKvKmmaBY0LPPHarSHz
         GvBxdbgvRXGxCOEyDt8tOrFY03t6t9dOkM0Qg/si/lPKpU5bjdwsZtAcG8468QShdEKV
         KQYSBm5t2xp/bZ6LY8l1dwrhu5YLyFiGzCD/nZxIGCoK9ZPGOTHZVVeko7wwpNeBnNXF
         +QA1hXIYJ2JEXxcK2lUE5015LQYn3RwnKdAFn1cxNMhg98e4Q4HosAWpSIpZiLtWgbyu
         pwTQ==
X-Gm-Message-State: AOAM533cstOdU1RbjLRKeU93BDeeQfUqVbV8tmW+ZQ43NjnDNm1uldTE
        7588LKDfCdh82icr7fTDiiM=
X-Google-Smtp-Source: ABdhPJxBH3xRePg3GN07CJFaSCHvo39gfLOYF2D01sOHTyhiAtmC+JM5coj4Vv88HOlhAoHDarpNdA==
X-Received: by 2002:a17:907:9623:b0:6de:c0fb:8acc with SMTP id gb35-20020a170907962300b006dec0fb8accmr20266161ejc.380.1647869676508;
        Mon, 21 Mar 2022 06:34:36 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id g13-20020a1709065d0d00b006df7dfa2a51sm6776497ejt.132.2022.03.21.06.34.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 06:34:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] ocfs2: fix check if list iterator did find an element
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <abcbf5d2-c348-7dc0-cfd3-9bcc6431bc64@linux.alibaba.com>
Date:   Mon, 21 Mar 2022 14:34:34 +0100
Cc:     Mark Fasheh <mark@fasheh.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7AA04AA-6B4C-4211-99A6-0D3C04ED7B26@gmail.com>
References: <20220319203106.2541700-1-jakobkoschel@gmail.com>
 <abcbf5d2-c348-7dc0-cfd3-9bcc6431bc64@linux.alibaba.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
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


> On 21. Mar 2022, at 02:50, Joseph Qi <joseph.qi@linux.alibaba.com> =
wrote:
>=20
>=20
>=20
> On 3/20/22 4:31 AM, Jakob Koschel wrote:
>> Instead of setting 'res' to NULL, it should only be set if
>> the suitable element was found.
>>=20
>> In the original code 'res' would have been set to an incorrect =
pointer
>> if the list is empty.
>>=20
> The logic before iteration can make sure track_list won't be empty.
> Please refer the discussion via:
> =
https://lore.kernel.org/ocfs2-devel/bd0ec87e-b490-83dc-2363-5e5342c59fa4@l=
inux.alibaba.com/T/#m96d4397930201d83d68677c33a9721ae8dbd8f15

ah yes, I just read up on the discussion there, sorry for having =
duplicated it
here.

Was any conclusion reached there which fixes can/should be merged?

This code obviously can always be safe if the list cannot be empty.
That's also not necessarily the reason I'm fixing this. The reason is =
that
we want to get rid of any use of the list iterator variable after the =
loop
('res' in this case). This will allow moving the list iterator variable
into the scope of the list iterator macro to forbid any invalid use of =
it
at compile time. Like this you don't have to rely on assumptions that =
are
hard to validate (e.g. that a certain list is never empty).

The patch here is the minimal change to simply do that but looking at
Dan Carpenter patch there might be more things in this code that can
be simplified.

[CC'd Dan Carpenter]

See [1] for changes that have already been merged:

[1] =
https://lore.kernel.org/linux-kernel/20220308171818.384491-3-jakobkoschel@=
gmail.com/

>=20
> Thanks,
> Joseph
>=20
>> In preparation to limit the scope of the list iterator to the list
>> traversal loop, use a dedicated pointer pointing to the found element =
[1].
>>=20
>> Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
>> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
>> ---
>> fs/ocfs2/dlm/dlmdebug.c | 12 ++++++------
>> 1 file changed, 6 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
>> index d442cf5dda8a..be5e9ed7da8d 100644
>> --- a/fs/ocfs2/dlm/dlmdebug.c
>> +++ b/fs/ocfs2/dlm/dlmdebug.c
>> @@ -541,7 +541,7 @@ static void *lockres_seq_start(struct seq_file =
*m, loff_t *pos)
>> 	struct debug_lockres *dl =3D m->private;
>> 	struct dlm_ctxt *dlm =3D dl->dl_ctxt;
>> 	struct dlm_lock_resource *oldres =3D dl->dl_res;
>> -	struct dlm_lock_resource *res =3D NULL;
>> +	struct dlm_lock_resource *res =3D NULL, *iter;
>> 	struct list_head *track_list;
>>=20
>> 	spin_lock(&dlm->track_lock);
>> @@ -556,11 +556,11 @@ static void *lockres_seq_start(struct seq_file =
*m, loff_t *pos)
>> 		}
>> 	}
>>=20
>> -	list_for_each_entry(res, track_list, tracking) {
>> -		if (&res->tracking =3D=3D &dlm->tracking_list)
>> -			res =3D NULL;
>> -		else
>> -			dlm_lockres_get(res);
>> +	list_for_each_entry(iter, track_list, tracking) {
>> +		if (&iter->tracking !=3D &dlm->tracking_list) {
>> +			dlm_lockres_get(iter);
>> +			res =3D iter;
>> +		}
>> 		break;
>> 	}
>> 	spin_unlock(&dlm->track_lock);
>>=20
>> base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
>> --
>> 2.25.1

	Jakob=
