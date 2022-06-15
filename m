Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064DA54BF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 03:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345431AbiFOBxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 21:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344884AbiFOBxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:53:50 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D3B4B86D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 18:53:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h19so10162069wrc.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 18:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zuurJxZcce+GoDsmp1XsGsqucLz8Pm2d/LbWYRwxasg=;
        b=Hk75TzxKOU+b4LJdwcRUJ4IfLV9WW0VYtYya1btgDzruS3jcFLy9dTRQcIp7DncVGz
         GxEHj33eh4N1GgAgd26Rs8hwr99dTS6/DxgKGHYHu6LVcB+/IQ9vDRqJUq0M6+vHdc8N
         Y9NEOrflVbbc0MhUSDowycMbhRKDv0oVjpXywOIS5+XAMDYv2mT4eZu+Ykgef6gfD1Hj
         rIdrT8frAu76Rv400YZeIHkkG370n8DXHXTqxP8Fw2qbwWuqGjX90lvZK5A90atalhCt
         HFYYNjCiQYpslG9M0VIbqtV0urX9jiGrPT/ca5e4VyeBvX5xehCEDjVY+mwQZa6Nki87
         qyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zuurJxZcce+GoDsmp1XsGsqucLz8Pm2d/LbWYRwxasg=;
        b=Y2HOT5x3oa3gISUPrr157HQC3RVhWU/sCWvUivmnKHcve7dSt5MjM5B0pvRDfvZLhl
         PyC96+V9OzMIdLuZDLD5qBC4BWnie6DAVsDHB+KFq/3ScdjRHgVrD/Cfv8/foyhrVZn0
         WsZTnP1qR/RASD2Sz94fb433wawwKeEJ7SwpfnxG5oud7b1iTPQBJ/CeqXk4Ovu5HEo7
         //ybWPppog5yEXxz7cun+bxx4LEDqYJDJ7sJm90pxPg9TyqALfJ1m2+rwMjXifu+E6Qv
         dQT8DKbQeuO9KOjwvVoYaTNKNtLLS1BOqgJz/eH/rZCI54LovPPhchP+NebIghoU+n/8
         hwag==
X-Gm-Message-State: AJIora/twmTwyBdhHi0zts9kUFFbc0i5ixaRj8vbEBXOIAa6gQv9f7De
        kmLwA5Z7NEcwUhnVbTWJVof/S6k7k2cwH+5FHP7A
X-Google-Smtp-Source: AGRyM1vRsOUPtdqjt1mrMHgiOilk/Nt9zj7WZR0tLboCsjgSZz0A/NS3Za/zmRV2TH9XT4dZvUjEqyid3O0bvErZd/c=
X-Received: by 2002:a5d:5272:0:b0:210:33b8:ac4a with SMTP id
 l18-20020a5d5272000000b0021033b8ac4amr7283282wrc.483.1655258028115; Tue, 14
 Jun 2022 18:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220614021449.39255-1-xiujianfeng@huawei.com>
In-Reply-To: <20220614021449.39255-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Jun 2022 21:53:37 -0400
Message-ID: <CAHC9VhRQJ8F9xd0YbAut7a2n_8q8RpqHatE4R47uhcHebfrJBg@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Add boundary check in put_entry()
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:16 PM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> Just like next_entry(), boundary check is necessary to prevent memory
> out-of-bound access.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/ss/policydb.h | 2 ++
>  1 file changed, 2 insertions(+)

It's not as critical here as it is for next_entry(), but it's still
not a bad idea.  Merged into selinux/next.

-- 
paul-moore.com
