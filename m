Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EEF51FC35
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiEIMLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiEIMLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:11:36 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02517F7C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 05:07:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h29so23425361lfj.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 05:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hz3zG1O/2dJnaL0QRSc1BWnr4Oj4kSB/rZ/+LbRoQNo=;
        b=HdD8N5grafzdCe33CeRKQJvrcU29ZFh4YJE3ipN+hI/kD/xf6bVomPvC2YyRkdduzw
         seFgw/J3PAdFjodA2jhLq9eafg7HXuy5e0I8alCtityGQ+244GYkSm9tXadNbZngJFW/
         ZiNHCkqyCi+U7bmqxjLhjtDWtP12gZeJFI2+1pPxUFaGKG1MAeQ5ixelX5iCgArN4dOu
         lP4QykvJVm0+Yte69KSDGbP1oXXa0L5TxGf8bVMgBrVFewYU5O45Wsx6OxaxW7aoh0IY
         /e2kgbe7gjDEmM2ZTK3UXbA6wJ8mEIraGqJDDBPB52n1wTblbqbw5SB7iTqjLrhnp1Kb
         Vyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hz3zG1O/2dJnaL0QRSc1BWnr4Oj4kSB/rZ/+LbRoQNo=;
        b=tyxD3ck/hP4+Bb2VQp5ldPsguia+2mxkiTCfpmIY8AdP9Q2K0ZWyE41sS6kLAoZpfF
         6oim6B23wO4RfH17h5rebWirsO1PMYFweban2n4KC9bBDlk1B5X16FezeQZlZBBAwX39
         pCYht8FTdFZBtluMPtJR3jbdMESGhkoP+Tt2c6I3Jx5kgc/FfVLxe1H3mVBhVQlxnoXj
         X6LbvDm4u0kzANkAV5oE5Yj20JCmO4fFLWK2SJTxsuJi25rZ4kmRWBHEfT3tdK3nB8CE
         wst0ppGlnYjLgQwStAGynHKZtZ9faoFu6CJfXOwxi3LiN1gEnlqVMem7foR3Ee9vE+T+
         l5ng==
X-Gm-Message-State: AOAM5302ItgsoK7gH2rotOmQ/93SIMSG5zJEFf8/Cv9AZDxB/zufECdu
        yYcjvPuWhsUEM1Xa3mQi9pGhqQ==
X-Google-Smtp-Source: ABdhPJwQM6U2NgGWtVQ07fnwW0qXKObLQlxYMDL5CCNjEwY0pTkUTytCkOqEuvDXVv17RWPqX8jdkA==
X-Received: by 2002:a05:6512:13a7:b0:447:3dac:7a03 with SMTP id p39-20020a05651213a700b004473dac7a03mr12797757lfa.362.1652098060361;
        Mon, 09 May 2022 05:07:40 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p7-20020a19f107000000b0047255d211cfsm1913325lfh.254.2022.05.09.05.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 05:07:39 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 39CBB10446D; Mon,  9 May 2022 15:09:27 +0300 (+03)
Date:   Mon, 9 May 2022 15:09:27 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Kai Huang <kai.huang@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Message-ID: <20220509120927.7rg6v5pyc3f4pxsh@box.shutemov.name>
References: <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
 <58d07b2d-cef5-17ed-9c57-e12fe5665e04@intel.com>
 <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
 <2ed5c9cc316950a5a47ee714715b7980f358a140.camel@intel.com>
 <ab17102c-0cb7-87d3-3494-969866d64573@linux.intel.com>
 <d53696f85ada39a91a3685c61d177c582810772e.camel@intel.com>
 <d63d2774-c44d-27da-74b6-550935a196fd@intel.com>
 <dca06ffa36abe9989f0a7abaeafc83c1a7250651.camel@intel.com>
 <20220507004236.5p5dyksftge7wwr3@black.fi.intel.com>
 <45d184273f1950320843f6696eb3071f7d354fd3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45d184273f1950320843f6696eb3071f7d354fd3.camel@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 03:37:22PM +1200, Kai Huang wrote:
> On Sat, 2022-05-07 at 03:42 +0300, Kirill A. Shutemov wrote:
> > On Fri, May 06, 2022 at 12:11:03PM +1200, Kai Huang wrote:
> > > Kirill, what's your opinion?
> > 
> > I said before that I think DMA API is the right tool here.
> > 
> > Speculation about future of DMA in TDX is irrelevant here. If semantics
> > change we will need to re-evaluate all users. VirtIO uses DMA API and it
> > is conceptually the same use-case: communicate with the host.
> 
> Virtio is designed for device driver to use, so it's fine to use DMA API. And
> real DMA can happen to the virtio DMA buffers.  Attestation doesn't have such
> assumption.

Whether attestation driver uses struct device is implementation detail.
I don't see what is you point.

> DMA API has it's limitations.

Could you elaborate here?


> So I don't see why TD guest kernel cannot have a simple protocol to vmap() a
> page (or couple of pages) as shared on-demand, like below:
> 
> 	page = alloc_page();
> 
> 	addr = vmap(page,  pgprot_decrypted(PAGE_KERNEL));
> 
> 	clflush_cache_range(page_address(page), PAGE_SIZE);
> 
> 	MapGPA(page_to_phys(page) | cc_mkdec(0), PAGE_SIZE);
> 
> And we can even avoid above clflush_cache_range() if I understand correctly.
> 
> Or  I missed something?

For completeness, cover free path too. Are you going to opencode page
accept too?

Private->Shared conversion is destructive. You have to split SEPT, flush
TLB. Backward conversion even more costly.

Rule of thumb is avoid conversion where possible. DMA API is there for
you.

-- 
 Kirill A. Shutemov
