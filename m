Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A737487C43
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiAGShH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:37:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30990 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229528AbiAGShF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641580625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uPSTezG0qBUzZU5b+ipwh4/mE7DoJRL0xcY71ufegho=;
        b=FmtCrAOsC+oCIKBQR0PZZnDO1MoLUIIcrQybrfdorUQTqJxvUV9lpcDwA14RhmjLhUAPIY
        4kYyOcZW4+d4nfFtAQivAtx2DcYtz+dwObvSaYSVIpc8v1OMvKyfniui7Ct4gIztVR95AD
        2dFAKpF1lSXBfVvmkaPFfuE9aVeE5ns=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-IW_UplKKNBiGVwkbs7ap0w-1; Fri, 07 Jan 2022 13:37:04 -0500
X-MC-Unique: IW_UplKKNBiGVwkbs7ap0w-1
Received: by mail-ed1-f72.google.com with SMTP id s7-20020a056402520700b003f841380832so5372532edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 10:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uPSTezG0qBUzZU5b+ipwh4/mE7DoJRL0xcY71ufegho=;
        b=GK3s1OP0Ig0VNGnuR2z8XtB8+MAzZsKladKCZLv4tObik3iU7DFfh9myXpB2QLKrE5
         8ksxoDRmkIdpp/3/1Ayx5z/Ov+eU/NPsjzZOSVGZ1Px3I1PZX+nm1ACJ5X+VovHMBzj0
         RKoBIieVV2FLD56+zBSorLClKZRBb0JcI8SrdOqya0fiunkvxIj6qRa/pDklGfoqAdKY
         5u/tFYXt02FGH0on1x/wpDIJOfgT6kZgelv6+EUR77qSeJaEJj38iwgSg4eT7UZ0o5di
         OYmDCAzxjtVLaEArFTTjQy52HYvUFVuL9UPGRpQnuRriL73Rti8lGezl36ZG4m2sVOId
         u2+A==
X-Gm-Message-State: AOAM532Rj6FInjpVnuouP4eRbXzV9ESpjfD+lx1nUjf3C9mKWRvBEfrF
        s+oYDptK9l6dmJyL8tLsgwB0wHOHdo9TQyg/vXmgYJwOHymB8Eyh54dfKsGb/JYvajVPcPAdvB9
        A7R94olASJB9e5cbI8KH56AmA
X-Received: by 2002:a17:906:619:: with SMTP id s25mr51826649ejb.237.1641580622753;
        Fri, 07 Jan 2022 10:37:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4odmwqaxtbqXcUV1sdIzK4rqzuTlxtGZIrWvniq6UiCUTgxjK1RQu6mI3MUUsoObGxHRq4Q==
X-Received: by 2002:a17:906:619:: with SMTP id s25mr51826624ejb.237.1641580622442;
        Fri, 07 Jan 2022 10:37:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ne39sm1630080ejc.142.2022.01.07.10.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:37:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5FF33181F2A; Fri,  7 Jan 2022 19:37:01 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        syzbot <syzbot+983941aa85af6ded1fd9@syzkaller.appspotmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [syzbot] general protection fault in dev_get_by_index_rcu (2)
In-Reply-To: <874k6fa1zc.fsf@toke.dk>
References: <000000000000ab9b3e05d4feacd6@google.com>
 <CAADnVQLH5r-OLfGwduMqvTuz952Y+D7X29bW-f8QGpE9G6dF6g@mail.gmail.com>
 <874k6fa1zc.fsf@toke.dk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 07 Jan 2022 19:37:01 +0100
Message-ID: <87y23r8kaa.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
>> Toke, Jesper,
>>
>> please take a look.
>> Seems to be in your area of expertise.
>
> Yikes, I think I see the problem. Let me just confirm and I'll send a
> fix :)

Fix here: https://lore.kernel.org/r/20220107183049.311134-1-toke@redhat.com

-Toke

