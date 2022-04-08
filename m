Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8284F8ABF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiDHALN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 20:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiDHALK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 20:11:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4634A2BFC3A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 17:09:08 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q19so10470836wrc.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 17:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PfNmVPJPOYhZo6mM9f4K9oOc3fjfxWYYQ/iwukBRnhg=;
        b=oraFk9phjJ55S9hBviFxzSiOkTOQTu7UEJ9re7/6lyBOUw0OQY89NWl6Ih4kH21IxI
         JY/Yrq8t02I1lVWV/dazvMWc2BWNt/XABfRSqbA+YkgHiA2e7CFE2FSgmQKSUBipDFr1
         kbhtpFbZs1XVFAVOJrzhEIfBJPAgz/8PlT/SVTWvFEGhdpX2pDqm/wTCxDVZiRrs6MPv
         d1r57kJMyzc+7H/5vZBXlyo9BKJqMRWmbxjN6s4VZ9DlhJiA4cv9p2qZGCwKZXAAXePN
         IZJZdvnGIHvqg/W0D+nn8uBPZBNLQbbUfpN7jHKCH5/QZWDSXgnpZzux4fkQNehLuU0/
         Ehxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PfNmVPJPOYhZo6mM9f4K9oOc3fjfxWYYQ/iwukBRnhg=;
        b=pkEOwBeWahH5oyws9d9CUGyUpICFaG9RfoHqIx5ZY/QhFCuvpo5GBbmENQVCLTzfht
         40qbRyWzPVu1HaYSzRbON3kenyiYBs1J1Iz/yQcxO8Oto4krIi09Bmtkgjn0iI0OJfVk
         C9ONcv7gvWRFMI1NNjJxYF8LWsD1eStzgdGe4neHkIklukYrjg03Zcl3kSbmcBnrT9IT
         BDbat9MaxxSL9I2WJw+lZAicQByYztWMRSreFq5Vo8v1Pwa6mccbNxt240r7IWXuHu9X
         0QlsUuXmwctpM5ic+yi0na39Rky/dMF3edSJjhotebpmaPHgzo2fQmIkPFt/Q35Gw+iQ
         lPkg==
X-Gm-Message-State: AOAM532Gd8vumKNMOAkYuF23rro5tBRHAxtizlYgKTerIjxGsrqWoQ+d
        ShEKdsUWYdUiNrjTkzfSR0E=
X-Google-Smtp-Source: ABdhPJyQWpXvBLKy9TL/68rPekbZXgqMOHgyXrxVRabA+akeP5vXPiWlRy91wCTHuYYPWMFbtkdNwA==
X-Received: by 2002:a5d:6c65:0:b0:204:119d:37e2 with SMTP id r5-20020a5d6c65000000b00204119d37e2mr12255514wrz.635.1649376546646;
        Thu, 07 Apr 2022 17:09:06 -0700 (PDT)
Received: from smtpclient.apple ([185.238.38.242])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d6da7000000b00203d9d1875bsm20728387wrs.73.2022.04.07.17.09.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2022 17:09:06 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 1/2] gfs2: remove usage of list iterator variable for
 list_for_each_entry_continue()
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <CAHc6FU4s952rPPsceefvZER8dPM9RVWyQrmneMyqaW_0oViFSA@mail.gmail.com>
Date:   Fri, 8 Apr 2022 02:09:05 +0200
Cc:     Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0EB429B0-8A2F-4247-8F84-F6A78BD030F0@gmail.com>
References: <20220331223857.902911-1-jakobkoschel@gmail.com>
 <CAHc6FU4s952rPPsceefvZER8dPM9RVWyQrmneMyqaW_0oViFSA@mail.gmail.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
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



