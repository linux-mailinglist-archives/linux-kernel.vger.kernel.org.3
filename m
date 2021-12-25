Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D0E47F437
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 19:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhLYSTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 13:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbhLYSTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 13:19:42 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B375C061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 10:19:42 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id p7so17902599ljj.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 10:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Eet2DOTt9N2FCnKhTSMQv7VraNOtLbXFUud1z4lNfWQ=;
        b=IPPITeuzagbGAOYzBYx5hHjxtGBYL6z/xyWZP7VNam/VlJUak/Ro9DZ/z4TT9CwZFj
         IM6SD+KUBgOgyAiZg8AajRmArf6o/1edk7wSgrqCAp6qgRuUZXyXe2Jwv8kBkGqYuQYw
         z0rtd5oh4S2cjBHEuj4B9QhBKI3Et3IYrxl/JGAZF8KPcp/nqC5n2gZlkPdgyH8nBwEz
         FOn4cBIcPLOj4rjFT9q8nr14phac37KLeJlA07AVVrKo3wmmkZvAuHeMrxECuUgg0NdA
         Oy63GI/Bt0sRDWbtchRd9TZ1BMHdJWRxBcGdz53ScIfdmJw+DkSp+x+SzIbAemWd0wvJ
         g0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Eet2DOTt9N2FCnKhTSMQv7VraNOtLbXFUud1z4lNfWQ=;
        b=ASMHhXdSLOpgzMqoHx41ic9kH9tGT7ieSnfq5QUxgX/hYUfDIl3+NCO0qVQm+Bkn2M
         E6F1iZtJyK87/GYFzPOrvaaG++Gkl+v7UPmpMNUKaQKbLfqSgd4EiaF5v/05/WoVoVTZ
         FLsR6mxWXCJWZ+Y9OpFSdkXpFR2begLVPP8dR8z/XqlFyQzk2OEMc+ZWm1OcvhyKH0Bk
         MAfvt2AqjWdRAC8BiwWgpG/9hu4jlYOievUoID7lEipHuDk2jvU/PSWE9hNoGYCsPn33
         PuIlKzGr1wcbSKRkWRu3Kcojcb4YUCD825Fl4yz57jHvWSZGAL/Mt89Le1eKZFt5kluw
         dr4Q==
X-Gm-Message-State: AOAM533+ipQQzEsgm1mNPpgwzJgZm6rF1P40uWllObCiuIHYBT9l+5Rm
        6NVp74sFjmVl4FXFjLeQEz+BHuML2i8=
X-Google-Smtp-Source: ABdhPJysz6tdYSDfA/n2nGuHihjtO7p4DujRww268V5QT82tRVyJ0qqPPEuGYF5mI02+ULaxqmq5PA==
X-Received: by 2002:a2e:9e43:: with SMTP id g3mr8089001ljk.291.1640456379591;
        Sat, 25 Dec 2021 10:19:39 -0800 (PST)
Received: from [192.168.1.11] ([94.103.235.97])
        by smtp.gmail.com with ESMTPSA id s14sm1173044lfg.43.2021.12.25.10.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Dec 2021 10:19:39 -0800 (PST)
Message-ID: <b2914fb5-4c60-9786-e06e-363904f0b12f@gmail.com>
Date:   Sat, 25 Dec 2021 21:19:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4] staging: r8188eu: Use strndup_user instead of
 kmalloc/copy_from_user
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20211225170436.111000-1-jiapeng.chong@linux.alibaba.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211225170436.111000-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/25/21 20:04, Jiapeng Chong wrote:
> This code assumes that the user is going to give us a NUL terminated
> string which is not necessarily true.
> 
> Fix following coccicheck warning:
> 
> ./drivers/staging/r8188eu/os_dep/ioctl_linux.c:4253:8-15: WARNING
> opportunity for memdup_user.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 2b42bd58b321 ("staging: r8188eu: introduce new os_dep dir for RTL8188eu driver")
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---

Subject line and commit message are completely unrelated to the change 
itself, please fix up.


With regards,
Pavel Skripkin
