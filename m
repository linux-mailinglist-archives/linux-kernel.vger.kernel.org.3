Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FAA5350A6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244388AbiEZOaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbiEZOaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:30:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E816C6E65
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653575405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/hbXFKs5os4KRddKG4snbTFtherU/r6Je1WrF2mEc5o=;
        b=W2hkmJ9iVVMVq5dfa6dkwqMUqBbw8AI88LiJM9JOJvRp5OCIzUtBSzNRBpRET18SxyfU2C
        e+mS2r6IYYEV8lmdN/gmfhRmwoASkxWvM5Ln4QV4A4yK92JTg6jxOmLyN3YarMuekJ2L/3
        6MT0WITGAyo85zrtx6+XxRYiuuxtHjs=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-Hyxd_wKpPMGLqkgbDB-C8g-1; Thu, 26 May 2022 10:30:03 -0400
X-MC-Unique: Hyxd_wKpPMGLqkgbDB-C8g-1
Received: by mail-il1-f200.google.com with SMTP id q6-20020a056e0215c600b002c2c4091914so1243870ilu.14
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/hbXFKs5os4KRddKG4snbTFtherU/r6Je1WrF2mEc5o=;
        b=kkfkknFlKcox/bF4kcY6jDRYjp704/bhBW7Z9xaLRDD8UQLo2gpma0PAzx4z9/YrPj
         CGeD5i6PJWBYsE6fKbyz7bxGFRH4eOL+mY79/Px2Kt+fZ/ZDfeEu9d51lXe1JnHdHqq4
         ema1OWhDr15V/B3VFJAhtOQys5QWg0jESRBSdZS/yTIbgW1YeEb7v4HJwQdLEg2qXsIb
         O4U3W4BeSpiXsQYWv97pHkxiWBFNdaiUfPwN39g3A4GpyMDqr53dHu+sUOM3TRAl4MbE
         eCxgvKvAqBkm3RWkMHH+qIfRBd1DnO4N+bHg/8/1CiW1Sr2eArQDT5cOXjCQ0EC1tQG4
         jNfw==
X-Gm-Message-State: AOAM532CAyciC3XVs558IG7JIlH/kovPOvZA2MxVFCS7Xpk1ZVXMkKqy
        O3qekl2BxqhGs8qGkxTkrF1C3+5DiCnqcabIpiW1jh5RmbMFjre9/WGWW1kDAG5KjQHA5IdHgC4
        icBlMebmc1dfG7nuG22CkgFWg
X-Received: by 2002:a05:6e02:1988:b0:2cf:691e:2a8 with SMTP id g8-20020a056e02198800b002cf691e02a8mr18862906ilf.54.1653575403299;
        Thu, 26 May 2022 07:30:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPSo8mF4mfBm24d7gUVoJ7UmeRwfK10RCCWWPovTs2cnyg4+iIr+dbQG+UmCYbdmiabpUN6w==
X-Received: by 2002:a05:6e02:1988:b0:2cf:691e:2a8 with SMTP id g8-20020a056e02198800b002cf691e02a8mr18862894ilf.54.1653575403028;
        Thu, 26 May 2022 07:30:03 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id l10-20020a92700a000000b002d1d3b1abbesm520825ilc.80.2022.05.26.07.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:30:02 -0700 (PDT)
Date:   Thu, 26 May 2022 10:30:00 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH] KVM: x86/MMU: Zap non-leaf SPTEs when disabling dirty
 logging
Message-ID: <Yo+O6AqNNBTg7BMY@xz-m1.local>
References: <20220525230904.1584480-1-bgardon@google.com>
 <a3ea7446-901f-1d33-47a9-35755b4d86d5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3ea7446-901f-1d33-47a9-35755b4d86d5@redhat.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 02:01:43PM +0200, Paolo Bonzini wrote:
> On 5/26/22 01:09, Ben Gardon wrote:
> > +		WARN_ON(max_mapping_level < iter.level);
> > +
> > +		/*
> > +		 * If this page is already mapped at the highest
> > +		 * viable level, there's nothing more to do.
> > +		 */
> > +		if (max_mapping_level == iter.level)
> > +			continue;
> > +
> > +		/*
> > +		 * The page can be remapped at a higher level, so step
> > +		 * up to zap the parent SPTE.
> > +		 */
> > +		while (max_mapping_level > iter.level)
> > +			tdp_iter_step_up(&iter);
> > +
> >   		/* Note, a successful atomic zap also does a remote TLB flush. */
> > -		if (tdp_mmu_zap_spte_atomic(kvm, &iter))
> > -			goto retry;
> > +		tdp_mmu_zap_spte_atomic(kvm, &iter);
> > +
> 
> Can you make this a sparate function (for example
> tdp_mmu_zap_collapsible_spte_atomic)?  Otherwise looks great!

There could be a tiny downside of using a helper in that it'll hide the
step-up of the iterator, which might not be as obvious as keeping it in the
loop?

Thanks,

-- 
Peter Xu

