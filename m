Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DE44BBC5C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbiBRPpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:45:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbiBRPpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:45:13 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486BA25B6FB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:44:57 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 132so8210277pga.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WW1+9zlpyrV60I92VVXb9m5yf74JuacJkWT5mx40gBM=;
        b=CHWiCXwwPvKo9/bgi4ri6u/BwPAT5eVvnPTUZhRwp7vIPLf8wQPBieipeC1uSokNha
         bv+JG1huaegKmj2UbZWmi88/pCeC2lLsvGeZtqkMNKmenZQmyOjukqkssQyy/fX7zM0V
         NBiLli6Mig1KBvYCrVf45gvTZ5coPP1zpD4itua/4N8CK1giSizWCpDTsxEPzG0OdWYQ
         kriX0pmD4maVL0mm46MlcLqBmpLvND7YNu373e+9Tvg54nP8BsblrFgQ3a8gQPaZuac5
         X0/CJu6KUPWvw0zbGREWYZngSj0HOZk1MtYrfVrCwrohHO3alpD8t7gk1XqJuMpPWdVs
         KNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WW1+9zlpyrV60I92VVXb9m5yf74JuacJkWT5mx40gBM=;
        b=xDqKZ6cln877vCAgnqLTAbCvcLRmmKoJvRLhvvRsJr9ClIoRsThlTmaam1ROer3Thd
         NkDk6UCKwACLY3lu//S+TZboWXuAYLrALHGZ95ElUbPFwe7jBGJ/l6SOux9tK/nWSaSN
         bqDMoHK535XLSfJ4mKLbKBoTFi2Rxp9eq/z0SzERj7zVKkC9f5tzkb+P8sNl8ySSRksF
         KfeOgwF2VNnLfxJViPyEsCX4fbLuSnFH9Y1OnWjI7XofuHngwSW8JU14F9R0snPbKiDS
         NPkdeg6X0etvotkcsLUHNUHKcrMXWN25mc280v+z8A+ocNVOADzh3I/YjNX+cqGY1moU
         kD2Q==
X-Gm-Message-State: AOAM532zC8ao/R10pqQhc/b+MhYXuqr3aNhAUH6/OaON799eXpUe92gV
        PjoPX4zdfamujEbnRTAAxTKYjg==
X-Google-Smtp-Source: ABdhPJz9uQx/hS2fxrIv0RK1Gx3Q5+yEY15wQk9lfou5+Sa5RxMM++1F+vDNJ2nbbIdnLWdYYFGvwA==
X-Received: by 2002:a05:6a00:8c5:b0:4c7:f9a5:ebc6 with SMTP id s5-20020a056a0008c500b004c7f9a5ebc6mr8503794pfu.34.1645199096658;
        Fri, 18 Feb 2022 07:44:56 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m25sm11951828pgv.4.2022.02.18.07.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:44:55 -0800 (PST)
Date:   Fri, 18 Feb 2022 15:44:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 1/6] KVM: x86: return 1 unconditionally for
 availability of KVM_CAP_VAPIC
Message-ID: <Yg++9MLgfBUyGHya@google.com>
References: <20220217180831.288210-1-pbonzini@redhat.com>
 <20220217180831.288210-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217180831.288210-2-pbonzini@redhat.com>
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
> The two ioctl used to implement userspace-accelerated TPR,

Hmm, are ioctl like LEGO?

> KVM_TPR_ACCESS_REPORTING and KVM_SET_VAPIC_ADDR, are available
> even if hardware-accelerated TPR can be used.  So there is
> no reason not to report KVM_CAP_VAPIC.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
