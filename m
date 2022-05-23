Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08FA531C12
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiEWTnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiEWTm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:42:59 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121911B1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:42:58 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w130so19098218oig.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vr6T/UqgVGLQWoul1vnNoytTWzJsPkn14WICohkLY7I=;
        b=Fs0S3Msok1ksTRe7NGFi2Ry+axura59LsvHOsYFwgudYlyVCr2tTvaiG818YWZuDf0
         IZZwL+wqiL6MtCfFD0gPzV0afDz9zib5f4lVh48rMdFUVgj+K3yQKYmuvHWZ98c1Knvk
         jDLi+BFuargstaoHS5pNBPjYIKTiAaoOaD3CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vr6T/UqgVGLQWoul1vnNoytTWzJsPkn14WICohkLY7I=;
        b=mXngLdtSs+/o/6SiqEpj2Hg2E5sICf8c/Wuful0tVa1nqkIzNw8PuW14tuLZoSdBBf
         txFm5qB0uYeTpeQKZM08ZjSXbmsFq8Fb/az2fSQlRyN9Q91zqhuDFAosI4WLvhsOrQgj
         BUFQDlIeJ1y3P/wbuonArqUadd9pFou6je2tCSTnAiXMTtu0kI8RM0+g58leVIYTHefS
         FUJn6PVCCkdSabQv10Zy11hp0px8Wr/wJC9xrXPk5dpzC81g5A2j5jgTUsbv3WRGHZ8m
         CnzSpEKgbl87qw2jcKFVQghriDW4om7OXDTy1UWvd6PURytkpiBxao5KOD3grDquEyNP
         wf+Q==
X-Gm-Message-State: AOAM533/zg5Pz/Xn6qu5iVokC0Dsjt2c28mSPPvxN2dPf2TtNmOq0cwJ
        VZwRspfRhZ4w3oY6Mv3QcK0zN/jodLXvJA==
X-Google-Smtp-Source: ABdhPJwaP5vB/86lkItxbhagXO0TXXeyCbjWCf1G+L7nzuoTQsTnCVD1C+q/+fJ8QX8JpXeTA1BjWw==
X-Received: by 2002:a54:4f88:0:b0:325:a26e:5278 with SMTP id g8-20020a544f88000000b00325a26e5278mr394439oiy.76.1653334977115;
        Mon, 23 May 2022 12:42:57 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id w2-20020acaad02000000b0032af1c6bf02sm4287407oie.45.2022.05.23.12.42.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 12:42:56 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id w130so19098127oig.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:42:55 -0700 (PDT)
X-Received: by 2002:a05:6808:140c:b0:326:cd8f:eb71 with SMTP id
 w12-20020a056808140c00b00326cd8feb71mr341566oiv.257.1653334975556; Mon, 23
 May 2022 12:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220523052810.24767-1-duoming@zju.edu.cn> <87o7zoxrdf.fsf@email.froward.int.ebiederm.org>
 <6a270950.2c659.180f1a46e8c.Coremail.duoming@zju.edu.cn>
In-Reply-To: <6a270950.2c659.180f1a46e8c.Coremail.duoming@zju.edu.cn>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 23 May 2022 12:42:44 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNBeN6k6y+eY06FkheNTNWN02P2uT9bB09KtBok0LVFfQ@mail.gmail.com>
Message-ID: <CA+ASDXNBeN6k6y+eY06FkheNTNWN02P2uT9bB09KtBok0LVFfQ@mail.gmail.com>
Subject: Re: [PATCH v3] mwifiex: fix sleep in atomic context bugs caused by dev_coredumpv
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        amit karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>, kvalo@kernel.org,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(I think people generally agreed on this approach, but please submit a
new series, with separate patches)

On Mon, May 23, 2022 at 12:27 PM <duoming@zju.edu.cn> wrote:
> What's more, I move the operations that may sleep into a work item and use
> schedule_work() to call a kernel thread to do the operations that may sleep.

You end up with a timer that just exists to kick a work item. Eric
suggested you just use a delayed_work, and then you don't need both a
timer and a work struct.

Brian
