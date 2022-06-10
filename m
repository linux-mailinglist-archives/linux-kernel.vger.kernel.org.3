Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A77E546F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 23:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350865AbiFJVMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 17:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350839AbiFJVMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:12:34 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BCD49B50
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:12:32 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q140so280120pgq.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLh8UWaxnG0XK4ejvWk5/7UEox62WuaIhi58ed8ZfqU=;
        b=oOOlocAR4BVT+CnGqmu5nFRQMD1z12qGrPh1buMTIuQt0LNbf3DZw0xZbNVlhc2y8n
         FYgbC30cstY+yvj2do6UDu46k7Vn5VFACCt0OQI1llYzuP3t8TKupeqiOl0mKnB7mEpx
         GBoXMrfeGKfVaH95mQ0aAmGMQl6kRSoID0l58jpYnm3rtiS1dksHi2ylQ1VCEV4L44Kk
         UDUm0pt38qW8TufTPezTvFPQNn59gduH4kJYvkmStSEnxU5vdWZHSf7q147zlIdmvwUs
         QtRPWAHObALA+wYaEq6Hz5Sjniu8RYXrZmOBthtCEfkCX7c09rysGegcLy4dFk/63PZR
         Ubxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLh8UWaxnG0XK4ejvWk5/7UEox62WuaIhi58ed8ZfqU=;
        b=7hb9M2/16Ohn6BM4F/j90u8HUNHI/TmwkwlS07pKfNlSPyJwcfEJfa44vDq6pzj6aZ
         85rtaPf+PRKbtNTjpzItjo9cc2CGqkbgGxfPsRfkQOp2sAaBn3i7HaVY4EiSuSGBcpFA
         A/LnNoBj9kYE4dWd+I2UZfUISiHsV3gSZBDkR8bZowadtB5VYTV8XDSgv5jkteIIByWN
         13CsBFEloJbiGqNQB9QYjyEGe8jvYhaAKJbUgdBGqOLvjK5pwyeV+1o2iDvkbLil7a1/
         QlTqz0JUtm5gojIX9j5gHK2whXCgk21WMwFj1JMM/btZxKEmggynHv8euZT775MzK7Gh
         Q9kw==
X-Gm-Message-State: AOAM531Xx8aH2c+px7PnGjIk4vIaDdEv3vteIzEf4r3LgHiax0Oe5AU6
        4MVvBITJiQCAFjHqZEJh5prkpfqwdfYqe2PUmewd
X-Google-Smtp-Source: ABdhPJwOyrpg1AqxhhST810M59Pif6MyGpe2uAsQzlGWQ8QXwysQpCn4KgUWCSY2xql44klzbHEzPc92Valgmk5MxIw=
X-Received: by 2002:a63:8449:0:b0:3fc:85a5:5b69 with SMTP id
 k70-20020a638449000000b003fc85a55b69mr40873314pgd.261.1654895552080; Fri, 10
 Jun 2022 14:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220609230146.319210-1-casey@schaufler-ca.com> <20220609230146.319210-31-casey@schaufler-ca.com>
In-Reply-To: <20220609230146.319210-31-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jun 2022 17:12:21 -0400
Message-ID: <CAHC9VhTraB9D962b9j8J0HxUE9RPbAp6ATNFuvucdccTHx_xmQ@mail.gmail.com>
Subject: Re: [PATCH v36 30/33] netlabel: Use a struct lsmblob in audit data
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 7:18 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Remove scaffolding in netlabel audit by keeping subject
> lsm information in an lsmblob structure instead of a secid.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/net/netlabel.h            | 2 +-
>  net/netlabel/netlabel_unlabeled.c | 4 +---
>  net/netlabel/netlabel_user.c      | 4 +---
>  net/netlabel/netlabel_user.h      | 6 +-----
>  security/smack/smackfs.c          | 2 +-
>  5 files changed, 5 insertions(+), 13 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
