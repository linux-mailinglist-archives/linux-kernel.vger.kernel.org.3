Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3733550147
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 02:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348242AbiFRAUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 20:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbiFRAUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 20:20:13 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689DF590B4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:20:12 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id y29so6277707ljd.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UrOYsC1ew/w6p73+nsWTtgf6LHyGTERsTIG20+T+qIA=;
        b=bWeTqjlmkUrmkwzI2B0BHdb/N/1umG3v250Prir35ImXG/+7Kc4GXIoLBzUiI8ngcH
         P0FKVfhaobo5HBD0tlJ/ZPBxPcHY9wChnOSGVnuUg95vJjia3SgK2yo/LBtG/koNQDEd
         Wk1ZjPRD4toLKKfVofO+e+1dl64Dvs0MN/bes+90C/KkJnzvkFV32WMI+86FSRkwNxBS
         r/d1ci66ssdEuvretCbaeHf+UCBdmLcWSt2gCFv5uyy7UqJYrnBY4M7WxHZIIDnd656h
         PDBf4Z0bMhVtD9cQuNCPHLRjhMXDfeI9mxAwdHMRP8aijs/Jx09kZDoMB1M+IurYve1Y
         FVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UrOYsC1ew/w6p73+nsWTtgf6LHyGTERsTIG20+T+qIA=;
        b=UgFdgU+lGAmboS7eYAQq0+nSjh0XIkM5aEkgvicDG4/u7AzRPTtxTO33ABmWaMTVcM
         oA3luuKiJOXYPwkT+Ee4iL6oxOo3KQac7myicm8TDRh5YtGF14AKpbpDmxmOs5llEyAt
         KHzzm2QqA+lkKjMgwh3GzXT7/mWbujAZPTQhcAkhW/mHf6V4fvrK8F3tY3OQhPMLU577
         /KYlYhNwWptbaDNHk/Cx14fOl46KMuM1KwGpjan8tM02hjqCYAVN6xHrtlIhszIGt95Q
         yAcyTcyFbZsrlP/I0cmW1SbUVbrezgLxPdmC2d9f+ZKKI5K4UvsZ4p+In5cAKqWeeHGe
         eXLw==
X-Gm-Message-State: AJIora8RIFKYtn9lNnmqdUKgfjKnhEemWch6tiul2RTRt7MG+LpL/lAe
        VI7MNmk7Yjiyxee73nWOAzpQFA==
X-Google-Smtp-Source: AGRyM1vZKK06Vz3WHdkkW8uYsXOtVXEDAj6OJMrTQM4yDdBXS/6lLvWRJMndiWTqY04XpQfxGxRg6g==
X-Received: by 2002:a2e:a549:0:b0:25a:44ab:5aa with SMTP id e9-20020a2ea549000000b0025a44ab05aamr6535706ljn.248.1655511610719;
        Fri, 17 Jun 2022 17:20:10 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o4-20020ac25e24000000b00479471cda69sm815354lfg.156.2022.06.17.17.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:20:10 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6DC4D103719; Sat, 18 Jun 2022 03:22:20 +0300 (+03)
Date:   Sat, 18 Jun 2022 03:22:20 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Fix possible index overflow when creating page
 table mapping
Message-ID: <20220618002220.panwk4zwnigayboy@box.shutemov.name>
References: <20220616135510.1784995-1-ytcoode@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616135510.1784995-1-ytcoode@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 09:55:10PM +0800, Yuntao Wang wrote:
> There are two issues in phys_p4d_init():
> 
> - The __kernel_physical_mapping_init() does not do boundary-checking for
>   paddr_end and passes it directly to phys_p4d_init(), phys_p4d_init() does
>   not do bounds checking either, so if the physical memory to be mapped is
>   large enough, 'p4d_page + p4d_index(vaddr)' will wrap around to the
>   beginning entry of the P4D table and its data will be overwritten.
> 
> - The for loop body will be executed only when 'vaddr < vaddr_end'
>   evaluates to true, but if that condition is true, 'paddr >= paddr_end'
>   will evaluate to false, thus the 'if (paddr >= paddr_end) {}' block will
>   never be executed and become dead code.
> 
> To fix these issues, use 'i < PTRS_PER_P4D' instead of 'vaddr < vaddr_end'
> as the for loop condition, this also make it more consistent with the logic
> of the phys_{pud,pmt,pte}_init() functions.

Hm. I don't see why you changed phys_p4d_init(), but not
__kernel_physical_mapping_init(). It does exactly the same thing, just
pgd_index() is hidden a bit deeper than p4d_index().

-- 
 Kirill A. Shutemov
