Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C144FEADE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiDLXS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiDLXSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:18:36 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14DC48388
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:06:41 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id c1so245839qvl.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p8u0CU1KvgYWMsdxtEOdCdEghJkrxplipXTRXNrm5S4=;
        b=DG+c7994oyQk1ElIm/4+o0ZgHIWOGTmheFs0LERWEGROvm/qYckVHs43ZYbkEj5VJM
         odL33hJmPMezfqOLZjCdle4myMgQVudQGGblllA2bim+A+cJ8wmSnrCk5/ZIwvHKy+wZ
         qeZBtrDRaZzAUEZIsm/GiIY8LlnmxZTCSd9DKxM862ZoTZhg3Un8XVa3lYSecE9e9Wmk
         qzo2RQq20WVvANBn49L9mCw0P8sXnxvRDThzOMFclR6YeKIvD8zKdMIiC7Udr7NvMdHp
         KF2fat9SEMQ14gg5Y1VymtEptuwhBxS204RX03E/hw5+umWOBV0+TvWZbSLstb3v1sqT
         OHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p8u0CU1KvgYWMsdxtEOdCdEghJkrxplipXTRXNrm5S4=;
        b=6B7x8iLKY+uPZnpwVSlt3S8hW4v7kvm9F70mxwJ572t4oyMQ/ho7485ixMvSWMxJ7q
         ystpB7MBRdRjqD+b7UiH6voiBZaeZtFiJHqvSiLy/mnIqNtff0T5rGlZOuVn2Ur4fTyT
         KUc1XXOJ8M45eT3OdCAJgjbORi/1N9qXtS/fAADLQzB8iSSdBkJusGdq1OHuanUK2Nz1
         BKPFbxjVg6Plnd6KVR3ZYJHJ339wagZAu7OOYWnBry9GjqRmkbno0Rzjr4KMMrFYML2k
         6V1U/5jWs2GDkVJTi7H0mhQ0Xx0RFqJVDcojo0oMFYpBU+8HW8vkXv3cRL7i9jtAX/Ic
         R3CQ==
X-Gm-Message-State: AOAM533DQd0RgKnBqxpDnA35RKYeZA9mKRrVbr4PBM/J1Hf1w+QKLxpn
        p7OPqg4tDjXfv9nFSi7Due1OiL5LpMZK5w==
X-Google-Smtp-Source: ABdhPJx8BTXc5+r92UKhVYuhBH/X61uNdS2qyAXuDlYul0QoeHX4uiTUuk38GGOdMl8bX6rqymn6Eg==
X-Received: by 2002:a17:902:f282:b0:158:339c:d4a2 with SMTP id k2-20020a170902f28200b00158339cd4a2mr19010663plc.134.1649799255087;
        Tue, 12 Apr 2022 14:34:15 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090a8b0300b001c735089cc2sm416972pjn.54.2022.04.12.14.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 14:34:14 -0700 (PDT)
Date:   Tue, 12 Apr 2022 21:34:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH V3 4/4] KVM: X86: Use passthrough and pae_root shadow
 page for 32bit guests
Message-ID: <YlXwUqnI2CeYT/xx@google.com>
References: <20220330132152.4568-1-jiangshanlai@gmail.com>
 <20220330132152.4568-5-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330132152.4568-5-jiangshanlai@gmail.com>
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

On Wed, Mar 30, 2022, Lai Jiangshan wrote:
> ---
>  arch/x86/include/asm/kvm_host.h |   4 -
>  arch/x86/kvm/mmu/mmu.c          | 290 +-------------------------------
>  arch/x86/kvm/mmu/paging_tmpl.h  |  13 +-
>  3 files changed, 20 insertions(+), 287 deletions(-)

This diffstat is amazing :-)
