Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D219528260
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242750AbiEPKm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbiEPKmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:42:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A653B28
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:42:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c12so3947004eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=erbXfCmeHocQjfL+rgDZPz13+JsufODTkqH4MW8FPkU=;
        b=P77DC0Il8yTtkstHIFJR8Nqlq8byFBHMvwFcvt4Nt22CzyvC/Fv+KdNgonw4S3OD3K
         2LvZ1t/0q7xkgaqJ5UbQef9PLfEU7ibZjarM7y30f4syi3XrIkk66bNTygONFoWTGBsW
         T0zLbcuIOAC9Pea0Sj+b22Ih6ju5PVW+bGFZBfbQIQwsZ2smRedVpMeslKaL1/f8c8ws
         cpfStIYgXZGpFXthRtvUGpT3DV00iZ9sg3V6xgZDESod1iRqB5UonePNMTjP7uGf8dB4
         IBqMuAHh6o186Vqyr9HRq/GyB3509vT7hUFGMlFByEIaa6lwVHd0K6KyZqrr3pKGyAHv
         dkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=erbXfCmeHocQjfL+rgDZPz13+JsufODTkqH4MW8FPkU=;
        b=VsZTZpEMYq7vnAwPfc99al06uv2EMD5QBrt86F+bOB58eM2Duc0cfPS6dA5kVs+roG
         iLRo6tsvDbOZd9sKdDbrJxc9Mq6OJMuWXX2kdr0Emo7BJNzXBZccUTnyBXz6Dx3OX6Fy
         cUJ9JDe8Fj7V40ItImVUGJFvmfxGQ/jPKGHbHHK+XAtwi3Xs9O4Vi2d7zHkslBDempL7
         vx5Fjc2QYJIb+ld06i7NDowiv+Gu6HrgXBEXGxgmJGmpMBOgTeYqPHqRR1hL6eBppxnv
         enYadsXR7l2xdGQBVjgxuGKRQiIxO99V7jIga04jhTMwHrPLuypYBhqD1HuAsUYrGSsy
         Oy8w==
X-Gm-Message-State: AOAM531RIkU8lXScZhbE3SVCFVyLdUMwsvkxpxV3KL25xtNxE1z5XKVX
        DIvefRN61Qmaq5+7yUXtHjIQ+A==
X-Google-Smtp-Source: ABdhPJwCmZ7TsADf4yBSO70bp+4Cv2yZYtgdUiE6w+q/M7boOVpmbsE2ZQrGrh1nN3VKR0CPmxFF2w==
X-Received: by 2002:a05:6402:2710:b0:427:d087:b with SMTP id y16-20020a056402271000b00427d087000bmr12509532edd.11.1652697721952;
        Mon, 16 May 2022 03:42:01 -0700 (PDT)
Received: from google.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id ec33-20020a0564020d6100b0042ab48ea729sm1151662edb.88.2022.05.16.03.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 03:42:01 -0700 (PDT)
Date:   Mon, 16 May 2022 10:41:58 +0000
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Don't hypercall before EL2 init
Message-ID: <YoIqdiOoCf0A1hcV@google.com>
References: <20220513092607.35233-1-qperret@google.com>
 <87sfpb59wj.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfpb59wj.wl-maz@kernel.org>
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

On Sunday 15 May 2022 at 12:10:20 (+0100), Marc Zyngier wrote:
> Can we simplify the condition? ARM64_SPECTRE_V3A is only set when
> !VHE, and we already bail in kvm_patch_vector_branch() if we see
> VHE+V3A, because the combination makes no sense at all. I think this
> can be rewritten as:
> 
> 	if (kvm_system_needs_idmapped_vectors() &&
> 	    !is_protected_lvm_enabled())
> 
> Thoughts?

Yup I think this works as both CPUs that are vulnerable to V3A aren't
VHE-capable. But if we ever get a VHE-capable CPU that's vulnerable I
think the next call to create_hyp_exec_mappings() will BUG(). Perhaps
the alternative would be to have has_spectre_v3a() say no in VHE to be
on the safe side? That is, prevent the cap from being set to begin with.

Cheers,
Quentin
