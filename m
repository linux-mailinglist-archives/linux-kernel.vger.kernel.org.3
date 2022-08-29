Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD355A4185
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiH2Dgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiH2Dg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:36:29 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B4A2409E
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:36:28 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id x80so2991701pgx.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ljjtZByavJYwGMqEDoi1bPqP2XeQlrKsYOp8SuafT3s=;
        b=HtamZU/KSkrTmyaRvuvKRC9UPAqGxWwQyyA17LXAfvk3VVa6gKoDrunBsmYLksOlR7
         mQzDr/6bOU7BKzc1aBvld38Dh9A1IR35flF+OjnlAOBN+kdvUsuw4J5WYXDBCDfj4s9U
         HcSmp8t/oJnsAOKkdAn6bVmpyBjp6fi4wcpIMxtt6cphFjTxhPCGjqU/7wbrX5Gu/y3X
         KvRUy/n67qLSXIcmILfPGwum+Rkb27eweGUmpOOlHNwKIRWojSdiIh70YLCvDk3FTf/s
         gI41JutfQdauEo8Z/I6DOf7jZlKttiq75Ku2Gqw52fs7fzoww98h6T/HKVX1bcK39BQy
         iKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ljjtZByavJYwGMqEDoi1bPqP2XeQlrKsYOp8SuafT3s=;
        b=mXBx+srBydGdBc+dS36xVaEhXvmPiFQITFGi/UxSdOrDnG0YW9Cqy80nOfyg13+DR1
         lBtvYWI3EIXzftQrfohjJC7RuVhmL+RqG9QsxSc4ecfkzw+JlvkIRWjDdWOuRWVzpT9+
         H0Z6sSl9B5nA/1ZLORW5TKQcyt1ioZdnhoec+nzHzAMDGM3LaPwaxBjOllvuds00TZii
         T4JIMYTNF0/OtTPw6f2/2q09U9PWnL1fI7nr5+fxipuFbsS5lrRvbq2+f7EGgUrg2epd
         mjhg5KjMz9n/RkGP+SP1maVe3mesThp7Ib8TjAjDeZtjRgbHFqnyI+gm0YvM9BMBX9YL
         GkvA==
X-Gm-Message-State: ACgBeo3bZXUU6LWlcwpS6QOTZMkEsajqA20pZ4djY0OR5i9XjHaKD2wb
        DfQzJp8sbcn3N9MFycD6zh8=
X-Google-Smtp-Source: AA6agR6OzuDiBM7qRdqVH+ICd/DRjA4Uq6NZFdt2kfY551/v+qpoPLOxfv1xBCB3g2KFyodyUvvE3Q==
X-Received: by 2002:aa7:88c8:0:b0:536:926:700f with SMTP id k8-20020aa788c8000000b005360926700fmr14999577pff.72.1661744188074;
        Sun, 28 Aug 2022 20:36:28 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id h193-20020a6283ca000000b0052e6d5ee183sm5972077pfe.129.2022.08.28.20.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 20:36:27 -0700 (PDT)
Date:   Mon, 29 Aug 2022 12:36:21 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dawei Li <set_pte_at@outlook.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: simplify size2index conversion of __kmalloc_index
Message-ID: <Yww0NV54DXTzPG+R@hyeyoo>
References: <TYCP286MB2323E622C54B765F087C073ECA779@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <YwwuSBAreqUk/jFq@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwwuSBAreqUk/jFq@casper.infradead.org>
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 04:11:04AM +0100, Matthew Wilcox wrote:
> On Sun, Aug 28, 2022 at 11:14:48PM +0800, Dawei Li wrote:
> > Current size2index is implemented by one to one hardcode mapping,
> > which can be improved by order_base_2().
> > Must be careful to not violate compile-time optimization rule.
> 
> This patch has been NACKed before (when submitted by other people).


Hmm right.
https://lkml.iu.edu/hypermail/linux/kernel/1606.2/05402.html

Christoph Lameter wrote:
> On Wed, 22 Jun 2016, Yury Norov wrote:
> > There will be no fls() for constant at runtime because ilog2() calculates
> > constant values at compile-time as well. From this point of view,
> > this patch removes code duplication, as we already have compile-time
> > log() calculation in kernel, and should re-use it whenever possible.\

> The reason not to use ilog there was that the constant folding did not
> work correctly with one or the other architectures/compilers. If you want
> to do this then please verify that all arches reliably do produce a
> constant there.

Can we re-evaluate this?

-- 
Thanks,
Hyeonggon
