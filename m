Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412884F1EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382665AbiDDVve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379529AbiDDRXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:23:39 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452B6240A9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:21:43 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t4so8905790pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=085CFCikZI0ZSlSyHC8HLU/h1P8XbTcUdfdIfFSc4n0=;
        b=OOV2xbEit2y/RdYNm23+xuyCZl8Z+T2ls0EsFdAXySz9w2s48E/Xs73MadwVN1p+JK
         HMfcSM84pXVwBFVgA7/8Tr4hMDCeyWPh3HmkbAHNTzdnWt96Y9rN6/i8uqMqRTgsHeMh
         chxXW3tMK9KMN1XT3Yqny19YyY2aErNbS8NMXMjQxGtUruOzKCflQ0CMr+4Y+e0iopSN
         7WdNTl8v1DadN1I9QAgp5Jk8Z8APtXIRMiaeFjeRmua6x7K7eSFhOLn9dw4AqXF+HJDI
         67g6u0kcNlZ/VL+qeK0e2Q8xal2YZZTBIqQ2daUc/bx7LECIxOTNjADyu4lJyg7TUTev
         BbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=085CFCikZI0ZSlSyHC8HLU/h1P8XbTcUdfdIfFSc4n0=;
        b=K4ZkHXaINqo9p0tF8p3d9gB2EUjRhV3bRxpiLt0fwq56INOJH2aeETnTgkqYnEjI0u
         lATVtoY6mg+YDmfWyrs0TPsKDOYap69WVdH4KL+cDiiW0Gfms40yCAnzYYBCVvzqvNNd
         glSThRp0gFpPquFANbkmzyfeD/zGkShH2Pbz7N+lm04rPYINCX4kNK2VMJ5iRmN1BpbV
         40McOUGbxVYXMj5RvfvS72IeQTZyLps8KvW68VsBwBJl5nkv2PNl3ojP1951YBiYyd+t
         0AihqtMFM1N97er9MVX9FThoriaXNzkXaG3V486ATFhmuUe2NKizYeWr5VCWC6dXbw4K
         oFRg==
X-Gm-Message-State: AOAM533EqIQc52Qv8sO2MtIGrw4t0JK/M/zccJKg8YZSGY7IkGxyCtf1
        cuWi7lMi7WqTlv7WnO/9mZOGiw==
X-Google-Smtp-Source: ABdhPJz+k9OiS7nNrV1t2/FVdiyJdJ0vcSykh+CdQ2uQEEAf6z7TVQrDn/IqrEkPX4yKHwxbwEqLJA==
X-Received: by 2002:a05:6a00:e8e:b0:4fa:a52f:59cf with SMTP id bo14-20020a056a000e8e00b004faa52f59cfmr1098319pfb.84.1649092902528;
        Mon, 04 Apr 2022 10:21:42 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090a394e00b001c670d67b8esm66687pjf.32.2022.04.04.10.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:21:41 -0700 (PDT)
Date:   Mon, 4 Apr 2022 17:21:38 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] KVM: nSVM: Sync next_rip field from vmcb12 to vmcb02
Message-ID: <YkspIjFMwpMYWV05@google.com>
References: <20220402010903.727604-1-seanjc@google.com>
 <20220402010903.727604-2-seanjc@google.com>
 <112c2108-7548-f5bd-493d-19b944701f1b@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112c2108-7548-f5bd-493d-19b944701f1b@maciej.szmigiero.name>
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

On Mon, Apr 04, 2022, Maciej S. Szmigiero wrote:
> > @@ -1606,7 +1622,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
> >   	nested_copy_vmcb_control_to_cache(svm, ctl);
> >   	svm_switch_vmcb(svm, &svm->nested.vmcb02);
> > -	nested_vmcb02_prepare_control(svm);
> > +	nested_vmcb02_prepare_control(svm, save->rip);
> 
> 					   ^
> I guess this should be "svm->vmcb->save.rip", since
> KVM_{GET,SET}_NESTED_STATE "save" field contains vmcb01 data,
> not vmcb{0,1}2 (in contrast to the "control" field).

Argh, yes.  Is userspace required to set L2 guest state prior to KVM_SET_NESTED_STATE?
If not, this will result in garbage being loaded into vmcb02.
