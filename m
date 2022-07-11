Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E7956FFBD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiGKLLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGKLLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:11:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696A3C1FEC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:18:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s21so4429427pjq.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OEP5c1Ts3y3jjcZd/vxo+DFJNaZAkcnY9wcB9rKwQk0=;
        b=8XMkm5VW53KdDaQvf+q37G9BYrf6ehTATfsf9ZgZosxgK5egvreQu1XDJoLFzGoxrY
         Spx4dIrYlGbHhKpGEAcH5SzpGOAVzKW0A/dn/krSdYeqGQoe5Sok0fUzEw74itmR57FW
         G8icen7/bsNrDOQqcQAy1CAUZHxDT3MyQLnFq0auLHAN1gCb808h7M1YXNy+iKHSZdUh
         QrkiA4RJfYEvDm7KtWKvEEuFML8KJBUfdV/5rhTe2Q6tHj0+o8ywPyFv3/0dCQ/Xrp8r
         hv6IlainqJPCGq+AN++UdANZFlv0xPCR6W+DIh/6wI4wQ7EIElt95OaP5psBkJ15one+
         7lAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OEP5c1Ts3y3jjcZd/vxo+DFJNaZAkcnY9wcB9rKwQk0=;
        b=Npj3mpTdGwjvmufaPiC0myY7hSjcqPj+XCWo1zL1UjxpE1q4ezodYiktyXo/Py7UVW
         kH9LbfyiTZeYKDa/YbbeWsFKk0zeevwVsETswFj+1B53vExChPrF+OuionWEyrvO2bVS
         1/OFvUS5Sejvgfcax4U2KFLtXPUP+wmR4GR1CXpHqg0NO+0XQKqOZ3BUlG70SVhzI9w7
         EeNen8OjtRyl7JMucHSf2q/kV2nTOk9plDUw9ipLIo6CglONQ4/GkoY24Mrp+BjYPxRT
         nNignxQkZGKuTDnYr1KoAiicd5dGEy4g+8oSofEK3b04P6SrXeFCng6KSv7Y9Fi4My7M
         n0uA==
X-Gm-Message-State: AJIora9NakFKsaGkFiEv/zNuxbBLIlQBT8WZ/splHGr1m4MzNg4wH+By
        55cl/nl0RzNmNhz5LzkFgQjC+A==
X-Google-Smtp-Source: AGRyM1sIYzLIe4/E3L+3duTvdoRwBoXV+BsrpUmKJRMQpAv5GS6y4B0utoiHVD2sU7/U5uNCjty5uQ==
X-Received: by 2002:a17:902:aa82:b0:16c:4bee:1f90 with SMTP id d2-20020a170902aa8200b0016c4bee1f90mr4181686plr.69.1657534701800;
        Mon, 11 Jul 2022 03:18:21 -0700 (PDT)
Received: from localhost ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id k22-20020aa79736000000b00528f9597fb3sm4383091pfg.197.2022.07.11.03.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:18:21 -0700 (PDT)
Date:   Mon, 11 Jul 2022 18:18:18 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlb: fix memoryleak in hugetlb_mcopy_atomic_pte
Message-ID: <Ysv46rUQDluYICn7@FVFYT0MHHV2J>
References: <20220709092629.54291-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220709092629.54291-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2022 at 05:26:29PM +0800, Miaohe Lin wrote:
> When alloc_huge_page fails, *pagep is set to NULL without put_page first.
> So the hugepage indicated by *pagep is leaked.
> 
> Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
