Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE215132DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345719AbiD1L4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbiD1L4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1CFB84ED4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651146781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m4wuSSXz7Bc2R5yzgoXp3lpJ6Gq5vjadLf49SvnLISA=;
        b=T7xCQ+2guoJgPIhsyi0GbEbC4nVHmRxUCNJFhzji0pX6tGQFbMKHbI2xkOUL68my2OICic
        NRahko7bqF6iL5rdFZ6oggejco+gyN18/cM8uiiSuQxVA9gKeMHff3kcXcgXGAWrmYQMXD
        VOmod4pgCxWQLGS/V7unwn/AX+qZKWI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-i-_4rzCOMTWIYSncly78lA-1; Thu, 28 Apr 2022 07:52:59 -0400
X-MC-Unique: i-_4rzCOMTWIYSncly78lA-1
Received: by mail-wm1-f69.google.com with SMTP id r186-20020a1c44c3000000b00393f52ed5ceso3517214wma.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m4wuSSXz7Bc2R5yzgoXp3lpJ6Gq5vjadLf49SvnLISA=;
        b=YGtXJgKY7HZ0bcw/15gsllwygJhUrT9cdXxS+jcUQXLM+TlEAv2NuXMZWNOrN+zClO
         0dKdklzEJbu5LEKV8rmlyq09Y+upsoLwnDAAHNg7211B1fO2g5fenLWhf7N+oKl4WB77
         mJJrHSwUPALMopktLiGNQ/fLjJHDE2HR1RWLt594QpktOmnYkPmPBfjzJXeavvP64NKS
         0gLlhqeTy/RBmCNmKNL2nope63rdEDJKMnXSmoNtlzBpcDHFoAlgWIEUT7kd0fllkEtD
         nyKfWWssfguUw87dRVdvXVgtfWV32LGADpxPyec04cVqVuT6vo7xewf6z5TkBra2jyp7
         rzrg==
X-Gm-Message-State: AOAM533s4M23A+49vDONph7IGlS6qzPwsFJk9zBjYqleR7Ezw05VMa69
        NNG4fQ6vDNIf/FDf2/yku6K5MdNOhb1JrNqAatlpFHQZJ7P8PJHp/HLkcbkUrYYVohNhKurHnUK
        utNdPFVxkqr3gYWfkJlVMAhDy
X-Received: by 2002:a1c:acc6:0:b0:38e:b184:7721 with SMTP id v189-20020a1cacc6000000b0038eb1847721mr30429297wme.94.1651146778349;
        Thu, 28 Apr 2022 04:52:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdXJHhuyonjHZZ5DuMT8VJ7tfpq1xfdkYBSxE+jsnntHiHGLuJGR6oIIiNOw4qdCLHwrqj1Q==
X-Received: by 2002:a1c:acc6:0:b0:38e:b184:7721 with SMTP id v189-20020a1cacc6000000b0038eb1847721mr30429276wme.94.1651146778091;
        Thu, 28 Apr 2022 04:52:58 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:834:5aa0:5160:7495:6b8e:3f15])
        by smtp.gmail.com with ESMTPSA id g13-20020a05600c4ecd00b00393ec8be5cfsm4113111wmq.24.2022.04.28.04.52.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2022 04:52:57 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] virtio-pci: Remove wrong address verification in
 vp_del_vqs()
From:   Christophe Marie Francois Dupont de Dinechin <cdupontd@redhat.com>
In-Reply-To: <20220428070345-mutt-send-email-mst@kernel.org>
Date:   Thu, 28 Apr 2022 13:52:56 +0200
Cc:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mopsfelder@gmail.com,
        Christophe de Dinechin <dinechin@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0ADDC136-7BAA-4D66-97A7-31747284BE2B@redhat.com>
References: <20220415023002.49805-1-muriloo@linux.ibm.com>
 <e8620e70-16bb-639c-9446-68dcd199253f@linux.ibm.com>
 <A5CD1C91-F5D0-4109-9894-824184362B5C@redhat.com>
 <B954A683-EE43-4469-B57A-EB8C6B671BEC@redhat.com>
 <2F2EFFE9-5174-49A8-A71F-EE134D387E07@redhat.com>
 <20220428070345-mutt-send-email-mst@kernel.org>
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

[Resend, still struggling with new laptop email settings]

