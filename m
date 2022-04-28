Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771C951309E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiD1KGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbiD1KFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A77022FFCB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651139504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HE3ta4HpBI6INhoQobpRyVvmn/Cv0Jx2r+Mpva9zKrg=;
        b=RDy6gvmNGAWTBQt7HUCMiIb/fZQOTIVnWIhf8W/RtGptZNKEBgi66hE7i3NtmrthvHBkCR
        Y152MR6i61zPOfZj2+0wpCg75hfyVhwRxYJZ3Bb+mWCtUAVJH0VrMLwkxbicDNwnmKbwl3
        9+j18fLMwepjmuyzKy+ZgDBEoqQ8m/I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-3rk3EHpdPE63CMQPNFcr1w-1; Thu, 28 Apr 2022 05:51:43 -0400
X-MC-Unique: 3rk3EHpdPE63CMQPNFcr1w-1
Received: by mail-wm1-f71.google.com with SMTP id c62-20020a1c3541000000b0038ec265155fso4143039wma.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HE3ta4HpBI6INhoQobpRyVvmn/Cv0Jx2r+Mpva9zKrg=;
        b=J44NySsVB9cJ6qoCPchZ3T4+/W89ZbB2dj1aDqyb+yVANz5Q4t0pin2ZumnW41VHQg
         /5rMTsTtucIhFI3X8jfFDAoIq0UsFN+PzNuU/sGqJThT4vLeNODoIJ4U8WHgqpx6aCCp
         fllL88X3Ek4ucgKffnD0kc9d1MHsJZPuV2cKAW2YQFqamxeCqpRKj/c4Fw2AYduD7wmE
         9Qdaiir/EeQSCRc31RlRXI6++ZnVO6yqLT4FK09Hqz51zXBZnY/wT3Vw20lE7h+N5HAd
         9NvkYjaiN5g648LZ7hwsEkYJT+Lr1y7ttbH2NfjelvfamB6DuylHj7YgAEfK1O8XcOfy
         8Whw==
X-Gm-Message-State: AOAM532QOe50sUF4dMK/7SvFxhiYXQphmwNe6Rh4us6EfYuIMqSWuoVy
        5StjMi1RUEDxEbTcB4L88EdUtK4VayXn6L4PDfX6VMi+oIfN+iXN/vPZYlIYIj2w++bc5iPe6QE
        0YlvKaj1XZbtVUlcsitN7ECNJ
X-Received: by 2002:a5d:4744:0:b0:20a:ea5a:dc39 with SMTP id o4-20020a5d4744000000b0020aea5adc39mr8250810wrs.236.1651139502542;
        Thu, 28 Apr 2022 02:51:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlt0WIxWYGUM3TXXA+zF5EJSKUPgDy28wndaEJHSCE7Dd7DqM6ReTuGFqvoCetntmepG+mHQ==
X-Received: by 2002:a5d:4744:0:b0:20a:ea5a:dc39 with SMTP id o4-20020a5d4744000000b0020aea5adc39mr8250795wrs.236.1651139502237;
        Thu, 28 Apr 2022 02:51:42 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:834:5aa0:80d7:8022:3692:b311])
        by smtp.gmail.com with ESMTPSA id n5-20020adf8b05000000b00207a4fd0185sm15653955wra.7.2022.04.28.02.51.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:51:41 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] virtio-pci: Remove wrong address verification in
 vp_del_vqs()
From:   Christophe Marie Francois Dupont de Dinechin <cdupontd@redhat.com>
In-Reply-To: <A5CD1C91-F5D0-4109-9894-824184362B5C@redhat.com>
Date:   Thu, 28 Apr 2022 11:51:40 +0200
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mopsfelder@gmail.com,
        Christophe de Dinechin <dinechin@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B954A683-EE43-4469-B57A-EB8C6B671BEC@redhat.com>
References: <20220415023002.49805-1-muriloo@linux.ibm.com>
 <e8620e70-16bb-639c-9446-68dcd199253f@linux.ibm.com>
 <A5CD1C91-F5D0-4109-9894-824184362B5C@redhat.com>
To:     muriloo@linux.ibm.com
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 28 Apr 2022, at 11:46, Christophe Marie Francois Dupont de Dinechin =
<cdupontd@redhat.com> wrote:
>=20
>=20
>=20
>> On 15 Apr 2022, at 05:51, Murilo Opsfelder Ara=C3=BAjo =
<muriloo@linux.ibm.com> wrote:
>>=20
>> On 4/14/22 23:30, Murilo Opsfelder Araujo wrote:
>>> GCC 12 enhanced -Waddress when comparing array address to null [0],
>>> which warns:
>>> drivers/virtio/virtio_pci_common.c: In function =E2=80=98vp_del_vqs=E2=
=80=99:
>>> drivers/virtio/virtio_pci_common.c:257:29: warning: the comparison =
will always evaluate as =E2=80=98true=E2=80=99 for the pointer operand =
in =E2=80=98vp_dev->msix_affinity_masks + (sizetype)((long unsigned =
int)i * 256)=E2=80=99 must not be NULL [-Waddress]
>>> 257 | if (vp_dev->msix_affinity_masks[i])
>>> | ^~~~~~
>>> In fact, the verification is comparing the result of a pointer
>>> arithmetic, the address "msix_affinity_masks + i", which will always
>>> evaluate to true.
>>> Under the hood, free_cpumask_var() calls kfree(), which is safe to =
pass
>>> NULL, not requiring non-null verification. So remove the =
verification
>>> to make compiler happy (happy compiler, happy life).
>>> [0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D102103
>>> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
>>> ---
>>> drivers/virtio/virtio_pci_common.c | 3 +--
>>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>> diff --git a/drivers/virtio/virtio_pci_common.c =
b/drivers/virtio/virtio_pci_common.c
>>> index d724f676608b..5046efcffb4c 100644
>>> --- a/drivers/virtio/virtio_pci_common.c
>>> +++ b/drivers/virtio/virtio_pci_common.c
>>> @@ -254,8 +254,7 @@ void vp_del_vqs(struct virtio_device *vdev)
>>> 	if (vp_dev->msix_affinity_masks) {
>>> 		for (i =3D 0; i < vp_dev->msix_vectors; i++)
>>> -			if (vp_dev->msix_affinity_masks[i])
>>> -				=
free_cpumask_var(vp_dev->msix_affinity_masks[i]);
>>> +			=
free_cpumask_var(vp_dev->msix_affinity_masks[i]);
>>> 	}
>>> 	if (vp_dev->msix_enabled) {
>>=20
>> After I sent this message, I realized that Christophe (copied here)
>> had already proposed a fix:
>>=20
>> =
https://lore.kernel.org/lkml/20220414150855.2407137-4-dinechin@redhat.com/=

>>=20
>> Christophe,
>>=20
>> Since free_cpumask_var() calls kfree() and kfree() is null-safe,
>> can we just drop this null verification and call free_cpumask_var() =
right away?
>=20
> Apologies for the delay in responding, broken laptop=E2=80=A6
>=20
> In the case where CONFIG_CPUMASK_OFFSTACK is not defined, we have:
>=20
> 	typedef struct cpumask cpumask_var_t[1];
>=20
> So that vp_dev->msix_affinity_masks[i] is statically not null =
(that=E2=80=99s the warning)
> but also a static pointer, so not kfree-safe IMO.

=E2=80=A6 which also renders my own patch invalid :-/

Compiler warnings are good. Clearly not sufficient.

