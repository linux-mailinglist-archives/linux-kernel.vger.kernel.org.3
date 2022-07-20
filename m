Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398E357BC67
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbiGTRMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiGTRMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:12:53 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2408C6E2C4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:12:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c3so16121751pfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bQl0D8zDrRiF3mJ6TcyM48t/M2yZQ/9TBfT8hc8mOu8=;
        b=sDoPzvEjkHDs8UN6jGnE915y436nioMGhcDMXf8MbpmSbIc2a7vpbtGpjAfEaYwQsi
         b1gZZfwW2qvy3NVBkatUKACyYkiySYS3uN8T2GsQPByoRi/Tvb28/gze4wJmjmGe9g0E
         numud4Ix6k5e5C0/d0yf3DUrRATyoMndZQovKZvjc058/hHLhQ9tEGqzrMlndEvJMbND
         Gi1LKu+LMqbzuTPMSbJsTYNo0xv9Izwi3Tpc61O/6uozKeiJm8urTyKLwPSLK0/M3YW4
         mmj+jVSKSujoh5e1g5uSeR5S2AmWt3Dj0kzltyOZqU3trKueMj2jVjdScKqtRxXy3wyc
         hk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bQl0D8zDrRiF3mJ6TcyM48t/M2yZQ/9TBfT8hc8mOu8=;
        b=NLRcoJeajRuecSLm+kmq3lrLTjo2XubKHEQOzqvrOzKHY2B4mxXJ/62XG5+AJxvGpf
         +1oaL5RbUgsMzHTNE4WfjBAtn/euv4tYb0/cyVVzdoMfS4EzQiEcag/SlcucuriGtnEf
         TRXVKtpnzEDFAqwSwTjzTdvOpZ2YOPpQebrP5zUq6fJPQO08PuWPNLRVSJ6iyn9b6yt6
         yFwkCZyCKxzcw6K1N8CaqqWzi/tdUv/vYechbMEU4FhbPF1tIXMURk4gz/ha52OLcPth
         wjP6wq13wYw5vem5UJxBY6mrvaK/ANNw5kOcFtNxqjK09Le2e1QkNHEGDbAPK7nVZQhd
         QeSg==
X-Gm-Message-State: AJIora/bT7Jh8hnsGIs+XPbL+aiAIS69Op2fqUHIig7Cc5ODIzhUMAx7
        VGOdaKyeSnqCSxPt0VS2a2Rwjw==
X-Google-Smtp-Source: AGRyM1vSEE9Qh0pg3VxxvDX5Io5BOoTmf6V4vi5NX1NnOQmSJ3mQvCTVBFrLnIUlEuv4VfvR9skC3w==
X-Received: by 2002:a05:6a00:16c7:b0:520:6ede:2539 with SMTP id l7-20020a056a0016c700b005206ede2539mr39586714pfc.46.1658337172519;
        Wed, 20 Jul 2022 10:12:52 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902650200b0016cdbb22c28sm10227813plk.0.2022.07.20.10.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 10:12:52 -0700 (PDT)
Date:   Wed, 20 Jul 2022 17:12:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kechen Lu <kechenl@nvidia.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, vkuznets@redhat.com,
        somduttar@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/7] KVM: x86: only allow exits disable before
 vCPUs created
Message-ID: <Ytg3kHHdft8IqIP+@google.com>
References: <20220615011622.136646-1-kechenl@nvidia.com>
 <20220615011622.136646-2-kechenl@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615011622.136646-2-kechenl@nvidia.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022, Kechen Lu wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Since VMX and SVM both would never update the control bits if exits
> are disable after vCPUs are created, only allow setting exits
> disable flag before vCPU creation.
> 
> Fixes: 4d5422cea3b6 ("KVM: X86: Provide a capability to disable MWAIT
> intercepts")

Don't wrap the Fixes: line (ignore any complaints from checkpatch).

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Kechen Lu <kechenl@nvidia.com>
> ---
