Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21C1557258
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiFWEtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiFWDLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:11:54 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C995723177
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:11:51 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bn8so4332521ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5jDNpLxr7cGIqADzC3sdvFFhgsnexUiy02PrUDQv/Rc=;
        b=n3/SAojrz0/DrGQPMh4WqNM2k2NjcEc6nMVjVXXxCdYX2AIyZ6sytS0oG0ItZ4mnUM
         XzKImwOIP3Y25IOGjXWiew1cP8zrvTIyKI7z5SigqInuCta2YY3bnLyIvj17PD8QLtP+
         IhoABN7knreFAv/nNhpWcSc0umlHnQc30OCBrOVLgmk6RmwxabUzCbnAnWWix/PDDc8f
         dFrB9wKnFBqufwQ/HJSDBRP+LkRXVIeURSo1LtMoPhWac5z8oG95PZoLls0MKkvS/PCn
         zH8p1qVzN4Jxeu9xnfHFvwYzXokVFx01f+j+RwZSe1u5A5xTBJ7UrQsqZaXfXYbWlvf4
         JP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5jDNpLxr7cGIqADzC3sdvFFhgsnexUiy02PrUDQv/Rc=;
        b=zfhHj7cpu2pj8LswL95UBk93H2jioTwzuuPZ3Bs4JkRO0d1qr246+jCOOds4fTuTm+
         15j1XOeeHe4BI6TeDpsTmgBb55ADffxpsCgKSsulFlJAKA/b4c5obupKL6g/Olq82S94
         epordO9pb+K6DNlVL0BNZCCZ8m9DjJndrQCVpJ+aYhDbWc9Rn+LzC2kK0qeb7Lkd/Nvd
         4HTqa9w2J1NEIVk9iFjtgHzeqzW1TL87cFqfyFimhaxi3SC7E8mOeJLtFqwNhuhKhwKw
         nLt8f0b/QDu0YdS9hVRQsViBSL8YsiBfp8oIMqViashLHZsAfRn5hH0qT0pkQIOklMOQ
         pn/w==
X-Gm-Message-State: AJIora8wZJ3NKZ4qu5Din7UewQtYa+idcR01JEfLjohToCc7cgoCaVyl
        dlRHsntt4f7vpB52SvYSMnCjUw==
X-Google-Smtp-Source: AGRyM1uv21oXvWhnlrC67bIpBGrktWhfdrCeenGfpqFQHyuq00SiRyba6eLq2NOvwzgLyWGhXEbY6g==
X-Received: by 2002:a2e:9283:0:b0:253:e175:dd84 with SMTP id d3-20020a2e9283000000b00253e175dd84mr3557956ljh.221.1655953910136;
        Wed, 22 Jun 2022 20:11:50 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a15-20020ac2504f000000b0047f665e2df8sm1754606lfm.257.2022.06.22.20.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 20:11:48 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BC825104A32; Thu, 23 Jun 2022 06:14:01 +0300 (+03)
Date:   Thu, 23 Jun 2022 06:14:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/16] mm/huge_memory: access vm_page_prot with READ_ONCE
 in remove_migration_pmd
Message-ID: <20220623031401.wdyt5ylin4aijzhh@box.shutemov.name>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622170627.19786-3-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:06:13AM +0800, Miaohe Lin wrote:
> vma->vm_page_prot is read lockless from the rmap_walk, it may be updated
> concurrently. Using READ_ONCE to prevent the risk of reading intermediate
> values.

Have you checked all other vm_page_prot reads that they hold mmap_lock?

I think the right fix would be to provide a helper to read vm_page_prot
which does READ_ONCE() and use it everywhere. This seems more sustainable.

-- 
 Kirill A. Shutemov
