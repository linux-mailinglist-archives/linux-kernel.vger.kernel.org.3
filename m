Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D1A568EC9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiGFQO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbiGFQM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:12:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C5126AF8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 09:12:26 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bf13so1324486pgb.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 09:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4WFgEfc4lU4Bdkh+g3sOJNLYHrZYR9dECbM6bIzs7yM=;
        b=iflVFHtvvvxlXskuJbiR0vcElZRuvHG9MtJzklGcKVV+DFwhKJNNDgDnMX8fxPGQa5
         LrEcqwqxrUWJSiYMS8FYUGGsUVEpi8gYInPAc2d1y91aUT+OZDdNZlio+p8nfS+6BcxH
         OKsqHYIdiPskSJWmG4GkDtYuLETZbIKi6oPxfXzdeGBZPJt+nHYnUpAZ/4uHWSgvcbVf
         gk5EtbdYAoljtvMVLWEwMiJBXTiFJ14Ow5wzcFdLN6zB1G7lO2vyuyDhhwnXwqUlfQ/L
         pBvaxzT4wUPA8RwwstqDcT5jEc+4Mc9obMs4SJOi5/VCDOzhE1jtLImPZeA3e9rxfrH0
         Qtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4WFgEfc4lU4Bdkh+g3sOJNLYHrZYR9dECbM6bIzs7yM=;
        b=B4ZL3PZ/W7Y9ccEuX8nkDMnBCmtIpIjGFYSEW1AajLXOnkYIev9eoNG6p91PiEb5LB
         4BEgQq70cxZ4Tjon6haPKEOhxoKJhijsrcyNnsHkswGn6kBfCgmpGMzedSspT5odYmjD
         YKSZ0dwTGGDN/AmD3CSuUYKfUnyiyECq5OqsqOJ846OAmt2YTYhHjDJFbd59Q68ab/wO
         LlRnHGKINbYIHJmgZdHrccvtrygRE7w55jK3QRmVRwRnit/yv052RvA3KcRgjBzXLKoD
         vYmeEXXQcMDZWmZLCH1PW8TKAbOAbhIXXM4MVOD6VFAKhwoDGJFFO71KbKmvWJyDOJr1
         nldw==
X-Gm-Message-State: AJIora9p2W1yoFvU1w/9fLRklTjG+JFvfll4OsviuChAjC+OUBHY8WsW
        fJCHRTeZFVk8EK5pV62cYWuT3Q==
X-Google-Smtp-Source: AGRyM1vptzfZUA+oT/ChE2oyDliXXD0XSTU6D7fqD5ilJCyC4Zsj7OFsmjVD43oTGnq61RX/svMQeg==
X-Received: by 2002:a65:6c03:0:b0:412:ac5a:bcab with SMTP id y3-20020a656c03000000b00412ac5abcabmr1517657pgu.7.1657123945682;
        Wed, 06 Jul 2022 09:12:25 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id m184-20020a6258c1000000b005289eafbd08sm2650556pfb.18.2022.07.06.09.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:12:24 -0700 (PDT)
Date:   Wed, 6 Jul 2022 16:12:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Subject: Re: [PATCH v2 02/21] KVM: VMX: Drop bits 31:16 when shoving
 exception error code into VMCS
Message-ID: <YsW0ZDkfVywkQEJO@google.com>
References: <20220614204730.3359543-1-seanjc@google.com>
 <20220614204730.3359543-3-seanjc@google.com>
 <df72cfcdda55b594d6bbbd9b5b0e2b229dc6c718.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df72cfcdda55b594d6bbbd9b5b0e2b229dc6c718.camel@redhat.com>
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

On Wed, Jul 06, 2022, Maxim Levitsky wrote:
> On Tue, 2022-06-14 at 20:47 +0000, Sean Christopherson wrote:
> > Deliberately truncate the exception error code when shoving it into the
> > VMCS (VM-Entry field for vmcs01 and vmcs02, VM-Exit field for vmcs12).
> > Intel CPUs are incapable of handling 32-bit error codes and will never
> > generate an error code with bits 31:16, but userspace can provide an
> > arbitrary error code via KVM_SET_VCPU_EVENTS.  Failure to drop the bits
> > on exception injection results in failed VM-Entry, as VMX disallows
> > setting bits 31:16.  Setting the bits on VM-Exit would at best confuse
> > L1, and at worse induce a nested VM-Entry failure, e.g. if L1 decided to
> > reinject the exception back into L2.
> 
> Wouldn't it be better to fail KVM_SET_VCPU_EVENTS instead if it tries
> to set error code with uppper 16 bits set?

No, because AMD CPUs generate error codes with bits 31:16 set.  KVM "supports"
cross-vendor live migration, so outright rejecting is not an option.

> Or if that is considered ABI breakage, then KVM_SET_VCPU_EVENTS code
> can truncate the user given value to 16 bit.

Again, AMD, and more specifically SVM, allows bits 31:16 to be non-zero, so
truncation is only correct for VMX.  I say "VMX" instead of "Intel" because
architecturally the Intel CPUs do have 32-bit error codes, it's just the VMX
architecture that doesn't allow injection of 32-bit values.
