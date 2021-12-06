Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD81468F73
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbhLFDEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbhLFDEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:04:09 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEE1C0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 19:00:41 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w1so36960290edc.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 19:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8XwGiTSdfjzsQMCJh72uWK8Wih1xLMBGRw/JJ9t7jo=;
        b=J2FiySOmo1p06R4yLl4Fbax8C6J2lDzrgmZGRp3XjAJlTH3nW6wwGdXKVvn2VxWC1p
         eoQO85zvY5NG6j/0CRCFEZTPoO8jyesyTmJ11gZwIO0UaXWIT/5b4frxNuFRKCUR/iwO
         /k7QP0KacB33uLJ1lM3utN2gpSIB7CJPOyM6oVsu3hALWZ+I+N7B04fr7w9cCRASZDlF
         wZeO7GHtr1Lj17LZ7lMVd7Wzx6P1r4061hPUENTz9PbtOXYbJXoXmZ3LDsZiP8CGXJ5+
         q9Fp+0kRUNrDNi76NRVvuUbx+ellf6oVMcNEIxj/AJPiyU9K61yFj9DyhYtnoAN3Nv5N
         Nw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8XwGiTSdfjzsQMCJh72uWK8Wih1xLMBGRw/JJ9t7jo=;
        b=kKGOeJsDcNHFVbJvVk2k2GlO6VJmjgtWayZxtR74uyOmAmlcnx3f/KdWpWcavaGDfi
         K7DeBPblEgXzTKjiKffeDUX+inuQ8Y7vR4I2S1aB+16bhXZpxAtokV6Mzxxy/xpbAbqm
         mHgESc2PjUdFHjKbRiEm1e/qxxOj6hfJl2GLz6Wve9mXZwQvUFtSY7Zy8AWc8M7x4DpN
         7ht5BIMVkQN+QBQAB9df7N1YC3gbMJ+hKBy2qK2shLfQKoVikyvVSAGnGjJeyuIRc9Ja
         GkZuefTC772WzBrABeXaUqXyfiudVUWebaDu8FkxqA4mRakKQAJB+Sbsh+jLLVq7/Ngi
         uGvw==
X-Gm-Message-State: AOAM530X1dgle5yqxzwaC97secsqQEHR7tig67e9uMFi19shqxuG3qb2
        4FPAm/5/XYOizP94PBEn5qYOudlR8i+nuRSGiWfd
X-Google-Smtp-Source: ABdhPJyhQR4tvE1MCQcoLhazqK5yvby/xMf1+slbVJzbD9Ck/Wk4nPvy3/5kTEeM3PBnJTA2Prpfj1+fwmw0/TJRYag=
X-Received: by 2002:a05:6402:4311:: with SMTP id m17mr50606773edc.103.1638759639626;
 Sun, 05 Dec 2021 19:00:39 -0800 (PST)
MIME-Version: 1.0
References: <20211202073533.104072-1-xiujianfeng@huawei.com>
In-Reply-To: <20211202073533.104072-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Dec 2021 22:00:28 -0500
Message-ID: <CAHC9VhQZx1F9TUbEYOKxK3mEAg8n5bCJZ7RuZHh0jEhwNg7eig@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Use struct_size() helper in kmalloc()
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 2:34 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> Make use of struct_size() helper instead of an open-coded calculation.
>
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/ss/sidtab.c | 2 +-
>  security/selinux/xfrm.c      | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Merged into selinux/next, thank you.

-- 
paul moore
www.paul-moore.com
