Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5166353F7AD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbiFGHxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbiFGHxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78906C9676
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654588429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p5gZGK2oHc6INSHHTUFNUO8RNY5gojgeBamGwkE0RTs=;
        b=BkaqNQ8ycvaI9+u6TabB3R2aH9jJeBSC9pBFZiQfcdDWi7uKsAHI7Tm8bOIZqQsU5+Spe4
        8lv6/2Qse28b8QG2r12/5IJNUjGX0Rya7HaEImg37MeDZd6p183BZE488mzm6vVtxwQ5Dq
        PBb4tYyDD/HWhK2gRmOt3kvSDtYRovY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-68xVCxi0PDirIBT2rCWd2Q-1; Tue, 07 Jun 2022 03:53:48 -0400
X-MC-Unique: 68xVCxi0PDirIBT2rCWd2Q-1
Received: by mail-qt1-f199.google.com with SMTP id l20-20020ac81494000000b002f91203eeacso13359436qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 00:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=p5gZGK2oHc6INSHHTUFNUO8RNY5gojgeBamGwkE0RTs=;
        b=EdKwTrzibJSPC3rp1HXoLaC5JQAppOfLkyr5pyoNZN30VaEwp+4lawnyFAUTCHK2kV
         YUTmTF5b0YP87HaJgW4aa3/MaDfh7Eh/XzOIUj6QQcYh/cLGVr60R3Gt5QObMlPlujH2
         JoLa2O9xmXfVa4odsxOUZ9IBH35ErWbU83slpdl1wUIlshs0YhzhOjtNTQTpASgoSuUk
         y9RUHaBTzrH7hL1ifuNPauD8x6taP/UygX0GJYZjDA/439rS+0JIEtcvMvvw5yUr2PQH
         KDfHs4VA8yQXcBP/LEA2jS7NXHRQMpkvNks9ia9JFcHY2bzCc1RyvHmvBqlqRSE+Joow
         +D+g==
X-Gm-Message-State: AOAM532/9TS7v15EnBiJK5/aTaDyGju1cb5IcQ3Gag4QxJyQ40jD7ys8
        4HjrxX6R6iM3z6QUK659Y5ixlQurXw5HF3D4eRgYiENugU7aJGO2LzcmCLBKmac0K4EWiun0vpp
        PFH18PmUf4+dR3W3T/pd1oCd+
X-Received: by 2002:a05:622a:52:b0:304:e646:8d23 with SMTP id y18-20020a05622a005200b00304e6468d23mr11345595qtw.350.1654588427667;
        Tue, 07 Jun 2022 00:53:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykcmoQEH1DeTa2Cc1XF3NkWdyz49V4zHhjPDPtJThSs/CPy68asbh75IEtZLPjXtaFejSTFQ==
X-Received: by 2002:a05:622a:52:b0:304:e646:8d23 with SMTP id y18-20020a05622a005200b00304e6468d23mr11345589qtw.350.1654588427429;
        Tue, 07 Jun 2022 00:53:47 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id v27-20020a05622a189b00b002f937991969sm11558876qtc.24.2022.06.07.00.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 00:53:46 -0700 (PDT)
Message-ID: <66b4d9d336884886d04d4d6dd5e517b2634ce625.camel@redhat.com>
Subject: Re: [PATCH 2/7] KVM: x86: inhibit APICv/AVIC when the guest and/or
 host changes either apic id or the apic base from their default values.
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 07 Jun 2022 10:53:42 +0300
In-Reply-To: <20220607070515.GA26909@gao-cwp>
References: <20220606180829.102503-1-mlevitsk@redhat.com>
         <20220606180829.102503-3-mlevitsk@redhat.com>
         <20220607070515.GA26909@gao-cwp>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-07 at 15:05 +0800, Chao Gao wrote:
> On Mon, Jun 06, 2022 at 09:08:24PM +0300, Maxim Levitsky wrote:
> > +       /*
> > +        * For simplicity, the APIC acceleration is inhibited
> > +        * first time either APIC ID or APIC base are changed by
> > the guest
> > +        * from their reset values.
> > +        */
> > +       APICV_INHIBIT_REASON_APIC_ID_MODIFIED,
> > +       APICV_INHIBIT_REASON_APIC_BASE_MODIFIED,
> > +
> > +
> 
> Remove one newline.
Will do.
> 
> > void kvm_apic_update_apicv(struct kvm_vcpu *vcpu)
> > @@ -2666,6 +2683,8 @@ static int kvm_apic_state_fixup(struct
> > kvm_vcpu *vcpu,
> >                         icr = __kvm_lapic_get_reg64(s->regs,
> > APIC_ICR);
> >                         __kvm_lapic_set_reg(s->regs, APIC_ICR2, icr
> > >> 32);
> >                 }
> > +       } else {
> > +               kvm_lapic_xapic_id_updated(vcpu->arch.apic);
> 
> Strictly speaking, this is needed only for "set" cases.
> 
True, thanks!


Best regards,
	Maxim Levitsky

