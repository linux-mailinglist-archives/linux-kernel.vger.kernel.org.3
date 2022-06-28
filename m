Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C17155D0DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243187AbiF1BiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243169AbiF1BiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:38:23 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939F31B7B2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:38:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id dw10-20020a17090b094a00b001ed00a16eb4so11148997pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qur+4N7rCs+mVR7/NYYv8k082l5ZRw3E/FtSDC7Vi20=;
        b=Es9RG3ilIwqewAskEs5xAWk7WPS179OJkjmrE1lpHCMqiMtUcmvTcsncMX9uv2+3St
         Cfg+MLs9G1Q1U+AWTwVOeOQs9jFh0b17GEhcbOLZa0mEV1InvlB8BS4sS6ppgnRBVedv
         t2hGAdnM7xWa5f8gf2Ohyu4expuS2Y9Dne2L018kAf4S+l0RHMu4SYG4AVSXhANglTAb
         iZ0b2CdJLCf34hwJPMzNtgHz7T+2o4RsEUwxxwSqqX+Eln24p0BJwVzo72bJl9r7qJGV
         1qoc1BSP7QwLF10YHsOHM2hnb5nha47ddiysJf28h9CIkIEAdpN0l1bBizKHVCBsVrjy
         3Vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qur+4N7rCs+mVR7/NYYv8k082l5ZRw3E/FtSDC7Vi20=;
        b=X6AWHBdM55ESq/TqjC9qkM4d2OPKTeAPB4BehC4IzScCdIejFRxBfS9LIJXBOtmEpX
         RVuFw8Jy59bOffuFFwYBhNPakn3QN+6KVbqZZEHWy3sJjAWZ5Q8Q9MFJzd364g5jnyXb
         /LBOYuAwacwG8nN2Ier6J/jDn8dv4C7DS0RoGPWPR/fGl/paobrLwRDveB7KfbpVpZ32
         cxcs3rgFV7d92ZAMMQYfv6sNwj9NtUmKI0bR0dbMgwDnuSjXplxrWFpbCQGa3GKWeb4r
         dzDMlt9KilgumSiXjHQRjMy1/8vpcOL8yclTkJJTXoIbgOqX0j0ULLQ2hIHtY05Krki4
         ixlQ==
X-Gm-Message-State: AJIora8sNeOhel8zjUpkMidX4x93hWweOBR+rAl56hQR0NfrP6OTvzdl
        Q/ABhhHgMvv+eRD2geEbxVfFpQ==
X-Google-Smtp-Source: AGRyM1tOjbhqovgiABjLCosAQ6d3Mxq9yIbjrj8W8Cwt5EgLooPUzzbVxvgAiu8u0rT87yiKJU5Kqg==
X-Received: by 2002:a17:90b:3685:b0:1ec:f6f4:8a64 with SMTP id mj5-20020a17090b368500b001ecf6f48a64mr24720404pjb.199.1656380301657;
        Mon, 27 Jun 2022 18:38:21 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id a14-20020a1709027d8e00b0016b7ba73a18sm2958838plm.38.2022.06.27.18.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 18:38:20 -0700 (PDT)
Date:   Tue, 28 Jun 2022 01:38:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Dong, Eddie" <eddie.dong@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/14] KVM: VMX: Extend VMX controls macro shenanigans
Message-ID: <YrpbiWw1E4DXQ962@google.com>
References: <20220627160440.31857-1-vkuznets@redhat.com>
 <20220627160440.31857-5-vkuznets@redhat.com>
 <BL0PR11MB304264B62299D642FF906C298AB99@BL0PR11MB3042.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR11MB304264B62299D642FF906C298AB99@BL0PR11MB3042.namprd11.prod.outlook.com>
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

On Mon, Jun 27, 2022, Dong, Eddie wrote:
> >  static inline void lname##_controls_clearbit(struct vcpu_vmx *vmx, u##bits
> > val)	\
> >  {
> > 	\
> > +	BUILD_BUG_ON(!(val & (KVM_REQ_VMX_##uname |
> > KVM_OPT_VMX_##uname)));	\
> >  	lname##_controls_set(vmx, lname##_controls_get(vmx) & ~val);
> > 	\
> >  }
> 
> With this, will it be safer if we present L1 CTRL MSRs with the bits KVM
> really uses? Do I miss something?

KVM will still allow L1 to use features/controls that KVM itself doesn't use, but
exposing features/controls that KVM doesn't use will require a more explicit
"override" of sorts, e.g. to prevent advertising features that are supported in
hardware, known to KVM, but disabled for whatever reason, e.g. a CPU bug, eVMCS
incompatibility, module param, etc...

The intent of this BUILD_BUG_ON() is to detect KVM usage of bits that aren't enabled
by default, i.e. to lower the probability that a control gets used by KVM but isn't
exposed to L1 because it's a dynamically enabled control.
