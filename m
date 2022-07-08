Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB18156BBD3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbiGHO1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbiGHO1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDB7729CA3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657290468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TgSz10/9BsFZpGAIEkp0ySVetokqd5lKigRRrfTtX48=;
        b=bEkfzJ6dLkacz3ZMqFTJ0OaiMyuAyJqUObHI+prH1JzwieONH/HlboZSUpl/wgWXsihmZR
        mcGzQmpJGXuHdLATzjQT/BZQlb6uWHNvxf6oMHgQBWgTTu1rKQEXAF1sEAHbUuZnLhTdM0
        SMJs3w45nO7XuoghnQUsr9/nVDacTNg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-2lXKOy0UMxm_3O095K8xMA-1; Fri, 08 Jul 2022 10:27:45 -0400
X-MC-Unique: 2lXKOy0UMxm_3O095K8xMA-1
Received: by mail-wm1-f69.google.com with SMTP id p21-20020a05600c1d9500b003a2d6c2b643so1092387wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 07:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TgSz10/9BsFZpGAIEkp0ySVetokqd5lKigRRrfTtX48=;
        b=6eWfKMurrNcZtKhGIGiVicHbh1xFjz6xpjUcGnWJ7g+OUPfgnz+9mVvzgK3AD4R/me
         dkFKT4mNZRgdurYYp5DYB6jza0g4nTC4Nbuaw8qOn4mAfXT0UaXluPmgrEHSTR+WlN2/
         Hr2+B+7LDhydWvnxoyDhTPNWnWhoIUeifX5b1bj78pLhTShLQ2X7oldhfXr6FAlDB/to
         DEh255Q+UxmNaQOiRhdMlU5bq3koVzR9fRglLPg3bPBKhuu64MK5yOydPk0vJaOUyV9C
         g2NdytLNw5dkS3TcBrADwuK3YUsb42fmT4JPRBBw+cNTohQzkmAl3o+XloO1xtjlVwWz
         Werw==
X-Gm-Message-State: AJIora95D3Jr8HYDpiyBOfDwBQ6j5YsXl8ufLZI3RMMVLxChSY6QdvWH
        LDhJbqO0kbRXrrHCN07A9mnQbceN5Om0ibcaI9i1TLZYbVDX7Zgs+78KFoalKTl0T2vWKsYsdKP
        cy3NeCRUzvmfIDv0Cc1QtiiT2
X-Received: by 2002:adf:efc7:0:b0:21d:9412:7d54 with SMTP id i7-20020adfefc7000000b0021d94127d54mr556192wrp.230.1657290464829;
        Fri, 08 Jul 2022 07:27:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sVca1hCqgfCicFr9JuOmeFXakjNABoNNlhHLLByVKShUtTdzfE9ZgweqHWfo2pmAH7s/5t7w==
X-Received: by 2002:adf:efc7:0:b0:21d:9412:7d54 with SMTP id i7-20020adfefc7000000b0021d94127d54mr556175wrp.230.1657290464654;
        Fri, 08 Jul 2022 07:27:44 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id ay26-20020a5d6f1a000000b0021baf5e590dsm41084417wrb.71.2022.07.08.07.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:27:43 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] KVM: x86: Fully initialize 'struct kvm_lapic_irq' in
 kvm_pv_kick_cpu_op()
In-Reply-To: <20220708125147.593975-1-vkuznets@redhat.com>
References: <20220708125147.593975-1-vkuznets@redhat.com>
Date:   Fri, 08 Jul 2022 16:27:42 +0200
Message-ID: <87let3ptlt.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> 'vector' and 'trig_mode' fields of 'struct kvm_lapic_irq' are left
> uninitialized in kvm_pv_kick_cpu_op(). While these fields are normally
> not needed for APIC_DM_REMRD, they're still referenced by
> __apic_accept_irq() for trace_kvm_apic_accept_irq(). Fully initialize
> the structure to avoid consuming random stack memory.
>
> Fixes: a183b638b61c ("KVM: x86: make apic_accept_irq tracepoint more generic")
> Reported-by: syzbot+d6caa905917d353f0d07@syzkaller.appspotmail.com
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

The patch was sent to linux-hyperv@ by mistake, my apologies.

-- 
Vitaly

