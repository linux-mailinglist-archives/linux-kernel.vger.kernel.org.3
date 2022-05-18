Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC29B52B3C6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiERHkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiERHkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:40:36 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA566118024
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:40:32 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gg20so1235245pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=FxAwdbb/Z2iFz9mmHnLiOpxEpn9tLUeGCl2bRMYRR98=;
        b=coF2p/xtqq5kbzcw8z4gzgPU4TNTmE5367fdqBh/2EUUAdcDvu58bgq1CV3Vmduw48
         cfYzCRdFI5K+bKAYN4UbYXjXvv5GXUy720PTldYLLT7R3XiFfkDATOmTturvUS1BJgFk
         Ls2Vi726DI3gyhqczftszBPB1OGh/6synGEc4RYSFwyzvNKtMLJWQOzB21gdEOLsNB1n
         pRcMQeeVGCoDVonB/ueqn9qhMpEougAaZLTdRiWHCu/R62yvD6mlmPbxoedKjoLlozr9
         RZTUmFoNIKE/F3hRjRSrefBDMhgy/gtKI2Luplt216tpNvJeJmKNHgLfd0frchAH2Thv
         5r1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=FxAwdbb/Z2iFz9mmHnLiOpxEpn9tLUeGCl2bRMYRR98=;
        b=lzuYluG2kkenmSuLh+U2/YRAL5ek8SXvCh2T1U85PIeTvwZF3N90jBriBzG0tdzD0e
         em85M5jNhGEwH08NdCeqMwOPkGvMSrxmCtA0q1ahKWz49K7lPE20VB22CKdPHJ2MJ8+G
         FSj4GFENIo3H/Jm/83plQNGm7zSi5WGuIlZGbgIsASU2uOysOoTvdP6TF2gQEHXIOa72
         B7v9feUD2Q08Owkjp9mU+WLL44p8wB/fxYIo/tUPXjBkXmbp4NL/IC2vomR4sh9hg+tb
         VDPW8fsD9IHnSEisq8Cr/vpw7FQJETOHJK7VqK1KBu5wJ4V+rvWCp/W34ZG+gvnEn9Jm
         L4UQ==
X-Gm-Message-State: AOAM533h38aRzg/c179DfQ54bD4FvBFn0VMLrrEvsiYH4yZKx8y0E45S
        GrmzqsIJKbAniIJ43h5xeLw=
X-Google-Smtp-Source: ABdhPJyuknGHZVYZTShNJtstyABeDVn/mGApt/yIW0GYpaFDALyef+05Id2jETX+j4m/cFJpDMbg4g==
X-Received: by 2002:a17:902:7d89:b0:15e:e999:6b88 with SMTP id a9-20020a1709027d8900b0015ee9996b88mr26201726plm.98.1652859632287;
        Wed, 18 May 2022 00:40:32 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d132-20020a621d8a000000b0050dc76281bcsm1096213pfd.150.2022.05.18.00.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 00:40:31 -0700 (PDT)
Message-ID: <6284a2ef.1c69fb81.e53cd.32b2@mx.google.com>
X-Google-Original-Message-ID: <20220518074030.GA1686385@cgel.zte@gmail.com>
Date:   Wed, 18 May 2022 07:40:30 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     akpm@linux-foundation.org, ammarfaizi2@gnuweeb.org,
        oleksandr@natalenko.name, willy@infradead.org, linux-mm@kvack.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>
Subject: Re: [PATCH] mm/ksm: introduce ksm_enabled for each processg
References: <20220517092701.1662641-1-xu.xin16@zte.com.cn>
 <YoSZE7Iak3AYA4VE@balbir-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoSZE7Iak3AYA4VE@balbir-desktop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 04:58:27PM +1000, Balbir Singh wrote:
> On Tue, May 17, 2022 at 09:27:01AM +0000, cgel.zte@gmail.com wrote:
> > From: xu xin <xu.xin16@zte.com.cn>
> > 
> > For now, if we want to use KSM to merge pages of some apps, we have to
> > explicitly call madvise() in application code, which means installed
> > apps on OS needs to be uninstall and source code needs to be modified.
> > It is very inconvenient because sometimes users or app developers are not
> > willing to modify their app source codes for any reasons.
> >
> 
> I thought we got process_madvise in 5.13, doesn't that help solve the
> problem with extensions to advice and an appropriate wrapper? Granted
> it might be a little racy with a running process potentially
> participating in KSM already. 

The reasons why I don't use process_madvise to achieve this include:

1. see https://lore.kernel.org/lkml/1835064.A2aMcgg3dW@natalenko.name/

2. process_madvise is still a kind of madvise. processs_madvise from
another process overrides the intention of origin app code ifself that
also calls madvise, which is unrecoverable. For example, if a process "A"
which madvises just one part of VMAs (not all) as MERGEABLE run on the OS
already, meanwhile, if another process which doesn't know the information
of "A" 's MERGEABLE areas, then call process_madvise to advise all VMAs of
"A" as MERGEABLE, the original MERGEABLE information of "A" calling madivse
is erasured permanently.

> If we are concerned about KSM, I would assume that we care about long running processes, is that true?
> 

Yes, it is.

> Balbir Singh
