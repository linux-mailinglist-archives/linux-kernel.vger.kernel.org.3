Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F8557CC82
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiGUNs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGUNsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:48:25 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2A31001
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:48:24 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id l11so2812913ybu.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mYg0pXExwxUW6uWYOtJRBBMxq1fhaTSolEX7wK8C8KA=;
        b=oxcNWd3bUI9mO4bfTJg5FFegz5mK7HDT8MmLyjAGh02VBNKNPGd3EYGzZp6tbtNkTt
         Nlat0xvdmkdYb04t7/NHGhCWe4YDT7JbXFPaCnziMyfWmwhwKyOcpRsuNe2D4FHIjNf5
         oq8B3XulrWuw69r8TIoY+zwC6dm2Zup8i6TrKYu4j34fzpTI5/4klQe2x6jUto7itvq3
         9ToXNdop0qcF9Brn5vZt7WvLZUtR0cK7NXbKHHB757V1sOY/PU5dn3vgl9rR7CR7mk8Y
         pWgS2Z9ZY6ECo9kl4gFSdi15t+r6zYIGvMdUKwWPgKfqoGsAjJh3fnvBGCHHgh4iFFXh
         Inlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYg0pXExwxUW6uWYOtJRBBMxq1fhaTSolEX7wK8C8KA=;
        b=WzefGnIl1TfNtYH8eiUeT0vuif7VQWM5qTTexl/QkzFF344SXxzDz7sETT9zvZoPXI
         n+hHzkgiSYZrYTEQnAGFe6AMQsT8VIIoNGoL99FTlcZ1lurxkbPcPu6/YBGTiURsf3dS
         GXuzPHsrcls4/s6lfXjTAiVnvDBxl7xK7ZKDqVsWU7rbKNmrSfoICGyRFEazE14ownoR
         S9lOGYuCzng4WQTK3vwUzuLurCs+rNfGuWNKh5XPRuVFU8cJzzgq7S6YoXb4B875QGpj
         69xekY7isx9WwMCCqbnW5hyr6YN5qzyeoQPUZPS4v2ai+Wi+XoDAzp2BRaXeb59VA9HS
         Ao9A==
X-Gm-Message-State: AJIora+dAl0mHJ870V27MCPWnPY3VP8BdL3nMoySWD1mdNY+4MVZxXFc
        EYKn6fiDFANKU/biBIafAf+SSj2gwPFzirgbdFtpjA==
X-Google-Smtp-Source: AGRyM1uw5xmLYGC/Gr6lj5CvGR4hMo/BK7xOaApowwLXRKW5wEw9IqTe5twBofh/1qHtyzFGDg/gratb6pk6lHg+ND0=
X-Received: by 2002:a25:5006:0:b0:670:9834:8767 with SMTP id
 e6-20020a255006000000b0067098348767mr6452844ybb.147.1658411303743; Thu, 21
 Jul 2022 06:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com> <20220712231328.5294-8-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220712231328.5294-8-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 21 Jul 2022 15:47:47 +0200
Message-ID: <CAG_fn=WTzXSVFQecQwLBpzgobH8b1ayU_N7DrpmFyguAdcXSMg@mail.gmail.com>
Subject: Re: [PATCHv5 07/13] x86: Expose untagging mask in /proc/$PID/arch_status
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 1:13 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Add a line in /proc/$PID/arch_status to report untag_mask. It can be
> used to find out LAM status of the process from the outside. It is
> useful for debuggers.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Alexander Potapenko <glider@google.com>
