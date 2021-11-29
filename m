Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A852746113D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245189AbhK2Jn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbhK2Jly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:41:54 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846E1C0619E8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 01:23:37 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id p2so32516866uad.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 01:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uPaoRHFFu8ygUlTEEIp8Daon4XaaBJX6v8zJJK11vk8=;
        b=mB2xPMCa1WbfMQn4KJKldiymo6yq8MzgWGl3DWB4tJcLMZrczpyhQuzBbwgsW0otif
         kEMSaQBegAHsLcHewgTlO3Ey+Kvgi7EfM/PPvbpb/SmEAsK5bypTuUdPSLK/XUTj6PiV
         0EaoXQaA7yg08vv60kKmes+5qdFbPJlUmw6oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPaoRHFFu8ygUlTEEIp8Daon4XaaBJX6v8zJJK11vk8=;
        b=CkktHP22CHu2UeA/OayESQYSThCeraKZ2i27e3C1x2hvDD9ld2EVC6OSnFyalBu9jp
         w9eqX2HI4RRhuxx8h+q1+Itoehb6LYFPLtuomfnp18Xyrt4w5IovPNBGtchQzUZ2svCl
         drsPn6zMlrNWR7Q2OrKTS/ibakh4WIfVduUMY40VDeO+ptalqmS4IPFTaI55t51NIkKo
         54tbqTFqsv97BueyRH570SduJ63nmwqkUUr5IOqwf4OSW2v69AGHfROqMW4METEqAr3R
         Sqnj43Cb677JDE+ZbudToq6U93RBX0RdfKXW4Ax84UJAsFDhzB5zB1NuYuPyEsnMHAin
         REeA==
X-Gm-Message-State: AOAM531rn/eyFEFoxZbxdpqQi7r/U3t4kYqVHacJtovAGkk+tEo7Dv0O
        L1HvPde8lbqFt6Wc/VdpjrSZgBTboAIVy3+b0sAGPQ==
X-Google-Smtp-Source: ABdhPJxGTgte/N3qu0QJigd7OlEwSA2yh7Yk60sN3HNe2rSgqIgDzQ/2N+a/EJlQWYv4blCCwJ5ChCqY2CrhEai9PaQ=
X-Received: by 2002:a05:6102:c4e:: with SMTP id y14mr31220717vss.61.1638177815913;
 Mon, 29 Nov 2021 01:23:35 -0800 (PST)
MIME-Version: 1.0
References: <1638008002-3037-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1638008002-3037-1-git-send-email-yangtiezhu@loongson.cn>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 29 Nov 2021 10:23:25 +0100
Message-ID: <CAJfpegvz-u+Wx7r3zR=2+LOGbm+0W5f+5ttMpsd8vfb8iCrWsw@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: rename some files and clean up Makefile
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Nov 2021 at 11:14, Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> No need to generate virtio_fs.o first and then link to virtiofs.o, just
> rename virtio_fs.c to virtiofs.c and remove "virtiofs-y := virtio_fs.o"
> in Makefile, also update MAINTAINERS. Additionally, rename the private
> header file fuse_i.h to fuse.h, like ext4.h in fs/ext4, xfs.h in fs/xfs
> and f2fs.h in fs/f2fs.

Sorry, no.  This will make backport of bugfixes harder for no good reason.

Thanks,
Miklos
