Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E4A5332C6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 23:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241836AbiEXVAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 17:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241820AbiEXVAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 17:00:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C880149FA7
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 14:00:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l14so17910923pjk.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 14:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rMLYZe5seQUfoZme6gT+f7ho5aBgGSwYKaK8wl4oIOI=;
        b=Jdq0OntSmdnICnvNK2eFTZxT61bSqvUXQKXNf9sJcTRf6WWrBI+p4+ISllQFwJOYiq
         mGYoUFqlXDn6F1g3U+eGkdn550HQp8EJEboxtOxs2Ln9QjKkD8HEyKMYpVKCj+9tATmj
         IKsIL/6t+sfWkYUM2dBTcj/oA4hFiZpdvq/KfscvVifP5AjUm6zpXX5uqgWZ0yLr3Pt9
         dejr/Cf8Y4DD457wcFdMbI1WD+bI2+st8wBumCl8GDAOUjYpf5kT7ehM72/4x375R6sL
         p2y+G4mwQuYEgZ3Yq7ypvdDOlh0DAS6XiW8U2JuDPPWtfHaW05JO35mUXAK+wdBsShux
         C8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rMLYZe5seQUfoZme6gT+f7ho5aBgGSwYKaK8wl4oIOI=;
        b=bdtLaZslql/lVLemEKqurw1YX97duYnuPD0JAL3yQ7poGW81wmbygCeIuwkVFWUQ/f
         y9+K6E3YoUPDBsWVpopwiAGQmM9f+dhf9OTigiGMM15hFPGDTfOmKaDt/gkTeauCGl6m
         SrlAqky76rtwEO+RtoJ9Grw994qBFtHyM1NI1iXdp2E7a2u7CBKEW0iTTFnks0cnCiNE
         eiEfWSY/hsSGpPHkLXI2UvdfYEUuaE6HQd+/i3laBlzSWsPFZrXem5R3aZrqlS+bdylD
         e8nRLvk1jSa8sYyrNfDGY+wHZQoOO4QrNgS62N195gQuwpKdXjD1iFCJw5tEMjr2fUQa
         cOrQ==
X-Gm-Message-State: AOAM533jIQKYu+RR++e2mcqLehu/QzITfvh1Vm9boDyLzjp3campUdCf
        WnIED+pR67AOwVm1oDtOXh2VTA==
X-Google-Smtp-Source: ABdhPJw9/Di5LxyocJDf+ROoCJVnY2Q1BO5rz35C4l3MU+cXIMynyJ7S3gX5d5JrduYr/4f5CGNuvg==
X-Received: by 2002:a17:902:b703:b0:158:2667:7447 with SMTP id d3-20020a170902b70300b0015826677447mr28871066pls.92.1653426046115;
        Tue, 24 May 2022 14:00:46 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id r18-20020a170903411200b001619b47ae61sm7565011pld.245.2022.05.24.14.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 14:00:45 -0700 (PDT)
Date:   Tue, 24 May 2022 21:00:42 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lei Wang <lei4.wang@intel.com>
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, chenyi.qiang@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/8] KVM: VMX: Add proper cache tracking for PKRS
Message-ID: <Yo1Hemue8+l5CPIT@google.com>
References: <20220424101557.134102-1-lei4.wang@intel.com>
 <20220424101557.134102-3-lei4.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424101557.134102-3-lei4.wang@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022, Lei Wang wrote:
> From: Chenyi Qiang <chenyi.qiang@intel.com>
> 
> Add PKRS caching into the standard register caching mechanism in order
> to take advantage of the availability checks provided by regs_avail.
> 
> This is because vcpu->arch.pkrs will be rarely acceesed by KVM, only in
> the case of host userspace MSR reads and GVA->GPA translation in
> following patches. It is unnecessary to keep it up-to-date at all times.
> 
> It also should be noted that the potential benefits of this caching are
> tenuous because the MSR read is not a hot path. it's nice-to-have so that
> we don't hesitate to rip it out in the future if there's a strong reason
> to drop the caching.


The patch looks fine, but this needs to be moved to the end of the series.
Definitely after "KVM: VMX: Expose PKS to guest", and maybe even after "KVM: VMX:
Enable PKS for nested VM".

If there's a bug with the caching logic, I want to be able to bisect to that.  By
implementing caching before any of the other PKS support, a bug in either the
caching or the virtualization will bisect to the PKS virtualization
