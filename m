Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0EF5A7C29
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiHaL3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiHaL3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:29:51 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8F82708
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 04:29:49 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id k22so14274200ljg.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 04:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ryGa5HH2ONldTgyCK39FNIVIuLx0hP5wuxCpISWNLD4=;
        b=pZcS1zwxA6l7/TgwYy6Ip8WCXhRiDkQmwhGL9DT9MXqbfMwDYVE7uktshh5naOh5P/
         rwSjVAfzzzkFenkaST+xjxuS0a0SReKup+S0gSJZDo5knZtCywLuySGdZeWMX1RalU9d
         MDUPincYHBHFpCTMT9V1YH9hJyXYlaisn8/42IBC07WyfVeIHa0zT7gtdf4xA4z6dR3U
         la4QgCy9Nj2oa+XS/EgDG6ILs8o/3pvHyxV4agbz1o6jLef5fHbIrtgZCfF5xZxU5U0I
         QIcQ1ClB19DDshRsMJo9Dbow/a7RNac1Hkw6umlZc8YO4mkjQNh5Hylk9K+8xhknttb7
         tEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ryGa5HH2ONldTgyCK39FNIVIuLx0hP5wuxCpISWNLD4=;
        b=6EEUL7iZ/JkDtwxgjL0P2FHUs/ybdNeXU4B4O89jkK2eLeTaOwkGDRIPhTynYD7YkW
         gBKveXe6fjUZvjhyyz+c/aCvtGfnECdRvAetWxrs/KokYyz3AEpI5VsKI3T5u5xcZlHa
         WpISqrgtXlEvhgaxF4DOXIC0FG8X3hTsdgfrCEEJSuV+BYmFrIaaWuVVl9su5VX1XcEd
         Wip8Vf9/FJH4CD7HMScbTehpBucmqQYG4rq5LtqzFx8LB64aksBAQatoInDjqTooceFN
         gtQ1eAXQsj1ealn64pm0hu8AEjibFKQ4mx77eXEaGQk0lxsjKP6AaNyc9YJl2uXKtSvb
         OVGA==
X-Gm-Message-State: ACgBeo04gXteQVMPVCikYHFmvETnCz8W1hwLvfk/eoCM2rKYpaOs8gDd
        snGGSIU0qe62/2+7/WCpSi40XoLFgOp7bGgeWlr9xw==
X-Google-Smtp-Source: AA6agR53GlpuM4UxX1UfvGvtHEzQl+QBr1k2NQNasZ+l6qk9EkqXOX0I02+WtF+RDCB/CQpzT72OIeA0esCIlEQy0f0=
X-Received: by 2002:a2e:8556:0:b0:268:96e4:2f57 with SMTP id
 u22-20020a2e8556000000b0026896e42f57mr507335ljj.505.1661945388119; Wed, 31
 Aug 2022 04:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220830100700.344594-1-sudeep.holla@arm.com> <20220830100700.344594-9-sudeep.holla@arm.com>
 <CAFA6WYPXsLt692eW3_tqy+=aLz7W-Ymh-RqZuqATeHpzGp8Tkw@mail.gmail.com> <20220831112652.brjnuygzkvcteadx@bogus>
In-Reply-To: <20220831112652.brjnuygzkvcteadx@bogus>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 31 Aug 2022 16:59:36 +0530
Message-ID: <CAFA6WYP9UF8qLcBkWVdAOyb_EArDHX6ihPf_6GqbkoZYkdNrPQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] tee: optee: Drop ffa_ops in optee_ffa structure
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2022 at 16:57, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Aug 31, 2022 at 04:28:01PM +0530, Sumit Garg wrote:
> > On Tue, 30 Aug 2022 at 15:40, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > Since the ffa_device itself carries ffa_dev_ops now, there is no need
> > > to keep a copy in optee_ffa structure.
> > >
> > > Drop ffa_ops in the optee_ffa structure as it is not needed anymore.
> > >
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  drivers/tee/optee/ffa_abi.c       | 9 ++++-----
> > >  drivers/tee/optee/optee_private.h | 1 -
> > >  2 files changed, 4 insertions(+), 6 deletions(-)
> > >
> >
> > Is this patch doing anything different from patch #2? If not then I
> > think both should be squashed.
> >
>
> Indeed, I thought about squashing them and forgot before getting there.
> Does the review tag still apply for 2/9 after I squash this into it.
>

Yeah, feel free to apply my review tag.

-Sumit

> Thanks for the review.
>
> --
> Regards,
> Sudeep
