Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1313251C9DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385556AbiEEUGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244961AbiEEUGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:06:47 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD895EDF4;
        Thu,  5 May 2022 13:03:07 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id m6-20020a05683023a600b0060612720715so3632937ots.10;
        Thu, 05 May 2022 13:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pyq/2vKiCJeafLAKrLbpew+3CjQ+qVQC3K8MNbXKH7s=;
        b=R9OswNI/bjFONSGVJ3EPs/rftmN7CfKjqkvnGdapZ3Yt76VwIySaNj1j26EsqRicsc
         c7JkMC71ipXEveZ7ee6YjS7YK0NxvDDVjxw67hf3TtBK57qgMCsw79Hu0TMfPUGmT58S
         j3CHsdYOKd52+QfXaXJV+i5KKEKQAymILzykTBBgTz+zkoVaWCMm+3/Sd/89if7iSn61
         RbNBZ5NWNT696fQungArPHZU6hYMQcA4O6U2btd3ZUP/ymzFbyvdL1llisNrZ3ygGptI
         /GbdY4wEIFz4VqE9KMaDY0r2nb9LqyJSUMyNNQOk+CBRqD883s/KxOuQUkuiQxlJLZiI
         hEow==
X-Gm-Message-State: AOAM5338TbvCu9kfb+M+MCvbjDNFcM36aSd6b9sKQvHPitpqJs3w0VoR
        Ka7/9qMniJZyB3laSqLgLwZbyvmVrw==
X-Google-Smtp-Source: ABdhPJzs1asTZTmKLXNMh0PXTiEvLAWMuCmzpJCTeiBCudCzgeCyMfW7UzBRQJMYiJSe1XEvIayZnQ==
X-Received: by 2002:a9d:6ac7:0:b0:5e6:ec48:d882 with SMTP id m7-20020a9d6ac7000000b005e6ec48d882mr9872300otq.274.1651780986171;
        Thu, 05 May 2022 13:03:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a32-20020a9d2623000000b006060322123csm935981otb.12.2022.05.05.13.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 13:03:05 -0700 (PDT)
Received: (nullmailer pid 100851 invoked by uid 1000);
        Thu, 05 May 2022 20:03:03 -0000
Date:   Thu, 5 May 2022 15:03:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Baoquan He <bhe@redhat.com>, devicetree@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen Zhou <dingguo.cz@antgroup.com>, kexec@lists.infradead.org,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Dave Young <dyoung@redhat.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v23 5/6] of: Support more than one crash kernel regions
 for kexec -s
Message-ID: <YnQtd5+iSXj+R5X/@robh.at.kernel.org>
References: <20220505091845.167-1-thunder.leizhen@huawei.com>
 <20220505091845.167-6-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505091845.167-6-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 May 2022 17:18:44 +0800, Zhen Lei wrote:
> When "crashkernel=X,high" is used, there may be two crash regions:
> high=crashk_res and low=crashk_low_res. But now the syscall
> kexec_file_load() only add crashk_res into "linux,usable-memory-range",
> this may cause the second kernel to have no available dma memory.
> 
> Fix it like kexec tool do for option -c, add both 'high' and 'low' regions
> into the dtb.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/of/kexec.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
