Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C95493447
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 06:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349757AbiASFUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 00:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346684AbiASFUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 00:20:36 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD2BC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 21:20:36 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z22so5546386edd.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 21:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vYx8eOAl4RT2Tv9sBT+HJ4x8t4tc97tFm9O/jaaTsa4=;
        b=lMCTWsEB0ae5lKyr2zSigr+qlpehucOGcjUdSD9WBJS4zbGUdEUaFdTyb6TZ8Ro2Nf
         bx/ARwE7fn70koy+fgEBx21aCQuDRd9gWVLWFbIraLqkGpD/QV1WhhSxzScZ2zLPyLPT
         eowq9hpmdo0viMA2FlFiEn/wJz3/DsOtQLBd9Xx7EmQFEWon8ZIHRW5q3VONd8owVXgJ
         CN1afyCkLVDGp0Gh2t0sck8UzQrLPaQCFDvz2gMfwnpU5z1SMFalrl/d/7C5AvOXNAmN
         BiK89sFuSrJqcfXzTQ8bKAyGboFgzWft+tTZ/r69CtgTICcKlPU2LBGW+IETyenxWrzH
         eh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vYx8eOAl4RT2Tv9sBT+HJ4x8t4tc97tFm9O/jaaTsa4=;
        b=W0rBceTu0vMSrPa9ejydeSg9rKKUvmw2eOJ8D4WdkAX+JYgQhXmmAzfUep4qD7rNJc
         1rGBl4L2GyMK6ggqxR4bbBmqL5eLI6PnRf1mwMt75ZXUmVhW5MsXU09HZAnk/Nlcdjwv
         9n4lV/7PEDxVJCTKra6n/X/WX+VD7WeOOZiYBnwgBzPI9GLeSbih3P+96gWrbt08dOdw
         ioHgtBanHkCXDBaQBe3Ixtzi7fKQ/wKOYUGr3rvVSgrtncYu1r0AaGALZ6+/iwfPv8cK
         ZpeMzjd6Ib3/9RKpyBdJ/I6mFUCiuDt0QMQDKNrOPgMuTmlmLa3PtaWAvDAZZt6S1z9T
         mXsQ==
X-Gm-Message-State: AOAM532dLAHs92r6LaBG+05HTFThvaB29FBvKE6urWdD5n26dF1Hl2eu
        CP+LB8GSO6PaK9yBG6cxb92LBhymbx4IdHZ/ey51
X-Google-Smtp-Source: ABdhPJz3CUf8bptlBtB/rX4cA9kNcch4aFX9O6GXmTxDc7OOTbu7tnPbx1e+VZAqVphJa5qky+GqoytPQ4dz/XCa2HE=
X-Received: by 2002:a17:906:6043:: with SMTP id p3mr10929713ejj.667.1642569634075;
 Tue, 18 Jan 2022 21:20:34 -0800 (PST)
MIME-Version: 1.0
References: <202201171409.rqbXNHlz-lkp@intel.com>
In-Reply-To: <202201171409.rqbXNHlz-lkp@intel.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 19 Jan 2022 13:20:23 +0800
Message-ID: <CACycT3sWMCR4sqUvO28CAjBCvr6R3tFHO-ZR=hxkFN_hs6E=TQ@mail.gmail.com>
Subject: Re: drivers/vdpa/vdpa_user/iova_domain.c:305 vduse_domain_alloc_iova()
 warn: should 'iova_pfn << shift' be a 64 bit type?
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 12:44 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hi Xie,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   79e06c4c4950be2abd8ca5d2428a8c915aa62c24
> commit: c8a6153b6c59d95c0e091f053f6f180952ade91e vduse: Introduce VDUSE - vDPA Device in Userspace
> config: arm-randconfig-m031-20220116 (https://download.01.org/0day-ci/archive/20220117/202201171409.rqbXNHlz-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/vdpa/vdpa_user/iova_domain.c:305 vduse_domain_alloc_iova() warn: should 'iova_pfn << shift' be a 64 bit type?
>
> vim +305 drivers/vdpa/vdpa_user/iova_domain.c
>
> 8c773d53fb7b64 Xie Yongji 2021-08-31  287  static dma_addr_t
> 8c773d53fb7b64 Xie Yongji 2021-08-31  288  vduse_domain_alloc_iova(struct iova_domain *iovad,
> 8c773d53fb7b64 Xie Yongji 2021-08-31  289                       unsigned long size, unsigned long limit)
> 8c773d53fb7b64 Xie Yongji 2021-08-31  290  {
> 8c773d53fb7b64 Xie Yongji 2021-08-31  291       unsigned long shift = iova_shift(iovad);
> 8c773d53fb7b64 Xie Yongji 2021-08-31  292       unsigned long iova_len = iova_align(iovad, size) >> shift;
> 8c773d53fb7b64 Xie Yongji 2021-08-31  293       unsigned long iova_pfn;
> 8c773d53fb7b64 Xie Yongji 2021-08-31  294
> 8c773d53fb7b64 Xie Yongji 2021-08-31  295       /*
> 8c773d53fb7b64 Xie Yongji 2021-08-31  296        * Freeing non-power-of-two-sized allocations back into the IOVA caches
> 8c773d53fb7b64 Xie Yongji 2021-08-31  297        * will come back to bite us badly, so we have to waste a bit of space
> 8c773d53fb7b64 Xie Yongji 2021-08-31  298        * rounding up anything cacheable to make sure that can't happen. The
> 8c773d53fb7b64 Xie Yongji 2021-08-31  299        * order of the unadjusted size will still match upon freeing.
> 8c773d53fb7b64 Xie Yongji 2021-08-31  300        */
> 8c773d53fb7b64 Xie Yongji 2021-08-31  301       if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> 8c773d53fb7b64 Xie Yongji 2021-08-31  302               iova_len = roundup_pow_of_two(iova_len);
> 8c773d53fb7b64 Xie Yongji 2021-08-31  303       iova_pfn = alloc_iova_fast(iovad, iova_len, limit >> shift, true);
> 8c773d53fb7b64 Xie Yongji 2021-08-31  304
> 8c773d53fb7b64 Xie Yongji 2021-08-31 @305       return iova_pfn << shift;
>
> I feel like iova_pfn should probably be declared as dma_addr_t?
>

Yes, I think we need something like:

return (dma_addr_t)iova_pfn << shift;

Thanks,
Yongji
