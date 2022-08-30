Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813E45A6F38
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiH3VhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiH3VhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:37:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9CD895CE
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:37:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id i5-20020a17090a2a0500b001fd8708ffdfso10050892pjd.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=zP3t1aYxwJPDk5XaVLsNCmAQ5v0NuNcsY2lJm9GovWA=;
        b=sSBdnFkQOT821zpew9yak7rxkuZeb2MC4Eg/M3h9RsaLbVBKZWY1eG0KF0WBa4hLVO
         dB4nfwltxmIzCziE1xcAppBM373cXbZojODy5YxqR70mcY1ijLMFLQO7/+hdRo12N5RW
         mV/695VjyHZBmg1V7KrxpNYChUGpOisqUQjT0CiEVEppX2kmUB4xhztvwHWweMW9uPSN
         9XsAYUnoXxgqfPg1WH+vZJt+6Yf8RIz5p8LdpBfClKrkDkszZH+4ezYh3iD01HriOvos
         38iu1NJovNQHvTytzm3pMP9YM4tqbrZMogaWEMXGekMhhp1WHqgQtjkD9hvCTDUG6DVi
         OIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zP3t1aYxwJPDk5XaVLsNCmAQ5v0NuNcsY2lJm9GovWA=;
        b=UqJ+JeWSRNupl7Me1CeJ3qYwl/3llp+jyffHMZe3/t+3yzRUAxlz0Bzd/BtTitbvjC
         Z7OKxTXxBLisn8Xr7TsX7P2q5X61WEwrB306vqkPclkszHmQgjGaySG52tnlx0PLOK41
         iaS2eXhKYMS0bwTUdemJ/b01LmqGqErnkWLQuFlwu1PUjTjsQ95NgjLTv98QgjmLKKYS
         13R+weZU2NO8SM/Rry7cnSWB8W/zpJDHUFyai2+y5oySCLq5wRJDpnIuh4nvCBKX4irv
         pCxIxn8k7WVWpA1A1zxKlIaBhhg8O5AbsOjjMgpzGK/HGloySSOouTdozGi43vkpu/KF
         Lwzg==
X-Gm-Message-State: ACgBeo0jqmfENf7TZ6QsrFRJh0W84WJC1OOgCIYTNazTRADXrEDSjrEz
        J2oKVe1DqRH55Gj5Z/K9Ng75/g==
X-Google-Smtp-Source: AA6agR7HymFegM1rQHVDFtk3+q6iFsbn6uobQxibnrsrUL5dEkAGm+VM696UFUWDHP/kya2qGH8WhQ==
X-Received: by 2002:a17:90b:1c81:b0:1fb:887c:f82e with SMTP id oo1-20020a17090b1c8100b001fb887cf82emr36240pjb.92.1661895421775;
        Tue, 30 Aug 2022 14:37:01 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902650b00b00172a567d910sm10059594plk.289.2022.08.30.14.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:37:01 -0700 (PDT)
Date:   Tue, 30 Aug 2022 21:36:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: fix memoryleak in kvm_init()
Message-ID: <Yw6C+tBZrbP5IX+e@google.com>
References: <20220823063414.59778-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823063414.59778-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-14.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022, Miaohe Lin wrote:
> When alloc_cpumask_var_node() fails for a certain cpu, there might be some
> allocated cpumasks for percpu cpu_kick_mask. We should free these cpumasks
> or memoryleak will occur.
> 
> Fixes: baff59ccdc65 ("KVM: Pre-allocate cpumasks for kvm_make_all_cpus_request_except()")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---

Pushed to branch `for_paolo/6.1` at:

    https://github.com/sean-jc/linux.git

Unless you hear otherwise, it will make its way to kvm/queue "soon".

Note, the commit IDs are not guaranteed to be stable.