> On 4. Apr 2022, at 16:58, Andreas Gruenbacher <agruenba@redhat.com> =
wrote:
>=20
> Hi Jakob,
>=20
> On Fri, Apr 1, 2022 at 12:40 AM Jakob Koschel <jakobkoschel@gmail.com> =
wrote:
>> In preparation to limiting the scope of a list iterator to the list
>> traversal loop, use a dedicated pointer to iterate through the list =
[1].
>>=20
>> Since that variable should not be used past the loop iteration, a
>> separate variable is used to 'remember the current location within =
the
>> loop'.
>>=20
>> To either continue iterating from that position or start a new
>> iteration (if the previous iteration was complete) =
list_prepare_entry()
>> is used.
>=20
> I can see how accessing an iterator variable past a for_each_entry
> loop will cause problems when it ends up pointing at the list head.

Well, as long as you only use it to access the list head, there
should be no problem, hence no bug.

The issue are more the cases that use other members of that 'bogus'
pointer and there were plenty of such cases [1].
That's why the goal is to "not use the iterator variable after the loop"
so the scope can be lowered and such cases are avoided by construction.

> Here, the iterator variables are not accessed outside the loops at
> all, though. So this patch is ugly, and it doesn't even help.

I do agree that this patch is ugly. I'm open to suggestions on how to
improve the code allowing to lower the scope of 'bd1' to the traversal
loop. But I don't agree that the iterator variables are not used outside
of the loops. (If with loops you mean the list traversals).

The iterator variables are not used "after" in terms of code location =
but
since it's wrapped by a while loop they are used "after" in regards of
execution time.
=46rom the second iteration of the while loop onwards, it will used the
leftover 'bd1' pointer from the previous iterations list traversal, =
hence
using the variables "outside of the traversal loops". Lowering the scope
will not be possible because of this.

>=20
>> Link: =
https://lore.kernel.org/all/CAHk-=3DwgRr_D8CB-D9Kg-c=3DEHreAsk5SqXPwr9Y7k9=
sA6cWXJ6w@mail.gmail.com/ [1]
>> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
>> ---
>> fs/gfs2/lops.c | 16 ++++++++++++----
>> 1 file changed, 12 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
>> index 6ba51cbb94cf..74e6d05cee2c 100644
>> --- a/fs/gfs2/lops.c
>> +++ b/fs/gfs2/lops.c
>> @@ -653,7 +653,7 @@ static void gfs2_before_commit(struct gfs2_sbd =
*sdp, unsigned int limit,
>> bool is_databuf)
>> {
>> struct gfs2_log_descriptor *ld;
>> - struct gfs2_bufdata *bd1 =3D NULL, *bd2;
>> + struct gfs2_bufdata *bd1 =3D NULL, *bd2, *tmp1, *tmp2;
>> struct page *page;
>> unsigned int num;
>> unsigned n;
>> @@ -661,7 +661,7 @@ static void gfs2_before_commit(struct gfs2_sbd =
*sdp, unsigned int limit,
>>=20
>> gfs2_log_lock(sdp);
>> list_sort(NULL, blist, blocknr_cmp);
>> - bd1 =3D bd2 =3D list_prepare_entry(bd1, blist, bd_list);
>> + tmp1 =3D tmp2 =3D list_prepare_entry(bd1, blist, bd_list);
>=20
> We should actually be using list_entry() here, not =
list_prepare_entry().

I'm not sure if you are referring to using list_entry() here in the =
original or
in the changed version.

I don't see how that would be much better in either cases. 'bd1' can be =
NULL in both cases
which would break when simply using list_entry(). In the original code, =
'bd1' would
be NULL for the first iteration of the while loop and in the updated =
version it
would be NULL in the first iteration + every time the list traversal in =
the previous
iteration did not break early.

Just using 'bd1 =3D list_entry(bd1, blist, bd_list);' when initializing =
would work
in the original code.
But it's not solving the scope issue where 'bd1' is used outside of the =
list
traversal loop.

>=20

[1] =
https://lore.kernel.org/linux-kernel/20220308171818.384491-1-jakobkoschel@=
gmail.com/

Thanks,
Jakob

