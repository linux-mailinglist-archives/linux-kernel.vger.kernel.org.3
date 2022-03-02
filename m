Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453604CAF15
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242300AbiCBTxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbiCBTxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:53:46 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ABACA0E9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:53:02 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id s15so2658933qtk.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=D5hGbG6WV0qF+4vkghfuUs0cqWssjsyjy9zl2xsHgs0=;
        b=HK/ggXk5ycWs0WlByrgo9XHrCsxLcY3N9SQBoeznMydDyeYrN8n8BtXH5cxIrmT4CN
         g1lZo4NiivObkQEWU47ExEOZWXCf8pJsCGKQm8sfBigGMgCR1PY/mWLg/P9HWN2zRkha
         TYD3LrpPqc47Zzk9Rgwi5vCSiaZjOhlrlU1/qb+pmvXYcGD6bPP1sLv6Mu3gA6vZxxMx
         dOtX6m1b8uQoMby9xb5xGUvf8DEZUqlmKxk7UZoh7ftypY+eeNo1W72hSu5AqSBXt7Zl
         qph+bX8yXlgxzVSlQqrJm342/XFglunO7p3hWjdH24f+XV2qreVhP4y9XLe/hWnrbmHE
         u8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=D5hGbG6WV0qF+4vkghfuUs0cqWssjsyjy9zl2xsHgs0=;
        b=e6JXfl0v3UEi6ev3U3vo52dsduBVaRjTrP2n0v1iVUvgTCt7/f6kurffby5Y12XrjB
         2h1spdfhUPEtRtyu3dXMR06EM7X+B4AXLidfjdt9JheZdAjuR3l1aUtqMvaLriDGHG3F
         zTKYtJwb8Og+Hj8DbizGADZWxxdEtJj/4VmGmiQK3Ud/bmlfC3AZg3KvnwOJPlQuzhsL
         r3otm9FcIjgQzWwI3yiKdYLSEBU/4t4J8we210QUcGs6V8c6zSZHb49E8Xmt+CVOTc4W
         g4cGo50LN/PW5aBrQQF9B05WDlbXFDtmoT6l4UW0kNq/a9+K6z4q+gaNlODRyYhWFA/9
         OKGQ==
X-Gm-Message-State: AOAM533Rg3Q5p9cA47M4L9niOSdbLjfWcUEYi5CCaPglPpLlQr2Zm+CX
        0TwKeX4Sgzt9p0f2gyPRORasrQ==
X-Google-Smtp-Source: ABdhPJxeNecSoJF3QszPDYgA+wS9xVPiD7ijd6d2IFz1kHiagtZo5iNejW1t55xH3CrRdiqfoRn5WQ==
X-Received: by 2002:ac8:5c10:0:b0:2de:2dac:1ea1 with SMTP id i16-20020ac85c10000000b002de2dac1ea1mr25516591qti.600.1646250781277;
        Wed, 02 Mar 2022 11:53:01 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p7-20020a05622a13c700b002de9f3894c2sm12165928qtk.50.2022.03.02.11.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:53:00 -0800 (PST)
Date:   Wed, 2 Mar 2022 11:52:58 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     yong w <yongw.pur@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, cgel.zte@gmail.com,
        kirill@shutemov.name, songliubraving@fb.com,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, yang.yang29@zte.com.cn,
        wang.yong12@zte.com.cn
Subject: Re: [PATCH] memfd: fix F_SEAL_WRITE after shmem huge page
 allocated
In-Reply-To: <CAOH5QeA4w+CKW+K58k3c5pRWdkx6uT5ouyQ6hepMd1wKF51mcw@mail.gmail.com>
Message-ID: <5bacaf7a-dc6b-9435-e6a7-377b8f9d67e@google.com>
References: <20220215073743.1769979-1-cgel.zte@gmail.com> <1f486393-3829-4618-39a1-931afc580835@oracle.com> <d6e74520-88bc-9f57-e189-8e4f389726e@google.com> <Yg5RDDRLVsuT/Rfw@casper.infradead.org> <8986d97-3933-8fa7-abba-aabd67924bc2@google.com>
 <a4f79248-df75-2c8c-3df-ba3317ccb5da@google.com> <CAOH5QeA4w+CKW+K58k3c5pRWdkx6uT5ouyQ6hepMd1wKF51mcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022, yong w wrote:

> Hello,
> this patch does not apply to the 4.19 kernel.
> Is it necessary to make corresponding patches for each stable version?

I expect there will be three variants (if it's worth porting back
to older stables: you make it clear that you do want 4.19, thanks):
one for xarray kernels, one for radix-tree kernels, and one for
old shmem.c-not-memfd.c kernels; or perhaps I've missed a variant.

Once this patch has gone to Linus, then been picked up by GregKH
for recent kernels, I'll respond to the mail when it goes into his
tree to provide the others (or maybe I won't bother with the oldest).

We didn't research a "Fixes:" tag for the patch, so Greg may quietly
stop at the oldest kernel to which the patch does not apply, instead
of sending out explicit pleas for substitute patches as he usually does;
but I'll know anyway when the recent ones go in, and respond then.

Hugh
