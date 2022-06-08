Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C56454255A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345144AbiFHDDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 23:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243577AbiFHDAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 23:00:07 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67057A82A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 17:29:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u18so16238583plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 17:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mYgGsy34+GhGM7pdMGfpARvQd5PGAcTP7M1pLkZ3n0Q=;
        b=G4e3xzjU94Fdu/P6jLsglG9MfMd29F+E2gRGiU/qlHt8JnRKZ5hEgAhx0/z4pnd5cL
         w5if0VJQCC+MPegl6D/elfj2u6VIzEyPT+YANRSpBDS+5ypmfS+kQ/KWjzISTp94Nwov
         Z8sSRgM1TzeW2PCgiezYag9bFs1U6JKqD+GN6+wdikfXOLbFGA07mgKi/WtfeXkGJpik
         t894dJ0xgmKjZDwD8TET8aYZt0kDYt33OmI9aEbiv5f73AZymzEJZrK4exdvSQr3BnNS
         b7Tql8YnpEQgHbVLtZYi58uq/P1xzr+8uy0uH0I1DLE+EnEw51uPKEke7ZlCAfuHRGbA
         NhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mYgGsy34+GhGM7pdMGfpARvQd5PGAcTP7M1pLkZ3n0Q=;
        b=UHmJvaEBa+yf9Xy0RXpI+O+ndYE/KmiZqk71RAhOJiDmLzTztlEnKORk7LlBwEVUJ4
         YadzHaShtnoX7fPriHFkWCWDhr+TOBPyusiVEzRUf6AoyxAYtAbuno4+i9GS7oRKjn2I
         NWSt6nTUGsNNvTlgK06OzvisXYbLn3D97cGPNrWd/0Ft5Fitpwze7OT/deojoC9nCpYQ
         DqHWyr0Lg8Es3Qh/8nzXGQ7vaL+4cnwS9Cy+3VV7/GxaqJ1apkrH6m7LbVnruQKXy9IH
         7J7I7ISZNFLJ8b/gmn7nbGazxGTW/eRgUjl5cNC4N/PXaFpE6z2w6P14n0ZKN3wTew7K
         eRvA==
X-Gm-Message-State: AOAM533wwo1iDXRqXzjrejFUQsuedANKsefCOyWmbAUi3qbQuW7Apx8a
        O+7NTT9HZCnqiF05AQQs02s7CQ==
X-Google-Smtp-Source: ABdhPJz5WEkY5NqvKutF00y/oV8CTyDQ1bEkAFD5sJg1BI0cYIx96wtvZpQSViXxo9UogaX8C+2u3A==
X-Received: by 2002:a17:90b:682:b0:1e3:142:a562 with SMTP id m2-20020a17090b068200b001e30142a562mr50504302pjz.91.1654648045289;
        Tue, 07 Jun 2022 17:27:25 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b001641b2d61d4sm12999997plk.30.2022.06.07.17.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 17:27:24 -0700 (PDT)
Date:   Wed, 8 Jun 2022 00:27:21 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH v2 000/144] KVM: selftests: Overhaul APIs, purge VCPU_ID
Message-ID: <Yp/s6aEHqNiys7Jf@google.com>
References: <20220603004331.1523888-1-seanjc@google.com>
 <21570ac1-e684-7983-be00-ba8b3f43a9ee@redhat.com>
 <Yp+0qQqpokj7RSKL@google.com>
 <Yp/Z7KE5C/QVpAeF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp/Z7KE5C/QVpAeF@google.com>
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

On Tue, Jun 07, 2022, Sean Christopherson wrote:
> On Tue, Jun 07, 2022, Sean Christopherson wrote:
> > +Raghu
> > 
> > On Tue, Jun 07, 2022, Paolo Bonzini wrote:
> > > Marc, Christian, Anup, can you please give this a go?
> > 
> > Raghu is going to run on arm64, I'll work with him to iron out any bugs (I should
> > have done this before posting).  I.e. Marc is mostly off the hook unless there's
> > tests we can't run.
> 
> arm64 is quite broken, the only tests that pass are those that don't actually
> enter the guest.  Common tests, e.g. rseq and memslots tests, fail with the same
> signature, so presumably I botched something in lib/aarch64, but I haven't been
> able to find anything via inspection.
> 
> Raghu is bisecting...

Ha!  Looks like it's an issue with running upstream selftest using one of our many
internal framework things.  Running a few of the tests manually works.  We should
have full results tomorrow.

I did find one bug during my inspection, in case someone gets ambitious and wants
to run tests too :-)

diff --git a/tools/testing/selftests/kvm/lib/aarch64/vgic.c b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
index 0de9b0686498..b5f28d21a947 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/vgic.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
@@ -55,7 +55,7 @@ int vgic_v3_setup(struct kvm_vm *vm, unsigned int nr_vcpus, uint32_t nr_irqs,
        if (gic_fd < 0)
                return gic_fd;

-       kvm_device_attr_get(gic_fd, KVM_DEV_ARM_VGIC_GRP_NR_IRQS, 0, &nr_irqs);
+       kvm_device_attr_set(gic_fd, KVM_DEV_ARM_VGIC_GRP_NR_IRQS, 0, &nr_irqs);

        kvm_device_attr_set(gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
                            KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);
