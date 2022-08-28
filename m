Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BFB5A3F79
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 21:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiH1TaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 15:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiH1T3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 15:29:54 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC65AE45
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 12:29:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x26so6311328pfo.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 12:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=TqJbg/rrm3nucdrwVtoq7wfJ4YFDUNA9zK2XyD1K2XY=;
        b=BheQtYiIoRrlpWTztJ2v5llo456WTtARObJvLX1PSCf/FGlfpxKAVS8v/6/tJc9jfn
         gnxGqIi//fu0j/j17GGsDd317KWrnjlGpaq1wS83BxmTIyNO8LPcjrJ3UlRLQa3TrWxv
         +reste2v/J32z59VC9vHA0KzRv05L9qiAT4YlDqRVGOQKBiDRMC39glZ1Rfb0N4gHBt7
         eB54PHWOca+ES5TdZEmYJKSyW+aTqDH8OlO/O0NZJVW8AJjr6GAOehmNE9ucO06ps9Uu
         lc2EALa/sWbjtyKl7Xo9unUKlQgeWS4jDKJnUBhBp4mIAbi5QJJPTmo72Ss4bMKnjasa
         xWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=TqJbg/rrm3nucdrwVtoq7wfJ4YFDUNA9zK2XyD1K2XY=;
        b=ZFyjL4rVBzP/8f64v9Pg9F8KQl/g5Tzq7sKPXy7QhNdcitkQEdr+L5xAIX/nEVXD/S
         /+oFIYGVOK8GzlJIrTkPi+/UfZ075TX5Dsg7o8lsoMal4I3VJOAfpdyDjKYcKVMDp9Z+
         bWFtyKxpNf4ASRgsOLhsv1G87ENFC1eQZnr8knmladg9plxxJO6LaTnerPfjAv0q9I34
         K+YkIpclSIp6yXMv5LK7V6sHwYdiYVkkMHXGZLkHVAiqmbKIYwGheH3uuZ8uO95ig+jv
         HZh1nZKWD9EpYAnyLG7BPnvyQ6CQaZGubptuUI0WcrqS67hq1iOEFuaAF8agIZRKS5is
         SgzQ==
X-Gm-Message-State: ACgBeo2Iid95OsxCq/VXcdUlXWObc4LoDUd+9ToDWn89+sjC6uKuBWO3
        9e20ZnKI6fDTOGvwpRdJA3ZJzg==
X-Google-Smtp-Source: AA6agR5LNkSAH7/hAPX5+g8t9Qv+Hi0ONnBT6mmQaz5UiN5x5Vb91/d+m/lze1W9Wr9q6zqU7RDetA==
X-Received: by 2002:a63:4a50:0:b0:41d:a203:a45d with SMTP id j16-20020a634a50000000b0041da203a45dmr11375936pgl.451.1661714990333;
        Sun, 28 Aug 2022 12:29:50 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d144-20020a621d96000000b00537a6c78ef1sm5576824pfd.190.2022.08.28.12.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 12:29:49 -0700 (PDT)
Date:   Sun, 28 Aug 2022 19:29:46 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 4/5] selftests: KVM: Add support for posted interrupt
 handling in L2
Message-ID: <YwvCKuWX9PLEbe0Q@google.com>
References: <20220802230718.1891356-1-mizhang@google.com>
 <20220802230718.1891356-5-mizhang@google.com>
 <Ywa/ZhbEJwo6gkRr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ywa/ZhbEJwo6gkRr@google.com>
X-Spam-Status: No, score=-14.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022, Sean Christopherson wrote:
> > +
> > +void prepare_virtual_apic(struct vmx_pages *vmx, struct kvm_vm *vm)
> > +{
> > +	vmx->virtual_apic = (void *)vm_vaddr_alloc_page(vm);
> > +	vmx->virtual_apic_hva = addr_gva2hva(vm, (uintptr_t)vmx->virtual_apic);
> > +	vmx->virtual_apic_gpa = addr_gva2gpa(vm, (uintptr_t)vmx->virtual_apic);
> > +}
> > +
> > +void prepare_posted_intr_desc(struct vmx_pages *vmx, struct kvm_vm *vm)
> > +{
> > +	vmx->posted_intr_desc = (void *)vm_vaddr_alloc_page(vm);
> > +	vmx->posted_intr_desc_hva =
> > +		addr_gva2hva(vm, (uintptr_t)vmx->posted_intr_desc);
> > +	vmx->posted_intr_desc_gpa =
> > +		addr_gva2gpa(vm, (uintptr_t)vmx->posted_intr_desc);
> 
> Let these poke out, or capture the field in a local var.  Actually, posted_intr_desc
> is a void *, is casting even necessary?
> 
Will do. Yeah, casting is necessary here because add_ga2gpa takes
'vm_vaddr_t' which is the 'long unsigned int', so we have to cast it.
> 
> > +}
> > -- 
> > 2.37.1.455.g008518b4e5-goog
> > 
