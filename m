Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12C658E3C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiHIXg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHIXgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:36:23 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267597AC1D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 16:36:21 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id c19so5222382uat.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 16:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=o4wdgvd9lokOVkmz3///Dw5D/UVYUgUiBJagcPYB94M=;
        b=bXQyJL88COq3m8pU1jfr6QgcWtKMoygb+O7A5xhSAn6byuBoRKA7YPEgwkvc/hp98n
         Nmwf/o0VAi7udRT2BEDfLzS/IB0BBkY4f+GsAuesfVq84iHg2T/ylNEdHDoG1pe8h16v
         IMCwwJ+FqhbWtajm2L10HsNVfk3jlz/iDOVlKtt/Sp5PR2nT79/zCmAK7MEQ3tffWgGy
         /Jbo5swYJmZxcm1wuNJSH3k08BdXLfRSdOSnRsmZsgfTHNyufGmqCLS1RVo/nDVSfjmT
         QUw6MI4TF0D8f1Kit9Bf6pKAUzzFDCh2Echh+LztL/1L1ElxK9rzolfDTrxVZ0se/IPn
         SB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=o4wdgvd9lokOVkmz3///Dw5D/UVYUgUiBJagcPYB94M=;
        b=K8BoNGb8jYA/Yk4pl7ec29gpBYCDVFKSRK3K1RQ+WlFofDhWrGuVrOt78XFsfFOcXt
         TRCjtkPJcLnrDFV51A5rtL+NgUoL+sy05dAgiPV3VtwV7vH9VA0WjJrAHLyAbfmKJ2lf
         Vu2TBlStxZWTiIxWw1mQ/MIJxrwwcR8JLcIsKC6XBThHK0fDrcKb1fwgMcJMSKTf/6yn
         5d6tmkZYA8+gBPxUDRczSRhzmtSBXVGByhIM1idLFdRcQBqWV8UvFT8K8wds+D4Fjno7
         V0vSBXK5ui+ETKmnK1ac/wnkEludRkE3oePPvHO6xXJueBBxFwK9G+2wUVUUnpb7ttwC
         IsDw==
X-Gm-Message-State: ACgBeo3c1rAVlbGif+sEFHqOQDLIJ9jpkqYP4Jx+XY8bAq2rkyCqZjMZ
        BpR0bjHeHobbTYWO4416A7GYHO6WAdLC7B87HSWsUA==
X-Google-Smtp-Source: AA6agR61c1M90WGtrFaP+Gh5AcPiEcbJHfs9ELby75M3kF5agX2qra8YCIPBx93xFQbktlykLKIWh8EoaYxHRtP78ZQ=
X-Received: by 2002:ab0:2242:0:b0:38c:7f0d:623e with SMTP id
 z2-20020ab02242000000b0038c7f0d623emr6415328uan.59.1660088180210; Tue, 09 Aug
 2022 16:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220805184016.2926168-1-alexlzhu@fb.com> <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
 <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com> <Yu1uabedm+NYnnAj@casper.infradead.org>
 <CA8C72B6-E509-4FB0-BEAA-C4368EB7A419@fb.com> <CAHbLzkp27aP4JYLPLzv2vtyzVe63bkhuZhw1jnxTF1Buvt4rew@mail.gmail.com>
 <fc108f58a4616d5d7d092a7c1f150069a92ee40c.camel@fb.com> <CAHbLzkqpn2ExBJuPD8sYJrEDCUU9=FE3GFh8kL3Bmax0KytKPw@mail.gmail.com>
 <1F8B9D85-A735-4832-AD58-CA4BD474248D@fb.com>
In-Reply-To: <1F8B9D85-A735-4832-AD58-CA4BD474248D@fb.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 9 Aug 2022 17:35:44 -0600
Message-ID: <CAOUHufbGcuvJ8EfBkWrdCgeMCiceP0SxHZzcJnOt1Mw0P2w9kw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to /proc/thp_utilization
To:     "Alex Zhu (Kernel)" <alexlzhu@fb.com>
Cc:     Yang Shi <shy828301@gmail.com>, Rik van Riel <riel@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Ning Zhang <ningzhang@linux.alibaba.com>
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

On Tue, Aug 9, 2022 at 11:16 AM Alex Zhu (Kernel) <alexlzhu@fb.com> wrote:
>
>
> > OK, it is hard to tell what it looks like now. But the THPs on the
> > deferred split list may be on the "low utilization split" list too?
> > IIUC the major difference is to replace zero-filled subpage to special
> > zero page, so you implemented another THP split function to handle it?
> >
> > Anyway the code should answer the most questions.
>
> They can indeed end up on both lists. This did have to be handled when
> implementing the shrinker.
>
> We free the zero filled subpages, while modifying the existing split_huge_page()
> function. Will follow up that change in another patch.

FYI. This series does it:

https://lore.kernel.org/r/20210731063938.1391602-1-yuzhao@google.com/

And this one:

https://lore.kernel.org/r/1635422215-99394-1-git-send-email-ningzhang@linux.alibaba.com/
