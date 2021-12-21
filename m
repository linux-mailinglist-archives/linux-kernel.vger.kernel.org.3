Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8407447C170
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbhLUOYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbhLUOYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:24:49 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D75C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:24:49 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id m24so10864778pls.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=cLkvxmmpuEZaFih+WohbYipB6VYzB16BcCBqKzVBa28=;
        b=aZvD0T10xjL70xBG6nrHdpJo633d5UrYE93iwitnJgfH285fdrat7fpPUvDu2YBopW
         KTa0EiGmjXRDIUw/XJaUMVfeoGMWM6lvSwBvloI8qQCuWUN0tFMj3jBNrfXGZOleOTaV
         Ix8rhQpQ9cdIG2IATWzZqXcfgoiKNGbu1ZlsERE9EG2wIggYO4QarAkUY/ZZnHCdbrqZ
         ZssszCy09ti8XmPOirqmFnCpVaOriUjHyiyO9qOmbtrPw9vxI4tuRvatUCyZgJsWctCB
         FxaXys/3lrKkMr9FOwOMQzUAYpxEZJ6llKV1XQvplIvjm7poguSrCWemop3uOmZCZx5A
         7RFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cLkvxmmpuEZaFih+WohbYipB6VYzB16BcCBqKzVBa28=;
        b=wS0IXjB01L8APMXE3EtW40dobbWZFhZcpD/cPXY0gg10D2EIrNy3duuB+X0n/+/kdw
         /EYvVbh1A93Equ1MAKEUBDRf5fiGCEEm9AdAa6H49BVtdvlED/oRNvvq4VQTxgEzMh1k
         kVgoXRgcdBcb58LuE9wKUYh+zpEd5/+x+SxfUB4mYXLXbIkNi8afNFgWc20OmCqRhhIW
         vy+pCzPktqqHY2npIOaEYTbaiRT6ycqlGAx8C5EsrqTXIsxr8M08g8/C3Bk+0h3DoS15
         P/TG6xH8wvJ1KAaZuzxRQ50lAduRkzkm0BkoW4D7akG2J0yIIGWuvh9W+OD83SVCBLfh
         s+fQ==
X-Gm-Message-State: AOAM530KUvj3aNIT8RuvgPQ016IWsOdMdW84J7qDRWnsnRDGKi/qEh05
        q8J4iLIrGr8FQuODkgVrw1Wig7cOHapk5EZeISw=
X-Google-Smtp-Source: ABdhPJy9DyVWNvICSIfWIV3uumeU3kNyTWiKRonBxMMPuHU5/XLyKhHbOYqY5RrZ5B82/EDuhes4Ow==
X-Received: by 2002:a17:902:ba84:b0:142:5514:8dd6 with SMTP id k4-20020a170902ba8400b0014255148dd6mr3564486pls.19.1640096688641;
        Tue, 21 Dec 2021 06:24:48 -0800 (PST)
Received: from [30.240.97.243] ([205.204.117.107])
        by smtp.gmail.com with ESMTPSA id f14sm3005238pfv.215.2021.12.21.06.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 06:24:48 -0800 (PST)
Message-ID: <5adf42d2-649d-adcc-4598-26263ca27a31@gmail.com>
Date:   Tue, 21 Dec 2021 22:24:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v2] virtio_mem: fix panic on mb_states indexing overflow
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vbabka@suse.cz, ziy@nvidia.com
References: <e60a66f60c059237bbf5cec3623c162a1bb1cbcb.1640005703.git.renzhen.rz@alibaba-inc.com>
 <32103255-7eba-08c1-8ab8-0730486332c1@redhat.com>
 <c7f5f829-5f2f-0c57-0599-6fc20fc8f1d7@gmail.com>
 <14ac1cb4-1cf0-03a3-d412-c35fa9eeea59@redhat.com>
From:   Eric Ren <renzhengeek@gmail.com>
In-Reply-To: <14ac1cb4-1cf0-03a3-d412-c35fa9eeea59@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

在 12/21/21 9:53 PM, David Hildenbrand 写道:
> Hi Eric,
>
>> _vm->sbm.first_mb_id == 0
> ^ that's precisely what I meant.
Ah, finally got it!
>
> How could it *ever* be safe on x86-64 to let a virtio-mem device start
> on physical address 0, eventually overlapping essentially all DMA, the
> BIOS and the PCI hole.
You're right! That clears my doubt why this "issue" can live so long 
there... util I see it.

Yes, my setup is a very hacking enviroment. The device region start addr 
is wrongly
assigned to 0!

So, let's just drop this patch.

Eric
>
> Thus my question: Is this a "fix" for x86-64 or is this a "prepare for"
> for !x86-64 (e.g., arm64).
>
> If it's a fix, we want proper "Fixes:" and "Cc: stable" tags. But I
> assume this is much rather a preparation for another architecture than
> x86-64.
>
> Thanks!
>

