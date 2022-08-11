Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8F4590560
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiHKRHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbiHKRH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:07:26 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD581EE4B0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:38:37 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o3-20020a17090a0a0300b001f7649cd317so5947558pjo.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=0aap4m9FUFBg/Ck6ulQO4i68xyODxi6/OEgWktBCFIo=;
        b=ZWES7YPHfHmU00wghrkUSvu/rjn2KatbZYn83g1Y7WJAtnSX9KhLGv3513/3F0lkqm
         uY3qucroAiZH2LwqIJbSmghTBztDRXah1t/EeaLAGbntEUvFu2HQyPrJN5BBgBcGv6/k
         +iElUgubsqwbHZPYODQTpK/unh+ebNdat05MwwpwqTiUOsTYx+4B9l/2XoLgPtSWTG0Q
         oMITC8RgGl2VqsRIdxutIPqvKO8iXiXwvCn4jr0jHfQMVIE0T5xyw/nQV1vXavuI985I
         lfR33TyyFcDSSWCqH/ZbVQjV3Krp9oyFMOyaYxBvq+dkUEv7rMFoDzHd8SsCo8k/oGmt
         gt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=0aap4m9FUFBg/Ck6ulQO4i68xyODxi6/OEgWktBCFIo=;
        b=lF3eUc+kd6BVTs3HUQGDPZMlvX6wzWMcE7ZVEE53ayURBEMuM2ihthEI+Lla5Ixm4W
         K9l/cEOVkbahl2f5xvq2i/7zSf0vZNKsw5zpGwvSgOuW1X41IUYPAjSgyksVogGsnrIq
         eJWdbH/DkEdwsqIrRcRO0D4lFITSCmABjkG1mVP20dGkgkMl54hnw1sviIlydpD1vNYW
         2cUopY8X5ncuKNz4Mmmg3QjYSmhsoVnKtUza8KMkjsDdHdoFNVT6XJukNF8V8XrHMQnT
         b9sBrHV6KuOWs1p3PJYYFn44qSGUbUQPKWac27MRU6lfqn9sRDnK2tIpk5HEALOWK2bg
         fUeQ==
X-Gm-Message-State: ACgBeo0799EGgRhsCX4ECr9WXNNCGiU4jd+TEiHXOx9pRQjEuYAi57q/
        XDPQYCvzS3E1pIB+hh5w7XtrdA==
X-Google-Smtp-Source: AA6agR6UGcw67lr1XeWC8q2k9BvMfaHqMJZcQXZSQmFSx0o3KbnF6dEQFwQrVI4Nd8+mqKgyL2KnRw==
X-Received: by 2002:a17:902:740c:b0:170:c27d:9cf with SMTP id g12-20020a170902740c00b00170c27d09cfmr31241pll.117.1660235916192;
        Thu, 11 Aug 2022 09:38:36 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d2c100b0016f09d217c1sm15285910plc.281.2022.08.11.09.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 09:38:35 -0700 (PDT)
Date:   Thu, 11 Aug 2022 16:38:31 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI: dwc: drop dependency on ZONE_DMA32
Message-ID: <YvUwh1mFpB2WEWdw@google.com>
References: <20220809180051.1063653-1-willmcvicker@google.com>
 <20220809180051.1063653-2-willmcvicker@google.com>
 <YvTJzTpsWlEizEX3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvTJzTpsWlEizEX3@infradead.org>
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2022, Christoph Hellwig wrote:
> On Tue, Aug 09, 2022 at 06:00:49PM +0000, Will McVicker wrote:
> > Re-work the msi_msg DMA allocation logic to use dma_alloc_coherent()
> > which uses the coherent DMA mask to try and return an allocation within
> > the DMA mask limits. This allows kernel configurations that disable
> > ZONE_DMA32 to continue supporting a 32-bit DMA mask. Without this patch,
> > the PCIe host device will fail to probe when ZONE_DMA32 is disabled.
> 
> > +		dma_free_coherent(dev, PAGE_SIZE, pp->msi_page, pp->msi_data);
> 
> Isn't msi_page a struct page * which should become a void * now?
> 
> Otherwise this looks good and is what the driver should have done
> from the very beginning.

I've updated this in v3 to use dmam_alloc_coherent() and dropped msi_page
since it's not actually used. So this block is dropped now. Thanks for
taking a look though!

--Will
