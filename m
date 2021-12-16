Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5AE477564
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbhLPPIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238336AbhLPPIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:08:10 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA36C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:08:09 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id q74so65311030ybq.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6pE3NqnXz9siytYRdR4wrsPlbhZQqG3dKNjNWE8EgQ=;
        b=vD2bNAVedHhtm7Cb3CYZ3/DDlhVTOCPbqQsfCfv6nFSus0HHlySKST88+VrblGIFYJ
         /XNx7KnjTYTv+m9ZRhFdEU0qOFjTaZrYWiJBGwDu2MIn86l8wDGRJBIbWzj3z6GJS/4R
         mlYuqC5XZSq3kQdJahTkt5Rgv8jVYHmmtMasXLnDP6KQ6hc22hHN99snZDsw6Rwrjl4l
         HKna1sT5ncXoODnDRziA74eF7x3aq+2gxYCpIOKKR7qNZwi/oP/nQ5GNPWp+TKmH6aeP
         HTj0cw8TAnhN0lJo+AijYLmXKN7lIYx0lu5xxVZA8VaEcOu0d4YQhUuHvhcdzNDhM4LW
         WYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6pE3NqnXz9siytYRdR4wrsPlbhZQqG3dKNjNWE8EgQ=;
        b=7HcMO2DD+qBd/g/XDtl22RfSoaGMgaAc3dfDwTZJVVqktYAqo6mzpvFMtLjWw6MVw6
         Y3aa3/80NlpCnHb3ZVhACkTBQfy+vCNGz3y4u/fTGw0y0skB+Sgobv4uiRlq1vOqn/x6
         ZlpJjKC8uiuZzDiQTmEq+xhHtfAqC0cwjEAaVS9ZZFMJdEwuMpsG+TYzyhfBbriGK+If
         9GyiY9aTt9JsZfcVJaOfsxYh5VazSGJFazTVRJXzwG9oG4tWG5s9nvS1FC3Z8NhUqEZb
         UHW07SoydyDa1oXXVcPBiMuUuuEj4kiFLkHPoOAbdfgyYCfd2UjeeTZ8GFLMrfilef4Y
         /xOA==
X-Gm-Message-State: AOAM531zD96eaGunA4sycdqo/72b1BtWopENZwvnpSUynXPbpOU8FA6u
        hbNnYSYJBKYeYdbUAdCjxRZfek2mqZr6qaoxjYyg3w==
X-Google-Smtp-Source: ABdhPJxq+l+hxZlBXDnnv4WQkQqCdtXqYe9vLn/USYeGGUpRjwJM+/w8RMfxuf6/pyYhO4tFgmN3s7VurhayA27UTQg=
X-Received: by 2002:a25:d685:: with SMTP id n127mr13413553ybg.523.1639667289170;
 Thu, 16 Dec 2021 07:08:09 -0800 (PST)
MIME-Version: 1.0
References: <20211202064946.1424490-1-yebin10@huawei.com>
In-Reply-To: <20211202064946.1424490-1-yebin10@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 16 Dec 2021 23:07:33 +0800
Message-ID: <CAMZfGtVTB+pW5Z9i1h_Ye=yMzFLd59xGnJN1w34uAxVRmU9M4g@mail.gmail.com>
Subject: Re: [PATCH -next] io_uring: use timespec64_valid() to verify time value
To:     Ye Bin <yebin10@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com,
        io-uring@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 2:37 PM Ye Bin <yebin10@huawei.com> wrote:
>
> It's better to use timespec64_valid() to verify time value.
>
> Fixes: 2087009c74d4("io_uring: validate timespec for timeout removals")
> Fixes: f6223ff79966("io_uring: Fix undefined-behaviour in io_issue_sqe")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
