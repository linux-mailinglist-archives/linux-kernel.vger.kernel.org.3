Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252FD4AEABF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbiBIHG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbiBIHGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:06:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9007BC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:06:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A0A4B81F16
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CB5C340F1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644390416;
        bh=IaS3n+YSyvbjKGntCu5fWfQp5qdKI/SX1N0ILn7hVFU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y8w/wlhK/H1xRHOLXNeDLRPmVxGRf/tkGY2XhoQ1RNZxDN6KpE3nRX/PO0S85c4ND
         CB28fc6d7cSyBFoqt1cLj/YeU8AA0KwOFIkLtz/HNG7RWgiydTbBD8iVTur1qsSMXs
         ia+mRRFrHWL3F29Zl2mXlRsZRyOhvjgTW11lPMwChexeDpChc0FZYnsAeb7xeJHvYg
         qfKQQUg0StYlhLbU33KjzcE2y2fQ+Pgjx3YFtUr7QxCACq2XMR8fcwUgzY5IoCullY
         mcVlCfprJITpw0UCa5njqYOrn0y9LRqPjWTVBn4O9fxg/qMchKKokPQkhpdh1ZNM1n
         Wy4LFpF3GjE6Q==
Received: by mail-wm1-f51.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso1836036wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 23:06:55 -0800 (PST)
X-Gm-Message-State: AOAM5329Qk0i9pt29g+EcsecAlFGg4vmaE58lon0iTYRvx9lxOXfMzM6
        C7PZ+Uts+vA5JiTxY1CwrimRWMrDSpmbvWxnypQ=
X-Google-Smtp-Source: ABdhPJzX9jWLhzTjtjQU7wN7OVHKYBR8BpWTxogSCK0npxv6vZ89SR9rQCAouuuUi4Nxuv6jbnTSYXFfBTmTa5PVQXo=
X-Received: by 2002:a1c:f309:: with SMTP id q9mr1267664wmq.173.1644390414247;
 Tue, 08 Feb 2022 23:06:54 -0800 (PST)
MIME-Version: 1.0
References: <6fc4a81f-1a13-bff9-7b2e-d5bec382cb42@synopsys.com>
 <9bab4777-3034-b789-fdf6-ca8d7e6a8c35@infradead.org> <CAOMZO5Aa4WxuadfoFGwwyYyD4UGPm-E258xTWU3-ozp_hwG-7g@mail.gmail.com>
 <d8981e2a-4f61-72bb-e5cc-bf4ded29c08a@synopsys.com> <CAK8P3a3ELrSC=KX6cr8UnP6kkJN0AXeAE4EG4oUY=Zz7gG_dgg@mail.gmail.com>
 <b44de208-6d5f-3fcd-0e36-f05745297747@synopsys.com> <CAK8P3a27RtHxYwtj=rjxcDzkMdKhC-w9ho=SApHpczma_vU8JQ@mail.gmail.com>
 <6743d6b1-13fe-9c83-f706-82338dd03897@synopsys.com> <7ed6137e-cf19-3614-9404-e89389411a8f@infradead.org>
 <992f01cc-eb0c-b503-f9b4-4a037c6cf67a@synopsys.com> <2434f050-b82c-03e6-ee8f-8c8799119815@infradead.org>
 <1aef3a8f-f93e-2824-6b6e-8df8a1460f15@synopsys.com>
In-Reply-To: <1aef3a8f-f93e-2824-6b6e-8df8a1460f15@synopsys.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 9 Feb 2022 08:06:38 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3bJcMKW5QJqoUT8jDe+cbK0A-zSbNZhveX0WwC=ZEUqw@mail.gmail.com>
Message-ID: <CAK8P3a3bJcMKW5QJqoUT8jDe+cbK0A-zSbNZhveX0WwC=ZEUqw@mail.gmail.com>
Subject: Re: Kconfig CONFIG_FB dependency regression
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Fabio Estevam <festevam@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        John Youn <John.Youn@synopsys.com>,
        Bing Yuan <Bing.Yuan@synopsys.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 11:42 PM Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
> Randy Dunlap wrote:
> > On 2/8/22 12:10, Thinh Nguyen wrote:
> >> Randy Dunlap wrote:
> >>> On 2/3/22 19:21, Thinh Nguyen wrote:

> Ah.. It's because I don't use old.config as the base config. I use
> x86_64_defconfig as the base plus some additional configs I need, and it
> has CONFIG_FB_EFI set by default.

Does it hang if you just disable CONFIG_FB_EFI on an otherwise working
kernel? This is supposed to only disable the framebuffer, but it could be
the actual cause if something else depends on its presence.

        Arnd
