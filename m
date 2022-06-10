Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8823546BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349826AbiFJReh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 13:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244325AbiFJRe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 514F818628A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654882463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5td43/LE7xUx34b6knP7m4z1v8nG7U8TzU1aeN6kGX8=;
        b=XfQw+j0q3AO5YFYVySM44rn3DfhfJc/f4VwUnMhAIVe28h5pG0IrIwJoVqoh0hk47pnkEd
        HnrFZuQn7qsbApQtP5XzIqoBmgdzxQ6KVEV2oJD7SIyhITXTrVTGGrQUIgjU4/vQp1LteF
        awFakr4siDMPMFD7J4jTTSsAGR0rMus=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-tYR9nyF3NEON76vtap6aEQ-1; Fri, 10 Jun 2022 13:34:22 -0400
X-MC-Unique: tYR9nyF3NEON76vtap6aEQ-1
Received: by mail-wm1-f72.google.com with SMTP id u12-20020a05600c19cc00b0038ec265155fso1607924wmq.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5td43/LE7xUx34b6knP7m4z1v8nG7U8TzU1aeN6kGX8=;
        b=CHuGITgqjgRhNDkQaYqP3bsrnrNJqziu8QbNPy9IuJKsR3ASR7vPMsZhAEpJ6YhN+x
         YsXK48YrPadK87aLdqjJCUs892voajUDBmC9QalocHHGjDpuOYjNYwQnaw5Y14Z+NPOi
         a8MJJed6eGbZslw9b5M5Lt86FAAju1J6ulPAfBwt/+S6GPS1pkl0SyiiOuLaN+T3tOv2
         n+iyDpZ8WHCWYP6F9RXxmPVnCO6V9Bjx2iyMA3Xnen3V48+bSmKpKYGJeE9U+t/Ed03t
         DakH5lMr5f0hnp73bX53EkJoQmB/YVzOBtJyVGosFwPJr4ezb0wKyryUsLVATmxqWZLi
         LRGQ==
X-Gm-Message-State: AOAM530Vfk9bpt9tQuxVSAfkXnm8y1SlUsrKtrR6KQiktVcxN+In0pj0
        r5OoxFofYYX4anFPC3GqHsHssQAg22Zpba7ysjpXGLkYXWO2hU+hAjZww1Lf/w8ubG2I6J6IofN
        44+nGL/jAUb3TzimwB9jj4AxT
X-Received: by 2002:a05:600c:2105:b0:39c:37d0:6f5e with SMTP id u5-20020a05600c210500b0039c37d06f5emr837030wml.44.1654882461162;
        Fri, 10 Jun 2022 10:34:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNxWAymFfGq+xgRBf813ZSMKMnC0rxF6WBwH2jNBliFQpVDzELR70MCyXDJhFsIeRROEM3fw==
X-Received: by 2002:a05:600c:2105:b0:39c:37d0:6f5e with SMTP id u5-20020a05600c210500b0039c37d06f5emr837013wml.44.1654882460984;
        Fri, 10 Jun 2022 10:34:20 -0700 (PDT)
Received: from gator (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id n123-20020a1c2781000000b0039c63f4bce0sm3787780wmn.12.2022.06.10.10.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 10:34:20 -0700 (PDT)
Date:   Fri, 10 Jun 2022 19:34:18 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 132/144] KVM: selftests: Purge vm+vcpu_id == vcpu
 silliness
Message-ID: <20220610173418.mfwhk5ou5gco6v5x@gator>
References: <20220603004331.1523888-1-seanjc@google.com>
 <20220603004331.1523888-133-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603004331.1523888-133-seanjc@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...
> @@ -1485,73 +1446,57 @@ void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid)
>  }
>  
>  /*
> - * VM VCPU Get Reg List
> - *
> - * Input Args:
> - *   vm - Virtual Machine
> - *   vcpuid - VCPU ID
> - *
> - * Output Args:
> - *   None
> - *
> - * Return:
> - *   A pointer to an allocated struct kvm_reg_list
> - *
>   * Get the list of guest registers which are supported for
> - * KVM_GET_ONE_REG/KVM_SET_ONE_REG calls
> + * KVM_GET_ONE_REG/KVM_SET_ONE_REG ioctls.  Returns a kvm_reg_list pointer,
> + * it is the callers responsibility to free the list.

nit: caller's or callers'

Thanks,
drew

