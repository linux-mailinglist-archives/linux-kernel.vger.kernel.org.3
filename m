Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307384A99F6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358755AbiBDNcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353799AbiBDNc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:32:29 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EBFC06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 05:32:29 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id h23so5026268pgk.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 05:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UbGuJT+82u/r5OVFIMOVDfayUzP0EGS/g4aR/lRMEDU=;
        b=tb319ZxJaT2G2jEsLg001lXCi1v5OjI0tcX3tYb96s6yhPSV74Av/Fmqv0P0FhrD7G
         s2KWFILCJ5Oe0/99QkM+8m8DWTGV1SDpUTKkSEDRGLnXb7mFRWlTwa9OyG+pZVFThbUg
         rYfdGtniBA03bJjxGVdaQl6ucJZuNbaP7KhiG9fD1L61EpDe3plJ3LfLi9tciIE5Iv7a
         mVRSxtjXq27G3q1MSzQc7EMJ3TBmmwQDnV0PsyF6L/Pih5jw/Bz24fS+cxAnAe5pbEeD
         2zG+kzzIf0gF2GH7cIe7EgjqwptmQB9eylyoXBg9MZBZ+fmNMejHy8r7jHrrx4IhOgwi
         HcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UbGuJT+82u/r5OVFIMOVDfayUzP0EGS/g4aR/lRMEDU=;
        b=vRwIBP8XHND2PIDtxGlkA/rjlpuMOvIw63oFE8v81FyzA4PZ+vnsCO0Jv3yzXDlt2M
         gcLYemi7QFspxIW1JLZ+kq8+HRyGVZI7FIoZp/E+CIIxJfSRwOqYMH9CYCPgfHyzk1pv
         aDfWuKg7LIHsdSzca3JUs2HETe/5oyHpo5sldN/Pe32bsQ1ZZ6XSKoRgIq9ytVJ4xnMl
         CncE969Q436apHjXJrzvwIe9+UZe0DIngU/mVcAC0j55PIb7vgfPoUA6tpfdUlEYt8Eg
         UbHceZVfgpYVW1lNF3U3FWPyoe+tC4nx8ZXuBp+DWWmC04lvx749JC4o+k3eWn8HeTmt
         VZZw==
X-Gm-Message-State: AOAM530kUOG+UhWMFhQ4yTfy0CDFscftxP7n/WcN0Xk05AP8nhqMi3Qv
        UVgEfHJEvFGSSGtKfG2gvFkxcw==
X-Google-Smtp-Source: ABdhPJwqTE9JG+YJdZ4CiM388CYHQbBhyS5L72K7Y633EUO/ynw8J+ru2L9V+JSjCIgU1JgykhkwhQ==
X-Received: by 2002:a63:f711:: with SMTP id x17mr2395738pgh.274.1643981548461;
        Fri, 04 Feb 2022 05:32:28 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o5sm2727140pfk.172.2022.02.04.05.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 05:32:28 -0800 (PST)
Subject: Re: Partial direct-io loop regression in 5.17-rc
To:     Milan Broz <gmazyland@gmail.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Kozina <okozina@redhat.com>
References: <feb7e4b4-1a6f-71a7-0cdd-fda547408bea@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <08e1dbde-b27c-fd99-294c-8e4715b92576@kernel.dk>
Date:   Fri, 4 Feb 2022 06:32:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <feb7e4b4-1a6f-71a7-0cdd-fda547408bea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 2:22 AM, Milan Broz wrote:
> Hi Jens,
> 
> It seems that there is a regression in direct-io over loop for partial
> direct-io reads (or perhaps even for other situations).
> 
> If I run this code (loop over 6M file, dd direct-io read with 4M blocks)
> 
> IMG=tst.img
> LOOP=/dev/loop66
> 
> truncate -s 6M $IMG
> losetup $LOOP $IMG
> dd if=$LOOP of=/dev/null bs=4M iflag=direct
> losetup -d $LOOP
> 
> 
> on older kernel (<=5.16) it reads the whole file
>    6291456 bytes (6.3 MB, 6.0 MiB) copied, 0.201591 s, 31.2 MB/s
> 
> 
> while on 5.17-rc (tested on today/s Linus' git) it reads only the full blocks:
>    4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.201904 s, 20.8 MB/s
> 
> No error reported, exit code is 0.

Can you try:

https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.17&id=3e1f941dd9f33776b3df4e30f741fe445ff773f3

-- 
Jens Axboe

