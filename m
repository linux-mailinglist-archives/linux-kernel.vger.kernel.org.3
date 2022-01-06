Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2C2486A4A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 20:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243159AbiAFTGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 14:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiAFTGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 14:06:12 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074C9C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 11:06:12 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z3so3117208plg.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 11:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Zsjxxw6pd4DdvZ9ARrFvDZnuIXFpfJxLz7WO0wCernQ=;
        b=aPDN54U5pkO5HHNN6o/d+Wa46jM8wSiiODG4x4hx33hrw4OfsqihQg6zGV32Nj2zax
         JanNwsFLN7TQup4lMAwYXzxS84trjw6x7/2pIIngpus6+Hssuuj1jxFjOt1qcbui6bpZ
         6AmUuehvcx4mr6QOG8ewp7Cb1IlOODwTu/hDVjZ4VR9tvO5+MY+aNXQ0Fo730QUdACHZ
         Yow2dzJLGzg4AcMPAWd4xVEUGzJVD6GxhcxA90amuZ5C5hseVYIVuBRtwS00ZZe/bpWb
         lAY4zAiuU3op47BJHysCARxVDHEyM4Xy+uuTB+N6Qiz2ZVnKNLkTCZe7ks1VM2zVWO8x
         D8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Zsjxxw6pd4DdvZ9ARrFvDZnuIXFpfJxLz7WO0wCernQ=;
        b=mx08lQ0mgp9hN7FMGH0xeh6iOUZdNzXChHziyWA1FYMlNUNiKMxEJpj6q11T5KHeAn
         f3XT844xsi24k6LYKCwUS7l5VfBc0k5RIChc8zx7SoS/2EK0U94bp6RTdJKSU1FocUGx
         sfoT0c3slsw5RsOLPpvRPXHRF4TS7xFuuW0SIu5dMI16KtsHgwmNEFZb1Ju0Wjn80jYZ
         QQok7UTO8Sdp2+AUnxgTFhaauAC1a6OWiXqVy2H+42SxDudn41rhZVU7xNHdiXi+cYMD
         iCO0RV99jsk+Thj2xu7YFNpndZH7T6pWiV9UKHV01aEP0ygjL6KGXZaiMJOnC2MXYECC
         pVhA==
X-Gm-Message-State: AOAM5303eeGAumArArhGwRHym0ckY97e0CqWoUwCuOsp3WxtlRrHe61e
        Y+PSYYdysVKLnYzLzf/Sdhc1fg==
X-Google-Smtp-Source: ABdhPJyxOxZKTJqgzSxRXlJWQk0gUdFo548NlJxlwKKYwpOb8FAbfo+BhY8W4Pz7mnZZ/bRCO95gCA==
X-Received: by 2002:a17:903:24d:b0:149:b68f:579 with SMTP id j13-20020a170903024d00b00149b68f0579mr24075313plh.1.1641495971463;
        Thu, 06 Jan 2022 11:06:11 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id z18sm3468833pfe.146.2022.01.06.11.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 11:06:10 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        p.zabel@pengutronix.de, balbi@kernel.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 0/3] usb: meson: fix shared reset control use
In-Reply-To: <20211212201844.114949-1-aouledameur@baylibre.com>
References: <20211212201844.114949-1-aouledameur@baylibre.com>
Date:   Thu, 06 Jan 2022 11:06:10 -0800
Message-ID: <7hv8ywr8f1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amjad,

Amjad Ouled-Ameur <aouledameur@baylibre.com> writes:

> This patchset fixes a usb suspend warning seen on the libretech-cc by
> using reset_control_rearm() call of the reset framework API. 
> This call allows a reset consummer to release the reset line even when 
> just triggered so that it may be triggered again by other reset
> consummers.
>
> reset_control_(de)assert() calls are called, in some meson usb drivers, 
> on a shared reset line when reset_control_reset has been used. This is not
> allowed by the reset framework.
>
> Finally the meson usb drivers are updated to use this new call, which
> solves the suspend issue addressed by the previous reverted 
> commit 7a410953d1fb ("usb: dwc3: meson-g12a: fix shared reset control
> use").
>
> changes since v4:
> - call reset_control_rearm() after clk_prepare_enable() fails
>
> Amjad Ouled-Ameur (3):
>   phy: amlogic: phy-meson-gxl-usb2: fix shared reset controller use
>   phy: amlogic: meson8b-usb2: Use dev_err_probe()
>   phy: amlogic: meson8b-usb2: fix shared reset control use
>
>  drivers/phy/amlogic/phy-meson-gxl-usb2.c | 5 ++++-
>  drivers/phy/amlogic/phy-meson8b-usb2.c   | 9 +++++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)

The cover letter prefix is "usb: meson" but all the patches are for
drivers/phy.

Could you collect the reviewed-by etc tags and resend to the PHY
maintainers and linux-phy list?

Thanks,

Kevin


