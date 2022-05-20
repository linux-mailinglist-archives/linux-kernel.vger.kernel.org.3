Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A5652F1AD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352276AbiETRdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352289AbiETRdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:33:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79500188E5A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:33:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so8403019pjf.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OrRB57pxEIl15FSAbGFcbR04Zed82TbWnP8Ld+Fb0B0=;
        b=YcuzP+v390hZe6XdOFXfD/RerN12dcdSbJLOi97YThDgyAgJtDrzjVdc8saKc4Zvls
         PY06gVOZFuFEnCYTG2IwEpgDV72zRr2VLvOOU/rnMHBTI/0lqo2bb205Jjs9bsthqzj9
         N3NPyEtF7PpLplFQZ54OoRz21BRsw+QtHl/osa8NS1VdCC54C0OC/mm+t1eD4F9ywA13
         L4pgZx+32SsqrD+8IHBWy1wsr2rv42lM/AwdezQGCOwjQavFQwBpq7NQaeMjmHksE21f
         IF0Bvw8bv0J67qRrnKVhdrZb8I7X0je2FO2+dQUoVdh/poiJwMjkN3bcMpEfxWMfCglQ
         ddwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OrRB57pxEIl15FSAbGFcbR04Zed82TbWnP8Ld+Fb0B0=;
        b=PgHuzTsXOUgF471vH0fJSqWDopSABSLGK8rHAb6p0CAlVVniO4zuXplejI/+KGC8S2
         2qvMainNrYNvT3YCL2hAVBvXzN0AF8Td5CgckpinXoegAsWqGsj1GNh8KwPol2NGnaHR
         8iO1HZlT3YMSKGVNbxTPhgH6e3jC2YaFumOuR+ZF5yJ4WRxB64egKEikLoLrlu9QTtUx
         nAQHVRBEFFaFjjwQJNooMyWfa7VXpDHYSBbeNYFUvQ0yAH48oVsS378eBvAzWe7O9OWh
         G2rIC/FD9r970PWddKDflPah+ZJ1h4Q0DYD+bKAiQRcI18BoaguApUogAE33pA2miVjG
         JsxQ==
X-Gm-Message-State: AOAM530Lgh6dKdxvrfAaH8cI7P8D84rTMmqGyIC4EK0VPawOQjUCHhZx
        WKmIrUHzdSSWX+RWG1Ts11qiXA==
X-Google-Smtp-Source: ABdhPJwQdl7zCAQyltZ8YceWiXiFncpYWC9yEUXZpjInWGC6kO731Tu2RH0yGESBbPyKG1N0SN7Vsg==
X-Received: by 2002:a17:90b:3506:b0:1dc:72c6:384d with SMTP id ls6-20020a17090b350600b001dc72c6384dmr12550486pjb.137.1653067989818;
        Fri, 20 May 2022 10:33:09 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u19-20020a62d453000000b0050dc7628182sm2175348pfl.92.2022.05.20.10.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 10:33:09 -0700 (PDT)
Date:   Fri, 20 May 2022 17:33:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv2 1/3] x86/tdx: Fix early #VE handling
Message-ID: <YofQ0RuJGMV9KBcW@google.com>
References: <20220520031316.47722-1-kirill.shutemov@linux.intel.com>
 <20220520031316.47722-2-kirill.shutemov@linux.intel.com>
 <YofJYpBLeyNsuw5W@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YofJYpBLeyNsuw5W@google.com>
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

On Fri, May 20, 2022, Sean Christopherson wrote:
> On Fri, May 20, 2022, Kirill A. Shutemov wrote:
> > Move RIP in tdx_early_handle_ve() after handling the exception. Failure
> > to do that leads to infinite loop of exceptions.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Fixes: 32e72854fa5f ("x86/tdx: Port I/O: Add early boot support")
> > ---
> >  arch/x86/coco/tdx/tdx.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index 03deb4d6920d..faae53f8d559 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -447,13 +447,17 @@ static bool handle_io(struct pt_regs *regs, u32 exit_qual)
> >  __init bool tdx_early_handle_ve(struct pt_regs *regs)
> >  {
> >  	struct ve_info ve;
> > +	bool ret;
> >  
> >  	tdx_get_ve_info(&ve);
> >  
> >  	if (ve.exit_reason != EXIT_REASON_IO_INSTRUCTION)
> >  		return false;
> >  
> > -	return handle_io(regs, ve.exit_qual);
> > +	ret = handle_io(regs, ve.exit_qual);
> > +	if (ret)
> 
> Ugh, the boolean returns instead of 0/-errno are fugly.  At first glance I thought
> this was wrong, i.e. advancing RIP on failure.
> 
> Assuming moving away from booleans isn't happening anytime soon maybe s/ret/success
> or s/ret/handled to make it more obvious that it's a happy path?

Doh, should have looked at patch 2...
