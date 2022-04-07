Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970114F8777
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347029AbiDGSzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347015AbiDGSzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:55:10 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C461C1A61EB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:53:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b2-20020a17090a010200b001cb0c78db57so4018289pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 11:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fo8H0nueaNQYXwWnR45P7t5f76HXHtUbYfyWixIMmlE=;
        b=JsJlMpiGtFmkZgy4GJuW5lseB6CTBRKy/rEjOi8S+RErpYdPJ8RRgcUb6HDMZUrBm5
         2gEN4xzT2U5zrXi9C7cR851g8OpVT5hFqC7tGGDVCZzGaSiBBdhDrv9EseeGzlTxiw+O
         3D4bRw0b1ExTl3K7CtdJeH9BvfoV/9+H40a7bTTDt7n4S6K9oRGNtGpZyTlhGc16GA3e
         B7HQGjGWKVkTzWPmEqV35doo/s3YLH00vEHd1c+B0smSSxuEYEQpH0qA2ET+TQXW+l3k
         +KA3KQClJ7mP967Lm0W+0mj4VqX0S8V3P3SZYH6KG9FLu2YFjaE7Z3bsgu9M9thvQqpL
         qTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fo8H0nueaNQYXwWnR45P7t5f76HXHtUbYfyWixIMmlE=;
        b=R1aNWwE0RG6fGaLRSq0vW9wKwLPxUFkaTt/GHH+9atMrlg8o1VhLZkVkwXq+48QJaw
         GEMNAPvjNbp5aTGD5hD5dbh+z69zYEbdn2+ifTp/WNeyn25fBcNdu55XEhk+9dNbb3bR
         /SgmtcYp2aLX2JkUSudVxZmZKiYuK44uhSf+2loDe7W9/ia8K34vX7eA0IFUyBIbNdWl
         IHQdfZd3LZFzlI5KEDkOwNuBaH2s29q4JPDs5rPHXZNHiKrxfpS3UAau+pWxiUP31DYM
         SlUzyb6CaX9AAI3fSJx+NsTik46Lw/ozIv+hnSf0aKsA2dggkNq8l4Xpeh09AWDMyMOM
         VrJQ==
X-Gm-Message-State: AOAM532ivGp6Ghzt35phX41BRqhr6KPxk1W8XZg/AVpvAhbgNBlDXcio
        p+11L9pMYZk16N06XkX7jDeH9w==
X-Google-Smtp-Source: ABdhPJz0T9pgM9gCM920WkqRVIxUwAdECBXyHMvc+e0iyeiTlQdl6DQcPBPzt1KRn6MBTnsG7bVsEQ==
X-Received: by 2002:a17:90a:488c:b0:1c7:b62e:8e8c with SMTP id b12-20020a17090a488c00b001c7b62e8e8cmr17356008pjh.157.1649357589115;
        Thu, 07 Apr 2022 11:53:09 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id bg13-20020a17090b0d8d00b001caa8f51098sm9456904pjb.9.2022.04.07.11.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 11:53:08 -0700 (PDT)
Date:   Thu, 7 Apr 2022 18:53:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 00/30] TDX Guest: TDX core support
Message-ID: <Yk8zEN9bZKiQltcL@google.com>
References: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
 <b43720c6-0763-f4bb-64a0-7745c6ad920a@intel.com>
 <Yk8WZn+etpj/o0OM@google.com>
 <20220407174744.cskt3rg63io4lkug@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407174744.cskt3rg63io4lkug@black.fi.intel.com>
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

On Thu, Apr 07, 2022, Kirill A. Shutemov wrote:
> On Thu, Apr 07, 2022 at 04:50:46PM +0000, Sean Christopherson wrote:
> > On Thu, Apr 07, 2022, Dave Hansen wrote:
> > > It would also be really nice to get some SEV folks on the list as
> > > well.  I suspect the coco/ directory will grow more common SEV/TDX
> > > code over time.
> > > 
> > > X86 CONFIDENTIAL COMPUTING
> > > M:      x86@kernel.org
> > > R:	Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > ...
> > > S:      Supported
> > > F:      arch/x86/coco/
> > > ...
> > 
> > And/or a dedicated vger list?
> 
> We already have linux-coco@lists.linux.dev. Although, it is not
> x86-specific.

Is it ok to spam that list with TDX/SNP stuff, or would it be better to create
something x86-specific?
