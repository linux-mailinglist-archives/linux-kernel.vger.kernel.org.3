Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2430646683E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359524AbhLBQcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359653AbhLBQbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:31:50 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2DEC06175B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 08:28:28 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id kl8so25485468qvb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 08:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4u0nMlsipyu+XwIR6Y+VD6kLwYQ+DRyX7X93/2ae68g=;
        b=akVrJdkr8wzj7RT55iNYgflFIkgb3zeHg072iRJuFevQdx8fsyEVHDqLVZO/cahe6x
         ZsgBgn05Cql3xk3Ld2fTnymWQlClnzHCbGdBtNbPVUQ2SA+VLe4UpUF1YWg7msNM367P
         RJCDjHe+LcM7Mn+DwTSu2DX55GrdI/fqiWt1N4fL8IC1k+0cuv9ZlbGuF57w4c6iP0l/
         t49gQuV9A0lWP5opLn1JKAkwWlS1JRftMCRnrt4FLACK52D2K2Tt6cg5bijADXSdePEN
         6XuvNZ4ZpdDhFsxpxLCMQwuMzY5q4NvwPyxufnH8OXxp53hhbafZ4JlmJnh7l3BGdH/U
         YW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4u0nMlsipyu+XwIR6Y+VD6kLwYQ+DRyX7X93/2ae68g=;
        b=J6XsexRCcYvPLP5zfk+Vw3StFI1oD5aG1lFh9nrD2C3dGui3tnGMI+zPrD7o3UhRyW
         DE5t3NlwIsZ4aFIQuKZo4wmOxlQ0fzh/tV6dL1+FGO9ZyaVOBGE5/os+0T/IirYV6yFx
         zCzhZJBScA9XxVZk6V6x+DGnMyWB/fyIXBuhGjVxLpyGCBInsWEKIr3lv/cLKEYtzJ91
         lT9hO4JPlV3wkjVZxJaLYFu0+DeGkiaLXRPKn+J5DJ90oclvWhudsTagLpT8vlr64YBL
         VnSlxYnLLdiLx5tkonF6WSqPni7qD2buiU+hkr56E6GRNcLoL7T+yjQvx228M+OnWHzG
         W5vA==
X-Gm-Message-State: AOAM532/rc/Gpr3VkWukV6M6487hqbvIC6dyGvd9xXh0N2q5ZrYv2WLt
        YTar+YNIVd/rEEgS52242GjxjQ==
X-Google-Smtp-Source: ABdhPJxJr0AT4yc8k2UT9IH28cpAKE+WYM/yF2quU+grEDqO9xYwQyfMHiFCEXN6hS01D7rlLzmKxw==
X-Received: by 2002:ad4:4710:: with SMTP id k16mr14157193qvz.105.1638462507292;
        Thu, 02 Dec 2021 08:28:27 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id f34sm139782qtb.7.2021.12.02.08.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 08:28:26 -0800 (PST)
Date:   Thu, 2 Dec 2021 11:28:25 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: count zram read/write into PSI_IO_WAIT
Message-ID: <Yaj0KTp17AaHMQyC@cmpxchg.org>
References: <1638356341-17014-1-git-send-email-huangzhaoyang@gmail.com>
 <CAGWkznHq15QN5Dn6_QfbAm7jS9OPCV4TVqn2_9RxUBx0V9v78w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznHq15QN5Dn6_QfbAm7jS9OPCV4TVqn2_9RxUBx0V9v78w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 07:12:30PM +0800, Zhaoyang Huang wrote:
> There is no chance for zram reading/writing to be counted in
> PSI_IO_WAIT so far as zram will deal with the request just in current
> context without invoking submit_bio and io_schedule.

Hm, but you're also not waiting for a real io device - during which
the CPU could be doing something else e.g. You're waiting for
decompression. The thread also isn't in D-state during that time. What
scenario would benefit from this accounting? How is IO pressure from
comp/decomp paths actionable to you?

What about when you use zram with disk writeback enabled, and you see
a mix of decompression and actual disk IO. Wouldn't you want to be
able to tell the two apart, to see if you're short on CPU or short on
IO bandwidth in this setup? Your patch would make that impossible.

This needs a much more comprehensive changelog.

> > @@ -1246,7 +1247,9 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
> >                                 zram_get_element(zram, index),
> >                                 bio, partial_io);
> >         }
> > -
> > +#ifdef CONFIG_PSI
> > +       psi_task_change(current, 0, TSK_IOWAIT);
> > +#endif

Add psi_iostall_enter() and leave helpers that encapsulate the ifdefs.
