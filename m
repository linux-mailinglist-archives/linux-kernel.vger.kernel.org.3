Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E685150A93F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391991AbiDUTeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiDUTes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 016434D623
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650569516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oirHxJeseSpQ4iOStNI8q8HxIkoCquebwBwbPngeeuA=;
        b=C2YpfXS4DJpqUHmRu22zF3Xga0Nz+gY7+9Rt4J/7uAYU4hl7DTdsSRYx0+UNPn/HQQpcKL
        2XHXeLZ9qTHoyjaANc93rCk8Z7C1SplGDuioc2L0R+iEy8jHXegHneKjV13M8HcbJMHmHR
        9PE9FOMeuaJsHnJXzvDV1oEUqsDW39I=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-3MXkdkeYPES8j3tMuFsKkA-1; Thu, 21 Apr 2022 15:31:55 -0400
X-MC-Unique: 3MXkdkeYPES8j3tMuFsKkA-1
Received: by mail-il1-f197.google.com with SMTP id h1-20020a056e021b8100b002cbec2c4261so3159436ili.16
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oirHxJeseSpQ4iOStNI8q8HxIkoCquebwBwbPngeeuA=;
        b=yQuQ5ucxi5crUNfC4aCKOY9jYg9/Ozb5Z7l8t7z+2SItQz0oNRAFaJEX2t0CmU+ko5
         hsUmvvMYcSXYQsynkssKe/U3RIMjHEeu6gzM5f/bJWhjhMGsV9GMCJ3nW5xTyu4WnbDf
         0S4vLR1viuX5LLAkLrsDfjwbVWqbJa7onQ4iXNlDcNYXHgr1FyaDweD3SPFxuheoayz4
         rVGKnhE7PSptB9s9TbJyJ61TbThgQXUVe9QtIm7Dr72GYtvt6rO/ah60wfjCK9Kf58FO
         6tAfHtkh0u0WKycA5wsIeR+wLIjLeg7V1f6Z7zucVhkQD+OdFsGNplwUArbzUpxRKOWQ
         K6aA==
X-Gm-Message-State: AOAM531HlkBd8ukEri0Ytx5k88YFlTfjo+aLCFLf1gTWLdlO/0lsLqq4
        D0UT5U2ftDFQjMr4cE5ECwEnlIEUBAYP34UnbCZweXtCpB/gxEx2clq21xwCEXnf20uM5xok29a
        P+NlTb/ut5VIM2/IBm2YPi00B
X-Received: by 2002:a05:6638:1611:b0:326:3406:f985 with SMTP id x17-20020a056638161100b003263406f985mr551456jas.59.1650569514948;
        Thu, 21 Apr 2022 12:31:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaoiG6Kxj7ErKitZqg/3JBzs4TupIDZ0lr19pOgKu/zn0W4U2N6Sl8x/7zKiVkv9tnJt6ggw==
X-Received: by 2002:a05:6638:1611:b0:326:3406:f985 with SMTP id x17-20020a056638161100b003263406f985mr551449jas.59.1650569514745;
        Thu, 21 Apr 2022 12:31:54 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id z5-20020a92cec5000000b002cbe5a870dfsm12676992ilq.36.2022.04.21.12.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:31:54 -0700 (PDT)
Date:   Thu, 21 Apr 2022 15:31:53 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH v6 09/10] KVM: selftests: Factor out calculation of pages
 needed for a VM
Message-ID: <YmGxKSM/r2V0tr3d@xz-m1.local>
References: <20220420173513.1217360-1-bgardon@google.com>
 <20220420173513.1217360-10-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220420173513.1217360-10-bgardon@google.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:35:12AM -0700, Ben Gardon wrote:
> Factor out the calculation of the number of pages needed for a VM to
> make it easier to separate creating the VM and adding vCPUs.
> 
> Reviewed-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Ben Gardon <bgardon@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

