Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F69E51B9B1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiEEIOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243600AbiEEIOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:14:43 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 01:11:04 PDT
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90F6F24BD3
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651738263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMmVpRWMoRU1azl33Fz0BSTKzhJqKUnbRhnfQ6zZG80=;
        b=g2jgkHF6MMN8Ft+KlYoldlTqtos7i1CADqVS75hsFElYUzUA4TBqpPRz3p6IHyBw99Ploj
        yZzIt6IjgTCxKic+dH0oTu9nOpup1GH1iugvOFSBE1oyiiVm29kc96at47OUwsTf6fYY+o
        WqmNuRGeA3xpo6MtBb2cAHySLRU8zbI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-1g34vRBtP6SBciSmsW4llA-1; Thu, 05 May 2022 04:09:59 -0400
X-MC-Unique: 1g34vRBtP6SBciSmsW4llA-1
Received: by mail-wr1-f72.google.com with SMTP id l7-20020adfa387000000b0020acc61dbaeso1181300wrb.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LMmVpRWMoRU1azl33Fz0BSTKzhJqKUnbRhnfQ6zZG80=;
        b=a77KnL9SN0GL5zP+J76tRiIzvvXsNzIBJ3Bnb4BHB5N7SugE7BttLqRbIPd9gfn3vF
         8OhbUGvx8F89qLuuYNu0Dw4kambyQw8Y5Bb1DX7nRxGbkgwHOpssLcydw0JTCsEp5BFr
         iyObgrqIC+R1t+gJzdJ1439ps5/wEdJdejLrCu5i+QrdINyyD3YYIBjgws8hupk8lgCS
         1V3J4t9oCQDHZOm1AbboPAJzUgQ0fkGwZcLjX1IMOb2R+MfQpsznjNCa9E2ZN5V2vmUm
         tMlcroXwTjdQSpGUV9p/vDdXZhVl3cuBlzmib7Aqjsk45RuSXcBAYIfpBRbkzQ185Sp3
         9+sg==
X-Gm-Message-State: AOAM53177eZxX5Yf94yLYmiw51SA01PawRLfaOUBptjXtn5Ma5SNIsu6
        HJmQ8uPbCifRmFdJnls3GFmaFuToCFLJoIN2YcDn/B7sBOdi/EQWNhkjoDOLAK9NF6WhWJbLbrM
        IxMyluwhtb7+gl0XLDZaHorR+
X-Received: by 2002:a5d:4dcc:0:b0:20a:ddaa:1c30 with SMTP id f12-20020a5d4dcc000000b0020addaa1c30mr18567313wru.419.1651738198215;
        Thu, 05 May 2022 01:09:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF3SnRl4IY2DzCHNuO4AiJMwnl6yo6g6VmMcLx1KaUXK8q/UHDTDCkU1gWSrtKSdDZPGdfcQ==
X-Received: by 2002:a5d:4dcc:0:b0:20a:ddaa:1c30 with SMTP id f12-20020a5d4dcc000000b0020addaa1c30mr18567296wru.419.1651738198020;
        Thu, 05 May 2022 01:09:58 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id bu21-20020a056000079500b0020c5253d8c5sm623451wrb.17.2022.05.05.01.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 01:09:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jon Kohler <jon@nutanix.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] KVM: X86: correct trace_kvm_pv_tlb_flush stats
In-Reply-To: <8E192C0D-512C-4030-9EBE-C0D6029111FE@nutanix.com>
References: <20220504182707.680-1-jon@nutanix.com>
 <YnL0gUcUq5MbWvdH@google.com>
 <8E192C0D-512C-4030-9EBE-C0D6029111FE@nutanix.com>
Date:   Thu, 05 May 2022 10:09:56 +0200
Message-ID: <87h7641ju3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Kohler <jon@nutanix.com> writes:

>> On May 4, 2022, at 5:47 PM, Sean Christopherson <seanjc@google.com> wrot=
e:
>>=20

...

>
> The net problem here is really that the stat is likely incorrect; however,
> one other oddity I didn=E2=80=99t quite understand after looking into thi=
s is that
> the call site for all of this is in record_steal_time(), which is only ca=
lled
> from vcpu_enter_guest(), and that is called *after*
> kvm_service_local_tlb_flush_requests(), which also calls
> kvm_vcpu_flush_tlb_guest() if request =3D=3D KVM_REQ_TLB_FLUSH_GUEST
>
> That request may be there set from a few different places.=20
>
> I don=E2=80=99t have any proof of this, but it seems to me like we might =
have a
> situation where we double flush?
>
> Put another way, I wonder if there is any sense behind maybe hoisting
> if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu)) up before
> Other tlb flushes, and have it clear the FLUSH_GUEST if it was set?

Indeed, if we move KVM_REQ_STEAL_UPDATE check/record_steal_time() call
in vcpu_enter_guest() before kvm_service_local_tlb_flush_requests(), we
can probably get aways with kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST,
vcpu) in record_steal_time() which would help to avoid double flushing.

--=20
Vitaly

