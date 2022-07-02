Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A962563FD9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 13:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiGBLmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 07:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGBLmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 07:42:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D3DFE3
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 04:42:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ay16so8363017ejb.6
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 04:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WhjM8Dp4mS9IBPn4kroy2wdgNNIdUgixClIV/mTih4M=;
        b=G5aRF3FDYzEYd2OJ5K35vT+eFEdkrmjc4c7Eyr428zyoAOxx1WuwoNBVxL5OykT9Lu
         RexthZ66BUxwMN9n+wsoTcNXyZfAWPmJtVqp8TW1NBR0a0fgCWytzFhLUCOCAAfzoi/y
         EPTkROUbArwuiq64voho2IYwp5VGYM1UQW5d7qK0MhzACkhycCA4xNkh3wfBjqpi4ZDq
         knyLD82Xsy8Q3GNqABz6Kqqd3MqaucKwLepqBbevKFMi3DBzmifbOTj8j5y4N3gQdF2A
         8hwR7Cjop8kQXTMOF5hNlmszW/Rtada7eBDmlBxAAeoxCjfRH68icS46M6HcvSmBoBuh
         C2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WhjM8Dp4mS9IBPn4kroy2wdgNNIdUgixClIV/mTih4M=;
        b=v1jnvPBUIlfzkWYliNJ+JAjwPtbEaLuuccJHj3nRiwkVsN/QGJcL1Sm6CyiuPUY/iB
         6GGN8LrY3xSrGhcV6RIiU1kPbNR1VhaGKXAqyda2g2YjiX93MY01NKA97NxC4VMd91pj
         o7GsDg4oZuempzv0Jviu1on1fe92qGiGQwmIbdjpllO44E4RzeOhs7fE5Adda61+4flP
         3b5AHEj31T6oIwp9+48eg9Y7ghs5lD5rCz46m62k1Gzrp5Q5XLKSyGXeYF20FN3rQur3
         RgqlTsWjJmHkjwrojD/SxvxwMWXqDB0h/qOdJQaacWuSen1RfJwxjF9+sVtL6OAhqBTE
         zd0Q==
X-Gm-Message-State: AJIora+1nnG9c6bgWbWB13WmvLXGVrZXPdiCbnI2G+HlF61hdWUZzHap
        oJgMA4BY7I1h/2TKTCBPQmyYsREyXpXGpppEkAc=
X-Google-Smtp-Source: AGRyM1sMKM+Zutej2Lk/Zoiz7uwcW9yWj8/qcDHkuNHPs5bqlatUV3f7qzNzERj7fejcIgDRX7YVW7CkMZKXqYYhmYk=
X-Received: by 2002:a17:906:4e91:b0:722:f996:fa20 with SMTP id
 v17-20020a1709064e9100b00722f996fa20mr19148286eju.733.1656762125876; Sat, 02
 Jul 2022 04:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220621072050.76229-1-christian.gmeiner@gmail.com>
 <20220621072050.76229-2-christian.gmeiner@gmail.com> <1a694037c631c298c6952cdf4bf54fcc6d2f08e9.camel@pengutronix.de>
In-Reply-To: <1a694037c631c298c6952cdf4bf54fcc6d2f08e9.camel@pengutronix.de>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Sat, 2 Jul 2022 13:41:54 +0200
Message-ID: <CAH9NwWf11tcQctdQhk5AoKT-Nz-ujMRaQJjfVydNDnT==+S+_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/etnaviv: add simple moving average (SMA)
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        "moderated list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <etnaviv@lists.freedesktop.org>,
        "open list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux+etnaviv@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas

>
> Am Dienstag, dem 21.06.2022 um 09:20 +0200 schrieb Christian Gmeiner:
> > This adds a SMA algorithm inspired by Exponentially weighted moving
> > average (EWMA) algorithm found in the kernel.
> >
> Still not sure about this one. I _feel_ that a simple moving average
> over a period of one second does not do a good job of reflecting the
> real GPU load for a bursty workload, where EWMA might be better suited.
> But then I also don't have a real informed opinion to offer on this.
>

I will play with EWMA and see what happens.

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
