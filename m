Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C77483B47
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 05:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiADE0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 23:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiADE0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 23:26:02 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608E4C061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 20:26:02 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id d14so27427822ila.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 20:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vij5nkHSlsH/FGJLjrs1+obkJ7Ro/bx/HwYUNsX7fYg=;
        b=n6ycA3XXCbLy47knEWpKD34JeA8ETb8B0KV+dwKYK4eJGVYwE0Rvu0G54t0qhrUVVF
         cSjQEyhFR/Yz9uPiREfTaBpoHjf8YY/eNn0QI2fLveGgteNmSJLzpY/1OD8kYZHJX6Ea
         CBREzfFk9XU3aZXSiPZGRqYCkXDlkmrmcFhm8wrZnq6SuYJr7Ub6nDTl9hcbCJqKrPwK
         sFLDBcCoHGdqCUfRtgHHU22owuSI1t1z6ug3FW0bA5fgJEXTuIgz2KxGMH709SjvM3jJ
         Agt3GqxnZey9N51qnEea+ad9Ck3/72gRJfjn7QYU+dmeC+ImwnOd33uWem6k+qCYfuot
         u6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vij5nkHSlsH/FGJLjrs1+obkJ7Ro/bx/HwYUNsX7fYg=;
        b=1udkBLbXptPDFT6tPkEoqotr7qz2lD+zPlQzeUJncwwZ20HAkFb2dSvL6a0uoDpWeo
         EHtVOiJOo4qXexInq529A/9OmzQ439qsyQ5o4Bhs2HnxGbQ9P0eXlcXrj/ABhkORzvVu
         cY+imYWMVsgwOYsKqStu5LxkMe9XxfAUCX7SW1DbJwp/0E7nRiumpKg50uNb0pKpTnM+
         XGKJgLe7q4JxRd/E48s8skHWbaEfTmaQ2wJDWE3dqExaMUVZ+jpCIL64ZlJZvsrS48ye
         ycUdlu/bZftNwM4k/gqcfDKm3PqMb4WlXX7U2y59Q0IqflSrlzzVkWuIwLUH5+hX4fv9
         rxLA==
X-Gm-Message-State: AOAM530hAstcAJP80n3GfgNiRw/8ksPgvvJIqpGsbNM72X9O2SzB5m8v
        sKv3wqPhisTf2L1pEd/h9NmKhdD298Nq0Q==
X-Google-Smtp-Source: ABdhPJyTKekCKbRgotBTNfLVoBraeZg+yA08JFsN7ScZWxlYoswvBoHbN5Ll7A5kpNaXTl+WBnREXQ==
X-Received: by 2002:a92:c7c4:: with SMTP id g4mr22404671ilk.112.1641270361648;
        Mon, 03 Jan 2022 20:26:01 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u14sm22054068ill.70.2022.01.03.20.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 20:26:01 -0800 (PST)
Subject: Re: [Regression] md/raid1: write-intent logging/bitmap issue since
 fd3b6975e9c1 - v5.16-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Norbert Warmuth <nwarmuth@t-online.de>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Song Liu <songliubraving@fb.com>, linux-raid@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <m3tuekbos5.fsf@nogrod.ivcecceob.t-online.de>
 <CAHk-=whzdxBuoeTP1uJrxRQYtwOxPDYuP92c8e=_K5T1xHy7Ug@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eddcc94a-2cd4-6258-5614-88c4d1dbbca2@kernel.dk>
Date:   Mon, 3 Jan 2022 21:26:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whzdxBuoeTP1uJrxRQYtwOxPDYuP92c8e=_K5T1xHy7Ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/22 11:53 AM, Linus Torvalds wrote:
> [ Jens wasn't cc'd for some reason but was the signer-off-on the patch
> you bisected to. Added him to the cc. I'll bounce the original
> separately, as I also don't see this on lore.kernel.org - it might not
> have gotten there yet ]

Thanks for adding me in, Song took care of it now. Will get sent out
shortly.

-- 
Jens Axboe

