Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A53568361
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiGFJYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiGFJYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:24:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFCE17A86;
        Wed,  6 Jul 2022 02:24:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u12so25966873eja.8;
        Wed, 06 Jul 2022 02:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mH3EsXz6QKYwAcafuhaDfR4s9oNm5ypp5DWlodyKTRg=;
        b=T2E05GBaGL/11rGkmcjP8ofYsha1Lg1NrGjhf6Vf6PTqLFE1sxhfYNGxKRyCaym7zt
         7Cqy83eanVyRZ3X+FBg+xvSAC4LlkRn4bnPxuCe8rqoO9N3rwoA8jGPx6R7LlR4HY8ZX
         K1+DpaK1ni2AqrjsGHjcPKXusGVUho0vbdAoRe0vmruxy3c+UrOK5bMxZ60uMSGHgkZ1
         CNrR300sNqAAb2KamGxILiztzoP6sLO7e8kO9T4Yx81h0JzOFzK5+sj6GmAdmMjvOtKr
         KzmCpnF3KgmBiu8gEcb/VKPj17cD1M0XqFnXR9R58KkQqsExDINO3zUTauu5WDfxlQOk
         GGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mH3EsXz6QKYwAcafuhaDfR4s9oNm5ypp5DWlodyKTRg=;
        b=Avkh0pU+FCY23zWyGjLTC2IgVHNS1IZmvDrgpNWA/6f+iBkUiEQ9JMg36QxaLr5E0d
         jcZlfKx0LiLjm2o3TLZCqAEayhqw4XZRVOgh4FGMnMqjjBa447sySwCvV7nZFwItiYHS
         4Db25bKKTocQp1g//4xCj9SBZYzdf11jN9gKZkZA12479sJRB4+03/yYLudvwAYpXAZG
         j8TbPCoEbckn5GOu6tF9h9KHTFDZK6HqVBbwKEnx7JKCH3nmyzNzAd6Vz88zT6jInk/s
         mnb2dFVL12TWlYiuZ5m1eQOxRuzDwmPpgkm52C+Lyi0RR3FN5r7NxPajc3PGZONcjUUk
         z/aw==
X-Gm-Message-State: AJIora+LsN3Ejv8IUK7TAifdTeMhE41h2IRgNeskF+SLoAvf33JEibJh
        zWWEjmuTuXzBQyB4aWHE+wUVWrUt1cJY
X-Google-Smtp-Source: AGRyM1vHsjMQWhvXLrUH9P2YfOB8CTmQmNkcv3PLEUqJjzfaQBpZuSMiCotecRvuygXLLFWawjsfpA==
X-Received: by 2002:a17:906:2bc2:b0:726:d02f:dea with SMTP id n2-20020a1709062bc200b00726d02f0deamr38414559ejg.60.1657099455050;
        Wed, 06 Jul 2022 02:24:15 -0700 (PDT)
Received: from localhost.localdomain ([46.53.251.51])
        by smtp.gmail.com with ESMTPSA id u5-20020a170906068500b00703671ebe65sm16937724ejb.198.2022.07.06.02.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:24:14 -0700 (PDT)
Date:   Wed, 6 Jul 2022 12:24:12 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Hemment <markhemm@googlemail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        patrice.chotard@foss.st.com, Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Hugh Dickins <hughd@google.com>, patches@lists.linux.dev,
        Linux-MM <linux-mm@kvack.org>, mm-commits@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH -final] x86/clear_user: Make it faster
Message-ID: <YsVUvK/zQaIW749P@localhost.localdomain>
References: <CAHk-=whCmmipbBDips0OJ=UiBUjZfgBGYruoOsqcq2TVd5kBSA@mail.gmail.com>
 <YnqqhmYv75p+xl73@zn.tnic>
 <Ynq1nVpu1xCpjnXm@zn.tnic>
 <YozQZMyQ0NDdD8cH@zn.tnic>
 <YrMlVBoDxB21l/kD@zn.tnic>
 <CAHk-=wgmOfipHDvshwooTV81hMh6FHieSvhgGVWZMX8w+E-2DQ@mail.gmail.com>
 <YrN4DdR9HN0srNWe@zn.tnic>
 <CAHk-=wj_MeMUnKyRDuQTiU1OmQ=gfZVZhcD=G7Uma=1gkKkzxg@mail.gmail.com>
 <YrQ1PPB77PBWyaHs@zn.tnic>
 <YsRuUl24zkhpE3s/@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsRuUl24zkhpE3s/@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 07:01:06PM +0200, Borislav Petkov wrote:

> +	asm volatile(
> +		"1:\n\t"
> +		ALTERNATIVE_3("rep stosb",
> +			      "call clear_user_erms",	  ALT_NOT(X86_FEATURE_FSRM),
> +			      "call clear_user_rep_good", ALT_NOT(X86_FEATURE_ERMS),
> +			      "call clear_user_original", ALT_NOT(X86_FEATURE_REP_GOOD))
> +		"2:\n"
> +	       _ASM_EXTABLE_UA(1b, 2b)
> +	       : "+&c" (size), "+&D" (addr), ASM_CALL_CONSTRAINT
> +	       : "a" (0)
> +		/* rep_good clobbers %rdx */
> +	       : "rdx");

"+c" and "+D" should be enough for 1 instruction assembly?
