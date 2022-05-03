Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669C751879F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbiECPDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbiECPDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50F8E39801
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651589986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XyarcUrf0R465efktdUAleuyj6ZDMyzyVobCRnMSWN8=;
        b=NZEMNqQyHoUtZ7ZxJZorjtj/VytvWaInuumxBz0JR99oTUVfEDgP+6BV3JUCCXsoafZ9g6
        TcvEXdEvpPnk0h0INmsIQy+/gOcB+hk1gqo7CYgZ+i1Fk0F0USgYiqOxZ2dZP3N0BubmuR
        ZhEDhxLAdRyINFRdCnIklz7MVwrG0/M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-59-kKbrXPAOVc7ZAM1zFeA-1; Tue, 03 May 2022 10:59:33 -0400
X-MC-Unique: 59-kKbrXPAOVc7ZAM1zFeA-1
Received: by mail-wm1-f70.google.com with SMTP id 26-20020a05600c021a00b003940660c053so5774693wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 07:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XyarcUrf0R465efktdUAleuyj6ZDMyzyVobCRnMSWN8=;
        b=6IPW8hiDAUv+REXFZjXZ0vfKKJb62byRe7VuueU58ihxpuZIQhKvoq/zPwN6RkxhNk
         0L+b9k/ojKbB/jIVgWjBnf6IV/a1Zdwo9MyiUsMKut85GJ0Q7xKF8FKe3ZZoO+Amut+4
         uGWpKA8ci39Gl5uN7Ewq4gWqUxDy3eC97a06i1WEkG6Blhs59rU4aShKT0VyVJJ14aOM
         zuIANyG4sDqvda+GbH834LpxmJyoM1sI3Sgw8wua/bNATpTDpPxrz1Pu7oQdz2qi/MHu
         ccQHbdPI26jA8Z1Fl/SI+OOm2+MQvq1RCxmKDUnM+nIhIDkTUJhcrMlXe/fComuo7+34
         Wo1w==
X-Gm-Message-State: AOAM533xqnVTLY6P3dMPLheIOq/egYlPxPfxpOuJW+/Sec6bZBuJm97U
        R9T5k2d56xiCrgJ3CZgvtlMd3ugqUBtnf0QjPt0UNmbJrTgBBqpWJ/kQpyRL5wQFaXo4de0fVMA
        IIp2hpRI7fOtudGvaytA6qUNN
X-Received: by 2002:a05:600c:3b1f:b0:394:5399:a34 with SMTP id m31-20020a05600c3b1f00b0039453990a34mr1536988wms.40.1651589954226;
        Tue, 03 May 2022 07:59:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyd0dxa95Pj2U+hA9w5BwXWjBAHcElOoTebVuZFbPFkRANcckEwJxnP4Vwxmt5ZItX1z0AydQ==
X-Received: by 2002:a05:600c:3b1f:b0:394:5399:a34 with SMTP id m31-20020a05600c3b1f00b0039453990a34mr1536968wms.40.1651589954045;
        Tue, 03 May 2022 07:59:14 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b003942a244f39sm1828183wms.18.2022.05.03.07.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 07:59:13 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 07/34] x86/hyperv: Introduce
 HV_MAX_SPARSE_VCPU_BANKS/HV_VCPUS_PER_SPARSE_BANK constants
In-Reply-To: <19a812b3-73b4-7e5a-8885-ec652598a5ce@wanadoo.fr>
References: <20220414132013.1588929-1-vkuznets@redhat.com>
 <20220414132013.1588929-8-vkuznets@redhat.com>
 <19a812b3-73b4-7e5a-8885-ec652598a5ce@wanadoo.fr>
Date:   Tue, 03 May 2022 16:59:12 +0200
Message-ID: <87ee1a3bnj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe JAILLET <christophe.jaillet@wanadoo.fr> writes:

> Le 14/04/2022 =C3=A0 15:19, Vitaly Kuznetsov a =C3=A9crit=C2=A0:

...

>> @@ -224,7 +225,7 @@ static inline int __cpumask_to_vpset(struct hv_vpset=
 *vpset,
>>   	 * structs are not cleared between calls, we risk flushing unneeded
>>   	 * vCPUs otherwise.
>>   	 */
>> -	for (vcpu_bank =3D 0; vcpu_bank <=3D hv_max_vp_index / 64; vcpu_bank++)
>> +	for (vcpu_bank =3D 0; vcpu_bank <=3D max_vcpu_bank; vcpu_bank++)
>>   		vpset->bank_contents[vcpu_bank] =3D 0;
>
> and here:
> 	bitmap_clear(vpset->bank_contents, 0, hv_max_vp_index);
> or maybe even if it is safe to do so:
> 	bitmap_zero(vpset->bank_contents, hv_max_vp_index);

Both your suggestions (including the one for "PATCH v3 07/34]") look
good to me, thanks! I'd however want to send them to linux-hyperv@
separately when this series lands through KVM tree just to not make this
heavy series even heavier.

--=20
Vitaly

