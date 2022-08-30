Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778315A7126
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiH3Www (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiH3Wwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:52:46 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E327696E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:52:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f12so12324210plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=50GcGtwxII56nR8Ve/iTsX8Cys/NHgWdZqTmv1JFSDY=;
        b=r8s7Zc5fnGQyyyCCB5WN6HBXRgA0/I9WQQfHM0dFlq4Kf1xPYAzRarv6YXb8oAxOGH
         XO4uMxrOlmUR2UgFdapMx5k8S/KHHzdLNdWKtidmKFk+LJlYMLMNLfdOWM7Z6mMF7SLs
         ipMHHcwpuswr6yKjXh7WNScCsbjMl32cesIh9pRG20EyAPlIELuGz2hACSHfZcmYDVCh
         VZmpY4wwqIcfMR8zUJCjdS6ZVpS0moVN3GNZJ86o3rPXxcdvbDw7VUuSIrrWbqpU5Ar4
         r7ZGk+Ba59oqXv9zp7SaMwX0u6gr+eBRySZ2gFPzpVwOROUyScgoKYG/wqM3P72wLjwL
         o5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=50GcGtwxII56nR8Ve/iTsX8Cys/NHgWdZqTmv1JFSDY=;
        b=vdPYAqE6GcJVjluOxkqWJESPqaAaR6IYtO3XyGdiZyacm4tfbocsTX4DWKoXKE6Z/H
         7qozeFmA3LZywAVxq1NapIfNgYGelfrOU7D9Siy8WqUBRJcjs30V+zesqGoecRAOfC/C
         V0z2aoRNnqLI/jnvPFZQEJsqrYlBZrqb2PgC8bXJHYtISYnWwkiPpLqJMCxLVD0YjUZh
         Bj3liJVK3V7NtZBYxZPLmUPRZWW2lhfGkmblLzXrYtynWy4Owb9zPJr7D7xjwwa3SodK
         Mw2YeOOlSDW8FSoPMTkhNbxVT8EqzVr0ifL/bTNw8HqLni9L5BmOy7Yw99957PBcWsjd
         JlnA==
X-Gm-Message-State: ACgBeo1HFydvAyqS5+WE6eL3VQEtW9hag0pY7Z/n6ou67ddHXtXEL6p3
        11k+mROGxD9IoXnhJK8MV5N+QQ==
X-Google-Smtp-Source: AA6agR4jUalQikRhi6sA4/IvdPGRz4uX8g+OW73SgOmAyijpEnGvNgIKwc9VoJqgs2ApD8BtveGOlg==
X-Received: by 2002:a17:90b:4f4e:b0:1f5:8a65:9192 with SMTP id pj14-20020a17090b4f4e00b001f58a659192mr263060pjb.224.1661899964563;
        Tue, 30 Aug 2022 15:52:44 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id o3-20020a656143000000b00427564b6b57sm2164222pgv.7.2022.08.30.15.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 15:52:43 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:52:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kvm: x86: mmu: fix memoryleak in
 kvm_mmu_vendor_module_init()
Message-ID: <Yw6UuGqIF1op5zYp@google.com>
References: <20220823063237.47299-1-linmiaohe@huawei.com>
 <Yw6DsUwSInpz97IV@google.com>
 <e1199046d184ad7210ebb100fc2f4b77d1ef4fba.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1199046d184ad7210ebb100fc2f4b77d1ef4fba.camel@intel.com>
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

On Tue, Aug 30, 2022, Huang, Kai wrote:
> On Tue, 2022-08-30 at 21:40 +0000, Sean Christopherson wrote:
> > On Tue, Aug 23, 2022, Miaohe Lin wrote:
> > > When register_shrinker() fails, we forgot to release the percpu counter
> 
> > > kvm_total_used_mmu_pages leading to memoryleak. Fix this issue by calling
> > > percpu_counter_destroy() when register_shrinker() fails.
> > > 
> > > Fixes: ab271bd4dfd5 ("x86: kvm: propagate register_shrinker return code")
> > > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > > ---
> > 
> > Pushed to branch `for_paolo/6.1` at:
> > 
> >     https://github.com/sean-jc/linux.git
> > 
> > Unless you hear otherwise, it will make its way to kvm/queue "soon".
> > 
> > Note, the commit IDs are not guaranteed to be stable.
> 
> Sorry for late reply.
> 
> The commit message has "we".  Should we get rid of it?

Avoiding pronouns is obviously my preference, but sometimes even I set aside my
crusade to move things along :-)
