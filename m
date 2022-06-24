Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3700855A000
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiFXRkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbiFXRjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:39:44 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD8442EEF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:39:36 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 9so3032123pgd.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3ar/1+mLh6qwduTPDwnjCk+kxbN2oEHXoDxML/EcSVY=;
        b=tcm+JEo5h7ZP8844prP/5Eix8WGaHF02okroX9C2zMhuonNOxD9/QsJ8wQuQn9k6Xa
         AhuQxb1zIqms+uifDfo0h3BsqkDOHF0G1Qtce9E0EyHcPBIcUP3Jc6VKG1akTgw18Y0V
         EvR5qpeCVeVFSoEpTmceZuKK1+HPTs1xDMuZnH1ZSP0v/Ch25bMD/av/T/wz/pKZE/yY
         ZWhBMlLBG2nWojl8WqklNmq+oygQj4OU6PCi09vYmmDrwjLc6QUisbEB8qqrbT/lHWBN
         pRjfRIzG+1ITpQzaRkaqfPbUX7kYX6+szr8+Nq63cRHmoonjK2J5tZomCx1hrrpG77im
         5AWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ar/1+mLh6qwduTPDwnjCk+kxbN2oEHXoDxML/EcSVY=;
        b=eG/5ix/+PIVEGyRbypbFmtOqmQtj9ytHRzHcBvdHS+b1uEe/9rpe8lr/lfpv19q6ve
         p4LFDwNCqtXJwGfG4chH+b2IM/8bnEVTCCD62zyC5s+Fa5KFoCTCV8rERmoafvBQEmBH
         GzC1y+d/yZGo4pqB86ukuQ4C3aeOiZIFKnk4Dc5sMpQBB9df1ZqAzTJ6wYO8osuEWdpk
         lJr1UMNrO22rncUmepqmNtnEyjCJhUu8E8PMoinc4EIKtYwKQyWfFp94vDZRRaeWtxPC
         w/PfnVvkGXPDh5hu7IYSc5Mz7xvEm3607fA9NxP3v436X7LUMvovWgTQM4s4UAJ0h52Z
         F3/g==
X-Gm-Message-State: AJIora8+fsLP2/wI5ixq8wzql461AI0gXnX+gfvvzsIxf1/ICY50w3fN
        22+ca2EeU8cSyb+l0vGqKNO03nQfBmDi2A==
X-Google-Smtp-Source: AGRyM1vAYyA7QxGT8j8Ts1o26PFmFwdcra8ehtzV59gyWJSY9IqKpep++KGtW4PhKpcIVvmAhKGGBw==
X-Received: by 2002:a63:ae4a:0:b0:40c:2d48:5fda with SMTP id e10-20020a63ae4a000000b0040c2d485fdamr14027pgp.434.1656092376024;
        Fri, 24 Jun 2022 10:39:36 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id s15-20020a17090a764f00b001df4b919937sm4193027pjl.16.2022.06.24.10.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:39:34 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:39:30 +0000
From:   David Matlack <dmatlack@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] KVM: x86/mmu: Buffer nested MMU split_desc_cache
 only by default capacity
Message-ID: <YrX20hfudgMQ/6ns@google.com>
References: <20220624171808.2845941-1-seanjc@google.com>
 <20220624171808.2845941-4-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624171808.2845941-4-seanjc@google.com>
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

On Fri, Jun 24, 2022 at 05:18:08PM +0000, Sean Christopherson wrote:
> Buffer split_desc_cache, the cache used to allcoate rmap list entries,
> only by the default cache capacity (currently 40), not by doubling the
> minimum (513).  Aliasing L2 GPAs to L1 GPAs is uncommon, thus eager page
> splitting is unlikely to need 500+ entries.  And because each object is a
> non-trivial 128 bytes (see struct pte_list_desc), those extra ~500
> entries means KVM is in all likelihood wasting ~64kb of memory per VM.
> 
> Link: https://lore.kernel.org/all/YrTDcrsn0%2F+alpzf@google.com
> Cc: David Matlack <dmatlack@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Thanks for the cleanups!

Reviewed-by: David Matlack <dmatlack@google.com>
