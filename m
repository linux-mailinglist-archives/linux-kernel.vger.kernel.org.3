Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACB04C8763
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiCAJIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiCAJIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:08:01 -0500
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5A38A31C;
        Tue,  1 Mar 2022 01:07:18 -0800 (PST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 22196kmS002069;
        Tue, 1 Mar 2022 18:06:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 22196kmS002069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646125607;
        bh=UY9OLn7hFjW9U1chVHUgkyiDXtaLJsAZWOhrge7kbXU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l0XwBzNr1NPLGPpqyMiqVggwwCB/1A72aUdEoK79UH5a67OgyaQfm1oYMV8+RL3E5
         E+ao5qZzHxewrO6QNfgSp6mk0edql70nkkdLBEAut6S7urcACDu6VTgWV23gEOBnvN
         zuggLLvot9SWKVVvJcVeQgpZpJLl36cJkN6qK+Y/B2kJO1DbQKU+Dpwq9w9PTyHM/d
         HJzs6drAtbY4D/wzs/MzOVaXS6k7wmHTde2fPZozhwpzK2tmRbUkKAlYt4xqW8UQ5p
         lv+u6bvi4zf+AT9eD7iA/rJqgA9x03Tn6fxLnxnW+5B5pp2GfrNJsBnumCjlpvAfhP
         qfHa/vyDGfvDw==
X-Nifty-SrcIP: [209.85.214.181]
Received: by mail-pl1-f181.google.com with SMTP id z2so12937555plg.8;
        Tue, 01 Mar 2022 01:06:47 -0800 (PST)
X-Gm-Message-State: AOAM530t/zdrpZUuLmI6iGLy0pyvPkquiFQs3kpThFE4B9+siG2h/9mF
        MIv79gOEWf62Owdn10QNEbuh+rWOU47HpPvqxh8=
X-Google-Smtp-Source: ABdhPJzujXuF494nq7rmDEipHgFpDJ0z4oRNLE7toucRij1tBQ/y+Gn6/D2MY52bqp1HVdP8vvAst/HO33aU1B0usQc=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr7340286plp.162.1646125606345; Tue, 01
 Mar 2022 01:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20220225144245.182659-1-masahiroy@kernel.org> <CAKwvOd=WjnHSHKLVRJifHxV2tyDsLTkek80NWU=do=FSHhNLug@mail.gmail.com>
 <67b75a36cf874dfea0871649ccd268d3@AcuMS.aculab.com>
In-Reply-To: <67b75a36cf874dfea0871649ccd268d3@AcuMS.aculab.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 1 Mar 2022 18:06:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNARKxd-kr3pABzTC2+uGhEKbyLtXDCSoxn56P0go--bg1A@mail.gmail.com>
Message-ID: <CAK7LNARKxd-kr3pABzTC2+uGhEKbyLtXDCSoxn56P0go--bg1A@mail.gmail.com>
Subject: Re: [PATCH v2] fixdep: use fflush() and ferror() to ensure successful
 write to files
To:     David Laight <David.Laight@aculab.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 11:28 AM David Laight <David.Laight@aculab.com> wrot=
e:
>
> Someone send HTML mail =E2=80=93 outlook is broken =E2=80=93 only lets yo=
u top post :-(
>
>
>
> The return value from fprintf() is normally the number of bytes written t=
o
>
> the internal buffer (8k in glibc?)
>
> Only if the buffer is full and an actual write() is done do you get any i=
ndication of an error.
>
> So you can use the error return from fprintf() to terminate a loop =E2=80=
=93 but it usually
>
> just isn=E2=80=99t worth the effort.
>
> The error status returned by ferror() is =E2=80=98sticky=E2=80=99, so you=
 need only check once.
>
> But you need to check before fclose().
>
> Since fclose() has to write out the buffer =E2=80=93 that write can also =
fail.
>
> I=E2=80=99m not sure whether fclose() returns and error in that case, but=
 adding fflush()
>
> makes the coding easier.


I just checked this.

fclose() returns -1 if it fails to flush the buffer.





[ test code ]
#include <stdio.h>
int main(void)
{
        char buf[2049];
        int ret, i;

        for (i =3D 0; i < 2048; i++)
                buf[i] =3D 'a';

        buf[2048] =3D 0;

        ret =3D printf("%s", buf);
        fprintf(stderr, "printf() returned: %d\n", ret);

        ret =3D fclose(stdout);
        fprintf(stderr, "fclose() returned %d\n", ret);

        return 0;
}


I tested this on Debian buster.


I created a very small partition with 1K size,
then write data to that partition.




root@buster:~# lsblk  /dev/vdb1
NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
vdb1 254:17   0   1K  0 part
root@buster:~# ./a.out  > /dev/vdb1
printf() returned: 2048
fclose() returned -1



The buffer size seems 4k
as far as I tested on Debian.





--=20
Best Regards
Masahiro Yamada
