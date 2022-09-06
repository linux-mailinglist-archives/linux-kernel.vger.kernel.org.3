Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FE25AE732
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbiIFMGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbiIFMGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:06:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB1C7198D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662466011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RGpqE5m5QaiFSA67pC16kBNOXl7AVmO7xPOTMHh+Gfw=;
        b=Ejd4TdYYTJf6GezbDCgqVUwLFrkm1S2CSU1S9/gwv2Gl9yUfAe3ToegZk5p5Kzcuw6Xoal
        AKNaePAhogdPDmESdmMPb9py0iz76ll2wBsXW9WXLY0H1xgLZrd+1BEy+aZRnnovcCu1oY
        p7v3+Fe4pBMi5ka+GXbYwiMb4hOtZQY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-387-VLk6waJSPJ27PtTZiEehKw-1; Tue, 06 Sep 2022 08:06:50 -0400
X-MC-Unique: VLk6waJSPJ27PtTZiEehKw-1
Received: by mail-wr1-f72.google.com with SMTP id e18-20020adfa452000000b00228a420c389so1532723wra.16
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 05:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=RGpqE5m5QaiFSA67pC16kBNOXl7AVmO7xPOTMHh+Gfw=;
        b=068XwvDEGcL/EKwYQRqTOT88+FtLex1AHrywCr0iNCpyJ8UpxPliGuqBlPMHQ6GJgD
         UKRj2PtXmBp8ZNqwbJBt4o/+W0lBOjjWb/3D96/AWpoJZTGrDMjMMwSJ6eQO3vQKRq8u
         ARUr0MEOcPW009SxDRZBh0LAJ3+eYNYUELlv22i9iBr87dTe8OzYMRdZh+M7l54g+caR
         saxg3z42fHYWfRb7ppF1EZhRiWzTC3GbuAVm72wwHB5Q3lgMbzx/24a84mi+6NvOuEAV
         0iOpMjRnmHD70yiX1301Q5yQoDMZ9tu5uXje420d3V99WIIqz1NYqOYpRzFr5jaZyBHE
         kQLA==
X-Gm-Message-State: ACgBeo1ji2RWzm459ODtvGz9yeXW5HdP6/7LtywBuUfquNL+gKVAk7Xn
        9sMXdWOQL1Ji/vvYFRw7hbIfmVtnuoVmlyf7dIOB+px/zCK8mwkgQg5nUwr4mcUt1bviaSi5b7P
        acWtKifuglyr0x0h8hHjdFWch
X-Received: by 2002:a5d:522f:0:b0:228:dc7f:b9a8 with SMTP id i15-20020a5d522f000000b00228dc7fb9a8mr629545wra.617.1662466008873;
        Tue, 06 Sep 2022 05:06:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7wVRAPn+nQRA3VGK3/sSMxLAczDYrb2ttN1HEHs8klYENvMj+SrfXEPVr+09HY9rNOCLnY5Q==
X-Received: by 2002:a5d:522f:0:b0:228:dc7f:b9a8 with SMTP id i15-20020a5d522f000000b00228dc7fb9a8mr629537wra.617.1662466008731;
        Tue, 06 Sep 2022 05:06:48 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c19c900b003a53731f273sm15568443wmq.31.2022.09.06.05.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 05:06:48 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 0/5] cpumask: cleanup nr_cpu_ids vs nr_cpumask_bits mess
In-Reply-To: <YxcK+HXLQ8WBS9Ee@hirez.programming.kicks-ass.net>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <YxcK+HXLQ8WBS9Ee@hirez.programming.kicks-ass.net>
Date:   Tue, 06 Sep 2022 13:06:47 +0100
Message-ID: <xhsmhy1uwbtbc.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/22 10:55, Peter Zijlstra wrote:
> On Mon, Sep 05, 2022 at 04:08:15PM -0700, Yury Norov wrote:
>> cpumask subsystem uses nr_cpu_ids and nr_cpumask_bits interchangeably
>> despite that the variables have different meaning and purpose. It makes
>> some cpumask functions broken.
>>
>> This series cleans that mess and adds new config FORCE_NR_CPUS that
>> allows to optimize cpumask subsystem if the number of CPUs is known
>> at compile-time.
>
> Who will use this? Distro's can't, which means 99% of people will not
> use this ever. Is it worth it?

I'd tend to agree here.

One extra thing worth noting is CONFIG_CPUMASK_OFFSTACK=n cpumask_size()
still uses NR_CPUS under the hood, despite being (mostly) used to
dynamically allocate cpumasks. So having an unconditionnal

  #define nr_cpumask_bits nr_cpu_ids

would save up some memory for those allocations.

A quick compile test on x86 defconfig (OFFSTACK=n) gives me:

  Total: Before=18711411, After=18705653, chg -0.03%

If it's in the range of barely-half-a-page on other archs, could we just
do that then?

