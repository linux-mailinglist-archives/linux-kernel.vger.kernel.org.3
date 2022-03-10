Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8104A4D426C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240301AbiCJIYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiCJIYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:24:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90DB8134DF7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646900628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+l4Wm/+i9uQFSCO6Q6PGOilIGdBXACV/1I5jpny3c0=;
        b=JK9gxxRKf7N77Uv2eV0Bot1yVxAS77yPFhPC6ADpQD9BH1LOWM+FOyYCRfZIa/f0XVasSX
        6+mLL74RuXwGNAzWi4wG/XuZY0GS8HYuZf5JLgtYCHyFX9T85GXc9GoRamzUnpOUazIWSL
        RG3DKQdcSs9yVq37IktkS8+l7DuWpfY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-3iTui-AXPZ6OwzS7WEfICQ-1; Thu, 10 Mar 2022 03:23:47 -0500
X-MC-Unique: 3iTui-AXPZ6OwzS7WEfICQ-1
Received: by mail-wm1-f69.google.com with SMTP id k41-20020a05600c1ca900b00389a2b983efso1828764wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=/+l4Wm/+i9uQFSCO6Q6PGOilIGdBXACV/1I5jpny3c0=;
        b=QYL1JOWM3rKI8l30uBeqYbveDk8zAFjy79Jf8s7fVnGp81InwlrbaM97dwyEzkdzYo
         VLVIzfXURVaPRbpF1ofk/b1IbIUAQiof6RL0VwSrpOMwRG6T6O6fgPSLMIAYn2qO7wo6
         5jBwcVUU2vgZMElFccrLv5VcbynATkotp6SLR9ryM5KSMtFfyHHkm93qUUoN73tp6BQh
         6SwqMgrb2nPO8EAtxcj4rkLCJ9S7NnvCfscW/ZwfO7K76mEQFcg+3DpsWRyfwxHhllXn
         Qs9Qo+H2N7NyU442wXXGGIRowCarqPvs2jIUzTSCXtGU1sIyLOmw2VkxjiR/2wwIgT5B
         5Rjg==
X-Gm-Message-State: AOAM530zSe33H/grxqEHNTAGUi/u56jr/vtstPtgXf0fWmwKjqiFrHLE
        yARUb+uvNCsM7b8QUYMOnrUPfhzMzRnJ32cw85BMoING1OQ4toyisteLpOfc7pxj7ot1EvsW4FO
        hkCCfmxNa0suQefjCSVGRnaHG
X-Received: by 2002:a7b:c94e:0:b0:386:3694:3e78 with SMTP id i14-20020a7bc94e000000b0038636943e78mr2547359wml.22.1646900626459;
        Thu, 10 Mar 2022 00:23:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZ5LGXrpDG+oZXlWmRve+wbXFrXo6EIpXvBD1ZCdvaQeZfsct49X7TFx7LGk8Zp1FwATZQ/w==
X-Received: by 2002:a7b:c94e:0:b0:386:3694:3e78 with SMTP id i14-20020a7bc94e000000b0038636943e78mr2547338wml.22.1646900626207;
        Thu, 10 Mar 2022 00:23:46 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id i8-20020a7bc948000000b003898dfd7990sm4200666wml.29.2022.03.10.00.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 00:23:45 -0800 (PST)
Message-ID: <9059fa71-330f-f04f-b155-2850abb72a71@redhat.com>
Date:   Thu, 10 Mar 2022 09:23:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM/dma-mapping: Remove CMA code when not built with CMA
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zi Yan <ziy@nvidia.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20220309175107.195182-1-keescook@chromium.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220309175107.195182-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.22 18:51, Kees Cook wrote:
> The MAX_CMA_AREAS could be set to 0, which would result in code that would
> attempt to operate beyond the end of a zero-sized array. If CONFIG_CMA
> is disabled, just remove this code entirely. Found when building with
> -Warray-bounds:
> 
> arch/arm/mm/dma-mapping.c:396:22: warning: array subscript <unknown> is outside array bounds of 'str
> uct dma_contig_early_reserve[0]' [-Warray-bounds]
>   396 |         dma_mmu_remap[dma_mmu_remap_num].size = size;
>       |         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> arch/arm/mm/dma-mapping.c:389:40: note: while referencing 'dma_mmu_remap'
>   389 | static struct dma_contig_early_reserve dma_mmu_remap[MAX_CMA_AREAS] __initdata;
>       |                                        ^~~~~~~~~~~~~
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Martin Oliveira <martin.oliveira@eideticom.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

