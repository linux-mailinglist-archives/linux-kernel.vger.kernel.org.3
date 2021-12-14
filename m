Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75368474E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbhLNWrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbhLNWrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:47:41 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2F0C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 14:47:41 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g14so67357807edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 14:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xCX8/Hqkkmsc7s8OoncQ2ygzJ7gumAwZl1sLrK9wpaE=;
        b=B7tL5v1bMp+BDC5s8TZoUSFQG4zXAQcv5FngmioPcul/1hnbkkO9E8ewfR4MOh1dJr
         LExoG5vgcs3iAf3RZW9XhlT3zMFTEZ0vOq9INnzos+zrPiS0vO3bJPVFmL/hqe5EZvrJ
         vG4ulmzleaIAFvXcpfbX2GTGVADiDU1Fr6SA/EMPSfEZW/hUzB9BbEqnYG4ytcnHRfBW
         E1dWSUNAEceRIHA+sU37056AlSN3u2qF5OpoHCixEszEN+HvQdTs+ORygh3aCvQc+xrR
         NdGb2SKb5y8oOewin1ak1+nY3gVbawin4eTo2D8qdyfGL3unRbEI79DhFPjXuOmG+ilU
         EIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xCX8/Hqkkmsc7s8OoncQ2ygzJ7gumAwZl1sLrK9wpaE=;
        b=yGOdieEaaruSmdlxlnHC/2+ykt5C69rlbu4wxc8vN9nJ3tYNDWc9xI8rYYLtc89y8F
         xn6msGPixILB5iUY80ACryPg8Mmoh93tkeEa6i9kmWsj9uUfehYKZKkDyoz2m3p7WnMa
         zG04k76Lm88P4jhBDm7mtktc5wBQolAGi4ZpEfWe0hfnSNMjObzgAgm9Ojtkcp/WPrmx
         Du2pai/3n/OhkwG5/ImeATyqKx4UAQGM6PtZsJqtehM4UdJ3tJmAPtAVoDfyT9MY9kRt
         FKn4XtrGY3nqYV1zt4XuNewXCFN6K878yJFaQxWdJZr1Fwx4VzPUa85VLcwpiOomq009
         FNKg==
X-Gm-Message-State: AOAM532ba3s1Sg9Ea4b/csXkeewuDaHV/g3yZJzxFxWB/Va5U+Yv/DGf
        nbCOlgTS9TJMxgt+iZjrxkCvN9QXADRd8j2jDdQl
X-Google-Smtp-Source: ABdhPJzIcu0cK8oFwIMlnj2GOKq7A90qrnk+9/eDShno+/EyDaHfWZQyD4u4EBk7RpLdqrkLyWgJHG51AdwmapcggB4=
X-Received: by 2002:a17:907:e8e:: with SMTP id ho14mr8724777ejc.12.1639522059848;
 Tue, 14 Dec 2021 14:47:39 -0800 (PST)
MIME-Version: 1.0
References: <20211214114854.133328-1-xiujianfeng@huawei.com>
In-Reply-To: <20211214114854.133328-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Dec 2021 17:47:29 -0500
Message-ID: <CAHC9VhRYZgDLsouVYkecHK1208dAHwLoGZ56sSTf1zBJ00R0ag@mail.gmail.com>
Subject: Re: [PATCH -next] audit: use struct_size() helper in kmalloc()
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     eparis@redhat.com, keescook@chromium.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, wangweiyang2@huawei.com,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 6:48 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> Make use of struct_size() helper instead of an open-coded calucation.
>
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  kernel/audit.c       | 2 +-
>  kernel/audit_tree.c  | 2 +-
>  kernel/auditfilter.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Merged into audit/next, thanks!

-- 
paul moore
www.paul-moore.com
