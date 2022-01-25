Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B1A49B30B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382624AbiAYLmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353399AbiAYLi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:38:28 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1087C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 03:38:20 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id w21so36765053uan.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 03:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Ix6kgvVL8Nx/8c4lClNn1uhhNmlmsg5FomNs+dQrm8=;
        b=TcL2zqIFyGmrSBGXnAzZyHWTQCUfrOmoLawiiEfG/DbKVQHFUwvWQhFmaP3z4heST0
         D7lj5aDTwFmiZ4fv86t6Au3RLSY9DsKr9q3CsLn8uNbYuCVU4OUTML/1JuvNyJ+tL21G
         pWsYQScqliIvmP5FQH94O68/Caosku1u4aLNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Ix6kgvVL8Nx/8c4lClNn1uhhNmlmsg5FomNs+dQrm8=;
        b=yyx8zSrWSJ6EvfQxyMCozKALPKkowH5QgSyqU+pq3SXh0uw8OUKci0tz8/jCBfTBDx
         bGUzWBe42NuCD10U4EsrydXYvR2eyzHf2ywNnk92i3cqJMT7AVuxMJrys96nHSUMNOLO
         Ae79+yEiwe3RmCCShUeMlNIzpvElFF8i6rNDf+Q8q8EMem/AQIq6VPN/Z4Fim+sRiH7W
         oWE1TwSGRN/xMEVdELLdjFp+Iqc/RKQKyCnwi7mULxVG2OwN3AoDrFpeX95n+cS2MhBt
         0/Fgf1bc865huKFKoGVSNlDDzSI47YKQpyIT4mRiUdQGdM11fYKQsfn/YzkYMmUDRHW9
         YTSQ==
X-Gm-Message-State: AOAM530c5vPcdKaAXC00RNjOUY//1wsXhYKQU/rhwgN2s3nNUt9ij4H0
        aBMIlXjGxBImaWumc4T4IgPSd9kNOZnLYbE0EvF9Jg==
X-Google-Smtp-Source: ABdhPJxUdxt1YoKPBp18HqqmTSJHdv14fBYM59nqNk9gfC62QoUo/N5B+/KzsQ+U3nKBgwu/DraVMQvVj57wkIiQCSw=
X-Received: by 2002:a67:26c1:: with SMTP id m184mr6848398vsm.48.1643110699766;
 Tue, 25 Jan 2022 03:38:19 -0800 (PST)
MIME-Version: 1.0
References: <1643040870.3bwvk3sis4.none.ref@localhost> <1643040870.3bwvk3sis4.none@localhost>
In-Reply-To: <1643040870.3bwvk3sis4.none@localhost>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 25 Jan 2022 20:38:09 +0900
Message-ID: <CAFr9PXk0XxXN4rWhwe_hVc8npXcVc=vb7QEmiwYaydMhXrjquQ@mail.gmail.com>
Subject: Re: "blk-mq: fix tag_get wait task can't be awakened" causes hangs
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Laibin Qiu <qiulaibin@huawei.com>, axboe@kernel.dk,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-block@vger.kernel.org, john.garry@huawei.com,
        ming.lei@redhat.com, martin.petersen@oracle.com, hare@suse.de,
        Andrew Morton <akpm@linux-foundation.org>, bvanassche@acm.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Same issue here. I just spent an hour bisecting the issue and hit the
same commit you did.

If I try to dd from a USB card reader to null I can see a few commands
wake up the thread that usb storage uses and then nothing more.
The user process then blocks forever waiting for the data it asked for.

Cheers,

Daniel
