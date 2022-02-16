Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C524B8D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbiBPQIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:08:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbiBPQIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:08:45 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8D8BB573
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:08:32 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id i21so2457032pfd.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9wWdENzbZdaz0aGjsJfBj6YVBvkD18Mx0mUyg9+LVWY=;
        b=FbFn8F0SOpc40AWHHfFRSB16uPldDLEDmc4ZI+6obojaZu6g3wKZWHbvNz9eeLZAux
         4hCqaEt3PzObjrd5Ijluhh/z+6zY6ZAPz73SfWrqF6EUjxOFUdLqP9edeDivuKjqw4Iq
         sg1eNH4kWs4Okf0IgCpRzcaQ0Ftpl0UhF4rkrLtihnElT37x3QFagoxKLne3kad43CzF
         ikMgGtEpDD/dlLxWShZFZ+k5yc7SMQqhMMinuh//1dvno4h7iEVNjtmP0axJHGu14ycL
         xSs9A4BvY4e8AmQrfpS9befONm23jz2Dyes3yho0FBCrFP90eOOitd3dxznkguTOMaUw
         ZlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9wWdENzbZdaz0aGjsJfBj6YVBvkD18Mx0mUyg9+LVWY=;
        b=2R5J7K3lYJDsEVuecORqDDJvBEZOFk9qW2M+viktNtfx0xQESSjAGOiPa9VfWF2MD7
         nwSTqVCPtBWD3xQR4XA+NyonfYxzUA1keHaVUBkA7ciUD7KOv1TWBTSc2EWg88tBVeju
         1FtFO6F8Uw5tIXc+oYTLT6wmpMP65p6rT4wzulRsL0mbj9DPnJVtlUcmrAIGzx0vVgMw
         9kimTO2Qtq5D5yv5olCVVGjCCbYYVjY1L2pomN9PWs9H0gE7qG/DGdPRaESMMQNRC8j/
         Mh7Y8K23turIhzrERu5+qHvM72KwG24KXd8XZqrgw/OQ9bYIMATnmKorw/2MnrZsmW2b
         olAw==
X-Gm-Message-State: AOAM5304lSeYPSNf/uQadJhKl+HoyqEF83m+SjHUML5JfcNurGjBShGT
        E+tCR8xM95BOyyAU5bY6EiZOQQ==
X-Google-Smtp-Source: ABdhPJyYN3JCwp7yUq9wOAqNNYZ89Txnz33l6Yz2FtAMeombq1IHb05JsIzHVsNr5gtscP62ffDs9w==
X-Received: by 2002:a62:e917:0:b0:4e0:1646:3b82 with SMTP id j23-20020a62e917000000b004e016463b82mr3987175pfh.57.1645027712082;
        Wed, 16 Feb 2022 08:08:32 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id me18sm18807624pjb.39.2022.02.16.08.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 08:08:31 -0800 (PST)
Date:   Wed, 16 Feb 2022 16:08:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCHv2 00/29] TDX Guest: TDX core support
Message-ID: <Yg0he8S8Z2vNikQz@google.com>
References: <YgOgog9Pb886lfsv@zn.tnic>
 <20220210003033.e57c2925b69bab5cfabf7292@intel.com>
 <YgOoId+vyd1VhIqQ@zn.tnic>
 <20220210004831.03dea501738bee060003d040@intel.com>
 <YgOr6tZjsooJgAi9@zn.tnic>
 <YgPwwI2+16/7jQC4@google.com>
 <YgQR/S67Fqz9PanR@zn.tnic>
 <YgQfGKXOemtXnFau@google.com>
 <YgQl6Uk9rONgv9+F@zn.tnic>
 <20220210130545.69cfffc8f9ced7d215141a17@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210130545.69cfffc8f9ced7d215141a17@intel.com>
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

On Thu, Feb 10, 2022, Kai Huang wrote:
> 
> > > No objection to omitting "coco".  Though what about using "vmx" and "svm" instead
> > > of "tdx" and "sev".
> > 
> > I'm not dead-set on this but ...
> > 
> > > We lose the more explicit tie to coco, but it would mirror the
> > > sub-directories in arch/x86/kvm/
> > 
> > ... having them too close in naming to the non-coco stuff, might cause
> > confusion when looking at:
> > 
> > arch/x86/kvm/vmx/vmx.c
> > 
> > vs
> > 
> > arch/x86/virt/vmx/vmx.c
> > 
> > Instead of having
> > 
> > arch/x86/kvm/vmx/vmx.c
> > 
> > and
> > 
> > arch/x86/virt/tdx/vmx.c
> > 
> > That second version differs just the right amount. :-)
> 
> Having vmx.c under tdx/ directory looks a little bit strange.

Yeah, it's inverted.  TDX is a built on top of VMX.  If/when we end up with stuff
that is relevant to VMX but not TDX, then we'll be referencing tdx/ for things
that that don't care at all about TDX.
