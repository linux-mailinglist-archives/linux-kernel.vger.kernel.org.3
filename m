Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5975A22BD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343594AbiHZIQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245046AbiHZIQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:16:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91D843332
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:16:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sd33so1723727ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=vSLa1x3yM/LYq8duQfSkPR7UjODiLbU3hMPX4a6qvnM=;
        b=UqyAlLYFjk8ZZXCZkUAkMzFHX94KU2J+l4l4rJrrQqciOEX6BHzsNxrwAFkdpANkj1
         DpFc90cp+HrdEdqAcWeb9GHE5MNqBYWVLf0ATbQGWJ5/VRMnMRmSqujnVkjPqAx5zwRN
         LeTyDNz/rscKZ8eplAnrC+SXS6utmYet2gqkNKUVIzbH02r3pVXxmUoYUVbScvNBSSHs
         a4KUorsMpqnXHyxa6s2S/svK0lbqMdlZi/h5op4aZqHk88SCZznn1RjaUNth/wqZmiN3
         U/O2G8zqGMEln7g3snEQbSw+ueJYb6Rje+GWy2Y1OACAxfY7qEkOA2oMJyqQAveB0Ab5
         P/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=vSLa1x3yM/LYq8duQfSkPR7UjODiLbU3hMPX4a6qvnM=;
        b=4gjChEc074v7G8l/MhPNdGxu8k1NQ0hsMTwkgilwuOiRZ8r6+UZ0pjKLlOeXPc0mON
         lYFOpIxTuiYvgWqsIgCi3nRKwNlGetX17ldeZvJsg4xmP7jQVkJ4T5li4/HItCp81xEf
         f7+7Wu9f5VOF0BnKOVCqZefHvJiGFxa1pAdDd40WRoV33j+VVhZgWP088E1UDsmHBmLq
         II/QGyCKLrMw03U16XVEFtXwIuOQLkh0LFxaJb+SuVd5BwqzgnDMXhvDttJtxLKNAP9A
         IymZE5allfEGzsLCQaJO6HxScLNvFhhIUB1AK8DDjFwoKjSbhiVZHf7/N1+dc+tSecIA
         15cg==
X-Gm-Message-State: ACgBeo0uYUYRH4iBspAVtRfQAUnmJCzbB6ooIydTKCwEgSv2dMP7wnn8
        ZI44xr5e6BqKNb2nqwxnAk4Rvw==
X-Google-Smtp-Source: AA6agR7QQFuPvk2/UcrqfPRvBVDgErUw2JqMJaaJBD2nyOQrRspsGSM+8O8zg2pcCsGFDSNrUvWSeg==
X-Received: by 2002:a17:907:2854:b0:740:2574:1f33 with SMTP id el20-20020a170907285400b0074025741f33mr883705ejc.105.1661501769444;
        Fri, 26 Aug 2022 01:16:09 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id a3-20020a1709063e8300b0072b3406e9c2sm601689ejj.95.2022.08.26.01.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 01:16:08 -0700 (PDT)
Date:   Fri, 26 Aug 2022 10:16:07 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Conor.Dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v2 2/2] riscv: extable: add new extable type
 EX_TYPE_KACCESS_ERR_ZERO support
Message-ID: <20220826081607.ci42sbffrmsfhk2w@kamzik>
References: <20220815032025.2685516-1-tongtiangen@huawei.com>
 <20220815032025.2685516-3-tongtiangen@huawei.com>
 <20220825110602.bog5mjpascvikwxx@kamzik>
 <7718a9bc-e976-daeb-f490-e7b5190e50b6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7718a9bc-e976-daeb-f490-e7b5190e50b6@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 02:44:48PM +0800, Tong Tiangen wrote:
> 
> 
> 在 2022/8/25 19:06, Andrew Jones 写道:
> > On Mon, Aug 15, 2022 at 03:20:25AM +0000, Tong Tiangen wrote:
> > > Currently, The extable type EX_TYPE_UACCESS_ERR_ZERO is used by
> > > __get/put_kernel_nofault(), but those helpers are not uaccess type, so we
> > > add a new extable type EX_TYPE_KACCESS_ERR_ZERO which can be used by
> > > __get/put_kernel_no_fault().
> > > 
> > > Only refactor code without any functional changes.
> > 
> > This isn't quite true. __get/put_kernel_nofault now sets a different
> > extable type (as the commit message says). But, nothing special seems
> > to be done with that, so there's effectively no functional change. Can
> > you please elaborate on the motivation for this change? Where will the
> > KACCESS type need to be distinguished from the UACCESS type?
> 
> The introduction of EX_TYPE_KACCESS_ERR_ZERO does not change any function,
> but makes a correct distinction in the actual type, indicating that there
> are indeed some kaccess entries in extable. I think this optimization is
> more clear and reasonable.

Well, creating new types, just for new type sake, just bloats code.

> 
> A few weeks ago, I did something similar on arm64[1]. I think this
> optimization can also be used on riscv.
> 
> We can do some features that are used on uaccss but not applicable on
> kaccess in the future[2].
> 
> [1]
> https://lore.kernel.org/lkml/20220621072638.1273594-2-tongtiangen@huawei.com/
> [2]https://lore.kernel.org/lkml/20220812070557.1028499-4-tongtiangen@huawei.com/
> 

This is part of the information, but I had already found this. What's
still missing to me are the riscv patches, or at least a riscv plan, for
actually implementing something which requires kaccess and uaccess to have
distinct types.

Thanks,
drew
