Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4E465815
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353462AbhLAVDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 16:03:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353141AbhLAVBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 16:01:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638392262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ev55CeShxZMLjyR6AWvoqEYxO3dGwDYuTnrnWeS0i0Q=;
        b=iN7dqzKPZiY/2hhLH+2DIJSu0Rulzm7jiKyoMxjBFAm3mHmpkwiyb6k/zigH8UAcLSKGbs
        C6hXhK4iikLo4hy8WlYhCzQHZEFgJDaXun8neaKokflrlTIjSyOU9Vo7WWGmJrw7LIhl6v
        f6AoT3J9L+RUHIdaa+Raxkdkoia520U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-91yPTCWLMFqXhOKpe2jbmQ-1; Wed, 01 Dec 2021 15:57:39 -0500
X-MC-Unique: 91yPTCWLMFqXhOKpe2jbmQ-1
Received: by mail-ed1-f70.google.com with SMTP id bx28-20020a0564020b5c00b003e7c42443dbso21393090edb.15
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 12:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Ev55CeShxZMLjyR6AWvoqEYxO3dGwDYuTnrnWeS0i0Q=;
        b=f/PJXhAyKoIb6cRN5Fh5Uhm9OoMeI4NDhwW9iKnKF8AHr2/+fEvNqeyvqNv/i3rHc2
         pSVgs7D5r23B5w28qp+3BlxCp3NHxmbsY2Vm8SJECqrzZoEQtS70ljuRvd8e5DW7kx9l
         4Hgfaj0jg4whFh+tmiz1XcPFv0uxF2winXzJU6uSC9b0B2qeGXVstBf9JSGZwgeKrEVy
         fQ/DSlwaa7Y9FSjwvitseBd9tP7b66tyHJtavEQezyFcxSrL8n5HwBzPRPLq24tVNuPH
         YYE+T8DthFqRvRy4pmc73bopz2nzlNd3RMtOv3YxwnQ3NgUfoe8agwak+aMUSRaJORcT
         i3/Q==
X-Gm-Message-State: AOAM530YQ+NMAazP8V0fKP0fJzjgmOsCf0FH4h+CSgKeAbt/zr3AmMsI
        XX9mJY5MZqRuWoGjnqH+2N3kPea96HXwSzfoQj/VPVTsYL/eWm6k95r/ABCMwQ6PM4ARWVmfwS8
        lL2W8UNLOjv/03p2hmtQ4xeOs
X-Received: by 2002:a05:6402:42:: with SMTP id f2mr12124017edu.204.1638392257494;
        Wed, 01 Dec 2021 12:57:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkFuY5Qu3gtYYCKqYKX5TiqOlyr4sCu/nky4225/b+rKH02PDkf84hbcaZAhuYG3e9lQc8EA==
X-Received: by 2002:a05:6402:42:: with SMTP id f2mr12123906edu.204.1638392256495;
        Wed, 01 Dec 2021 12:57:36 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id sc7sm505038ejc.50.2021.12.01.12.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:57:35 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1F8071802A0; Wed,  1 Dec 2021 21:57:35 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] samples: bpf: fix conflicting types in
 fds_example
In-Reply-To: <20211201164931.47357-1-alexandr.lobakin@intel.com>
References: <20211201164931.47357-1-alexandr.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 01 Dec 2021 21:57:35 +0100
Message-ID: <87sfvc59hc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Lobakin <alexandr.lobakin@intel.com> writes:

> Fix the following samples/bpf build error appeared after the
> introduction of bpf_map_create() in libbpf:
>
>   CC  samples/bpf/fds_example.o
> samples/bpf/fds_example.c:49:12: error: static declaration of 'bpf_map_cr=
eate' follows non-static declaration
> static int bpf_map_create(void)
>            ^
> samples/bpf/libbpf/include/bpf/bpf.h:55:16: note: previous declaration is=
 here
> LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
>                ^
> samples/bpf/fds_example.c:82:23: error: too few arguments to function cal=
l, expected 6, have 0
>                 fd =3D bpf_map_create();
>                      ~~~~~~~~~~~~~~ ^
> samples/bpf/libbpf/include/bpf/bpf.h:55:16: note: 'bpf_map_create' declar=
ed here
> LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
>                ^
> 2 errors generated.
>
> fds_example by accident has a static function with the same name.
> It's not worth it to separate a single call into its own function,
> so just embed it.
>
> Fixes: 992c4225419a ("libbpf: Unify low-level map creation APIs w/ new bp=
f_map_create()")
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

I just ran into this today as well - thanks for the fix!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

