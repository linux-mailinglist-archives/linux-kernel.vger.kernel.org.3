Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F785AD008
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237794AbiIEKTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbiIEKSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:18:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B97753014
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:17:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q3so8001285pjg.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 03:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=F0ddXFVLxsyluskjlQCTzOkpXw/Iq5ze8DpeLG6TX/8=;
        b=ZKiFiuxy/bJNdyZsis/2GMHJnWZKLPLWmKNo/OlfL+iAGLD/H/nqM6nR8jgAXrij+O
         n46QHM71KCKpys9Js1hB0qdJa4QA4gOky5ZHGuiPTesuRIW2o2YhrAdahEVazSdipXqG
         eNhOMzXg6X6bL2uLwlvFY3gDtD6BmMIFmTuqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=F0ddXFVLxsyluskjlQCTzOkpXw/Iq5ze8DpeLG6TX/8=;
        b=AXw73YiAvBjZAFEzen20GLLuzzQhNV5ZgYoUbSEAxGebNUOSFvhgzrvt64C0ZPeWKo
         6AzYnleufmgP+nBHx5QGsbufZzDHgvaifwHl520VVhIU0cjsdsv+EHy5YLkWA2VSVUhM
         mm6TuO0HlaTLrupFV8l4HjE01a1wH3IbnsNVmFAxTBofhYDE+3DL8h2i9G5RmVH37OTY
         WAb0wLRa9Z1CIW0GpRj2VxBun4Jb2tfTXoDP7cOfCybW5NSzqovuUgasCg0blrE9n00C
         k0hOOa+e9GAQ/V4+WWxbQvKr8j0hjcEFfRp+XQhcKwkqKWOBWVj9pCEKvk1mnh5bxRW5
         UUbw==
X-Gm-Message-State: ACgBeo3EYGH1+K9l/HTHmaJNFt/Bu/svaU398+VxOdD+0PJYJH27lwCE
        XDDErbfXk3UgnnP6B4c2zYdyIsM4eWqs1A==
X-Google-Smtp-Source: AA6agR7cQ6Kdc7lDA6p+oTLhOt05qMwgjkaiG/8Sj4vFtvXw6tmM2bKARpAGBYRvbaAPM0qvjdAywg==
X-Received: by 2002:a17:90a:6b4c:b0:1fa:d973:e4eb with SMTP id x12-20020a17090a6b4c00b001fad973e4ebmr18424093pjl.15.1662373077690;
        Mon, 05 Sep 2022 03:17:57 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:5167:aa6c:9829:64dd])
        by smtp.gmail.com with ESMTPSA id v28-20020aa799dc000000b00537ab89c66csm7630564pfi.143.2022.09.05.03.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 03:17:57 -0700 (PDT)
Date:   Mon, 5 Sep 2022 19:17:52 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC 4/7] zram: Introduce recompress sysfs knob
Message-ID: <YxXM0PwVEghPF9hg@google.com>
References: <20220905081552.2740917-1-senozhatsky@chromium.org>
 <20220905081552.2740917-8-senozhatsky@chromium.org>
 <CAGsJ_4yciyk49cTk9A4di2sM=io-4z5oi4Q7P-SUOG-MGJGcQg@mail.gmail.com>
 <YxXHFZ1PJI3h6BZY@google.com>
 <CAGsJ_4zqXJJHA02NzyZ662jfL+sNp3LrErTP18vGz2N4u1Tqiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zqXJJHA02NzyZ662jfL+sNp3LrErTP18vGz2N4u1Tqiw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/05 22:06), Barry Song wrote:
> 
> make sense! thanks! i assume you will have some benchmark data to compare
> three cases,
> 1. lzo with recompress zstd
> 2. always use lzo
> 3. always use zstd
> 
> such as power consumption, cpu utilization, available memory, benefits to user
> experiences especially to UI smoothness under memory pressure?

So I didn't want to include any benchmarks, because this is entirely
specific to device's data sets/patterns. In term of CPU usage, zstd
decompression is really fast [1]; and the way plan to use is battery
aware - e.g. when low on battery do not recompress at all, if AC is
plugged in then recompress more aggressively, etc.

In term of benchmarks... a copy paste from our internal tests. But
*do note* that this is relative only to our specific data sets.
Your millage may vary.

ZSTD recomp algorithm (5.10 kernel, so the last column is the number of
'zram huge pages'):

- Initial state of zram swap partition
localhost ~ # cat /sys/block/zram0/mm_stat 
8955662336 2180671776 2277711872        0 3179720704   798724   469474   118949

- Recompress HUGE objects only
localhost ~ # echo huge > /sys/block/zram0/recompress 
localhost ~ # cat /sys/block/zram0/mm_stat 
8944390144 2106998658 2211835904        0 3179720704   798617   469474    66821

- Recompress IDLE pages that are >= 3000 bytes in size
localhost ~ # echo 3000 > /sys/block/zram0/recompress 
localhost ~ # cat /sys/block/zram0/mm_stat 
8934166528 2085232505 2207690752        0 3179720704   798484   469474    66811

- Recompress the remaining IDLE pages that are >= 2000 bytes in size
localhost ~ # echo 2000 > /sys/block/zram0/recompress 
localhost ~ # cat /sys/block/zram0/mm_stat 
8913981440 1946488434 2145157120        0 3179720704   798130   469474    66498

- Recompress the remaining IDLE pages that are >= 1000 bytes in size
localhost ~ # echo 1000 > /sys/block/zram0/recompress 
localhost ~ # cat /sys/block/zram0/mm_stat 
8905592832 1711533182 1984495616        0 3179720704   797162   469474    66222

[1] https://facebook.github.io/zstd/
