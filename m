Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF23F500856
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbiDNI3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbiDNI3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:29:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7984E61A1F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649924835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ddRxj9LdJdoAY5aIKpg/GD3Zecf+f1HKev+aQowj1oc=;
        b=Jx0GL31gOT2hO3s1EoUzyyvXAPR9LO+hW7cis1BEZ3RYBYS7l+e5Opsg4qWdnz3PcjFRMy
        iV0nSDTlAeqpludoh30k4bLaKTW1fzEo/PyrUc/LTLwMvSdq7L4uek3P7jhjfNMrYMGNMv
        Mdl4wRdalXosOBS7j0MKhYboe2q+wZo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-h2sHK2NSOkSJ_RqnmySchg-1; Thu, 14 Apr 2022 04:27:14 -0400
X-MC-Unique: h2sHK2NSOkSJ_RqnmySchg-1
Received: by mail-wm1-f72.google.com with SMTP id n37-20020a05600c502500b0038fdc1394c6so1458179wmr.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=ddRxj9LdJdoAY5aIKpg/GD3Zecf+f1HKev+aQowj1oc=;
        b=a1eN4/74Qtg1yEjqy/AT7asxRiIEPox0pdWLxXWYPHC5mVDqO4bdXOqkke/6Cxtkpj
         cZIioZl4iHzXTLyNWpKWTZQGtGS0+6lm8ZiEbGSxPlk5vXOyyhmpIMw6r94RabO2y0BE
         QBa0Q0odaeRJaL+Ji/5lT+Pervtfv4WjYGVtQ2/M61pEZByrmKZh+YHkkMsTI/Z5OP8u
         D5m9d4gQBLOAFZG4CvlotBgOtESWUtQQAwMHWJXu1fusLZycZBm4+pnmQr5aCnLNgZ1L
         RlAC2GKwAsKxnwK3SrKFhsPxpxURRWY5BpNZ8ES/csDx8UX9WLL5ijgu2jrSEgKa/rQn
         8nUg==
X-Gm-Message-State: AOAM532BBh5lEVay3TchWpl5Hfjs4btcbY0ut1zwvzbZX3wVqMYFUwUG
        ldMfXz/zKmsNyGR0pu6xcUOKQ60Gwa/DiAK+l91XIOrDK+CbsYPqZ06QKoliLZX6kJexNiHbOaR
        6CEHTjdC/7vuZZ3axGpsOgGTBGDJitT4caIQhREeJ6gtchzGR7GXQj6bpipdz7w0p0fvmA0487m
        Vb
X-Received: by 2002:a05:6000:1a8d:b0:207:afb7:d72e with SMTP id f13-20020a0560001a8d00b00207afb7d72emr1182683wry.7.1649924833047;
        Thu, 14 Apr 2022 01:27:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOF1zopMHOZH1OzYYyLBnmGcF74DLN0DmBvjZmBJUcjBvJKnt4PS+uDJ3NdHGlMn9YHtFcIw==
X-Received: by 2002:a05:6000:1a8d:b0:207:afb7:d72e with SMTP id f13-20020a0560001a8d00b00207afb7d72emr1182671wry.7.1649924832817;
        Thu, 14 Apr 2022 01:27:12 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id a16-20020a056000051000b00207b5d9f51fsm1204865wrf.41.2022.04.14.01.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 01:27:12 -0700 (PDT)
Message-ID: <166f2025-1479-a5d0-9d0d-da158b01fa95@redhat.com>
Date:   Thu, 14 Apr 2022 10:27:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 16/22] KVM: x86/mmu: remove redundant bits from extended
 role
Content-Language: en-US
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     seanjc@google.com
References: <20220414074000.31438-1-pbonzini@redhat.com>
 <20220414074000.31438-17-pbonzini@redhat.com>
In-Reply-To: <20220414074000.31438-17-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 09:39, Paolo Bonzini wrote:
> Before the separation of the CPU and the MMU role, CR0.PG was not
> available in the base MMU role, because two-dimensional paging always
> used direct=1 in the MMU role.  However, now that the raw role is
> snapshotted in mmu->cpu_role, CR0.PG *can* be found (though inverted)
> as !cpu_role.base.direct.  There is no need to store it again in union
> kvm_mmu_extended_role; instead, write an is_cr0_pg accessor by hand that
> takes care of the inversion.
> 
> Likewise, CR4.PAE is now always present in the CPU role as
> !cpu_role.base.has_4_byte_gpte.  The inversion makes certain tests on
> the MMU role easier, and is easily hidden by the is_cr4_pae accessor
> when operating on the CPU role.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Better:

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index cf8a41675a79..2a9b589192c3 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -234,7 +234,7 @@ BUILD_MMU_ROLE_ACCESSOR(base, efer, nx);

  static inline bool is_cr0_pg(struct kvm_mmu *mmu)
  {
-        return !mmu->cpu_role.base.direct;
+        return mmu->cpu_role.base.level > 0;
  }

  static inline bool is_cr4_pae(struct kvm_mmu *mmu)

given that the future of the direct bit is unclear.

Paolo

