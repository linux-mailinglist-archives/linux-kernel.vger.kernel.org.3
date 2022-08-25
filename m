Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D09B5A1B91
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244191AbiHYVsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244190AbiHYVro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:47:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F27DC57B8;
        Thu, 25 Aug 2022 14:46:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id s23so10823617wmj.4;
        Thu, 25 Aug 2022 14:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=mE/4YBZh38TyYLhC6G5fQYeRHrAbzB7JvF8agv/vdQg=;
        b=P6++xFNR1j0FfYdfcet9OwwFkgk8uW+QeGrsGedHWY32iLGlB2WTWHd0wEKUvrLfyw
         8PIs4gz3vkR9Mxv5wfuXVMTHU5ZYIkrj2GBHeqM27WwzY2tF1tPpbagfTsmfbx5BWVPp
         DOePwUjptMdp2mN1L2K2lS6WdQXAd6gNyRoxaMAiNlGePB3owtm/aCrRQguMiHKITf/4
         VuMJC7mvsdos057Hw1T5i8rDb58UF3RBi40wqWBJpnN75SZxCwMjbhaogevZ3kXA+BN8
         RsJ9P04/SH/PsScmrAk2cxLYQ7MuPMUBB5HUnXSfEKoNqoNx3PVdxp0gvFUiBwB/zH5t
         Jpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=mE/4YBZh38TyYLhC6G5fQYeRHrAbzB7JvF8agv/vdQg=;
        b=2KutgZh1XuQzq9269azltC5iTxWchSx6IervfQGXF/GH12+kJdRO3EdN0yki9cyuYv
         3iYVr7HPWgMi7jfhdEMalS5vLrj5LSdwNV1yOd/xw+xBOmQokZTparZ6nKqEpWlJ/8hB
         M6WRb82zsXovtkzZ+ZcvV+bJry6cYxVnyy6MMSxWO9UVS8BnwjQAaoFN3PDTYQbFHg8o
         RWzaLrePkVOnUF/UiN1tVm5AzhGaVogWC/3di1GB0EskQBeBkxaIqd9mghZai1dfE2kY
         QvtN2ayM2m3uIoVnFpl34Ytgqnm0u+ioDc0bV1fKadOzhXdtSsUMULkbesfyB+pbojlg
         ySXA==
X-Gm-Message-State: ACgBeo2ukbfk6Tv+K/pc32LDVjKpz4ZA75xkIt3/rIpr6bjML8jGtfTd
        lZAETDacNZCh7e+L+iBkzew=
X-Google-Smtp-Source: AA6agR7230MGbs821+A8YN82pus383ho1o4vUi1fAFFJ5dzUVRhvyyd967MFX7/eyIwgOmyNIlfCpQ==
X-Received: by 2002:a05:600c:4ed0:b0:3a6:de8:5e7d with SMTP id g16-20020a05600c4ed000b003a60de85e7dmr9320639wmq.181.1661463957948;
        Thu, 25 Aug 2022 14:45:57 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id az41-20020a05600c602900b003a60bc8ae8fsm466499wmb.21.2022.08.25.14.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:45:57 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: Re: [PATCH] clk: sunxi-ng: d1: Limit PLL rates to stable ranges
Date:   Thu, 25 Aug 2022 23:45:56 +0200
Message-ID: <1870351.taCxCBeP46@kista>
In-Reply-To: <2839208.e9J7NaK4W3@jernej-laptop>
References: <20220812080050.59850-1-samuel@sholland.org> <2839208.e9J7NaK4W3@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Dne nedelja, 14. avgust 2022 ob 09:47:42 CEST je Jernej =C5=A0krabec napisa=
l(a):
> Dne petek, 12. avgust 2022 ob 10:00:49 CEST je Samuel Holland napisal(a):
> > Set the min/max rates for audio and video PLLs to keep them from going
> > outside their documented stable ranges. Use the most restrictive of the
> > "stable" and "actual" frequencies listed in the manual.
> >=20
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
>=20
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied, thanks!

Best regards,
Jernej



