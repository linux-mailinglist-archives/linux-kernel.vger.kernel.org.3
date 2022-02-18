Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDD84BBC71
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbiBRPtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:49:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237220AbiBRPs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:48:26 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CB82C125
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:46:39 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v13-20020a17090ac90d00b001b87bc106bdso12675769pjt.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0h0yzaW462ZF9lyYj1aHP10k4uXSQPfG+Ko5s+1LJxg=;
        b=Vblj9l7DSl6NjW4P3nEo+yA4pBRc6GV5wKlIkQI9RYk9QxeAYDmff7Wt96DQ419OxE
         venDArEZzh23AuQhZaL0x9N7i0BohjnLY2hSowm4bhh1u4EF8PXFB90+NYdQxVtqL0vX
         4N6sHfws37oWBIEmcxSVmrzyBfvJuzdh53JXuzCYoUED5Gc6IKy2PPvNJcHVrGzbeTLJ
         w5lgAW46wmvaDEwj7/HqAu2jmWfdw84YAU0tcWig2mC0GaeECKjEvy5uU0HBiEx1kBUa
         MeO75fomWOPLzf62CyyjhQb3n+PedNP2hZxYSoz2xtof3EFX7+3wlFnldDHO2G2Bi5kU
         5KsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0h0yzaW462ZF9lyYj1aHP10k4uXSQPfG+Ko5s+1LJxg=;
        b=6kwCX3jvclTA/u1HejIZCLowAT+LJMz1M7iZqrSYlDI8ITtg0H16I44Lh414jK4A56
         veshTS9rlJLTPDsUpr3YOqO04i72Xsl7DmUlreMqv0w4TADuaKLX8eeZRxrw0r4RJEyO
         wo+xSHmxeDKIHNK6h0rz9l/4lNEljUXFqyzctCNCVFj3P8za0wSj9vZs/CUC6Xrqf3on
         mcetH2ORxgm24j7zkA4u40FyHkBso7P7RpsKFVxp3+/QSNJk+aglPytz14MeHY+rocGc
         /ZYvJv413HJzjEMGM9P7mOzBBzdPlVEtK24acU6/iivDo6KWRR4AXgc4mnnyO4+HtJL1
         Z2mQ==
X-Gm-Message-State: AOAM5312XyiqvnkyAoPm1UUT0GlNoboXhXVXbE2WFv10OLtWOpq64ehD
        1EB5/jTJjYSfzr5kLLbVQYZnBA==
X-Google-Smtp-Source: ABdhPJwTapBayvFSHcTphOCuoc0Liz2WvP8m0tyMK3bULiLHZ4HyYwgRZwfW19JzdRRkOIM//07CzA==
X-Received: by 2002:a17:902:eb85:b0:14d:b906:cbd3 with SMTP id q5-20020a170902eb8500b0014db906cbd3mr7909810plg.122.1645199199015;
        Fri, 18 Feb 2022 07:46:39 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 14sm11614010pgk.85.2022.02.18.07.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:46:38 -0800 (PST)
Date:   Fri, 18 Feb 2022 15:46:34 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 2/6] KVM: x86: use static_call_cond for optional
 callbacks
Message-ID: <Yg+/WirqvhO0Zx1q@google.com>
References: <20220217180831.288210-1-pbonzini@redhat.com>
 <20220217180831.288210-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217180831.288210-3-pbonzini@redhat.com>
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

On Thu, Feb 17, 2022, Paolo Bonzini wrote:
> SVM implements neither update_emulated_instruction nor
> set_apic_access_page_addr.  Remove an "if" by calling them
> with static_call_cond().
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
