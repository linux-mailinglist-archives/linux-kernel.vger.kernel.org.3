Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BF848C397
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbiALLyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240322AbiALLyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:54:40 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D80BC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 03:54:39 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l16-20020a17090a409000b001b2e9628c9cso4218452pjg.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 03:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LT0CPQ4LjGQda0r31DVagHWPW/WMPcFrzJQSM8nEMzY=;
        b=XXHml25tt60drO39EtR8zK5L1Iz7/ByCY2ePEkE6ZC3/SXcRL8eYBBAc5Z2o4STa6Y
         ERzQII6QW51u9O72XmVQdBn10hSPBEirs/WSNZynh0UdcWJaYwiOMFNQYGeYQzk4BB0Q
         H0MtQWV7t5ww1dfQ0ulV1KsNttsDxZsgbJOmc4CP+2kpyEPvmfdpmmuIdbTWFY78lwp6
         i4YoMn8EhjD+Eq7sqPjs5fFmEcqo7C42qJpNWQ9aQyilQA98CgaB2sTZw0KTSKX3VdSj
         3DMq7SKJeDzCIwCTdsZY9yg3ZHrfcth7njtWIwbn1QEu1TrEepKOO3h5MhujyOF7o6MF
         l4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LT0CPQ4LjGQda0r31DVagHWPW/WMPcFrzJQSM8nEMzY=;
        b=Lj1aY5Y0jZfC3M7Qo2Tf8hdibekJWzNUNwt5ANtpBVq8AVhFJgDfkXZ8sMMjq4QQmJ
         +voadqB5Gmqrd4D0agAxU3eHzVEiTroI8cfF0251wQOpeDginn15MCchMWZo7xvKtnSW
         VSR9tpApuaR9GYj7s8vDEuhpZNqjwQNSBJ7VpdKFa8MA0YGyr4XQCP/do4irAsTZvXDE
         fFh6Mg70uK8FUo6ZMnhDB2tiwWAjZwLYtKfrU3QdEnib5SrZRf3hmrN0KFSH88k3nzUL
         CUmO5C4xca7DAfS5VRX0L/0R6A+1dcFST7kUMnwMg6hvxWl/jviq0SOGdBRNLv8vjWzb
         WMHg==
X-Gm-Message-State: AOAM532gDKVchfJpDpTTeoVoMD8h/t+T6gt/Br8ui0+WYD/haEJoDoWC
        gOynCoCgLUQg6RUqNuUBCxtNGZkkskqchXGzLQw=
X-Google-Smtp-Source: ABdhPJwJYlKnZr2PrQgseAYhkwhTlfxEl3/6t8ytnMogoOwa6qEIpKivSILXXDn61XzZIX3rkM/WJw==
X-Received: by 2002:a05:6a00:2151:b0:4a2:5c9a:f0a9 with SMTP id o17-20020a056a00215100b004a25c9af0a9mr9073381pfk.39.1641988478895;
        Wed, 12 Jan 2022 03:54:38 -0800 (PST)
Received: from VICKYMQLIN-NB1.localdomain ([159.226.95.33])
        by smtp.gmail.com with ESMTPSA id r11sm13791398pff.81.2022.01.12.03.54.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jan 2022 03:54:38 -0800 (PST)
Date:   Wed, 12 Jan 2022 19:54:35 +0800
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Suman Anna <s-anna@ti.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Nagalla, Hari" <hnagalla@ti.com>
Subject: Re: [PATCH] iommu/omap: Fix missing put_device() call in
 omap_iommu_probe_device
Message-ID: <20220112114851.GA712@VICKYMQLIN-NB1.localdomain>
References: <20220107080428.10873-1-linmq006@gmail.com>
 <de3a3e1c-6c51-e951-cc7f-9ce2ccb3f283@ti.com>
 <20220110022531.GA61@VICKYMQLIN-NB1.localdomain>
 <fd659736-2106-1be3-084b-7caddf2dc18e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd659736-2106-1be3-084b-7caddf2dc18e@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

On Mon, Jan 10, 2022 at 12:43:57PM -0600, Suman Anna wrote:
> Hi Miaoqian,
> 
> On 1/9/22 8:43 PM, Miaoqian Lin wrote:
> > Hi Suman Anna,
> > On Fri, Jan 07, 2022 at 08:42:16AM -0600, Suman Anna wrote:
> >> Hi Miaoqian,
> >>
> >>
> >>> Add the corresponding 'put_device()' in the error handling paths.
> >>
> >> Also, need it in the regular path, not just in error handling path.
> > I think after calling platform_get_drvdata() normally, the
> > reference will be released in other functions, so don't need it in the
> > regular path.
> > 
> 
> No, it's a local reference and is acquired within omap_iommu_probe_device() and
> needs to be released within this function. What other function are you referring
> to here?
> 

I am referring to the release function of this device, here is
omap_iommu_release_device(). But I find omap_iommu_release_device()
doesn't handle the reference, and calls kfree(arch_data) directly.


