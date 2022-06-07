Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B5A54260B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443026AbiFHCBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442549AbiFHAE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 20:04:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B92320C05
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 13:01:17 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so10073128wmz.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 13:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DI47X6O8WNPdRIaOI5TCI5HzTriGbfEZ08eAVzDNU4k=;
        b=kzO7xnGCbcxSDemr20z8Nl0/EDcjpHr8qVKEybiy0LKIUcUuR+of2LEPkfnM+Jqgle
         9vE2l3qCUJMCOSlLnHVK1HJ1H3QAF3hWHSr4/q5AxLcdDizwQ0EVMl4/Vpsu6arIcoZ+
         anWf4MAlCDasKgZuvNW1YIU0M33K27piqc5Av2r4OUuR9uUpNi29wgA/AiMD9othXh4b
         K+ojT7xS20whvrQKhkAlgcUpbe7uaL1viZN0LSFNTEzwVUEdmR/kn+12eJ4RTsya4ZPB
         Frx1r5vzMisQeCKnNKw4DbLotZq6GoRNQ3B76n1NqdKqJo2KGPNQnbRiXkKn71o0Mxqs
         kCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DI47X6O8WNPdRIaOI5TCI5HzTriGbfEZ08eAVzDNU4k=;
        b=IAoK8yB+CvpAOeQ6uJR6LxVWMUMjGcC1nJekrAaNk3CdFaVQQMKqqZht9IcQBRzOGR
         qrra7ZuW4b/isWisqZ6YHfZjncJiv28hG7aFAwBrfs5G34Rn7tpPeQcaybsfJB3IzSfD
         adomoYKVmO0mQMFQY3mx3gPBYPtoN4Nn24DJ1TB+aM4Hj36YRcKss5BkSrCSyqVR+Aux
         EZL7lbNJPzlSbnm22rnWFKqJPqyRoMpa9GjzfyrQV4nuR4peJrgSl7HvRjz3T0WYhLqD
         O/dcSecXZ6Nx/s8wf9hXT2He3mMt4sENp/UXp+leump+maU8eLQMLAU3s6g4pvTm1vMU
         nMXQ==
X-Gm-Message-State: AOAM530h3z+Ij6JPi/OsPt8KhPTsYep9azJj9tQmriXt2eoqrpMplfcl
        8fwvSllShJp7NuilccW4BsqiR4LW49vlgNjlCuts
X-Google-Smtp-Source: ABdhPJwWmFFpwbQWJhllmV2/9lG6pi5JxgWQDxcD5Pu+pq89/vsuwtXmAKjpt0yON1i//vRJxXjrGt9vlLWGiTkj91w=
X-Received: by 2002:a05:600c:3b05:b0:397:54ce:896 with SMTP id
 m5-20020a05600c3b0500b0039754ce0896mr60163408wms.3.1654632075793; Tue, 07 Jun
 2022 13:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220515073110.304193-1-sshedi@vmware.com> <CAHC9VhQge7uUSwbDUkA9=VCY0dL+UDUjBRT7aSMEEVGU6jQqLg@mail.gmail.com>
In-Reply-To: <CAHC9VhQge7uUSwbDUkA9=VCY0dL+UDUjBRT7aSMEEVGU6jQqLg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Jun 2022 16:01:05 -0400
Message-ID: <CAHC9VhTpBAeEm6U6-=YW7e0JV-WS3MeOjT4g9S-V4ZM2OboBAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] audit: remove redundant data_len check
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     eparis@redhat.com, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, Shreenidhi Shedi <sshedi@vmware.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 7:35 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Sun, May 15, 2022 at 3:31 AM Shreenidhi Shedi <yesshedi@gmail.com> wrote:
> >
> > data_len is already getting checked if it's less than 2 earlier in this
> > function.
> >
> > Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> > ---
> >  kernel/audit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Thanks, this patch looks okay, but since we are already at v5.18-rc7
> this patch will have to wait until after the upcoming merge window as
> it isn't a critical bug fix.

... and it's now merged into audit/next, thanks!

-- 
paul-moore.com
