Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FFA5A1850
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242967AbiHYSG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbiHYSGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:06:24 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763CEAE210
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:06:23 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11c59785966so25887519fac.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=vvKNhwodo3b0D7wr+xi2jqqIEIqtl+Yrqm5TAHzIjcc=;
        b=kpMw1/0cz2l0wLS5eCf0pnYaOSzM1oU82bCuNWzIxcLoeGHTzZbqIHLicPez40Cb/5
         L2Yt8dlKbIbpOn9tzU3csXG41A/LrkV+60n/R9SffFc13VjBWIkn5JQMpwtCCFSTi8Kz
         YWjboilvOWYg7X9U95pelUBTngmBeoDX+husI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=vvKNhwodo3b0D7wr+xi2jqqIEIqtl+Yrqm5TAHzIjcc=;
        b=XrPBtUa/KFzAc2ZFArGgoUlWD95exEWgVgO7aCDn9/RVlUaoHVNoSqwiF0XpiuCrfy
         2yiHeyfLL/kCVa+XrD3FvEKJ4ojVlGs3yUN5cSFzN3WWFsm5cUh2VAh+6sWB2fTF+30w
         CCwQoqh21SXbzmBN4R3VaKwYmOI6VcY5haGO8ZsN6JPLzBwaRodeTpQFKCm8Sr6Zk3it
         Gb0t7wCjliO/QZy58VgTDN8vfEI0+5VV5QqtKbsoTTIWedYM2r+kabPXmOHZqrJAHNBj
         GAYaiehOfurstTn63MAbkWYmsaoPF4uoyvgURdtmWWJ1AY9df2l9xMluEbdPboQ526me
         a8mA==
X-Gm-Message-State: ACgBeo2m01CWA3LrgQ5YS41gDpzBIsaCR8g4kF2UQNq6MqDIY/tq4DoU
        Euqjle+5quZB8WjefM1voNTswDuPuNWBNg==
X-Google-Smtp-Source: AA6agR6tqD3cbz1kLeRqSirSDXEcrxMHjMkHhlfA6JUJV04qZdAHj2DSZ1fqli3lSLbk/BjbYIoINQ==
X-Received: by 2002:a05:6870:5591:b0:10e:20d0:b2cb with SMTP id n17-20020a056870559100b0010e20d0b2cbmr167022oao.12.1661450782395;
        Thu, 25 Aug 2022 11:06:22 -0700 (PDT)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com. [209.85.167.170])
        by smtp.gmail.com with ESMTPSA id p10-20020a056870a54a00b0011c6b9abb67sm100807oal.46.2022.08.25.11.06.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 11:06:21 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id o184so24193553oif.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:06:20 -0700 (PDT)
X-Received: by 2002:a05:6808:20e:b0:344:997f:32b8 with SMTP id
 l14-20020a056808020e00b00344997f32b8mr93699oie.11.1661450780460; Thu, 25 Aug
 2022 11:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220822180729.1.I8ac5abe3a4c1c6fd5c061686c6e883c22f69022c@changeid>
 <CAD=FV=W5X2XvvKT5tq+1ywJSmVB0TAHquGgn02uNmn4s-sqndg@mail.gmail.com>
In-Reply-To: <CAD=FV=W5X2XvvKT5tq+1ywJSmVB0TAHquGgn02uNmn4s-sqndg@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 25 Aug 2022 11:06:06 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMetKHtL8Hm_=S7xPcHX19FDaCoXtHmh=E6i6pLEXQZ0g@mail.gmail.com>
Message-ID: <CA+ASDXMetKHtL8Hm_=S7xPcHX19FDaCoXtHmh=E6i6pLEXQZ0g@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm: bridge: analogix/dp: add panel
 prepare/unprepare in suspend/resume time"
To:     Doug Anderson <dianders@chromium.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>, xuqiang36@huawei.com,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Zhang Zekun <zhangzekun11@huawei.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 25, 2022 at 10:37 AM Doug Anderson <dianders@chromium.org> wrote:
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks :)

> Given that this is _not_ an area that I'm an expert in nor is it an
> area where the consequences are super easy to analyze, I'm a little
> hesitant to apply this to drm-misc-next myself. Ideally someone more
> familiar with the driver would do it. However, if nobody steps up
> after a few weeks and nobody has yelled about this patch, I'll apply
> it.

I'll take this opportunity to correct Andrzej's email address (my bad;
I need to use the up-to-date MAINTAINERS / .mailmap when generating CC
lists), in case he's one such expert.

Brian
