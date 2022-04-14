Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE085019CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245052AbiDNRQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245577AbiDNRQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:16:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEB91C93B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:09:11 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id md20-20020a17090b23d400b001cb70ef790dso9824132pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4DY38zt6SGkIm7qCLcszzp71RSWzFwtMpyIliN/cQdM=;
        b=HrLCRwTjmr1NLdCljzYlFvY6ttcg9ZrtnXkyJWNFBoKg1lC2/QDj1Z+HqZvgxXMN2V
         G/ztWyQPEVGIpLnJfwAxFwVck/NE2ulUg/uGXokN995N6hSa3mN3PVayPSMFW8vKBfRw
         oSQDq5IWpEzVn5Qdwe0YVQIwf8IIB9PkuC0X6muXYfk4xHhJ+zJq6Ct/P3qFrhR66dK6
         xR4IG2ikIahi2HCqviegtE2R3opvSYUc7mxnyHqYJWHYCRUAKu7AH7SCDc8wuXurRI7Z
         U37GtOYH6KRYe8x+3itBTRIY/yHXi5DgGJho+agRoq0/QgAUZCtCs/ag60bH6EUV1j8g
         d1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4DY38zt6SGkIm7qCLcszzp71RSWzFwtMpyIliN/cQdM=;
        b=wWfy8tIFCD7ZxH5HB5mIKv9V1+1EouaSCKIbN7IbBZf/TsAgDCuc9WgVnXXYw0rlU8
         0/FNIbftRNre5NSIrP9hJMsc6/i+0GjwSbm8jypZHLhv3kFElWiu2nzN6/0gpVrHxczu
         kqFSyj/dxctSkEER5HHc3CpuUgMorfJgCm2Ao8xlE+XlEXo/pK8vMrMi/eLksxZoua94
         sDu50+8tHDP9Hq6yWmTpeXL4MIRKJHFYeojaRSMPO/XQpWHKLsB6ahGcyoZVxESc2IWK
         eobliwnKce/sFLAdYI9LtzUvX8Hhcg4bXbgjyZs/qAW2GYgMxnQbEXI4IrjCng+5a1Bz
         WlJQ==
X-Gm-Message-State: AOAM531cWKLc06/y11KnEfrZ99W7QZg99F9dEzW9vNdRkKVBVq9Hlfsm
        uJqnoFS8487yf5vd9I390uONYA==
X-Google-Smtp-Source: ABdhPJxGEJznTdlqtjBF84pK5RGMzIwBmz4c+h6rdYXZeZrge2UBebitMJPG0Ztg01qkgDMtepmTEA==
X-Received: by 2002:a17:902:7795:b0:157:c50:53a6 with SMTP id o21-20020a170902779500b001570c5053a6mr35811305pll.40.1649956150947;
        Thu, 14 Apr 2022 10:09:10 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k8-20020aa790c8000000b00505d6016097sm449808pfk.94.2022.04.14.10.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 10:09:10 -0700 (PDT)
Date:   Thu, 14 Apr 2022 17:09:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Isaku Yamahata <isaku.yamahata@gmail.com>,
        isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        erdemaktas@google.com, Connor Kuehl <ckuehl@redhat.com>
Subject: Re: [RFC PATCH v5 092/104] KVM: TDX: Handle TDX PV HLT hypercall
Message-ID: <YlhVMgePjZvQWang@google.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <6da55adb2ddb6f287ebd46aad02cfaaac2088415.1646422845.git.isaku.yamahata@intel.com>
 <282d4cd1-d1f7-663c-a965-af587f77ee5a@redhat.com>
 <Yk79A4EdiZoVQMsV@google.com>
 <8e0280ab-c7aa-5d01-a36f-93d0d0d79e25@redhat.com>
 <20220408045842.GI2864606@ls.amr.corp.intel.com>
 <27a59f1a-ea74-2d75-0739-5521e7638c68@redhat.com>
 <YlBL+0mDzuTMYGV9@google.com>
 <a7d28775-2dbe-7d97-7053-e182bd5be51c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7d28775-2dbe-7d97-7053-e182bd5be51c@redhat.com>
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

On Mon, Apr 11, 2022, Paolo Bonzini wrote:
> On 4/8/22 16:51, Sean Christopherson wrote:
> > > It also documents how it has to be used.  So this looks more or less okay,
> > > just rename "vmxip" to "interrupt_pending_delivery".
> > 
> > If we're keeping the call back into SEAM, then this belongs in the path of
> > apic_has_interrupt_for_ppr(), not in the HLT-exit path.  To avoid multiple SEAMCALLS
> > in a single exit, VCPU_EXREG_RVI can be added.
> 
> But apic_has_interrupt_for_ppr takes a PPR argument and that is not
> available.
> 
> So I suppose you mean kvm_apic_has_interrupt?

Yeah, I realized that when I actually tried to implement my idea in code :-)

My hopefully-fully-thought-out idea for handling this:

https://lore.kernel.org/all/YlBhuWElVRwYrrS+@google.com
https://lore.kernel.org/all/YlBkiOmTGk8VlWFh@google.com
