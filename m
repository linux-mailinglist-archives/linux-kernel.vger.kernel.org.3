Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B12F49B39C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382617AbiAYMPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444545AbiAYMKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:10:55 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89950C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 04:09:05 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id w5so12397011ilo.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 04:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=oIUXCBkZfDaLwCmKVAom3m0nKZsZArvDj4sp66MxNIY=;
        b=kbwWYTigtVbAwxVP5h/2WoMNCT0uvDobJJOmV8gAulZTryYMbYlINIkMwhyjUfRvlm
         APbiDi0n5yDb7PWuT3c5q+g+YA5mcbj6tUatepXj1ktuRNxnIpCX7OYCB/9eNKfoNAlH
         LI6jOFVO6fG1UvjIizRiFwgZqz04lBkyIhYDYObNAXfDwZt+HUdAiYoSI3lZ7RVWDet/
         FFzhe6BokKBfPG+t2TtrbnyNdc3QaY9OZ7/rwcWwQEd4vjEEAE9m4hqdA5BzSt9jHuYn
         wWbj1SCWgHoDjrOgWWVhA/SpFPmvg1M993W/otRzFlCRXDErqfRo9cXVBuy01+KPtsMp
         tnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=oIUXCBkZfDaLwCmKVAom3m0nKZsZArvDj4sp66MxNIY=;
        b=uP/hZGlPZQ9ornHE9Ult+brupglrBVdAr6XQOU+C8EkLdrPJ0y3Q7oxUREuM3d41Ud
         eFWlNMPuEBURfM570sL41Hi3l3VYMjARvPRt1saUknmjJQOebpYtFIhIOngNX90WnWMX
         Y52yESaGwSu4KcmTG4c6rU7Sw7/3xppXcOE6NirId3a60EmdB4Ubh8jJnIXBIQ7Zs425
         iqI9oChW8+9GX7sOUDnIPpaQWaay1rCq1OF6B4jiFBHNmT0vjDE55YKd7rvXpHFXWg7L
         LjHyXBNtRWx6Z1tjnGPhQcax5M2B3LNp8UglSqdde5Ckfpr/d2ux/RS1NwU0xB9j2aJU
         1e/Q==
X-Gm-Message-State: AOAM533oH0h5dzw8929Cass0TnKaZFNC7IlHqrnDL/SD/9a1xnfkPk7k
        PpBFbg4f7ZaTlennhbiHGfI=
X-Google-Smtp-Source: ABdhPJxcJRVl8Fn9/N5IAWVXaogd7+vJ+p5UHZ/wbZXPiXLLmpuscNgQLcWynu2NtESRMFJ2w3uXew==
X-Received: by 2002:a92:d68b:: with SMTP id p11mr11243784iln.222.1643112544862;
        Tue, 25 Jan 2022 04:09:04 -0800 (PST)
Received: from smtpclient.apple ([2601:285:8200:efd:d5d:bd1d:8ace:f57f])
        by smtp.gmail.com with ESMTPSA id i10sm5091515ilv.86.2022.01.25.04.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 04:09:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   William Kucharski <kucharsk@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Date:   Tue, 25 Jan 2022 05:09:03 -0700
Message-Id: <E44A9AB1-DBF0-4B8E-B049-293DD4DE6093@gmail.com>
References: <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        willy@infradead.org, longpeng2@huawei.com, arnd@arndb.de,
        dave.hansen@linux.intel.com, david@redhat.com, rppt@kernel.org,
        surenb@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
X-Mailer: iPhone Mail (19D49)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would think this should be the case; certainly it seems to be a more effec=
tive approach than having to manually enable sharing via the API in every ca=
se or via changes to ld.so.

If anything it might be useful to have an API for shutting it off, though th=
ere are already multiple areas where the system shares resources in ways tha=
t cannot be shut off by user action.

> On Jan 25, 2022, at 04:41, Kirill A. Shutemov <kirill@shutemov.name> wrote=
:
>=20
> =EF=BB=BFOn Tue, Jan 18, 2022 at 02:19:12PM -0700, Khalid Aziz wrote:
>> Example Code
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> Snippet of the code that a donor process would run looks like below:
>>=20
>> -----------------
>>        addr =3D mmap((void *)TB(2), GB(512), PROT_READ | PROT_WRITE,
>>                        MAP_SHARED | MAP_ANONYMOUS, 0, 0);
>>        if (addr =3D=3D MAP_FAILED)
>>                perror("ERROR: mmap failed");
>>=20
>>        err =3D syscall(MSHARE_SYSCALL, "testregion", (void *)TB(2),
>>            GB(512), O_CREAT|O_RDWR|O_EXCL, 600);
>>        if (err < 0) {
>>                perror("mshare() syscall failed");
>>                exit(1);
>>        }
>>=20
>>        strncpy(addr, "Some random shared text",
>>            sizeof("Some random shared text"));
>> -----------------
>>=20
>> Snippet of code that a consumer process would execute looks like:
>>=20
>> -----------------
>>        fd =3D open("testregion", O_RDONLY);
>>        if (fd < 0) {
>>                perror("open failed");
>>                exit(1);
>>        }
>>=20
>>        if ((count =3D read(fd, &mshare_info, sizeof(mshare_info)) > 0))
>>                printf("INFO: %ld bytes shared at addr %lx \n",
>>                mshare_info[1], mshare_info[0]);
>>        else
>>                perror("read failed");
>>=20
>>        close(fd);
>>=20
>>        addr =3D (char *)mshare_info[0];
>>        err =3D syscall(MSHARE_SYSCALL, "testregion", (void *)mshare_info[=
0],
>>            mshare_info[1], O_RDWR, 600);
>>        if (err < 0) {
>>                perror("mshare() syscall failed");
>>                exit(1);
>>        }
>>=20
>>        printf("Guest mmap at %px:\n", addr);
>>        printf("%s\n", addr);
>>    printf("\nDone\n");
>>=20
>>        err =3D syscall(MSHARE_UNLINK_SYSCALL, "testregion");
>>        if (err < 0) {
>>                perror("mshare_unlink() failed");
>>                exit(1);
>>        }
>> -----------------
>=20
> I wounder if we can get away with zero-API here: we can transparently
> create/use shared page tables for any inode on mmap(MAP_SHARED) as long as=

> size and alignment is sutiable. Page tables will be linked to the inode
> and will be freed when the last of such mapping will go away. I don't see
> a need in new syscalls of flags to existing one.
>=20
> --=20
> Kirill A. Shutemov
>=20
