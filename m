Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C141051327A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345553AbiD1LeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345591AbiD1Ld6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:33:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B132C1E3D1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:30:44 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z16so4006544pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=staRmhhoFTpyzY4bmoGFNp1v/Je4AKSeU0LxuCL4jDU=;
        b=hqHWSiUoHqyucL9B+7Xovyqujly0/ugOcnWDtDiN8oqihfAWB3RIpcDDXpM5jV15hg
         hTTlGPr3vXZRbJEmMPxe+48hchpbpDQzU9bfmKH90Q3gDCvNlq5F/Colly/UkdD2GC8h
         Z498WozUjhxAMqgWkj7eE/fObrJZXKE6RCpmtDvuQmmQ0u2C/rrZg4VSC+uU8OpHYk3p
         EiGnC1lTGNxR81i2k0/0bNLq6rY0x5G1fLV4zpQ6NuW/MfiWfB84djujM1Bgn06h86dG
         fhKx8kxM5BPben913+t8OLYYFey76abD2FhmjWoh7/ZQ9G9kcTs37BXGHUdTf2iCoTwq
         dDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=staRmhhoFTpyzY4bmoGFNp1v/Je4AKSeU0LxuCL4jDU=;
        b=PiNQOOBuT3/huEbe5Nv78FaNsxX38AlBBlyZa1Qy7civ2u7Q3cygDiHz0Qdkl8fdDC
         yHxXQoJZ92txSbBXKkI3wtwjTpg9NS3kBEaIsRbAqZhxgBIdvshiC/P86S8VttwvMHgL
         1qh4oSMpgVS+KPNYDbCtduTisGf2LGNV/q84giObeoH2pUBubNkqZtDS1BIxBBe8GeJb
         5fCV3Zw5hjCV89EyuU5Vmvx7E7HpFf8hamy5bt6a6VEs0cbSz2993PCl4j92YcXFi4wS
         hSvdy8HgEBOqtCqLSBRaGHKI98jJy6ATaoCKgrwav4ORhq02+fG1YuCFW4TAWX0+kiVk
         OxlQ==
X-Gm-Message-State: AOAM532X6Aj0KHhVvQqFVDJY/VGEAZjSLuKtwsYTATZJPfMovL2a3H9I
        iFg+oUBNTSYeNMLc9JVWgrs=
X-Google-Smtp-Source: ABdhPJy4d74zijQjqs1W8GNyLpfUWDBftTGBf+gvoOKVYW1Ym1+35cJ3dEQgQPDvWNhrYz0i3Hx9MQ==
X-Received: by 2002:a05:6a00:1908:b0:4f7:8813:b2cb with SMTP id y8-20020a056a00190800b004f78813b2cbmr34479446pfi.54.1651145444215;
        Thu, 28 Apr 2022 04:30:44 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id w123-20020a623081000000b005056a4d71e3sm22029839pfw.77.2022.04.28.04.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 04:30:43 -0700 (PDT)
Date:   Thu, 28 Apr 2022 20:30:36 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/23] mm/slab_common: cleanup kmalloc()
Message-ID: <Ymp63L22CQ2q8gsC@hyeyoo>
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
 <20220414085727.643099-13-42.hyeyoo@gmail.com>
 <50118b134e9495c5264adf62d998a5c5386d6a55.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50118b134e9495c5264adf62d998a5c5386d6a55.camel@perches.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:00:32AM -0700, Joe Perches wrote:
> On Thu, 2022-04-14 at 17:57 +0900, Hyeonggon Yoo wrote:
> > Now that kmalloc() and kmalloc_node() do same job, make kmalloc()
> > wrapper of kmalloc_node().
> 
> Why make every kmalloc larger object code size ?
> 
> What is the overall object size change in a typical defconfig ?

Thank you for pointing this.

It increases every call to kmalloc() is increased (+5 bytes) due to
passing NUMA_NO_NODE. on x86_64's defconfig, the difference of vmlinux size is not that
visible because this patch also removes tracepoint.

But yeah, increasing 5 bytes for every caller seems questionable.
I'll think about this for a bit :)

Thanks!

-- 
Thanks,
Hyeonggon
