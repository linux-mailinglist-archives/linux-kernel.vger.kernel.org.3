Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8947252FA5B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 11:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242003AbiEUJcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 05:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbiEUJc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 05:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60F1B69CFD
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 02:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653125546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lvxdXwOHitcBIpGs6wIQPCxkxQb56H4Xqa134ITbFFo=;
        b=Ql/jCE4HB8w75InnvSjhR8USSQAh0kdwgVAjv75vKMcm5XjBJMDjK5kN1bY8ZltGQYdZP4
        IgVJiHXGcFmQZd3CRzkC/O704BMTi9sdLkSaUknMMyVyOfWba0srqneN2Hn/spyqttComO
        4zUpIhU33zDDzp8qUD3FdvFEoXaQ6TY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-zkMzzXI7NQel0p0FgxDo_Q-1; Sat, 21 May 2022 05:32:24 -0400
X-MC-Unique: zkMzzXI7NQel0p0FgxDo_Q-1
Received: by mail-pl1-f199.google.com with SMTP id s7-20020a170902ea0700b00162028433bcso897073plg.16
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 02:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvxdXwOHitcBIpGs6wIQPCxkxQb56H4Xqa134ITbFFo=;
        b=MNb5sbtJq0xTTp2vou38UyW4vaW8tn+If/rsIvWvvzfFiixBp5ZhYQm3ocDTdoLrU8
         3ndo17bVIGpko9YzZKk/JZwkjamkyk1VLJo6v27Xs/yOiMYnWQeiTzVc5uQiX7FRnFG4
         KES+8Rkj7HdqodlAvXCntmz4xS2DgX54FQDeeSOisvRwV4siGz7igklQYmnIWnnnlnDc
         hN7+e62Mo0G1JC2GXwwoh31ZoFW1o2WFecAQJOAMfhUaje4NZUfh9l6LroQJqp8KLisF
         cTetOodlw4ei7nwqdX3JdiabTK/J0LRX/UXTMHe/3gUL9rqJm5zNo2zNts1O4khn1ze8
         ZDgA==
X-Gm-Message-State: AOAM530FMfxFrA/aZVfMLBa0KGHr0TRLCAxvYfUx0Suxzemfo0xLn1NO
        y03ZDkW57Upe/RUN84C+mYRZtyB2eUbecszdkOLylqjo6vTi4/uuLaX63rfhu27qxpjjuQmlwX6
        +0grmCIyOnnLhJoY/IXwOcWADpahHengR47kzRE5X
X-Received: by 2002:a17:90a:de02:b0:1df:3f94:811c with SMTP id m2-20020a17090ade0200b001df3f94811cmr15866273pjv.112.1653125543199;
        Sat, 21 May 2022 02:32:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZSU2qJUc3vst7EcYhkZxGtYX1NO9nd4dXQIH+kq11dwaVfU8QzctRDQMSoJsmOb3HNifMH180iKdF5vsCY3w=
X-Received: by 2002:a17:90a:de02:b0:1df:3f94:811c with SMTP id
 m2-20020a17090ade0200b001df3f94811cmr15866253pjv.112.1653125542902; Sat, 21
 May 2022 02:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220521093017.148149-1-usama.anjum@collabora.com>
In-Reply-To: <20220521093017.148149-1-usama.anjum@collabora.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Sat, 21 May 2022 11:32:11 +0200
Message-ID: <CABgObfauKbK5oepM49CKH4yJ3mBVzYTtLD8ycsobtmxTtgMCqA@mail.gmail.com>
Subject: Re: [PATCH] selftests: kvm: correct the renamed test name in .gitignore
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Yang Weijiang <weijiang.yang@intel.com>, kernel@collabora.com,
        kvm <kvm@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 11:31 AM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Correct the vmx_pmu_caps_test test name from vmx_pmu_msrs_test in
> .gitignore file.
>
> Fixes: dc8a9febbab0 ("KVM: selftests: x86: Fix test failure on arch lbr capable platforms")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Hi, this is fixed already.

Paolo

