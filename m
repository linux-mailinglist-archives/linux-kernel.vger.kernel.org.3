Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991BC4E2230
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345242AbiCUIaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbiCUIaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:30:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A0A1B7AB;
        Mon, 21 Mar 2022 01:28:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id p15so28252840ejc.7;
        Mon, 21 Mar 2022 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gCEz5dPRyK/flzz3OwRwSC02KK3yfqplin0VwWaXWE=;
        b=QNwhaLiJEae5pMKgOMyy82/3orwYX6EmvDOiaeaMDKcv6Y6Y2zrqF5M6MHxYSAcXcw
         S9knKiS0TVBHgQCOVMiG+j68JzdO89XbVQWaXhK8r9lyNa1CQYqVfjmOiwost+Y+ImBJ
         5Woj49+X+/jvTzkJZB46UO5vbub60b3bzjlM/VhBR8iu07ah0fBXerD/Vjam8+johwS3
         BIadP+T29VxWVlQhgrc1gtCpB36o2qgNVyhij5u97PPPMqFDKmjfIW6Zgpg9FjzlRjsV
         o+Lqp5H+O8OsoIslyOLE/cWZEBMHDKTuiPdVjU2+AdtLjDXSFyssrib8aPY5X4FKtFUd
         3UOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gCEz5dPRyK/flzz3OwRwSC02KK3yfqplin0VwWaXWE=;
        b=KiOihw55vt2Px1naCwQIFziOekLxfx3Yuq06v/iau8p0a/I45Y6IRbwp+CrVqSkBlp
         XE8yv0hEMk5lz1RULFk7pIDImW6RIiNa319pdco83nXlW1QMODDFGD3TYlDXv6WCQS8q
         L/WX9v0f54dfm5Ct0CFMjlYDKzjPrD+t1sWPE7Ikays9htK1B0Mrxv54lsIxUjJky3fO
         2X0yOMS/9vvlTFetUXnsu5LOighgyKZvUllAFej8PWab48xMk3JA4O8yv+nFAW7YLc7Y
         gxuuuwER5ZbEvl5GPqhpdTbcszQMXMqJskW9au1h4q5Ct5/bqWgzpuVRu/HvKi8uZaOr
         NXFg==
X-Gm-Message-State: AOAM531uTaawKNo526dgeyqeqAfMXwXemAVZwJxX6VGpTp4VhVvjP+7o
        D5ZeDHsDfcehor+SJ54yIMsOe9kdaxKZhq37dGw=
X-Google-Smtp-Source: ABdhPJxEC4DR4nHi3LTLgZLvnkWrkRiZcojwi3k7rZSh7MLaAb3zSZZJYU9EOHm3nchAhjlo+UMKK+rb5GCVm2zX5zU=
X-Received: by 2002:a17:906:4cc7:b0:6d0:7efb:49f with SMTP id
 q7-20020a1709064cc700b006d07efb049fmr19583930ejt.639.1647851328749; Mon, 21
 Mar 2022 01:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220319162006.13c60c1f@jic23-huawei> <20220319193459.2628876-1-ztong0001@gmail.com>
In-Reply-To: <20220319193459.2628876-1-ztong0001@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Mar 2022 10:27:37 +0200
Message-ID: <CAHp75Vfk+CQZoz+s5PuSTBb0Nb4KLB+yoNiTCJQ4NktxV1nycQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio:imu:bmi160: disable regulator in error path
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sean Nyekjaer <sean@geanix.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sun, Mar 20, 2022 at 8:44 AM Tong Zhang <ztong0001@gmail.com> wrote:
>
> Regulator should be disabled in error path as mentioned in _regulator_put().
> Also disable accel if gyro cannot be enabled.
>
> [   16.233604] WARNING: CPU: 0 PID: 2177 at drivers/regulator/core.c:2257 _regulator_put
> [   16.240453] Call Trace:
> [   16.240572]  <TASK>
> [   16.240676]  regulator_put+0x26/0x40
> [   16.240853]  regulator_bulk_free+0x26/0x50
> [   16.241050]  release_nodes+0x3f/0x70
> [   16.241225]  devres_release_group+0x147/0x1c0
> [   16.241441]  ? bmi160_core_probe+0x175/0x3a0 [bmi160_core]

Haven't I given you a tag?

-- 
With Best Regards,
Andy Shevchenko
