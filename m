Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1001C51307A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiD1KAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiD1KAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5F3AB0D37
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651139291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qatp2Yg/wXTDFXvXeilZVsHVfa7JvQVmG1q95f+gwzc=;
        b=EBKBJOjlODWC9wOT8UmVq2ZlFxE/ArffuzCZHBTbTp5u27Xj9ZK/Exc7gvBU93YFpZtTwI
        anT7oVD2BBnUWQbUsxeCYqADoXhsvo1beS8hOwaEcnk9T7iijMtKWYwYmKOIv5OfUyBkjQ
        rZaXkneKVcTwYY/MR3UJfW+rarNAM00=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-A-0Dn3ERNwyb7WSNgbvFUg-1; Thu, 28 Apr 2022 05:48:05 -0400
X-MC-Unique: A-0Dn3ERNwyb7WSNgbvFUg-1
Received: by mail-wm1-f72.google.com with SMTP id v184-20020a1cacc1000000b00393e492a398so4145385wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Qatp2Yg/wXTDFXvXeilZVsHVfa7JvQVmG1q95f+gwzc=;
        b=M/QHscs9zbRjnGmvNxsUwxKaEte1di8FOOgUiZ+jZEXWdmNzL9KDcDUDM/IzjYDWUU
         UeXFTdPecuva5+5AK+cFJpGxqoj1a+ofMuPww8RqGg34NQoysV07gWReKRQcRHJozWx7
         lAhPoVsdQ6dcZcI1Aqri2qsuJgZUzIdOWoOtP50iPYTup5HUCoy/3VcmQFZBUPazKqqK
         fO9NnNsnCYnaJe/Wq1H+uUb5oLBR3mtJKlWmB4KhgW+GXdHmsXcj5Hx3tOK/UTvN0LBk
         yD3cQRlMpq6j/DyEizPzQRQPL4kpqdSEPDz2d5DxHntCPhWctHcCSxyEYG+hVipbBy8M
         cqWA==
X-Gm-Message-State: AOAM530/tPOOEloSEhNaZ6Eqhg1sEjrvMSxFmfRGJto88MHj1MRPB64j
        ZR55qR/1R72bJGhu9lMGVuT6evyZkHXP8E8KlU54dGUK+g9OVKs/q0RuLo+XxyrwMjePUO6li21
        OGLdKYvuguiv6FGv7qwbCuaV5
X-Received: by 2002:a5d:4302:0:b0:206:4b2:8690 with SMTP id h2-20020a5d4302000000b0020604b28690mr25833745wrq.224.1651139284002;
        Thu, 28 Apr 2022 02:48:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytEglwbjPG2HcsgM6oJexGZfTUC4dM+bbxTN5qYMDe8QZnP/GqEzl9BFojoxxRZ4Gj/Bqn1g==
X-Received: by 2002:a5d:4302:0:b0:206:4b2:8690 with SMTP id h2-20020a5d4302000000b0020604b28690mr25833710wrq.224.1651139283752;
        Thu, 28 Apr 2022 02:48:03 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:834:5aa0:80d7:8022:3692:b311])
        by smtp.gmail.com with ESMTPSA id t8-20020adfa2c8000000b0020ad7121495sm11722189wra.23.2022.04.28.02.48.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:48:03 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 3/3] virtio-pci: Use cpumask_available to fix compilation
 error
From:   Christophe Marie Francois Dupont de Dinechin <cdupontd@redhat.com>
In-Reply-To: <20220415044657-mutt-send-email-mst@kernel.org>
Date:   Thu, 28 Apr 2022 11:48:01 +0200
Cc:     Christophe de Dinechin <dinechin@redhat.com>, trivial@kernel.org,
        Ben Segall <bsegall@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D264F7F-624D-4E9D-A139-F1DB0CC6045C@redhat.com>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-4-dinechin@redhat.com>
 <20220415044657-mutt-send-email-mst@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 15 Apr 2022, at 10:48, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Thu, Apr 14, 2022 at 05:08:55PM +0200, Christophe de Dinechin =
wrote:
>> With GCC 12 and defconfig, we get the following error:
>>=20
>> |   CC      drivers/virtio/virtio_pci_common.o
>> | drivers/virtio/virtio_pci_common.c: In function =E2=80=98vp_del_vqs=E2=
=80=99:
>> | drivers/virtio/virtio_pci_common.c:257:29: error: the comparison =
will
>> |  always evaluate as =E2=80=98true=E2=80=99 for the pointer operand =
in
>> |  =E2=80=98vp_dev->msix_affinity_masks + (sizetype)((long unsigned =
int)i * 8)=E2=80=99
>> |  must not be NULL [-Werror=3Daddress]
>> |   257 |                         if (vp_dev->msix_affinity_masks[i])
>> |       |                             ^~~~~~
>>=20
>> This happens in the case where CONFIG_CPUMASK_OFFSTACK is not =
defined,
>> since we typedef cpumask_var_t as an array. The compiler is =
essentially
>> complaining that an array pointer cannot be NULL. This is not a very
>> important warning, but there is a function called cpumask_available =
that
>> seems to be defined just for that case, so the fix is easy.
>>=20
>> Signed-off-by: Christophe de Dinechin <christophe@dinechin.org>
>> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
>=20
> There was an alternate patch proposed for this by
> Murilo Opsfelder Araujo. What do you think about that approach?

I responded on the other thread, but let me share the response here:

[to muriloo@linux.ibm.com]
Apologies for the delay in responding, broken laptop=E2=80=A6

In the case where CONFIG_CPUMASK_OFFSTACK is not defined, we have:

	typedef struct cpumask cpumask_var_t[1];

So that vp_dev->msix_affinity_masks[i] is statically not null (that=E2=80=99=
s the warning)
but also a static pointer, so not kfree-safe IMO.

>=20
>=20
>> ---
>> drivers/virtio/virtio_pci_common.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/virtio/virtio_pci_common.c =
b/drivers/virtio/virtio_pci_common.c
>> index d724f676608b..5c44a2f13c93 100644
>> --- a/drivers/virtio/virtio_pci_common.c
>> +++ b/drivers/virtio/virtio_pci_common.c
>> @@ -254,7 +254,7 @@ void vp_del_vqs(struct virtio_device *vdev)
>>=20
>> 	if (vp_dev->msix_affinity_masks) {
>> 		for (i =3D 0; i < vp_dev->msix_vectors; i++)
>> -			if (vp_dev->msix_affinity_masks[i])
>> +			if =
(cpumask_available(vp_dev->msix_affinity_masks[i]))
>> 				=
free_cpumask_var(vp_dev->msix_affinity_masks[i]);
>> 	}
>>=20
>> --=20
>> 2.35.1
>=20

