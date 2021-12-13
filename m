Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B74D472BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhLMMJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:09:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231405AbhLMMJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639397384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1a/bd6+FuUOJG/H4wd0T2lOdNMz9aPxRtEUk/VcsT3Y=;
        b=FBlLK3gzW1VETyv3wwHk1b/YhynbG8rJDGPWM82tdpgbSaAzdsDF0K1/W4opEa8ET9XRja
        KUb7U3I7CNdNJ8Vxo3Qq7DzNV8EzmzoViO/eZ2NalkF7FOLSkaiLh4ihzPdptSPmw/ilSp
        JJtluHg7v7x543sNEMTMCa3KVyj98rA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-2ztb42CIOuSjqs1KFJhYtQ-1; Mon, 13 Dec 2021 07:09:41 -0500
X-MC-Unique: 2ztb42CIOuSjqs1KFJhYtQ-1
Received: by mail-qt1-f198.google.com with SMTP id e14-20020a05622a110e00b002b0681d127eso22947863qty.15
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=1a/bd6+FuUOJG/H4wd0T2lOdNMz9aPxRtEUk/VcsT3Y=;
        b=iTl9Hlpd8BBLx6UovDBjX8qqr7rSAto+iyThpqXqqsx6eLxOUQnf1S6iVjX2oNkPq7
         kNlEoakXR3c8+h4nzTC4GIB9+cF1GgKExRCvq7u2s0R1G6Nfk4W4JoTDHb38p0dzuwxl
         8plFeLuN7qKJ4sA9yMmEThJSObRKM9WgOWWOH3E1mrdhrv+EAq+v554b+GcXWd5QnL6U
         k/4+PwK8NoFy3Qe/J5vArkUb5YsfTT+xvgBXT7ddqlmLz4jIECewFTNiVPYX0H/rPezz
         stDOO5K4uVmg2BU0OxoaiGiHC3ZnIAoFfJjho6tcFraoZTO4ZJvyzR7GDvSMBxG8CM7U
         18xg==
X-Gm-Message-State: AOAM530OlB8BtykXjv0wHwg9L+rgA5lzDIIrcyonBe0t8rPFERSBa3Nn
        Hz5qiswiRiQgBqsjdO9QCSVp6HnaVNAh1NWYll9vC6BJsA9j4KwdbnA73Ui48+AZsBmQoDQg8F6
        3Z/GhFHjdnKX1ivEhtpIuRljo
X-Received: by 2002:a05:620a:1904:: with SMTP id bj4mr32164876qkb.536.1639397380554;
        Mon, 13 Dec 2021 04:09:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUMjea4dS/GuZs2NBiHsvdQKAl1msbX4jKzb27GUcYuJ0+s3SA6OeCnzyR+/7myLc0P/iXYw==
X-Received: by 2002:a05:620a:1904:: with SMTP id bj4mr32164837qkb.536.1639397380127;
        Mon, 13 Dec 2021 04:09:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id n13sm6194857qkp.19.2021.12.13.04.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 04:09:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 845DC180496; Mon, 13 Dec 2021 13:09:35 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yihao Han <hanyihao@vivo.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@vivo.com
Subject: Re: [PATCH v2] samples/bpf: xdpsock: fix swap.cocci warning
In-Reply-To: <CAEf4BzYv3ONhy-JnQUtknzgBSK0gpm9GBJYtbAiJQe50_eX7Uw@mail.gmail.com>
References: <20211209092250.56430-1-hanyihao@vivo.com>
 <877dccwn6x.fsf@toke.dk>
 <CAEf4Bza3a88pdhFEQdR-FnT_gBPqBh+KL-OP-1P3bVfXv=Gbaw@mail.gmail.com>
 <87sfuzuia3.fsf@toke.dk>
 <CAEf4BzYv3ONhy-JnQUtknzgBSK0gpm9GBJYtbAiJQe50_eX7Uw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 13 Dec 2021 13:09:35 +0100
Message-ID: <87fsqwg0zk.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Sat, Dec 11, 2021 at 10:07 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Fri, Dec 10, 2021 at 6:26 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke=
@redhat.com> wrote:
>> >>
>> >> Yihao Han <hanyihao@vivo.com> writes:
>> >>
>> >> > Fix following swap.cocci warning:
>> >> > ./samples/bpf/xdpsock_user.c:528:22-23:
>> >> > WARNING opportunity for swap()
>> >> >
>> >> > Signed-off-by: Yihao Han <hanyihao@vivo.com>
>> >>
>> >> Erm, did this get applied without anyone actually trying to compile
>> >> samples? I'm getting build errors as:
>> >
>> > Good news: I actually do build samples/bpf nowadays after fixing a
>> > bunch of compilation issues recently.
>>
>> Awesome!
>>
>> > Bad news: seems like I didn't pay too much attention after building
>> > samples/bpf for this particular patch, sorry about that. I've dropped
>> > this patch, samples/bpf builds for me. We should be good now.
>>
>> Yup, looks good, thanks!
>>
>> >>   CC  /home/build/linux/samples/bpf/xsk_fwd.o
>> >> /home/build/linux/samples/bpf/xsk_fwd.c: In function =E2=80=98swap_ma=
c_addresses=E2=80=99:
>> >> /home/build/linux/samples/bpf/xsk_fwd.c:658:9: warning: implicit decl=
aration of function =E2=80=98swap=E2=80=99; did you mean =E2=80=98swab=E2=
=80=99? [-Wimplicit-function-declaration]
>> >>   658 |         swap(*src_addr, *dst_addr);
>> >>       |         ^~~~
>> >>       |         swab
>> >>
>> >> /usr/bin/ld: /home/build/linux/samples/bpf/xsk_fwd.o: in function `th=
read_func':
>> >> xsk_fwd.c:(.text+0x440): undefined reference to `swap'
>> >> collect2: error: ld returned 1 exit status
>> >>
>> >>
>> >> Could we maybe get samples/bpf added to the BPF CI builds? :)
>> >
>> > Maybe we could, if someone dedicated their effort towards making this
>> > happen.
>>
>> Is it documented anywhere what that would entail? Is it just a matter of
>> submitting a change to https://github.com/kernel-patches/vmtest ?
>
> I think the right way would be to build samples/bpf from
> selftests/bpf's Makefile. At the very least we should not require make
> headers_install (I never understood that with samples/bpf, all those
> up-to-date UAPI headers are right there in the same repo). Once that
> is done, at the very least we'll build tests samples/bpf during CI
> runs.

Alright, sounds fair. I'll look into that, but probably before the
holidays :)

-Toke

