Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1C9507271
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354289AbiDSQEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354250AbiDSQEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:04:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA002E6B9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:01:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso2265755pju.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yFkFjqpOiICUZKBBXqsv6xYMwtD9akgoqB/oPFVYH6s=;
        b=XUI8d/MUyS+Z6t573L3e0zuWKytIV2vZPTKhN/jpInIJdtPnyFpa3mkD2THyk7ulh+
         Kqkl8braNAE9j+cVqi7h+zsguIoHKpwdt1ulMzRFn9XAtlCXgEOceJ/X9P8kPhdyy6RS
         OVkWATHLx+hgWUtYYauSZ6X5JObL8xWSV6fUicas6A0xH3fX0hdPhsb3TMwEmzIgh/Gy
         I4vZggAjTylrVzA/eostCtJqoIKLdgQQ3CRHVlNXJeM70gzFnU/wRP+jUh75enA0xueE
         183IFLFuwju1wx0+xzjYChKiiozVGiLMpIX+hd8ZM54/iy97hS3wlE0UGmPbHw99186R
         82Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yFkFjqpOiICUZKBBXqsv6xYMwtD9akgoqB/oPFVYH6s=;
        b=Df4uqKHrDPmrbWhYwYN6sLeaelleWwnLpCck83Q8y3oQ5cIbhf9S/39X0CF4ChtwMR
         /4z/Df8s/FKRkxudrPHF1VNtCyI4rg9aPk2t11cZJR87PO9W4DxsWQprAiy4KMb5W3LU
         bmX7GfZnDkr2vmuhKe5Obb77yCMeHPMsYRXnYcSV2SUTtrdmo68qd5cjvpa8cVkOl8KV
         MUniiIMx9fKYXH/7LllsYdzFHjMx0Gu5XeIwsx4/Ncs3XEzRw5WU9Fe/ySMsJTPjoGh6
         f3pVWv86a0BFtBq2hmjuSzmrkc6oe2NpF0Rb/XdK4bpo8Ub4DLlw2MD2oAcaSjBb1XoW
         xurA==
X-Gm-Message-State: AOAM533uo39dCsV14eCVvu2bhMs9a49wXwEfF3hlSpC7Hz9KxVx2q4F4
        Zwip/g4rR3f/h+++4Udr8WMLPg==
X-Google-Smtp-Source: ABdhPJz7yUN7JdXLKZI7zWnZgfsDj/Q4UEhY0oOMe0d/DOdZqQMBqZRMVdNAYhpKxscDLCxPy8+FKA==
X-Received: by 2002:a17:90a:2983:b0:1cb:8d6e:e10b with SMTP id h3-20020a17090a298300b001cb8d6ee10bmr19430845pjd.208.1650384087908;
        Tue, 19 Apr 2022 09:01:27 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090a718600b001d27a7d1715sm8704344pjk.21.2022.04.19.09.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:01:27 -0700 (PDT)
Date:   Tue, 19 Apr 2022 16:01:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>,
        Peter Gonda <pgonda@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kvm tree
Message-ID: <Yl7c06VX5Pf4ZKsa@google.com>
References: <20220419153423.644c0fa1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419153423.644c0fa1@canb.auug.org.au>
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

On Tue, Apr 19, 2022, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kvm tree, today's linux-next build (arm64 defconfig)
> failed like this:
> 
> arch/arm64/kvm/psci.c: In function 'kvm_prepare_system_event':
> arch/arm64/kvm/psci.c:184:32: error: 'struct <anonymous>' has no member named 'flags'
>   184 |         vcpu->run->system_event.flags = flags;
>       |                                ^
> 
> Caused by commit
> 
>   c24a950ec7d6 ("KVM, SEV: Add KVM_EXIT_SHUTDOWN metadata for SEV-ES")
> 
> In this commit, the uapi structure changes do not match the documentation
> changes :-(  Does it matter that the ABI may be changed by this commit
> (depending on the alignment of the structure members)?

Yeah, it's a bit of mess.  I believe we have a way out, waiting on Paolo to weigh in.

https://lore.kernel.org/all/YlisiF4BU6Uxe+iU@google.com