> On 28 Apr 2022, at 13:03, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Thu, Apr 28, 2022 at 11:55:31AM +0200, Christophe Marie Francois =
Dupont de Dinechin wrote:
>>=20
>>=20
>>> On 28 Apr 2022, at 11:51, Christophe Marie Francois Dupont de =
Dinechin <cdupontd@redhat.com> wrote:
>>>=20
>>>=20
>>>=20
>>>> On 28 Apr 2022, at 11:46, Christophe Marie Francois Dupont de =
Dinechin <cdupontd@redhat.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On 15 Apr 2022, at 05:51, Murilo Opsfelder Ara=C3=BAjo =
<muriloo@linux.ibm.com> wrote:
>>>>>=20
>>>>> On 4/14/22 23:30, Murilo Opsfelder Araujo wrote:
>>>>>> GCC 12 enhanced -Waddress when comparing array address to null =
[0],
>>>>>> which warns:
>>>>>> drivers/virtio/virtio_pci_common.c: In function =E2=80=98vp_del_vqs=
=E2=80=99:
>>>>>> drivers/virtio/virtio_pci_common.c:257:29: warning: the =
comparison will always evaluate as =E2=80=98true=E2=80=99 for the =
pointer operand in =E2=80=98vp_dev->msix_affinity_masks + =
(sizetype)((long unsigned int)i * 256)=E2=80=99 must not be NULL =
[-Waddress]
>>>>>> 257 | if (vp_dev->msix_affinity_masks[i])
>>>>>> | ^~~~~~
>>>>>> In fact, the verification is comparing the result of a pointer
>>>>>> arithmetic, the address "msix_affinity_masks + i", which will =
always
>>>>>> evaluate to true.
>>>>>> Under the hood, free_cpumask_var() calls kfree(), which is safe =
to pass
>>>>>> NULL, not requiring non-null verification. So remove the =
verification
>>>>>> to make compiler happy (happy compiler, happy life).
>>>>>> [0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D102103
>>>>>> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
>>>>>> ---
>>>>>> drivers/virtio/virtio_pci_common.c | 3 +--
>>>>>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>> diff --git a/drivers/virtio/virtio_pci_common.c =
b/drivers/virtio/virtio_pci_common.c
>>>>>> index d724f676608b..5046efcffb4c 100644
>>>>>> --- a/drivers/virtio/virtio_pci_common.c
>>>>>> +++ b/drivers/virtio/virtio_pci_common.c
>>>>>> @@ -254,8 +254,7 @@ void vp_del_vqs(struct virtio_device *vdev)
>>>>>> 	if (vp_dev->msix_affinity_masks) {
>>>>>> 		for (i =3D 0; i < vp_dev->msix_vectors; i++)
>>>>>> -			if (vp_dev->msix_affinity_masks[i])
>>>>>> -				=
free_cpumask_var(vp_dev->msix_affinity_masks[i]);
>>>>>> +			=
free_cpumask_var(vp_dev->msix_affinity_masks[i]);
>>>>>> 	}
>>>>>> 	if (vp_dev->msix_enabled) {
>>>>>=20
>>>>> After I sent this message, I realized that Christophe (copied =
here)
>>>>> had already proposed a fix:
>>>>>=20
>>>>> =
https://lore.kernel.org/lkml/20220414150855.2407137-4-dinechin@redhat.com/=

>>>>>=20
>>>>> Christophe,
>>>>>=20
>>>>> Since free_cpumask_var() calls kfree() and kfree() is null-safe,
>>>>> can we just drop this null verification and call =
free_cpumask_var() right away?
>>>>=20
>>>> Apologies for the delay in responding, broken laptop=E2=80=A6
>>>>=20
>>>> In the case where CONFIG_CPUMASK_OFFSTACK is not defined, we have:
>>>>=20
>>>> 	typedef struct cpumask cpumask_var_t[1];
>>>>=20
>>>> So that vp_dev->msix_affinity_masks[i] is statically not null =
(that=E2=80=99s the warning)
>>>> but also a static pointer, so not kfree-safe IMO.
>>>=20
>>> =E2=80=A6 which also renders my own patch invalid :-/
>>>=20
>>> Compiler warnings are good. Clearly not sufficient.
>>=20
>> Ah, I just noticed that free_cpumask_var is a noop in that case.
>>=20
>> So yes, your fix is better :-)
>=20
> ACK then?

Yes.

Acked-by: Christophe de Dinechin <dinechin@redhat.com>

>=20

