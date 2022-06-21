Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2D65528F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 03:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbiFUBWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 21:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiFUBWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 21:22:15 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECA4634B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 18:22:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g4so16767504wrh.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 18:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iGjjY3HwOIbttDwUviSsDQPsfAs3UUDt07n3f4W7ebQ=;
        b=hnD5iao8QXyX4Am/IkpwLe36L0lhcFXUS9xABII7VIuDsCodgNb9mLuww/8hvhAQ+U
         dURvI7VLHfSpnufrdyDrHeMM5PYellEIW7LsmQ+COuxxgo+evSCiCFouKZJfw6l4uL11
         ASLeErBCwWndAVyF2EuOX+uK632Op8J3u8vq6ZhedSixDg8Tw2pq48sL0imLE9RFfM0Z
         sbro9vvE7qH6o5Bl5+8zcxPeDCqpNklnbANFwGnOXgN9jghips19+aIUwdslj8p6MVGj
         Xj329321iOTelgM4m7YEeEuhvqG+j+0XGOP/95Pd3HSuPMgnVLJ1HP3QomhQefqB7hdV
         WOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iGjjY3HwOIbttDwUviSsDQPsfAs3UUDt07n3f4W7ebQ=;
        b=GdcwJgIHeZmhFNQzdV6NoyBNRuZ5TJl9hxSMUtu9A3drx/yIYHplzb+u8yhTgaryhr
         EZe2PsOwm6c3WQKH4tKvgqJDqiNUQFfkMZ/Z9qCV6wugMnwS1siHMWYlhE5/MTtKTdCH
         aP/uPkDhEFq1cYwD1IvDn4rakGRcdxEdyrmDfLIapNDdlfJU4POsjL4f1FQqDWEqhr+d
         286qOzIhbtA/xSF0usRJ7xkg66n99BUjiAz8zxSvQXVi4zlyE1N7AkdqL84ZRKPWkwuM
         vv3Lu+qVYZo1Uyt2D5bls4QDIJ0s2++O4WKPAh+tZM6JYV1wQmmWypYjIc3SXB0/GFlo
         MNrw==
X-Gm-Message-State: AJIora/s5TZ3VMMH0iG/m61G2uwzX1+DxvvDAGLqJJ/ChHPT+iS+vaEn
        68yLTIXHQ4hLCzut/SwaBki1xcXLTDC/a6Wjf653
X-Google-Smtp-Source: AGRyM1srvmz0sxYpUL+j7hh3Nxp9SHP3Rpo4co7pFbz2Zx5Ri5/ae/iUzcou5p1/HoxjxoYMy50uLEJPD/myCX07iXE=
X-Received: by 2002:a5d:4848:0:b0:21b:8cda:5747 with SMTP id
 n8-20020a5d4848000000b0021b8cda5747mr9405276wrs.483.1655774532923; Mon, 20
 Jun 2022 18:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220617094412.197479-1-xiujianfeng@huawei.com>
In-Reply-To: <20220617094412.197479-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Jun 2022 21:22:02 -0400
Message-ID: <CAHC9VhTD0Z=9M_7TRBoOUDgNigLyYCW2SgNAtaZdPj8nJNCV2Q@mail.gmail.com>
Subject: Re: [PATCH RESEND -next] selinux: Let the caller free the momory in
 *mnt_opts on error
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
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

On Fri, Jun 17, 2022 at 5:46 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> It may allocate memory for @mnt_opts if NULL in selinux_add_opt(), and
> now some error paths goto @err label to free memory while others don't,
> as suggested by Paul, don't free memory in case of error and let the
> caller to cleanup on error.
>
> And also this patch changes the @s NULL check to return -EINVAL instead.
>
> Link: https://lore.kernel.org/lkml/20220611090550.135674-1-xiujianfeng@huawei.com/T/
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/hooks.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Thanks, merged into selinux/next with some rewording of the subject
line and commit description.

-- 
paul-moore.com
