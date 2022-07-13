Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9A3573E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbiGMVDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbiGMVDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:03:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0346132D9C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:03:06 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l22-20020a05600c4f1600b003a2e10c8cdeso2616988wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3RE8IpT0EbD+zikgdgGwj/YsTGC42mNfwGCljsqFQGQ=;
        b=p8UcNprSsjajY/y467Cc7+NJUUdV0ERBggqcph9FOEfVNFHl4H+H8vxqXR3v1xZzjt
         pK6W16sAreb75A9vaznnnvu93IANTnp33ZNAA1zwX6O3cCRKLMgvLMOdDCftMz+OH9uM
         ehflCksWAbFZcQRfcR6Trv/6C0YyOHxLhJx2qD30/txfFtNzpx0jiaLOz1scyc1tTPke
         seTQB5v/7o3XF6f8wmqMXxEjyUFEV3+KwiTAM+vNn5TsacfEoQCFmG0BcoWpH/NqfaN9
         BFIKF1O3xtchPogBDLwXk2UswASkuQzyDgh8ZP37XR183L/VvOzkEz6ompKwojJw2H0j
         0r/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3RE8IpT0EbD+zikgdgGwj/YsTGC42mNfwGCljsqFQGQ=;
        b=Pv1GrTG1WryRET1G8i25RG+vBVaOklszxAVECgBDTvSA8xprW/3q+CR3GfzwpxR30J
         jc34ZbXebhGeyTY8da1JEqf6qddM7UIsTO5BjTIhur3luhtCAkH92y43vOXe2xgdH+LK
         SF4+b5yYEwODQVrLhPEwJrTyEcSpFx18IzIeZDOwmEVTLyRQz/oxEtLYfRWFu38hmMlR
         AqnlGaLyQKjrTLxhcOvIwlFDzFBgWeCwcN/PMK22b/y2PFFmn6DzAyNoiGJXyUGew6Ds
         unYd5lLh9gI8Gl25Y7/5CaH4YFRSJ63WIic2J8X4o8q+tRYqrN3wWVhwJT28zhxWLZqp
         t/BA==
X-Gm-Message-State: AJIora8755ro+cmfhQP1noeAfBXFRc0Ufa4LouBfjOolePyXq82kWhLw
        oZIKkDcsaoaWUbnggMWPi7AjGkqXdWMm8qfqsZS1
X-Google-Smtp-Source: AGRyM1vejqT/tSdioS1eQS86Ms9UekbxWVJYvavZtfgP/tqiiD3MrMqFpuWjFXK6vEArUHpSe2aruoP8qUv8kHn0unM=
X-Received: by 2002:a7b:cd0c:0:b0:3a2:e864:98b8 with SMTP id
 f12-20020a7bcd0c000000b003a2e86498b8mr11477902wmj.200.1657746184461; Wed, 13
 Jul 2022 14:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220713204623.5443-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220713204623.5443-1-wsa+renesas@sang-engineering.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 13 Jul 2022 14:02:53 -0700
Message-ID: <CANDhNCp3KhGjXSrS4xmqrdPJfxStZOOn+FQxJEEoiXZ39CxDpg@mail.gmail.com>
Subject: Re: [PATCH 0/9] selftests: timers: fixes and improvements
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 1:46 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> The timer selftests are quite useful for me when enabling timers on new
> SoCs, e.g. like now with the CMT timer on a Renesas R-Car S4-8. During
> development, I needed these fixes and additions to make full use of
> the tests. I think they make all sense upstream, so here they are.
>
> Patches are based on v5.19-rc1. Looking forward to comments.
>

Hey!
  Thanks so much I really appreciate the effort to make and send out
these cleanups. From the initial skim it all looks great (though, some
are slightly embarrassing :), and I think some of the extra config
args will be quite nice for others to use as well.

Acked-by: John Stultz <jstultz@google.com>

Thanks so much for submitting these.
-john
