Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A41054A0B7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351558AbiFMVA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351964AbiFMU6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:58:46 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A87A167EB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:34:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u8so8494580wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F++4mxvxKCq3D0MOi1hm7r02V15ZXV/REZlzwvy9ouk=;
        b=j2adBRuldeFOlyGNeZXecupRfS1od6Xh2itNTGnXKvNwuvuj0sTo4+tBpwbOoQUjoZ
         Xw5/Y6VRboaE9ShCfnwDIZnZGzNe0UBnP7p85yggpZ996Zj6EDVLRZ/MwJuINbvAcmJZ
         wKNXfVZM/+zjJLD17EzOm6Q3qZ6slsFQMs35GciHNu/KM+rORkItSwa0C+04oGDuRuDV
         7xFjk4xk8JwQA8P3q+5YrQmQWZN6mHNP/xv/JzGOi96zHLEWBAINtzy31gOteVHeGA58
         eWgmH0arr8cGZulxXYnGAPuynMx0dJM6F5D11HkGOHyFsF4lIGR3zqFmLjhGeoCY6JW7
         0DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F++4mxvxKCq3D0MOi1hm7r02V15ZXV/REZlzwvy9ouk=;
        b=RfQ8deD7k/aXFitgNO+rkAwC4ZTzKdBIas82uW6J0buGzsPEQtUTaXoU4BF9wUd76A
         x7SLkILCKfoKAIC9Kc/Wb7LSsyyK6dkaGMvWlxM/LHQE3AjRmu817Af9WTpfaXQxg7J3
         EtjU3WH81vg9L9z7IjRV2RxXEY2QQVhbA6CHd0Uv8joPDwqZ80w6ZkFENUqzjT1cGr5b
         4p77lg8sbESoDV8G36NchAoyPYHPkVlWo68NuoxhFatl3mNp0Xy+9KbLIUUX8lb9F7+r
         tBbKthWAqWAXrwHcTPiufmdjoJ7FRCxcGly1c7o+QZi7C/ibI1tGk7P5RpL61dHibiiJ
         hZDg==
X-Gm-Message-State: AJIora+2lSepmWMzO6AaUuNwru+8d6noj5nggt/3rtKxR6vtlR43TG/L
        8VD8lrRvXJpeFESo6Em7beLCKTO4fYkPVhCNYzvW
X-Google-Smtp-Source: AGRyM1vYniplidzOuY5TAIYbimsWA/grGb4GRxaY2HWhql3MwuRYoLgOrYQtewKpRFU1AZ1P3cpbpdbefd+744wWgbU=
X-Received: by 2002:adf:fd84:0:b0:216:1595:82d3 with SMTP id
 d4-20020adffd84000000b00216159582d3mr1427711wrr.239.1655152461446; Mon, 13
 Jun 2022 13:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220613135953.135998-1-xiujianfeng@huawei.com>
In-Reply-To: <20220613135953.135998-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Jun 2022 16:34:10 -0400
Message-ID: <CAHC9VhR0-814-YsC3ugTsCzL1be37tyxZHTs7Dq2mY+iC8pjgA@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix memleak in security_read_state_kernel
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        cgzones@googlemail.com, omosnace@redhat.com,
        michalorzel.eng@gmail.com, austin.kim@lge.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:01 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> In this function, it directly returns the result of __security_read_policy
> without freeing the allocated memory in *data, cause memory leak issue,
> so free the memory if __security_read_policy failed.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/ss/services.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Merged into selinux/next, thanks.

-- 
paul-moore.com
