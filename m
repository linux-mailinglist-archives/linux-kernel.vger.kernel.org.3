Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC724FA601
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbiDIIda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiDIId0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:33:26 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435E42AF4;
        Sat,  9 Apr 2022 01:31:19 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t2so12366200qtw.9;
        Sat, 09 Apr 2022 01:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=ltAY4NbF/ZSQmQzIhU/4Ym22AhhgYTgYnlUh+8O5iJA=;
        b=cIJfldWO0aaKZ/s2g7WrzTjdvvmjd4AqSw4a7vCyoXHk9atITLN3cYXJZzBrxGWzS3
         2IAzSleIVK14v/0qzAT0xa7Ym+LPV4nMqqOA8jUcX5r3wKaMve1WbBiGNCAc830xTSGY
         Jkh8UkYcogL/RwuGGOdsFDAbTgnZLCKT/Y2XwHO/LQb+FFIVzG8zvyhxjQsQ4yp7LLYU
         Gr116iV2EuFE4Te/zywR072GzV9kYiSf5rRTZpvcxpJRqvLE/IiJZ/Bakjv75Q/90RpT
         rbtYmAfdKtdXLYdSrtYuNPUwNEYs2R9V+8omraLsLbqFILV5IU3gicQwCzn+qtxEZq/h
         I8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=ltAY4NbF/ZSQmQzIhU/4Ym22AhhgYTgYnlUh+8O5iJA=;
        b=DVsS/n2fIYhvgOHDFfQnUAeH8xLuYaqAqMggMkte/SRG0vNiZkhtzAGcQ9qywn/qJA
         YWHtdU+53ZBVgpIu9HMLQ9HebgteB23bHjvIU124qIvMe/gsNUAq0qMHss4i1tr1MRBD
         wnPP/6ei4Rt6Nyth5i8Kc7cI2dRrUKfunDtlYXGpgaQ4GOZHXTUzpPrD+Ng6ylZu9ehj
         1DbTUsW+v9Kq8OozXmCZgvD6Ddqkchu+CJ1KvkXrjDCyPYV/rqMNiLWP8o1jW4braGGo
         LeUdv+znODZWzAazdby5vqzV4hQKpG83b1XhqvaQ1WuubpD2jTFamswAlA5U5YH+C8S5
         /9xQ==
X-Gm-Message-State: AOAM531fuew+kK5UriMo2fugyqWOY1WK2Vevqlgmw7a7+PPHlSssXXbO
        6wMgd8r7vk1UtGntS5tST/o=
X-Google-Smtp-Source: ABdhPJyPw38hwLF/dooO3O86uxNY+G/TWkIEvyniY/+jSbTxqEMrcWm7UJDTy/nryC2ybFBUgzzGFQ==
X-Received: by 2002:ac8:124c:0:b0:2ed:e5d:d07e with SMTP id g12-20020ac8124c000000b002ed0e5dd07emr3274899qtj.231.1649493078308;
        Sat, 09 Apr 2022 01:31:18 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 14-20020a37090e000000b0069bfe98662csm260436qkj.17.2022.04.09.01.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 01:31:17 -0700 (PDT)
Message-ID: <62514455.1c69fb81.5db1c.0ef7@mx.google.com>
X-Google-Original-Message-ID: <20220409083114.GA2513948@cgel.zte@gmail.com>
Date:   Sat, 9 Apr 2022 08:31:14 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, david@redhat.com, corbet@lwn.net,
        bsingharora@gmail.com, mike.kravetz@oracle.com,
        yang.yang29@zte.com.cn, wang.yong12@zte.com.cn,
        ran.xiaokai@zte.com.cn, jiang.xuexin@zte.com.cn,
        thomas.orgis@uni-hamburg.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        sfr@canb.auug.org.au
Subject: Re: [PATCH v2] delayacct: track delays from write-protect copy
References: <20220409014342.2505532-1-yang.yang29@zte.com.cn>
 <YlE7ZVMfAhs4Ba27@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlE7ZVMfAhs4Ba27@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 09:53:09AM +0200, Peter Zijlstra wrote:
> On Sat, Apr 09, 2022 at 01:43:44AM +0000, cgel.zte@gmail.com wrote:
> > From: Yang Yang <yang.yang29@zte.com.cn>
> > 
> > Delay accounting does not track the delay of write-protect copy. When
> > tasks trigger many write-protect copys(include COW and unsharing of
> > anonymous pages[1]), it may spend a amount of time waiting for them.
> > To get the delay of tasks in write-protect copy, could help users to
> > evaluate the impact of using KSM or fork() or GUP.
> > 
> > Also update tools/accounting/getdelays.c:
> > 
> >     / # ./getdelays -dl -p 231
> >     print delayacct stats ON
> >     listen forever
> >     PID     231
> > 
> >     CPU             count     real total  virtual total    delay total  delay average
> >                      6247     1859000000     2154070021     1674255063          0.268ms
> >     IO              count    delay total  delay average
> >                         0              0              0ms
> >     SWAP            count    delay total  delay average
> >                         0              0              0ms
> >     RECLAIM         count    delay total  delay average
> >                         0              0              0ms
> >     THRASHING       count    delay total  delay average
> >                         0              0              0ms
> >     COMPACT         count    delay total  delay average
> >                         3          72758              0ms
> >     WPCOPY          count    delay total  delay average
> >                      3635      271567604              0ms
> > 
> > [1] commit 31cc5bc4af70("mm: support GUP-triggered unsharing of anonymous pages")
> > 
> > Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Jiang Xuexin <jiang.xuexin@zte.com.cn>
> > Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > Reviewed-by: wangyong <wang.yong12@zte.com.cn>
> 
> As per always; I refuse to take patches from cgel.zte@gmail.com. Because
> yet again From and Sender don't match.
> 
> If you want me to consider your email, please send from the email
> address you've listed in your SoB.
Very sorry to have this problem, because our company's mail system
(xx.zte.com.cn)has a little format problem, so we use gmail instead.

We do want to do a little work for the community, so sent patches
before it fixed. I will try to connect our mail system administrator
to solve it next time.

For this patch, it had been modified for several times, special thanks
to David Hildenbrand, so we hope to merge it(if no other problem).

Thanks!
