Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB1E5395D5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346795AbiEaSE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbiEaSEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:04:24 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9747CDEB
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:04:23 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q123so8485466pgq.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LpmMdysyC4EuwmfUpWYT4g8ctBwXLvzk07Qi2XK7JsM=;
        b=gX4P7zYcwxNMt3f/51KHmhU4a/ISIuExFCNA7tcwcFzpCqu49cJoSabKE1yXibyL9L
         mt6nfYUihQGZidZh0975O37DUTCCaC8YINroUYIbfuKxl3jJC1kW1zn3PrHOU0/HhGXF
         CXhSPA759RdAF+9XlYXeT8lK8Np4X62fd1iak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LpmMdysyC4EuwmfUpWYT4g8ctBwXLvzk07Qi2XK7JsM=;
        b=FVcKielr8/MhccNiNX4Tyf/L3IWuV6zh7nesqStqWUQsdHhoRg73rEQX0kdjYCWlbr
         gcHmOwlKqo9xShRlquw7Q2anQTqSluuJrSJFs96G4Nqyuyzt1S44D/QNTLfzmr6DcLUx
         mvXGriNPHdQpOIK/QJ/f/K3u+pA5pToZdCFniYFOqiIaNE6dCQQxvgzkSoeRWeljVswN
         3fgKlyEFl5Vmg2Y0cOeaCJpPKeVn3JtrSYd/SAb0yUfFiQvLmq9LRSb3NWu/NlyZ5blX
         g7c1Ulx6oyaHwUXWxeH5Qsi5F5t7rzDkq7XLcKklEEn3J+cheaQBloeeAfdnfs5aFIlf
         /e0w==
X-Gm-Message-State: AOAM533/Nu/wsxMSvjSYamw9DoLlnpYKMsfXYZo7tSAj/TuPzkNLgjPQ
        6wKnOwYdRz2Y6HWj1K+qZWmHSw==
X-Google-Smtp-Source: ABdhPJzV8AW8cb7WymazRj58+zWlWGSrmquLGFfkOVWBvwJf0m1IVdQvtmejbHeVC9pF/EbsbvpqQA==
X-Received: by 2002:aa7:8432:0:b0:518:98a7:dbf9 with SMTP id q18-20020aa78432000000b0051898a7dbf9mr45813014pfn.28.1654020258084;
        Tue, 31 May 2022 11:04:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u21-20020a056a00099500b0050dc76281bcsm11231926pfg.150.2022.05.31.11.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 11:04:17 -0700 (PDT)
Date:   Tue, 31 May 2022 11:04:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Dinse <nanook@eskimo.com>
Subject: Re: [PATCH v2 5/8] KVM: x86: Reduce the number of emulator GPRs to
 '8' for 32-bit KVM
Message-ID: <202205311104.381834A@keescook>
References: <20220526210817.3428868-1-seanjc@google.com>
 <20220526210817.3428868-6-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526210817.3428868-6-seanjc@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 09:08:14PM +0000, Sean Christopherson wrote:
> Reduce the number of GPRs emulated by 32-bit KVM from 16 to 8.  KVM does
> not support emulating 64-bit mode on 32-bit host kernels, and so should
> never generate accesses to R8-15.
> 
> Opportunistically use NR_EMULATOR_GPRS in rsm_load_state_{32,64}() now
> that it is precise and accurate for both flavors.
> 
> Wrap the definition with full #ifdef ugliness; sadly, IS_ENABLED()
> doesn't guarantee a compile-time constant as far as BUILD_BUG_ON() is
> concerned.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
