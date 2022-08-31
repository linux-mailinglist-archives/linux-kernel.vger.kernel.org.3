Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C954D5A8358
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiHaQht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiHaQhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:37:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E55D741C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:37:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n8-20020a17090a73c800b001fd832b54f6so12885114pjk.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/FJSEh1V45RFMHMbfBC/sbmtNpZrWIPYgncZYN6O8Eo=;
        b=RT9xiJf3Xo/GkFE55Wne/Ya5ou4nSORjFT3juE8qKMXQ1SUBYRrsSEqQK6HFbBmYfH
         JN53r6aehB/q4hccIR7FoWTqABqvr98p8RkMDnvXZIhtj8KVRHPdTPL619vA/fhS2ZTv
         yeNpTXsJADrnGC4F+6sJulvA4Fws3blnqierVwkXObJnh22EktBZWvk0OIgReS9gMr7a
         dDmnfgbdTHuAzYcttZa7yh2NvBBuaLPVjhN5XoUD2XjYqbpFUagECvPiXSge1Jm5NUsm
         89Q/ytYGm0W8M+UZKFHW9TqNhnFXnP02e/LJGk3XHCRWIadywyZYGpqUuGxP8LBtw58T
         su7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/FJSEh1V45RFMHMbfBC/sbmtNpZrWIPYgncZYN6O8Eo=;
        b=ayMNIOnyZ6o8ftEUewi+J/9xgm1+71ih8VO5ADI5udTSLDjDNaj6sMHflutGjLnNNC
         mtkvOSDyLZSsK+1gVTmO9kxmWeKrJDwIz3JDxuI7A7z5Du/IGzZCelz8RhZLs4MovdBC
         CCW0AkQexo8JdGbCXDUSYTYgmleBxfof5f1QP4P1CQUcYWdXPdEC642gyDEYdTu8Qf1E
         sDsPk/hfatDIGq8Kyc5A1Q1HmE1h8ETcTtUE/M7UXiXn7nTDgvb9FAjfnm2lPE9FRdZ0
         3jAUGicYZJUpw2qT5CcTRwHenZa7DXQYfjV1ZF+20hS2TwIStsmN7zWKBUA1mQjEg3ZP
         gaSg==
X-Gm-Message-State: ACgBeo25u0UDvACUQT2QmxxvrP3X29NGI8rB25kisSQyPb1QW0skJx5j
        A/RxMGksz6DmMdCEshTZ6H1+yw==
X-Google-Smtp-Source: AA6agR7WBEdXp34JiIngWPb7UH+UuvBGe/3mx/+q9RaGK06vi3QOVSQ4iTXVCkKQ6/Xpf+bRFx4Gkw==
X-Received: by 2002:a17:902:e5cc:b0:16f:1e31:da6c with SMTP id u12-20020a170902e5cc00b0016f1e31da6cmr26626057plf.66.1661963861208;
        Wed, 31 Aug 2022 09:37:41 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 96-20020a17090a0fe900b001f54fa41242sm1488864pjz.42.2022.08.31.09.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:37:40 -0700 (PDT)
Date:   Wed, 31 Aug 2022 16:37:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH 07/19] KVM: SVM: Drop buggy and redundant AVIC "single
 logical dest" check
Message-ID: <Yw+OUa3l1Rg036fb@google.com>
References: <20220831003506.4117148-1-seanjc@google.com>
 <20220831003506.4117148-8-seanjc@google.com>
 <dd8c92855762258d87486f719bf7e52e36169ef2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd8c92855762258d87486f719bf7e52e36169ef2.camel@redhat.com>
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

On Wed, Aug 31, 2022, Maxim Levitsky wrote:
> On Wed, 2022-08-31 at 00:34 +0000, Sean Christopherson wrote:
> > Use the already-calculated-and-sanity-checked destination bitmap when
> > processing a fast AVIC kick in logical mode, and drop the logical path's
> > flawed logic.  The intent of the check is to ensure the bitmap is a power
> > of two, whereas "icrh != (1 << avic)" effectively checks that the bitmap
> > is a power of two _and_ the target cluster is '0'.
> > 
> > Note, the flawed check isn't a functional issue, it simply means that KVM
> > will go down the slow path if the target cluster is non-zero.
> > 
> > Fixes: 8c9e639da435 ("KVM: SVM: Use target APIC ID to complete x2AVIC IRQs when possible")
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/svm/avic.c | 10 +---------
> >  1 file changed, 1 insertion(+), 9 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > index 3c333cd2e752..14f567550a1e 100644
> > --- a/arch/x86/kvm/svm/avic.c
> > +++ b/arch/x86/kvm/svm/avic.c
> > @@ -411,15 +411,7 @@ static int avic_kick_target_vcpus_fast(struct kvm *kvm, struct kvm_lapic *source
> >  			 * Instead, calculate physical ID from logical ID in ICRH.
> >  			 */
> >  			int cluster = (icrh & 0xffff0000) >> 16;
> > -			int apic = ffs(icrh & 0xffff) - 1;
> > -
> > -			/*
> > -			 * If the x2APIC logical ID sub-field (i.e. icrh[15:0])
> > -			 * contains anything but a single bit, we cannot use the
> > -			 * fast path, because it is limited to a single vCPU.
> > -			 */
> > -			if (apic < 0 || icrh != (1 << apic))
> > -				return -EINVAL;
> > +			int apic = ffs(bitmap) - 1;
> >  
> >  			l1_physical_id = (cluster << 4) + apic;
> >  		}
> 
> Oh, I didn't notice this bug. However isn't removing the check is wrong as well?
> 
> What if we do have multiple bits set in the bitmap? After you remove this code,
> we will set IPI only to APIC which matches the 1st bit, no?

The common code (out of sight here) already ensures the bitmap has exactly one bit set:

                if (unlikely(!bitmap))
                        /* guest bug: nobody to send the logical interrupt to */
                        return 0;

                if (!is_power_of_2(bitmap))
                        /* multiple logical destinations, use slow path */
                        return -EINVAL;

                logid_index = cluster + __ffs(bitmap);

