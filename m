Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F60A4C4AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242956AbiBYQZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiBYQZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:25:23 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAA71AA06B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:24:50 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d15so1851042pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D79+RdzU+L/GtA2XOSZQN4AqmEuYIPOmKq3WAPF3SkI=;
        b=A4jeRnzgoZ9Dq38F72sRWI8seS6HDLcmRGZFZqN+MGCtNDG4EGqNaH7+SXtUbaFEDX
         TM3PQ6hvrfAkrLJRlZvOXVYtllkTYLKTLWeq5Gum1pMSUe4Zbexrw/qgEkfAuDHshXL7
         5hRyoOVL2L4F1gjSV3bTGzA21N7VZvUS5FJX+V4ycY6Fd5S/x+CQzjaj3mG7qz+xCMLM
         awklnyckvlCyIsqeA8sNaS1HAWsf4NVe1Isme6YgUxduGBT8IoRKkmOXsmBeTXyMLLXl
         qdJzntyw7CuiJr6y6vj/bSiyxyLnJdxBYWr5QQ698QFc7yhDN9SxilT+A4iHn+y7HQD/
         nLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D79+RdzU+L/GtA2XOSZQN4AqmEuYIPOmKq3WAPF3SkI=;
        b=53BIXdEIdXgHo/IrmRjcqJyRSsimTP7+vrGZD9HA7XJz0ZqcZk7Fiy5x1mFDu0VScp
         ZqfeJd4n+WGa9f/EKLXHqJxq64+dmoZxB3tyBC4Ga1eMteNWcj0PQJhd8N+B9vJbzPNy
         DPlLw0KwQwPgbtNsEXZELy+PZZIrd2UcBZIi+uaJ62TnaLpQigC3sJUqFHpZBGk5gsUU
         o/psYnmptTsmq9hcDrAvCbJLwEKZ8MxZuZpW9Fhg0CyjQcpe4F6AvGqhARfUX5StEkuU
         uzK3DeUo00s6nt5/ioF57HOayH1pMfNHwej10hFyXoa1Vx5Rx+Kfs9F9MTL7gr7Qe6X1
         dxwQ==
X-Gm-Message-State: AOAM533a2/9jrzL0tcBQTw5e2gci/gcuczcZM0IBNLy5wouzKjjKDS/n
        QKGcTuJ1RCsYpPYnAA5oaMqRoA==
X-Google-Smtp-Source: ABdhPJy3mnowp10UYMf1jIacWzg32LTrZuK+Y7C4SXIyABt4ooaZumINqjOGL6uQFxBgmXptpFoOPg==
X-Received: by 2002:a17:90a:f48f:b0:1bc:2521:fb0a with SMTP id bx15-20020a17090af48f00b001bc2521fb0amr3948419pjb.48.1645806289910;
        Fri, 25 Feb 2022 08:24:49 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090aa58100b001bcb7bad374sm6430552pjq.17.2022.02.25.08.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:24:49 -0800 (PST)
Date:   Fri, 25 Feb 2022 16:24:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, 0day robot <lkp@intel.com>,
        Like Xu <likexu@tencent.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kvm@vger.kernel.org
Subject: Re: [KVM]  9daee8ca83: kvm-unit-tests.apic.fail
Message-ID: <YhkCzS1rGYyJ0mKP@google.com>
References: <20220219093404.367207-1-pbonzini@redhat.com>
 <20220225014911.GA30182@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225014911.GA30182@xsang-OptiPlex-9020>
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

On Fri, Feb 25, 2022, kernel test robot wrote:
> commit: 9daee8ca835bf3ba264414c6f3a3924e23455449 ("[PATCH v2] KVM: x86: pull kvm->srcu read-side to kvm_arch_vcpu_ioctl_run")
> url: https://github.com/0day-ci/linux/commits/Paolo-Bonzini/KVM-x86-pull-kvm-srcu-read-side-to-kvm_arch_vcpu_ioctl_run/20220220-190039
> base: https://git.kernel.org/cgit/virt/kvm/kvm.git master
> patch link: https://lore.kernel.org/lkml/20220219093404.367207-1-pbonzini@redhat.com
> 
> in testcase: kvm-unit-tests
> version: kvm-unit-tests-x86_64-882825e-1_20220215
> with following parameters:
> 
> 	ucode: 0x28

> please be noted, besides kvm-unit-tests.apic.fail in title, we also found below
> cases fail upon this commit while pass on parent:

Same thing I hit[*].  Paolo temporarily dropped the buggy patch, a new one will
presumably show up soonish.

[*] https://lore.kernel.org/all/20220224212646.3544811-1-seanjc@google.com
