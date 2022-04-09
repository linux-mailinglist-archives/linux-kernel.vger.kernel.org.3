Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3B64FA561
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 08:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbiDIGW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 02:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiDIGW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 02:22:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5C96BDD7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 23:20:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bg10so21138315ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 23:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4BQe7TgqOAtfT/R2AUCBUs2g5GlgSgJpGVyoI7WVG/w=;
        b=gtSABei8uzjOdfw3yc/pmm30Ev/wWkJObqpHCoV8lYBIrEhb/tdjw9rSejDBicD23E
         ejiVFCCgR9+5IgBdTtuKjluB5ODVUwdinidpDQZkNBDYEGBOteejCB4JZfZ5c5oBc8YQ
         sTdjMVGbTyZQO9mw1gujqdEK9/z1m3hTlViDuOXk8mXDtTNVJGezHqAktMzXiLUZd+a3
         ifitFVkBPFrt5eUmRl3tfvs7hHT5feMhd2Xme+/kf+o825tbVUSbo/RGOt0imCLOLXqt
         zUk0+VEItJQAJigTlS1+De95bXs3OT1y9tR7xRSo7i4XgUvvvR/fggC+dBJKxfHzeQIt
         msAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4BQe7TgqOAtfT/R2AUCBUs2g5GlgSgJpGVyoI7WVG/w=;
        b=dco7OziOhdE5xMgY5XYUkrfrMYLzq5wpw1ctn4R4SbUsyjyifNp4PZCY5ujZlhOf9/
         kd3X+pCpzZIEeZUjXDoKm64B9w45ojDj+IXL6khTdnetbVUF+OxXUswPZgnTqbnMqyb+
         Ti/aWbQEXYFT1FeJUoCbIDLNmsJT3r6CQbghZN05Sqg8qx2bimcQJ/iLqHrDuMz1GAkZ
         NTmgaE4u6b87tDMbgUZN84ecSE7trhhQlOlwHdND6TLkQpQ235ejO1d2h31Ka3iH2M+X
         3H6cYXRttzcvGpnYEMdGLA1Q/rxYZIJ55aV11JIL/umhoY0FVmiD60afLpsZbq+MK5CJ
         MDUg==
X-Gm-Message-State: AOAM533Pl09wtEO6KfAdmtqOrT5+gS616CxGDBNcXgCCKVlpqu3utJKZ
        2lbVmLTTkybNo+LNotN5Dd+7uzZZMcojzmuxecM=
X-Google-Smtp-Source: ABdhPJyYEn//xBRwWlvOLIDlxNrcXeZYM/P1WNui5RCtMkqPkuzA0evaLAiSlc0wGqale3SrhBYKykxQfkWOTxPU+NM=
X-Received: by 2002:a17:907:8a19:b0:6e8:a7e:5f50 with SMTP id
 sc25-20020a1709078a1900b006e80a7e5f50mr21928977ejc.322.1649485249436; Fri, 08
 Apr 2022 23:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220409055135.54921-1-duoming@zju.edu.cn>
In-Reply-To: <20220409055135.54921-1-duoming@zju.edu.cn>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 8 Apr 2022 23:20:37 -0700
Message-ID: <CAMo8BfKfxA3b2DmRPc4KK1Mn28-xUBaQeu7ZMUTdoZWr4ESGLw@mail.gmail.com>
Subject: Re: [PATCH V2 10/11] arch: xtensa: platforms: Fix deadlock in iss_net_close()
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Jakub Kicinski <kuba@kernel.org>,
        alexander.deucher@amd.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Duoming,

On Fri, Apr 8, 2022 at 10:51 PM Duoming Zhou <duoming@zju.edu.cn> wrote:
> There is a deadlock in iss_net_close(), which is shown
> below:
>
>    (Thread 1)              |      (Thread 2)
>                            | iss_net_open()
> iss_net_close()            |  mod_timer()
>  spin_lock_bh() //(1)      |  (wait a time)
>  ...                       | iss_net_timer()
>  del_timer_sync()          |  spin_lock() //(2)
>  (wait timer to stop)      |  ...
>
> We hold lp->lock in position (1) of thread 1 and use
> del_timer_sync() to wait timer to stop, but timer handler
> also need lp->lock in position (2) of thread 2. As a result,
> iss_net_close() will block forever.

Would block forever in SMP, that's true. But the ISS machine
that uses this driver had never had SMP support, so we
haven't seen it blocking so far.

> This patch extracts del_timer_sync() from the protection of
> spin_lock_bh(), which could let timer handler to obtain
> the needed lock. What`s more, we should remove spin_lock()
> in iss_net_timer(), because there is no resource need to
> protect and spin_lock() may cause deadlock in timer handler.

There's a lot more strange locking in this driver, so I've made
a cleanup series that gets rid of most of it, including what
causes the deadlock mentioned above. I'll post it shortly.

-- 
Thanks.
-- Max
