Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E107557325
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiFWGcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFWGcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:32:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABCC3981C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:32:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y6so17339042plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IDA0Z0/FgecfP4XP3E1js+ZS0DqzIZA81VkobU3maeQ=;
        b=AZnqr3yg1vCRy01iwUqviZ2FhttYv/C/KBCAj3JXFxD8eHHjb4UBWNLuTPnRFnmAZN
         UrdEd+9KyOqH7CVBX7kn5qv8xh+a17Lb+UEaRiEsyoSBsNnZW7td6fXxMBrVzhBlcl5R
         6ZUtqANIvqKB7YVNz8idiV6s+OqUAWSfH1fvlKyjzE2wyFRUePiPIQ/Du8oF576ITDRD
         dijbqMJoXulMB86s7wWbgbUV7laNLg2UQcah6rI4WkKMjXP5qOaH+5CBwUt4UX+EwnHV
         ZN5xa1hpN8Ui9luuUa2aRmUD1Atxxfd8CvvD8Gbu14MUHCed5nOCBJQvaGG4bdOGraEU
         Y01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IDA0Z0/FgecfP4XP3E1js+ZS0DqzIZA81VkobU3maeQ=;
        b=z5CuvDKeiHHtA5pcMB5NyGFEV2Oob5+TMef8feo2/MrMFNl8gaS9MPZqdFTdf/Z99t
         d5TnrZ8uL1A+/J04mlLVqLERT4kYzbB+oJr6cNUxdIjA/aVV5OvB/7hG0q7eXg7SOdig
         nQXyd1tt9XhEiys3B4tiaoIavzA6yrSab3doLLOoXq1joOmd2qQE6IJlL6FH/vC8A+zT
         lRmfkY4iWLG6cWskiagV37/N/5IW0RgR4DHec69OAGN3Rm84JKLMhI7ocKIbGcpHA0go
         9tIOCznoIKti8BxPsO/vYaWc4I8iqZ98zBd/JcFmez9n5vCBag4hmso5TaU9TvmwAXZi
         I9vg==
X-Gm-Message-State: AJIora8NBiNpFZO4Sb51/fSpv3MeNB0ejiFolke1TOfvJ7423KmeISkf
        h+rSNFcpu/0NmQ7B13OFmDKcTQ==
X-Google-Smtp-Source: AGRyM1vidPkMTYOk1M4gt3oypZqdw6zR5+/gHpYb11HAI/EteLi2iBj/DiqP4JTOrStpZcs1AD3iEA==
X-Received: by 2002:a17:902:a413:b0:156:15b:524a with SMTP id p19-20020a170902a41300b00156015b524amr37431141plq.106.1655965934070;
        Wed, 22 Jun 2022 23:32:14 -0700 (PDT)
Received: from localhost ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id a19-20020aa795b3000000b00525550222edsm708574pfk.214.2022.06.22.23.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 23:32:13 -0700 (PDT)
Date:   Thu, 23 Jun 2022 14:32:09 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/16] mm/huge_memory: fix comment of
 __pud_trans_huge_lock
Message-ID: <YrQI6UVxch0h920n@FVFYT0MHHV2J.usts.net>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622170627.19786-4-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:06:14AM +0800, Miaohe Lin wrote:
> __pud_trans_huge_lock returns page table lock pointer if a given pud maps
> a thp instead of 'true' since introduced. Fix corresponding comments.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
