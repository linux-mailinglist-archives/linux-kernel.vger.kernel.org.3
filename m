Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E3A4FA5A8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 09:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbiDIH4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 03:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbiDIH4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 03:56:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A03065823;
        Sat,  9 Apr 2022 00:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RdaGnqMln3670/kDQ7mKAMFJwaZLOEULPAbgvLVVG7U=; b=biNBw+AmPhGVWsLvNIg7LdLyPE
        Wc63D/ma3GbzIZqb0n5ZnVGBFo1bdg4BwXlt2nEq4GWfm0+AH0bdQ+OLovrDo/yizqEkE0eMZ28Qd
        W7hGJlAA5dknkANJSCSzuO+p1Hf3i+RGfBKpgCnRuF3RSgKJjA+P1xdMwSdX+8Al6+iRLqPFff4Oh
        ybI8THGQLShPPXH+pBPD1jVUqkAawRrDup/5UCYrv1Y1VIzm3zdvEg0KfYMDUdAh8oF63XK3/+XYU
        Dxr6c7fUYTuUGG6++JPc6AsXhv06dDmC/lEdj+yhgsaaznUHHOcaQDIKWYnMPXjhjelqWfGEXPPFr
        SRMu22OQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nd5uC-00AXsS-IM; Sat, 09 Apr 2022 07:53:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5DAE8300299;
        Sat,  9 Apr 2022 09:53:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C2B820C50BE8; Sat,  9 Apr 2022 09:53:09 +0200 (CEST)
Date:   Sat, 9 Apr 2022 09:53:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, david@redhat.com, corbet@lwn.net,
        bsingharora@gmail.com, mike.kravetz@oracle.com,
        yang.yang29@zte.com.cn, wang.yong12@zte.com.cn,
        ran.xiaokai@zte.com.cn, jiang.xuexin@zte.com.cn,
        thomas.orgis@uni-hamburg.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        sfr@canb.auug.org.au
Subject: Re: [PATCH v2] delayacct: track delays from write-protect copy
Message-ID: <YlE7ZVMfAhs4Ba27@hirez.programming.kicks-ass.net>
References: <20220409014342.2505532-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409014342.2505532-1-yang.yang29@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 01:43:44AM +0000, cgel.zte@gmail.com wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> Delay accounting does not track the delay of write-protect copy. When
> tasks trigger many write-protect copys(include COW and unsharing of
> anonymous pages[1]), it may spend a amount of time waiting for them.
> To get the delay of tasks in write-protect copy, could help users to
> evaluate the impact of using KSM or fork() or GUP.
> 
> Also update tools/accounting/getdelays.c:
> 
>     / # ./getdelays -dl -p 231
>     print delayacct stats ON
>     listen forever
>     PID     231
> 
>     CPU             count     real total  virtual total    delay total  delay average
>                      6247     1859000000     2154070021     1674255063          0.268ms
>     IO              count    delay total  delay average
>                         0              0              0ms
>     SWAP            count    delay total  delay average
>                         0              0              0ms
>     RECLAIM         count    delay total  delay average
>                         0              0              0ms
>     THRASHING       count    delay total  delay average
>                         0              0              0ms
>     COMPACT         count    delay total  delay average
>                         3          72758              0ms
>     WPCOPY          count    delay total  delay average
>                      3635      271567604              0ms
> 
> [1] commit 31cc5bc4af70("mm: support GUP-triggered unsharing of anonymous pages")
> 
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Jiang Xuexin <jiang.xuexin@zte.com.cn>
> Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> Reviewed-by: wangyong <wang.yong12@zte.com.cn>

As per always; I refuse to take patches from cgel.zte@gmail.com. Because
yet again From and Sender don't match.

If you want me to consider your email, please send from the email
address you've listed in your SoB.
