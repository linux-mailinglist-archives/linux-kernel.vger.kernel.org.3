Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C24D492619
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 13:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240559AbiARMu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 07:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbiARMu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 07:50:57 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BDDC061574;
        Tue, 18 Jan 2022 04:50:56 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id az27-20020a05600c601b00b0034d2956eb04so4698058wmb.5;
        Tue, 18 Jan 2022 04:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6Y1Ova7Y1eOHP74TgEiFjPPk+lw3tUNdNdvPlgpu9No=;
        b=RtjWIbAtRny80mz/OpmyKJ9FC9+6jLFxBi1LOeq1D08R8ox/YYC9dIhi/RR+vuuY+0
         xBPqA0HJKsRhn0HRiCMJcmp3K5gneAiuh7BbFne9+7Q6Svu0xRSu2hUSRlTUwj9SJ/ro
         ntlzb6FK7uGuObaeT1zn1cyF+gKFOKp6O5bm2U9tst+uabLJ0R5WLvwI5Vip9Qa2/tpl
         quwnGyWi0M/39GvFJV0ehHCLRNbh+EshK//WyZDGqMkh/9yItgsfkvaqvkkhq0sNl8lw
         ZoKlOxX7jHZhSgm2AEFLfmQiXdqakvNIjZWcGloCn8SUn8q0Cc6MeWaSFer36O7U9bRt
         GTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6Y1Ova7Y1eOHP74TgEiFjPPk+lw3tUNdNdvPlgpu9No=;
        b=ZtLX1dG/5cgxlWazyd2ZuzK/GrtQZzsOJ3rVf8IvQV+F9y1hvIqFWh5IntyUug8/76
         9s6IwF6I5UVYDRXpef+ZSynumALs5S/868ryBLyc8tvjOcjuHWs34alMOr3IY5DQzTB/
         nJojLSTtaoU1LXPj7UJaGNbBPbZrJUOIZFpdHXuhkIZKm3IQ6V+YonGk2GhagRuG8Dx4
         AZl5qJaRZkPT2CBFt9ZyACRv4CzSOBfbclR9WR5zxKjvmWSfy7SM3sUcIz7gBriFSo1f
         wdWQOiiy8RJPMlJteOzCsV0Q4XThz/DhN8D7YToT4v6wvMs2ZseVByfhQIZVblPy1wj4
         3aag==
X-Gm-Message-State: AOAM530cAMa2K4E7vftP1trS8VYVhH37U0niZlcBmIboqBe4ODRyeUzt
        wDBDzfizWsND7VLh/DyF9tI=
X-Google-Smtp-Source: ABdhPJyDSrvcv7mWnHIq6RZY+NtmzayswEkL/ZHaSgHVOBpfNr4TFBPTmJ0DRNqLKr5usyY9+ic0MQ==
X-Received: by 2002:a05:600c:3488:: with SMTP id a8mr24525180wmq.131.1642510255432;
        Tue, 18 Jan 2022 04:50:55 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id o8sm10636835wry.112.2022.01.18.04.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 04:50:55 -0800 (PST)
Date:   Tue, 18 Jan 2022 13:50:52 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     linus.walleij@linaro.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com, hverkuil-cisco@xs4all.nl
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        zhangn1985@gmail.com
Subject: [BUG] pinctrl: reg-fixed-voltage usb0-vbus: error -EINVAL: can't get
 GPIO
Message-ID: <Yea3rBmY+MO4AhhV@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

As reported on old googlegroup sunxi mainling list, on linux-next-20220118, USB storage fail to bring up on orangepiPC.
We can see some error logs in dmesg:
reg-fixed-voltage usb0-vbus: error -EINVAL: can't get GPIO
reg-fixed-voltage: probe of usb0-vbus failed with error -22

This is bisected to: 8df89a7cbc63c7598c00611ad17b67e8d5b4fad3 pinctrl-sunxi: don't call pinctrl_gpio_direction()

Reverting this commit lead to a working USB storage being setuped.

Regards
