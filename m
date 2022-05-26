Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D0E535357
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 20:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbiEZSbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 14:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbiEZSbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:31:46 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254052714D
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 11:31:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h11so2795486eda.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 11:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OqaDyen+xHLMjM1+kU3vv7vEUmDoXnKLSHCxr0ki/yI=;
        b=BkgFlzuGNKyb+uNyGnU6TxJ6tLPcnTTz0fIfAd0G6SJqAnBMulcPqqFv87YZb40zBr
         45DtchsOB/RWvL1ETS2WM5vNZNWwcoQi6eUXN3Y8ht6azoD9p5U3j+SjLzDTj5jRzMFr
         mWYp8z+Lw27JzV6nLRO784rXgmDzNNVW1X4rPhGqT9CcDL8N1xECKwkUKmAH6hwNip8o
         tSoFF1Gw5harFb5i08n4Q7kK2a6o3lPbBYAZ1gbMnFKFovTyzUOrKznNLujUO78M392n
         snBE7BSEouVeDgQ6JuN5/Yu3lgHzFryGE7lN27p/JX2G+Yeoipo1Iq2B6uT8zo0Dp3kg
         Y26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OqaDyen+xHLMjM1+kU3vv7vEUmDoXnKLSHCxr0ki/yI=;
        b=PEnh+uxf7YKYsHPnrLMROIh8cM/kJIPTNTR3c90qT/ui6X4PKtJUb49bRbJ8q/TTY1
         O1QH1x9NblGdknx6X+kv4jQhRIf75cqMEIS2xU8tvOE7Z6OVlFzz/0ii3THwOTFRGdi+
         CxO4TlLK2lofObhLdu0EK9GwQVazmMzZFIbJ+W5NEJvRDJbGrhHg8qMamknhB8yCnEB5
         YDXYDBbhURpkixWLcTNGBR1FS83Lwxo4rEnDAyRnDdBjtbkkYjkOqTQKlTVnvKBAOX4d
         k261xtz8V7DgczPOECr8Fx4NuXZjhUWIGGKLzAkN9tJC43cgBWrDRdJmH8g+DcPrcV19
         EY1Q==
X-Gm-Message-State: AOAM532zprev/AYBzmKi2ppc94wki+/2mXzE3SU8idI1JV6OhFqbBg3D
        FoRidq9IKkU9/pRUUI66dN/KgenIFC7D/4ttFMwtcA==
X-Google-Smtp-Source: ABdhPJx0eHADBVzR9F6OjFXojGL3k6dCwZofMe8lUrMYlUp5GceoNL/vvUAdvoESE6uYkZYs+3Ly5be4VSp7LeVAaXM=
X-Received: by 2002:aa7:dccd:0:b0:42b:d509:b5b with SMTP id
 w13-20020aa7dccd000000b0042bd5090b5bmr6266347edu.19.1653589902378; Thu, 26
 May 2022 11:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220526113350.30806-1-linmiaohe@huawei.com> <Yo+B4b0nF+kI35pG@casper.infradead.org>
 <CA+CK2bBBLjr3kGqc=zA6M5773G6gj83LB_kwwOCNuFX8YoUp+w@mail.gmail.com> <20220526111546.50102da288cccbe913cadbf4@linux-foundation.org>
In-Reply-To: <20220526111546.50102da288cccbe913cadbf4@linux-foundation.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 26 May 2022 14:31:06 -0400
Message-ID: <CA+CK2bBJ3baj2Qt+9Wy1r==_Uym_UZJ+S-HRwFAsspPamctk_Q@mail.gmail.com>
Subject: Re: [PATCH] mm/page_table_check: fix accessing unmapped ptep
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Miaohe, please store the ptep, or maybe drop this patch entirely.
>
> I think it's best to fix it.  I rewrote the changelog as
>
> : ptep is unmapped too early, so ptep could theoretically be accessed while
> : it's unmapped.  This might become a problem if/when CONFIG_HIGHPTE becomes
> : available on riscv.
> :
> : Fix it by deferring pte_unmap() until page table checking is done.
>
> I'll retain the Fixes:.  This doesn't imply cc:stable in MM, and anyone
> who backports the original patchset will want to know about this fixup.
Makes sense.


> And I queued a fixup for the thing Matthew noticed.
Thank you Andrew.

Pasha
