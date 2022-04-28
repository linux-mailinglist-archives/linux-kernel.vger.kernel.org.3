Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728F4513078
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiD1J6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiD1J5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C81794E3BF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651139204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwSKQr8OcZBwXxZOkibHDwzuYYi6mLdIMZd+BmKKQvs=;
        b=E0Jor3MsGcSj1VqxHcCM80ut9WAJ4Az39W7/2J3EN7TF/BXNvnyokKsPEeFHrER2VLsNVh
        4000rVr/7YcAoZdV+FxgbMQVf7Hxzr6hluz/st8aOycAHOF2gjr4R0LZa1x1RZGMMM4Aff
        VLYnJ3y8/9A5AF30PNaWxm0injwNwiU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-PL_8v699NMuFEyQAq6S7rQ-1; Thu, 28 Apr 2022 05:46:43 -0400
X-MC-Unique: PL_8v699NMuFEyQAq6S7rQ-1
Received: by mail-wm1-f72.google.com with SMTP id g9-20020a1c4e09000000b0038f20d94f01so4138090wmh.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hwSKQr8OcZBwXxZOkibHDwzuYYi6mLdIMZd+BmKKQvs=;
        b=y7GW3jhhmgUwdXTAPTuNAAwd3l7dIF/C2Q0fv2UNRHGfRbBA0hy4RJneStqmEecpWj
         OKSJUwdjAi9oII/vx0zVWTMqJExVeErjmuuxT5O8r8IQPqOcsn+Yb9Bb5TxB0NDLo8b1
         y9Erya9FDRwIO9gQCFYSO8VQWvt2QCJxiAPeWarcD4V3Z3S6tTeeG6IwwlNTixTGPz2h
         FR4iV5qq859aa94cUx1/LeZ0P/zRpuGXq823YTnPwrFoYMlNwIdsO3C+zdd7S0+kMAzn
         ZAWi69W0uoN+1jAPMMhWVxmhqoHnNnLu0jsw3c/cbj8dDfPJyMTh9sqqvcunhCgRzqGj
         kaSQ==
X-Gm-Message-State: AOAM530yRUHXqIM7nzkyBX2pBoGNcIXo9C+vWj2FdVWm8/PJTNhbK1p7
        BsTlKnoQXcoSFRE9q1LAXwW9ENCSIyONvXjT7byhGSxf59uDPmdylgSeIXZJJ8QS/6bXr/Y/PiP
        W0KI1lZH36vhkEKPccwtqltRJ
X-Received: by 2002:a7b:c24d:0:b0:393:f9a3:e712 with SMTP id b13-20020a7bc24d000000b00393f9a3e712mr11561180wmj.198.1651139202121;
        Thu, 28 Apr 2022 02:46:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1S+oAqN9cl2UnoBlUqKMtV+8tL4oX9YO2Iq6WKppDimrB6iJojyXKMTv40cePERaMJVIzcA==
X-Received: by 2002:a7b:c24d:0:b0:393:f9a3:e712 with SMTP id b13-20020a7bc24d000000b00393f9a3e712mr11561167wmj.198.1651139201843;
        Thu, 28 Apr 2022 02:46:41 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:834:5aa0:80d7:8022:3692:b311])
        by smtp.gmail.com with ESMTPSA id b2-20020adfc742000000b0020ac89e4241sm17413163wrh.31.2022.04.28.02.46.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:46:41 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] virtio-pci: Remove wrong address verification in
 vp_del_vqs()
From:   Christophe Marie Francois Dupont de Dinechin <cdupontd@redhat.com>
In-Reply-To: <e8620e70-16bb-639c-9446-68dcd199253f@linux.ibm.com>
Date:   Thu, 28 Apr 2022 11:46:40 +0200
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mopsfelder@gmail.com,
        Christophe de Dinechin <dinechin@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5CD1C91-F5D0-4109-9894-824184362B5C@redhat.com>
References: <20220415023002.49805-1-muriloo@linux.ibm.com>
 <e8620e70-16bb-639c-9446-68dcd199253f@linux.ibm.com>
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



> On 15 Apr 2022, at 05:51, Murilo Opsfelder Ara=C3=BAjo =
<muriloo@linux.ibm.com> wrote:
>=20
> On 4/14/22 23:30, Murilo Opsfelder Araujo wrote:
>> GCC 12 enhanced -Waddress when comparing array address to null [0],
>> which warns:
>>     drivers/virtio/virtio_pci_common.c: In function =E2=80=98vp_del_vqs=
=E2=80=99:
>>     drivers/virtio/virtio_pci_common.c:257:29: warning: the =
comparison will always evaluate as =E2=80=98true=E2=80=99 for the =
pointer operand in =E2=80=98vp_dev->msix_affinity_masks + =
(sizetype)((long unsigned int)i * 256)=E2=80=99 must not be NULL =
[-Waddress]
>>       257 |                         if =
(vp_dev->msix_affinity_masks[i])
>>           |                             ^~~~~~
>> In fact, the verification is comparing the result of a pointer
>> arithmetic, the address "msix_affinity_masks + i", which will always
>> evaluate to true.
>> Under the hood, free_cpumask_var() calls kfree(), which is safe to =
pass
>> NULL, not requiring non-null verification.  So remove the =
verification
>> to make compiler happy (happy compiler, happy life).
>> [0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D102103
>> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
>> ---
>>  drivers/virtio/virtio_pci_common.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> diff --git a/drivers/virtio/virtio_pci_common.c =
b/drivers/virtio/virtio_pci_common.c
>> index d724f676608b..5046efcffb4c 100644
>> --- a/drivers/virtio/virtio_pci_common.c
>> +++ b/drivers/virtio/virtio_pci_common.c
>> @@ -254,8 +254,7 @@ void vp_del_vqs(struct virtio_device *vdev)
>>    	if (vp_dev->msix_affinity_masks) {
>>  		for (i =3D 0; i < vp_dev->msix_vectors; i++)
>> -			if (vp_dev->msix_affinity_masks[i])
>> -				=
free_cpumask_var(vp_dev->msix_affinity_masks[i]);
>> +			=
free_cpumask_var(vp_dev->msix_affinity_masks[i]);
>>  	}
>>    	if (vp_dev->msix_enabled) {
>=20
> After I sent this message, I realized that Christophe (copied here)
> had already proposed a fix:
>=20
>    =
https://lore.kernel.org/lkml/20220414150855.2407137-4-dinechin@redhat.com/=

>=20
> Christophe,
>=20
> Since free_cpumask_var() calls kfree() and kfree() is null-safe,
> can we just drop this null verification and call free_cpumask_var() =
right away?

Apologies for the delay in responding, broken laptop=E2=80=A6

In the case where CONFIG_CPUMASK_OFFSTACK is not defined, we have:

	typedef struct cpumask cpumask_var_t[1];

So that vp_dev->msix_affinity_masks[i] is statically not null (that=E2=80=99=
s the warning)
but also a static pointer, so not kfree-safe IMO.


