Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529FC543732
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244041AbiFHPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243712AbiFHPVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45674443D6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654701507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AnWWOoyOWawcqFhgiK1IzszeYcOCqS5xnbxe9Zf0Cgo=;
        b=JxyRrVY5X6YjX7BWiKvQVyrwXexA7hjJTeKCrOEGvaVTa6Vp7UwUK+8yjvH936xJ1EEn/2
        viL0bc2a/gv/gmbLZmDVT9HPx+ykSs/6Egmbwr7k5DiIc5xXA0o5d5RfNnUcIrxXS78BVM
        rxvepRw1wrZF7dRdU9R/VZpyWdTNkAU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-yWA4oxaAM1auDPaelM_jfQ-1; Wed, 08 Jun 2022 11:18:25 -0400
X-MC-Unique: yWA4oxaAM1auDPaelM_jfQ-1
Received: by mail-wm1-f69.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so10039162wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 08:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AnWWOoyOWawcqFhgiK1IzszeYcOCqS5xnbxe9Zf0Cgo=;
        b=YTrGygd6tbweee9W+y/pZ6raVoOKmIYWbkkgevWU754h17A5aYTkR/m3PHHqC01I7z
         hhVYNqelIuiygRTH3JFoxO5WY8A3YuoRSqnujzhnIrimhpYpOva3dQTyFBacxWo2PFl2
         BdHjIQ0yVxmPOFBGxvkeH3sw15K5/bVio5os7BlgKbBGGylCpzo9UhsB4dZwy6nxTAEQ
         OIgI26JYGspAYUisPphbwSJAuFVE+ZpmogHKeIGsk7/TT1Juo7dCbJ9BfcjpCTrn9Pdr
         LZBy3Mr7Y18nNwsKXPDtOK2PhI69O6KzPPwKDvYT+2F0R3qtOj0P/uw9dt3j3FjJswX6
         LuVw==
X-Gm-Message-State: AOAM531cabiE4OCjGft7sdFTnTE3b0joAbAzYtlv+H1iwbzuMjwCwzQI
        o7XisL+GF0lUfD6i3EAqZsY6YfT5qgn0HuROsdwFWwgPN2dHPVT/yr8/AiRBNR8lNzrzXAO6Iaw
        eyrnEMOLQel0BG7IEErPjHKG2
X-Received: by 2002:adf:c64c:0:b0:20f:e8f0:be4c with SMTP id u12-20020adfc64c000000b0020fe8f0be4cmr33666974wrg.614.1654701498449;
        Wed, 08 Jun 2022 08:18:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRS/yRRjFqqUpDqSS8/66z+cKo0PuMhKNuaPM77uM1lLBZJm6Y+CXdsd5hVWJjUOUJYn0i7A==
X-Received: by 2002:adf:c64c:0:b0:20f:e8f0:be4c with SMTP id u12-20020adfc64c000000b0020fe8f0be4cmr33666957wrg.614.1654701498236;
        Wed, 08 Jun 2022 08:18:18 -0700 (PDT)
Received: from gator (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id y16-20020a05600c365000b0039c5328ad92sm8348596wmq.41.2022.06.08.08.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 08:18:17 -0700 (PDT)
Date:   Wed, 8 Jun 2022 17:18:15 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 048/144] KVM: selftests: Rename 'struct vcpu' to
 'struct kvm_vcpu'
Message-ID: <20220608151815.7mwlj3eppwmujaow@gator>
References: <20220603004331.1523888-1-seanjc@google.com>
 <20220603004331.1523888-49-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603004331.1523888-49-seanjc@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 12:41:55AM +0000, Sean Christopherson wrote:
> Rename 'struct vcpu' to 'struct kvm_vcpu' to align with 'struct kvm_vm'
> in the selftest, and to give readers a hint that the struct is specific
> to KVM.

I'm not completely sold on this change. I don't mind that the selftest
vcpu struct isn't named the same as the KVM vcpu struct, since they're
different structs. I also don't mind avoiding 'kvm_' prefixes in "KVM
selftests" (indeed I wonder if we really need the kvm_ prefix for the
vm struct). If we do need prefixes for the kvm selftest framework
code to avoid collisions with test code, then maybe we should invent
something else, rather than use the somewhat ambiguous 'kvm', which
could also collide with stuff in the kvm uapi.

Thanks,
drew

