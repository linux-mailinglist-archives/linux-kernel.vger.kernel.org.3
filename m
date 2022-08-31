Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA235A899D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 01:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiHaXw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 19:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiHaXw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:52:57 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EC2F14F0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 16:52:56 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id r17so1013957uat.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 16:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dB/Ygu4p0hlR5xc5n0QdJ7utzSAVujm8LkOKbdwdxZo=;
        b=TTZRTgyinQmb9tXu1/58oyS1vRReaulbY6sg+mYeCtxDE0gmiSTwGHJhnpoLo4rnol
         FEOqEvawWWLah6qOsOhxE0ZknAEMGZr5A2C1e2wCTsSff3YQX60ct9Z/kZYeKNEBRDfL
         hmRi55KGcZ1P7IRJsmIw8FKVEcHbAtjjwqzuvfDP18sXhHtqVCWF5lwrmgEi87I/J5rf
         kSDFG760CKP/0PMKEcaCEkXjjmKL7s/KGIAA2GkdRky96W7blG82kWfpFrCVe5+GEgfE
         sD66DkLcfpA7G01yAn4uyBI1rEySbdlHEPF9+xSylnmryp2+/+qTWW9uykXAmehm2LDd
         +pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dB/Ygu4p0hlR5xc5n0QdJ7utzSAVujm8LkOKbdwdxZo=;
        b=fsxO1ticwG2wcle1Yb1jfUkMwL3BE+/f6isOLk0QU7JLOAVQT05tIAWFj6r6LdZCsQ
         wxcQ0XSz/ch3EOySEttJhiuTJKQWki3GyASve1TxIGUXh0vGTrzDhfrktnz4Uu6DSlFO
         pxg+cqpoeNS2ce+9rKalTufUDUNhhZgef0aUQx4nJGR1Q1uOTbT6GGJBokU7mGRCkS8V
         qbLXW4XrV74C3JFUoYlu72sCXRrmgUsdmg0END7aq9XKrEIX+5pBkDxLkRxLWwhAJCaJ
         kveLWvJee0DGMdpI5aGb708j1Q6+6SOHXlarHCuMc2baaT4pZ991+1iXha22rDInj83I
         MRkA==
X-Gm-Message-State: ACgBeo2fAFJwyYFg1wrtlu/aRRRmvRPffUVMoLunGiahHOur2WcdAOYu
        rvV6IKveXT/a/UCWKwxBvX7gXCeZ7nbvchVl6QwYaA==
X-Google-Smtp-Source: AA6agR6gV/O1dKGBMeIJ5VWnArZrpcd9hDk6vFY3nL1JOYKPLFbQPcA4C6aQ8QYasBuBQSMHSCeypEeo9nvGZdgyhqM=
X-Received: by 2002:ab0:14c3:0:b0:39e:f748:a1e8 with SMTP id
 f3-20020ab014c3000000b0039ef748a1e8mr8093976uae.59.1661989974466; Wed, 31 Aug
 2022 16:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220829232934.3277747-1-yuzhao@google.com> <Yw9lOwlKrXyRsB8+@xsang-OptiPlex-9020>
In-Reply-To: <Yw9lOwlKrXyRsB8+@xsang-OptiPlex-9020>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 31 Aug 2022 17:52:18 -0600
Message-ID: <CAOUHufaa2P471xL-8jCG-188386pkcKUBYPnM-mzq-f0W1eh8g@mail.gmail.com>
Subject: Re: [swiotlb] b253fbc6b9: WARNING:at_kernel/dma/direct.h:#dma_direct_map_page
To:     kernel test robot <oliver.sang@intel.com>
Cc:     lkp@lists.01.org, kernel test robot <lkp@intel.com>,
        iommu@lists.linux.dev, Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Aug 31, 2022 at 7:42 AM kernel test robot <oliver.sang@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-11):
>
> commit: b253fbc6b9640aeebffc73d72bf0177c2a1ede1e ("[PATCH] Revert "swiotlb: panic if nslabs is too small"")
> url: https://github.com/intel-lab-lkp/linux/commits/Yu-Zhao/Revert-swiotlb-panic-if-nslabs-is-too-small/20220830-073123
> patch link: https://lore.kernel.org/lkml/20220829232934.3277747-1-yuzhao@google.com

Thanks.

It was reported and followed up on yesterday [1].

https://lore.kernel.org/r/20220831063818.3902572-1-yuzhao@google.com/
