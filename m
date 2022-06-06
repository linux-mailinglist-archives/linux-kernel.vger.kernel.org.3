Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E71453E95F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbiFFO31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbiFFO3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:29:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B9EC7E3A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:29:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i1so12237983plg.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TFLEIjRx+aSYvMhZeHjAivjN2q9x2X4PUbVTc44Yjww=;
        b=KpSIkmnv1ezDYRrt9QuA0WGeAgeyMDBnkOrR5VLDMDybyQH5r/Pc7Xm/1q2PjQPyNR
         YFO8GcikzzBOVGkI2D8LqeMyDliFqjnxL+I+VRn/LvhnzrOJuGHWX6UBvBsbogKgpzkQ
         Ey2YW8or0Qnvtuuk3uk+bxROgvwAoJunx5ilC61bKNaZBMdElKVD54xJ4XoReMB8D79K
         XiRCcMQ7WZNIn8kSizWaHDwjha+d21KmKmzzXPScRzcxyUN+SFHMeT9fMV85Bs2/A6s4
         a48mwBDtd9c6DvAYlGO5+WQFvqrFjMkc4E+su9RZHlCI33FAJaettKb0w9jQxJzrEjkd
         pPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TFLEIjRx+aSYvMhZeHjAivjN2q9x2X4PUbVTc44Yjww=;
        b=dDiglPpRdut9px4VGdA+C3WGKpawgugnmuzSc6Za2iVwXpA9Y5IqGZ9yZR9msCVVOY
         hKDToASSCY9h5OxJj2rW6jY/BI6bFOQaIq0Kuy4lTl+YW402YFIwt7BTjT0bUosJ7NN2
         jNG2Mwe7wu7qQylz0s1EnxKxZHXUMIalYeUzSYp8Dws42K+84HK3KcMg8wjF05urkc4I
         7dYyPIcr6k3u7BySnIUn1Zz1wj9JxYWadvMV7ohzZDbQdRWYFt1fhrVmBsq41m3h3WJS
         VV5+BakULjXsLdK5pQnMxnbUu3fbQVO8xgfzycK82got8hQbOrKnywWTVdvsKQ/Ej5j3
         QXVg==
X-Gm-Message-State: AOAM531u+w28W4fOvy/Xw7a6G8jXJJ1lPQOh+zASHYojBWWaTm5qyuO9
        jm7poLZlCdYRNcpCbB48Kfc=
X-Google-Smtp-Source: ABdhPJw+JhxDzx1oc/r32eWMwHM+WKNYE+9IOZc5mNyQ51ypFIOWJNDZ0mVGpdxwA5h8Zm9NT+01bw==
X-Received: by 2002:a17:90b:180e:b0:1e8:3023:eeb9 with SMTP id lw14-20020a17090b180e00b001e83023eeb9mr19301337pjb.55.1654525761401;
        Mon, 06 Jun 2022 07:29:21 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id a3-20020a170903100300b0015ea4173bd6sm10497475plb.195.2022.06.06.07.29.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2022 07:29:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] x86/mm/tlb: avoid reading mm_tlb_gen when possible
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20220328103551.GY8939@worktop.programming.kicks-ass.net>
Date:   Mon, 6 Jun 2022 07:29:17 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: 7bit
Message-Id: <8F17ACF3-D1AC-4330-9E44-B718F598CD6E@gmail.com>
References: <20220322220757.8607-1-namit@vmware.com>
 <20220328103551.GY8939@worktop.programming.kicks-ass.net>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 28, 2022, at 3:35 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Mar 22, 2022 at 10:07:57PM +0000, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>> 
>> On extreme TLB shootdown storms, the mm's tlb_gen cacheline is highly
>> contended and reading it should (arguably) be avoided as much as
>> possible.
>> 
>> Currently, flush_tlb_func() reads the mm's tlb_gen unconditionally,
>> even when it is not necessary (e.g., the mm was already switched).
>> This is wasteful.
>> 
>> Moreover, one of the existing optimizations is to read mm's tlb_gen to
>> see if there are additional in-flight TLB invalidations and flush the
>> entire TLB in such a case. However, if the request's tlb_gen was already
>> flushed, the benefit of checking the mm's tlb_gen is likely to be offset
>> by the overhead of the check itself.
>> 
>> Running will-it-scale with tlb_flush1_threads show a considerable
>> benefit on 56-core Skylake (up to +24%):
>> 
>> threads		Baseline (v5.17+)	+Patch
>> 1		159960			160202
>> 5		310808			308378 (-0.7%)
>> 10		479110			490728
>> 15		526771			562528
>> 20		534495			587316
>> 25		547462			628296
>> 30		579616			666313
>> 35		594134			701814
>> 40		612288			732967
>> 45		617517			749727
>> 50		637476			735497
>> 55		614363			778913 (+24%)
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Ping?

