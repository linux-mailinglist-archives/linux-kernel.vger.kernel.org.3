Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78F0576364
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiGOOHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 10:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiGOOHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:07:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1341261C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:07:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g1so6411520edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tG8UwfM9XgsU2gpK8iZAI5QuO4Taq8sY6XWqWuLovpU=;
        b=M3X5Tr7FPZHC+7bkRn7RRykQVi/wfaS3ybPSNR/xzd4iJZkrgXYUWFxjI5HWMhxv0M
         9BOv9pkEYqlbio5/KLX6bt/3ju9AEDpu2LsiZi3WrH5mHJVk/gCyouJ67m2pt6ZPEPt6
         VxGKJlEFF6Hsk/vkwoPwefkk0ZgwGzZzL7tME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tG8UwfM9XgsU2gpK8iZAI5QuO4Taq8sY6XWqWuLovpU=;
        b=t8hZEbdXzHSo4ZGoTM2iStWmWGTFE3iNxEZ/HudWLujHrhpTchaxodDHVZRcg5MRJ7
         FzLg0KtTZydQgUQTwSELxR6mEzcU/Ae65E/nAHuxjKHAJWT7eg8V3F8REXxyCgyeMAkn
         bSN6p1YjHxqUhSB1boh9YO+hL3mEn6zMYhxXwgzW7eCevL92uS0bRToACI9QBIICor9+
         H3CUG1yR6RYDD4pzqnfXqeKplbb68vg+0YYxrRjL52ZlmJtTKmOgdZJYproXJ+Snturf
         wM1vMHU8+XyjS8hUHBYY0RN728OTiiIPv4Ozg9tnvx48bHza0B+vNtAnDSZ4kEXY+JOd
         dkPw==
X-Gm-Message-State: AJIora8pf3eF6g1vsVB6XRXsMbNgcysiQQriCRNQMuURgZmzo1htQHnc
        F1QrBEIakYrY3OLxqrEr2eUXUPGGffRbBWkOhY8gUw==
X-Google-Smtp-Source: AGRyM1uq6Rh6Te7IY61z9eJaeA+04DZZ9mK0UQyF/K217FYesaE7A0mHMwzT6A9TAcC215uqb5P++5cm8U64EFQ5NIs=
X-Received: by 2002:a05:6402:270d:b0:43a:d1e8:460b with SMTP id
 y13-20020a056402270d00b0043ad1e8460bmr18857128edd.40.1657894022967; Fri, 15
 Jul 2022 07:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220715075343.2730026-1-williamsukatube@163.com>
In-Reply-To: <20220715075343.2730026-1-williamsukatube@163.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 15 Jul 2022 16:06:52 +0200
Message-ID: <CAJfpegs4jRd=FrgDaLxcnbCKWCU=PrsdEzat58j0xB2XdTatZg@mail.gmail.com>
Subject: Re: [PATCH] fuse: Fix a potential memory leak for kstrdup()
To:     williamsukatube@163.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 at 09:54, <williamsukatube@163.com> wrote:
>
> From: William Dean <williamsukatube@gmail.com>
>
> kfree() is missing on an error path to free the memory allocated by
> kstrdup():
>
>   sb->s_subtype = kstrdup(parent_sb->s_subtype, GFP_KERNEL);
>
> So it is better to free it via kfree(sb->s_subtype).

Not needed.  s_subtype will be freed in __put_super().

Thanks,
Miklos
