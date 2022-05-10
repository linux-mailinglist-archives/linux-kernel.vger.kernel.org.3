Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97159520AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 03:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbiEJBct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 21:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiEJBcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 21:32:48 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C664828202F
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 18:28:52 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id m23so19097175ljb.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 18:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KvsYgset45myBW8qA4NZQkt2vsRPsWbkOZTPZ8B0QZs=;
        b=EJOcwMNhJhZ5IsTE/SrqEyOG5DXsWPDja6JwALHOzhsywHYbKQfw/yAL1WPXwHr8Oq
         PtBWNPli66lh/BLwgJ9RITIj9y61VbJQItVH58HAsfRMXdMOiAAWo69fPdIo+55RVm5r
         rrN93WjCILcdpaVFwbK4ochwIDbMVqJQaLrzNZ1btEdbnlTEPzjJmWjI7GN1dbdvZTkx
         TsQOL7eHqN6VOc35W4SJgeqVtcS++l2vHczg5UwUoSVCJMIJZmeu4Ur/5vsEP/OV4zPn
         mMBwBe7o/iiNW6fySALgeIXM2wcioj1jV2t+vWSLDQ1eTBk0HLFG/YkCvHly6om3nVJ/
         SX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KvsYgset45myBW8qA4NZQkt2vsRPsWbkOZTPZ8B0QZs=;
        b=isqb07/vFd8qnECrKC0yHSADLeIANskmNLU5xv3SuSRgraI5B9MkNDICRVgBCushkS
         y++1Ut1MXD4+Sf6WW0h+fm82DANpO7IvVIjeK9DwxRX9O6WZQq1eWPun3fLBF1VqiEbV
         4Kx42xCUzdqB+7ghiUZexifMSaCoznXqFwjok1eU0SfOOhleLe+uumQ0X3QiW5eDvh30
         MmZZuK4ZEP1OoUHLmp9r8bGA3AnU3FlU+c8a5XBaHNvCnzpd/aj54549mjgnSz5HlLHJ
         xTjuBryM6+JnUZTQXuhA/ZOoX3XLCfZEevLTUJdlMJi+WxXDz8x/EcWGT7tKNv55D+vn
         mUmQ==
X-Gm-Message-State: AOAM530hq4oGCUFG9/Zrrq+MHtDezJHCx0p3QpnyVvlqd/aOweem4SuI
        DHrHe16ZQk/CFnFkX4Fnj1DU4kp7NsUSnjwq
X-Google-Smtp-Source: ABdhPJwqvBmGPTHTUUieU71G7SakyCdLYM2OuHn7lGWU7+9YrHtQfGQgAp3pviejLtX6pl5FP/Q/mA==
X-Received: by 2002:a05:651c:a09:b0:250:628a:e7d0 with SMTP id k9-20020a05651c0a0900b00250628ae7d0mr12506962ljq.66.1652146131132;
        Mon, 09 May 2022 18:28:51 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l26-20020ac24a9a000000b0047255d21130sm2115301lfp.95.2022.05.09.18.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 18:28:50 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A08D6104ADF; Tue, 10 May 2022 04:30:38 +0300 (+03)
Date:   Tue, 10 May 2022 04:30:38 +0300
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
Message-ID: <20220510013038.ggubvsrwf7pyoamk@box.shutemov.name>
References: <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
 <2ed5c9cc316950a5a47ee714715b7980f358a140.camel@intel.com>
 <ab17102c-0cb7-87d3-3494-969866d64573@linux.intel.com>
 <d53696f85ada39a91a3685c61d177c582810772e.camel@intel.com>
 <d63d2774-c44d-27da-74b6-550935a196fd@intel.com>
 <dca06ffa36abe9989f0a7abaeafc83c1a7250651.camel@intel.com>
 <20220507004236.5p5dyksftge7wwr3@black.fi.intel.com>
 <45d184273f1950320843f6696eb3071f7d354fd3.camel@intel.com>
 <20220509120927.7rg6v5pyc3f4pxsh@box.shutemov.name>
 <75d4755c9a376df2e98a267e10e60da3bd178b17.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75d4755c9a376df2e98a267e10e60da3bd178b17.camel@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 11:54:12AM +1200, Kai Huang wrote:
> On Mon, 2022-05-09 at 15:09 +0300, Kirill A. Shutemov wrote:
> > On Mon, May 09, 2022 at 03:37:22PM +1200, Kai Huang wrote:
> > > On Sat, 2022-05-07 at 03:42 +0300, Kirill A. Shutemov wrote:
> > > > On Fri, May 06, 2022 at 12:11:03PM +1200, Kai Huang wrote:
> > > > > Kirill, what's your opinion?
> > > > 
> > > > I said before that I think DMA API is the right tool here.
> > > > 
> > > > Speculation about future of DMA in TDX is irrelevant here. If semantics
> > > > change we will need to re-evaluate all users. VirtIO uses DMA API and it
> > > > is conceptually the same use-case: communicate with the host.
> > > 
> > > Virtio is designed for device driver to use, so it's fine to use DMA API. And
> > > real DMA can happen to the virtio DMA buffers.  Attestation doesn't have such
> > > assumption.
> > 
> > Whether attestation driver uses struct device is implementation detail.
> > I don't see what is you point.
> 
> No real DMA is involved in attestation.

As with VirtIO. So what?

-- 
 Kirill A. Shutemov
