Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421544A7163
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbiBBNTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiBBNTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:19:33 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832AAC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:19:33 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m14so38101500wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UYI//ra1wTgLyHqKdRvMjbFjIxVxiJ90kyMxoCqfe7o=;
        b=BdnTyOGFvWo7ZOsPwl6fux65m4DLYweJEERzekMEE8H27wwdS3+nQ/U2j33dBYMudw
         Eq0TXwdago9sG6j3KDWOLpvLf3b+IoUHY8DL/rwfZEN5abJJTKke3i2EeSxkj/Ah1i/K
         j3J6uUnSK95UqDWXhoHzCS2LbBvYevBbttD5uFfKCiQplkh/aunp0/MbA0xKhdasCknv
         uuWvt89ICmhS2Urtrfl6SYFsHIJ9WxX2eyyy4qkEShPKDPo5IDvaN1UaQIWuwiJFZSjA
         A0muRiAE1N2UClRfFkVFgLfzEKz36nyYyXsHY3s0LIvJzL/7Y1wOVa0n1bW6jSX/+iJm
         aukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UYI//ra1wTgLyHqKdRvMjbFjIxVxiJ90kyMxoCqfe7o=;
        b=T2kbSlV4J+tLXvEL6I98lO7kzPsftaRqSYMEKO6xuaYCyM+0muUaP+fD2ZdGNX3/sN
         cT19XDfqgajy3lfwhnZUMfvOo+gZfHIVwucD+VilFjZTFu4FW3029aHMPX92tXg9626E
         EwPQteDQQgjTLkpmydJiNmRu7NElgJAGWI7o6+81EsVnUenmWfgkjIhbT/OMLfeGxQao
         0avNFShto5ZgAkP2VjVUEVUb/+uZHgMrQz+pgm4eVfONeXNCOSqs8PxqfllD7W1R2sQY
         ztjiApcxXhlTcr6UZ776vurhheSmkVi7LLSPSNNUrB9MfCSUXofM50GVkHe/XUzXlATv
         lFlA==
X-Gm-Message-State: AOAM533M3GyX+gRLamSX+ioFTtGfQ2dYaSjNVGastpHWqVNVu+E46dfa
        v5Bg9VsBjs2iFhjcokiKJ2NtP/H03M+jUgIb
X-Google-Smtp-Source: ABdhPJzICvYrz69A0ityikLYb25DkNUNN2ptebetqW4p1gmz63PHRuJ5vDe+5x5Y5OTc6DJ6I4foww==
X-Received: by 2002:a5d:614d:: with SMTP id y13mr1433428wrt.553.1643807972109;
        Wed, 02 Feb 2022 05:19:32 -0800 (PST)
Received: from smtpclient.apple (global-5-143.nat-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id t18sm17797789wri.34.2022.02.02.05.19.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Feb 2022 05:19:31 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] RISC-V: KVM: make CY, TM, and IR counters accessible in
 VU mode
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAAhSdy2wX7Re4yepV7ReNQazF9jb-eqSUDE7rLCarr3iUchzkQ@mail.gmail.com>
Date:   Wed, 2 Feb 2022 13:19:31 +0000
Cc:     Mayuresh Chitale <mchitale@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B04F937F-6FC8-42F5-9D6B-7EF1148F9646@jrtc27.com>
References: <20220131110307.1684739-1-mchitale@ventanamicro.com>
 <CAAhSdy2wX7Re4yepV7ReNQazF9jb-eqSUDE7rLCarr3iUchzkQ@mail.gmail.com>
To:     Anup Patel <anup@brainfault.org>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Feb 2022, at 11:14, Anup Patel <anup@brainfault.org> wrote:
>=20
> On Mon, Jan 31, 2022 at 4:33 PM Mayuresh Chitale
> <mchitale@ventanamicro.com> wrote:
>>=20
>> Those applications that run in VU mode and access the time CSR cause
>> a virtual instruction trap as Guest kernel currently does not
>> initialize the scounteren CSR.
>>=20
>> To fix this, we should make CY, TM, and IR counters accessibile
>> by default in VU mode (similar to OpenSBI).
>>=20
>> Fixes: a33c72faf2d73 ("RISC-V: KVM: Implement VCPU create, init and
>> destroy functions")
>> Cc:stable@vger.kernel.org
>> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
>=20
> Thanks, I have queued this for fixes.

The formatting is clearly wrong...

> Regards,
> Anup
>=20
>> ---
>> arch/riscv/kvm/vcpu.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>=20
>> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
>> index 0c5239e05721..caaf824347b9 100644
>> --- a/arch/riscv/kvm/vcpu.c
>> +++ b/arch/riscv/kvm/vcpu.c
>> @@ -90,6 +90,7 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, =
unsigned int id)
>> int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>> {
>>        struct kvm_cpu_context *cntx;
>> +       struct kvm_vcpu_csr *reset_csr =3D =
&vcpu->arch.guest_reset_csr;
>>=20
>>        /* Mark this VCPU never ran */
>>        vcpu->arch.ran_atleast_once =3D false;
>> @@ -106,6 +107,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>>        cntx->hstatus |=3D HSTATUS_SPVP;
>>        cntx->hstatus |=3D HSTATUS_SPV;
>>=20
>> +       /* By default, make CY, TM, and IR counters accessible in VU =
mode */
>> +       reset_csr->scounteren=3D0x7;

... here

Jess

>> +
>>        /* Setup VCPU timer */
>>        kvm_riscv_vcpu_timer_init(vcpu);
>>=20
>> --
>> 2.25.1
>>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

