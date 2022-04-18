Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2BF505BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbiDRPxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346362AbiDRPw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:52:56 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1762B190
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:36:01 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q19so19511151pgm.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QviqotR2gz/eMDzQiY33X7gSHfXUDsED7iwPy8uZ8ik=;
        b=YRHLSgzUndeIFUkty4Lmq/0J9dKNIekDC9tgukXyxi0heyP2Q5YwFHIR4QOKMge983
         +dkkaXjhgCr4bGk4fnhTquTeuwlQqE2diD4U4vk8ZZq3L3l1mrandDqHCVKBdEVXElyE
         9CyeGdXhx122zipo/+pcnDNxkAHdxfr03G1318xWNIkadw9CxHhobfV+yTdy1/X/+piQ
         k4VBNAa6Czb/bByfTLtVVGC6KSmBn66clYOCRyKX5J633+LiO/rQE2OaF9+BFf/Nu5Li
         xxfudcdPAdBg9TqaDdnMoquyh5xWSS5OfnpajZPi9UUdoTH8CK4DjHLgS+Lce7X3pjYS
         kaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QviqotR2gz/eMDzQiY33X7gSHfXUDsED7iwPy8uZ8ik=;
        b=AtRv16VXPjho8N3Vqhs7AMT7jOP3hAKbjRwRXnb4htTc6EGdDgB615Upi15zUXrJgL
         ke7murIZ2dnIlkRgjmE1hVsFm1xcNSJ0dDt65WtEJmLquhQlUL8QWgcCNWiVREi2Waeo
         k3Htnk77s8mqmBlGsm0g4s3oW+7+CdYUVq5MstxSLeY64P4g94UyZe3SR9jKT8HRgjGG
         VWnOg30vy4VBePX7MQAdmDAxXH3qRkx4TDoXE7D1z889mO7fDraFQm7TZT9pPXTwW2EJ
         w46mxdKtqETVkMSbphhPYRwlV1LPUYd1C6ys9Qjf5pHib0O0pfQfDnOE+VYVGlJhlN1E
         yzRg==
X-Gm-Message-State: AOAM532V5g9wP49+tKIJdqIxIDp2am9kIcIXSrmQTyIPucgQUXln+8ub
        Hn4yr5NtY8RO23walI3XXzaMjQ==
X-Google-Smtp-Source: ABdhPJwGRrtNegpZSzpZ1sifIOwowHypSLOZC0tItIpT/pTq/gRtnL+nJ7wOBcg1VcHkJVSC7myJYA==
X-Received: by 2002:a65:6d09:0:b0:3aa:1ecf:8848 with SMTP id bf9-20020a656d09000000b003aa1ecf8848mr1369951pgb.55.1650296161135;
        Mon, 18 Apr 2022 08:36:01 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g3-20020a056a000b8300b0050a833a491bsm3104774pfj.197.2022.04.18.08.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 08:36:00 -0700 (PDT)
Date:   Mon, 18 Apr 2022 15:35:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gaoning Pan <pgn@zju.edu.cn>,
        Yongkang Jia <kangel@zju.edu.cn>
Subject: Re: [PATCH 2/4] KVM: nVMX: Defer APICv updates while L2 is active
 until L1 is active
Message-ID: <Yl2FXfCjvkNgM4w3@google.com>
References: <20220416034249.2609491-1-seanjc@google.com>
 <20220416034249.2609491-3-seanjc@google.com>
 <227adbe6e8d82ad4c5a803c117d4231808a0e451.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <227adbe6e8d82ad4c5a803c117d4231808a0e451.camel@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022, Maxim Levitsky wrote:
> On Sat, 2022-04-16 at 03:42 +0000, Sean Christopherson wrote:
> When L2 uses APICv/AVIC, we just safely passthrough its usage to the real hardware.
> 
> If we were to to need to inhibit it, we would have to emulate APICv/AVIC so that L1 would
> still think that it can use it - thankfully there is no need for that.

What if L1 passes through IRQs and all MSRs to L2?  E.g. if L2 activates Auto EOI
via WRMSR, then arguably it is KVM's responsibility to disable APICv in vmcs02 _and_
vmcs01 in order to handle the Auto EOI properly.  L1 isn't expecting a VM-Exit, so
KVM can't safely punt to L1 even if conceptually we think that it's L1's problem.

It's a contrived scenario, but technically possible.
