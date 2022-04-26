Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9A0510499
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353325AbiDZQyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242264AbiDZQxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:53:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E7E3F89A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:48:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id m20so16548534ejj.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D5d/UcR8WWtwm14ZrH9Ny0PXpXXCcP8eFt6zg75qTSg=;
        b=yMnq6FHdIFP459zaK7zNPCwuRcpBpup0Y1hoR3dAu5PPSw7HQd07CTlTZ9YCPonIId
         ZQAGvu+x/52Q9qIGRZmn19hqTyWABcsgcKEFHr0tOLHNk1zKpB/zVNVwnUr6cfv8iGoM
         4eUW78aeT6k0GqobuS7hJJxguXWLDkQCn2gZakfxyOQYb6z8z1t51xjefG3z7RCOVXRN
         ll2reAII6TC0sdef0SoidM2Fp2/WFZp+kA4p09I3WY8dyGRV1vfNz4aInSOfOlO/7eM6
         8cWAp66JfasHp/hw7TWyXOglVjWCSUPvzyOs6OaeoBWH6Ez0psTrqiAs4XVQ9AL79CgC
         PzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D5d/UcR8WWtwm14ZrH9Ny0PXpXXCcP8eFt6zg75qTSg=;
        b=4viuqI1iphXzAnALKri69fC6WPHpvAOC5T2//j8GcvMb3FSt90RqctwqRZTO+pOaWh
         8vKlGarZfTpD76vVJGXQv74OE2lb9NRWKmdWHUvRZOAxnHwrVbeaPUiry5FBleR64E4I
         8bLht3QhdVQOb6wvlDZ2dMl95+kmkp76Jj0mj2gmEXSoQo3Z6163qO/j2tGpdeyAGuQC
         erBFLwinxCd1z1MR2OZgICHAnrQZanfdisJAro8YrHGhoBS/boqimNnUXSZ6jvruo2BG
         sPIyofpUVKuSlqfZKyU8LRbLhxwWIO8iQvfCxcsDESMvnLpfXpSGkCGTZ10C1+ChJlT1
         PCoA==
X-Gm-Message-State: AOAM532T4axLLcShG5afg1UAxY6+sj+jNctpekU6ZTvXbMCc5Pyur+zU
        IWpq2X6iogjfa9VcVip8Bun96w==
X-Google-Smtp-Source: ABdhPJzrAtI4rer1zqBksVvk+bjUCWF1lDnl3p29wyqsYQRedTzX6mxZ5ycXF9qp5uSxW7pEKXAXew==
X-Received: by 2002:a17:907:868c:b0:6f2:d939:630c with SMTP id qa12-20020a170907868c00b006f2d939630cmr19937985ejc.211.1650991708641;
        Tue, 26 Apr 2022 09:48:28 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090617cf00b006f3bf8e69absm133895eje.5.2022.04.26.09.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 09:48:27 -0700 (PDT)
Date:   Tue, 26 Apr 2022 17:48:01 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        robin.murphy@arm.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YmgiQZZyFxsJ+9um@myrica>
References: <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica>
 <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com>
 <YmbO/l5IwfBCHrl8@myrica>
 <8c044e49-74bb-df56-8a60-663013c0910e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c044e49-74bb-df56-8a60-663013c0910e@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 08:27:00AM -0700, Dave Hansen wrote:
> On 4/25/22 09:40, Jean-Philippe Brucker wrote:
> > The problem is that we'd have to request the device driver to stop DMA
> > before we can destroy the context and free the PASID. We did consider
> > doing this in the release() MMU notifier, but there were concerns about
> > blocking mmput() for too long (for example
> > https://lore.kernel.org/linux-iommu/4d68da96-0ad5-b412-5987-2f7a6aa796c3@amd.com/
> > though I think there was a more recent discussion). We also need to drain
> > the PRI and fault queues to get rid of all references to that PASID.
> 
> Is the concern truly about blocking mmput() itself?  Or, is it about
> releasing the resources associated with the mm?

The latter I think, this one was about releasing pages as fast as possible
if the process is picked by the OOM killer. 

Thanks,
Jean
