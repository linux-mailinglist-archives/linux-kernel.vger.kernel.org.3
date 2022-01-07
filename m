Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12037487B6C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348575AbiAGR3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:29:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21228 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348578AbiAGR3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641576571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w2KxBeQrAHXVA9SVJNoEJTZJLIEcRuBQ110rV6r0h9c=;
        b=EtzPgzGMFayqkMrb51VR7+YgYtHD6NbYBNhUCqlZRIQ2cVTOepRCn3Zoxz/vHsZOcNBWm6
        auyOGoZTstYOwvHK/+kIo61wtXrO7mJtVBQKl1IVBzPwgta6ITYYTNUju0hj2TVwHuVnLR
        bPW6VEgzG/8ka8vZgNFQXMcWb8yl7sk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-WazrDWnXOSCCpOO4ExlOzg-1; Fri, 07 Jan 2022 12:29:30 -0500
X-MC-Unique: WazrDWnXOSCCpOO4ExlOzg-1
Received: by mail-ed1-f71.google.com with SMTP id o20-20020a056402439400b003f83cf1e472so5208759edc.18
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 09:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=w2KxBeQrAHXVA9SVJNoEJTZJLIEcRuBQ110rV6r0h9c=;
        b=7/YyrbVQpyEO3RbT+oGHVoVCFEZvqXhwmzo4/RMEK0QtJUX2jazD0xilaclf0yIJ2I
         cAJ5jEafRxyoPXRCSgVtiWHrBTJM/2axvOTPMwzGtUQZOpgF9XJZXr5lns+ujV0NJP1+
         1XeSnon4w5uSvIEUbNRraP3+1wzN1+x52JT1ceJ0vPivURm5cpWLyVWJ7eX9UKo4stgZ
         PeDR/VjWkO2MoiIzaXONSHiRqyHZupIuO4FsiiqrhKf02tQOysNbWSVuBCzWEue+5m1X
         lYk7mmfjp2ZlGGaNCgu51g5wJpnIkdCewyWaXly85wIK7cCQk7f8u995Zs2FVufJCBws
         Hp3w==
X-Gm-Message-State: AOAM533zzHOTkZloIgbw8kMOKnYvE18TGQ5ySf3POpW72oQtDHppmh4v
        XxRUWldaNHF/3GG0F56GXibW3onhRcz4yHdzu+bkSUJ+fzvCliYyVTzTMVcgdmfSdSXFcel4zlx
        qZ4al4gWkTSbRw5FojnkDh6ze
X-Received: by 2002:a17:907:6d9b:: with SMTP id sb27mr51336322ejc.1.1641576568815;
        Fri, 07 Jan 2022 09:29:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzZgAyvHy6/3n4mdP5+CHjQ6k0K3cLQ0RLXe8ADTAkR0sdYwTJWo+R+P5+Omx9hBM/6p+3nw==
X-Received: by 2002:a17:907:6d9b:: with SMTP id sb27mr51336290ejc.1.1641576568381;
        Fri, 07 Jan 2022 09:29:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id qw4sm1574095ejc.55.2022.01.07.09.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 09:29:27 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 162B0181F2A; Fri,  7 Jan 2022 18:29:27 +0100 (CET)
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
In-Reply-To: <CAADnVQLH5r-OLfGwduMqvTuz952Y+D7X29bW-f8QGpE9G6dF6g@mail.gmail.com>
References: <000000000000ab9b3e05d4feacd6@google.com>
 <CAADnVQLH5r-OLfGwduMqvTuz952Y+D7X29bW-f8QGpE9G6dF6g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 07 Jan 2022 18:29:27 +0100
Message-ID: <874k6fa1zc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> Toke, Jesper,
>
> please take a look.
> Seems to be in your area of expertise.

Yikes, I think I see the problem. Let me just confirm and I'll send a fix :)

-Toke

