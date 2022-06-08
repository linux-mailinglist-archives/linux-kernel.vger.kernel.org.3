Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0422E543632
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241897AbiFHPLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243201AbiFHPKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 079FA47BCF9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654700509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hImUqq81nsVWX35qLEtCQciHYWT/M6hkZvxAV6wtRbM=;
        b=CDuCn6U93tOBTciJNNQ9UZWuNfkBrLFrMq4ZA7HewPBgs09imQ+WyOBs41YkFzynPqwN1a
        4yX8XVdGoYvxmUw1Gq1nsPmsB38hImSPYg0iZ0V4DYhoczrBMeyw6nKsNtQhC47MXN+aHY
        qFJtuCMiCj/jugCKbA/taLgwL8DYJnE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-blzQETNsMASIXuIo7mhO8Q-1; Wed, 08 Jun 2022 11:01:46 -0400
X-MC-Unique: blzQETNsMASIXuIo7mhO8Q-1
Received: by mail-wr1-f69.google.com with SMTP id v4-20020adfebc4000000b002102c69be5eso4920150wrn.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 08:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hImUqq81nsVWX35qLEtCQciHYWT/M6hkZvxAV6wtRbM=;
        b=5eKpbIGu+t79V8lOu+2lc9LXDBJC+xL2jZPPjnMSdQcOM80CzMLcNXwDkZuqTM+Xen
         ehVgiSG9kptiL7auq29rhbJi90Mfx+owzxkylvwkEWLEy6cyap5fuze0o9oshF/lomBS
         HlSEaE0VlObxrtAA38mpbnrMbazoB0RTZrhF5Fh7IeY6+8t5CzIOrCIoyA/Q0oaT80DT
         SfzXsS//Ft7SmMiPzn4paDtNi2tWCppXjuqvVbhgM7LtOn7fe2lmO6DTX0SJ4hPrcldo
         R8qXncd9+bcHdK3xzcoYOXxcgrq2w1tLmMC2D54LhfKfWA7x2vBTuPoSp4l/MZiGUv95
         WVoA==
X-Gm-Message-State: AOAM530TTPUjf7nstmYlgDRk5zw/pLTKdpf+DokipiJ+z2E5hKnGnteG
        uPucy47FGx50qz2WeI1wGy6ficplm1U+Wr9V3861810/rWgn4p6oI/fySrw+ZdihBSOlsQW7Dlv
        iIxv6y+lFOafxdHI5ywS9H92E
X-Received: by 2002:a05:600c:4f4d:b0:397:4d0f:f92f with SMTP id m13-20020a05600c4f4d00b003974d0ff92fmr64886212wmq.36.1654700504930;
        Wed, 08 Jun 2022 08:01:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4q2nur4K3c+AEjtKWjSJusQeIGhrSTGfOK3Lzr9yvq+XhTvBx8lF7Krf5+qJ5RmSQftW1iw==
X-Received: by 2002:a05:600c:4f4d:b0:397:4d0f:f92f with SMTP id m13-20020a05600c4f4d00b003974d0ff92fmr64886170wmq.36.1654700504626;
        Wed, 08 Jun 2022 08:01:44 -0700 (PDT)
Received: from gator (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b00397122e63b6sm24717540wms.29.2022.06.08.08.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 08:01:44 -0700 (PDT)
Date:   Wed, 8 Jun 2022 17:01:42 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 045/144] KVM: selftests: Make vm_create() a wrapper
 that specifies VM_MODE_DEFAULT
Message-ID: <20220608150142.nnhiyp5svrrkenxv@gator>
References: <20220603004331.1523888-1-seanjc@google.com>
 <20220603004331.1523888-46-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603004331.1523888-46-seanjc@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 12:41:52AM +0000, Sean Christopherson wrote:
...
> +/*
> + * ____vm_create() does KVM_CREATE_VM and little else.  __vm_create() also
> + * loads the test binary into guest memory and creates an IRQ chip (x86 only).
> + */
> +struct kvm_vm *____vm_create(enum vm_guest_mode mode, uint64_t nr_pages);
> +struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint64_t nr_pages);
> +
>  static inline struct kvm_vm *vm_create_barebones(void)
>  {
> -	return __vm_create(VM_MODE_DEFAULT, 0);
> +	return ____vm_create(VM_MODE_DEFAULT, 0);
> +}
> +

I don't [overly] mind the "____helperhelper" naming style, but in this
case wouldn't __vm_create_barebones() also be a reasonable name?

Thanks,
drew

