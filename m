Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCF6499A19
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456815AbiAXVkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444617AbiAXVBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:01:12 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BF4C04C062
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:02:29 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y17so6554462plg.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=YEJC09BaXrXowCgo9lvcrsFTV9cTaqg/eq8tuzFMaPw=;
        b=DLTXaapbxBx8Ck2RAOi8Km23rVDe/NrQim0Hyuk9wVITZr/4LaUJWCmM6ZbgIdHD5+
         Bfbyk94aQIaY1Rc+qGCqqMdFebGLVBDH96OROrgotIHdW4Hh1dhVpWkfWTn0q4Te3Pgj
         aSfCuKXWAQ/cZJ1OyKX80U3Vyd1/5T8MhgqNBA/rp/ewQIcdx+4TY/xZVbIDvyn0D+ZK
         ECdAoT2mVumJv3G+w1blktv69GFp0n4Mr6Gy7flDMz8sym5urBR1piAz0EmnubjfByUv
         je+eezmQoun/pWIz0vxjehkBQF/etGyOdFNp4dPOQ530mru/TUA1BjBlZXxiFbzeGk5t
         08YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YEJC09BaXrXowCgo9lvcrsFTV9cTaqg/eq8tuzFMaPw=;
        b=Ys+NYQIhqDs23yQXZMT6WDJ2AQz/VPAc/2bWWN16NTFsgd52WENMaxnZNBH8X5rQmO
         xTprIe/o8PXUWjSxi8rkQ8RmvI/3sTx+5k7UxeX4cNoGwBkQ/QUgr5pDTi/6bQSsppJ7
         qxyB8tGoGaL1V2kd7Aa3Gkbfwsijlg1TQ44v5jCg38tfhYGqQr/yfEY4q5mq8BFVuXC8
         /yG5myTauorP2Zf51CgOhFEEqToKXngrT+pVcSNSbzeL2pEUsJ6tg/8isYg/TYgPcf1u
         vIlvFlsybR7IIeLEEOGCRm5OitlXqA91i02/Iizv9bf+zhEqtskJ2Bvo4YjYrqmbKf+V
         p8QA==
X-Gm-Message-State: AOAM532MBw+2IdU4JdOiyrnw2Bwx/kVxC3HWo36NSrku8ZkYWBBHN8xl
        CG3pWcxcJtnSBpuHXkhReFBxsw==
X-Google-Smtp-Source: ABdhPJyiTOFUPgKGEwmWzQPhRYM03CkpcJgdqO1Y7YACYLF7j4l4I+LB4xnmrsL4Sfps2GBC71HDOA==
X-Received: by 2002:a17:902:9a49:b0:149:7b66:e85c with SMTP id x9-20020a1709029a4900b001497b66e85cmr16054144plv.66.1643054549104;
        Mon, 24 Jan 2022 12:02:29 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id q7sm15972777pfs.32.2022.01.24.12.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 12:02:28 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Furkan Kardame <furkan@fkardame.com>
Subject: Re: [PATCH 0/3] arm64: dts: meson: add BL32 reserved region to
 Beelink g12b devices
In-Reply-To: <20220122073221.2398-1-christianshewitt@gmail.com>
References: <20220122073221.2398-1-christianshewitt@gmail.com>
Date:   Mon, 24 Jan 2022 12:02:28 -0800
Message-ID: <7h7daoyka3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

> This resolves a long-running issue where Beelink GT-King/Pro and
> GS-King-X wedge on boot or shortly after when booting from vendor
> u-boot. In some distros the issue is often reported as triggered
> by large file transfers to/from USB or SD cards. Reserving the
> BL32 memory region prevents the issue.

The BL32 is typically common for the SoC family, so this change should
probably go into the g12b.dtsi.  Or probably even
meson-g12-common.dtsi, which is where the BL31 reserved-memory is
described.

Kevin


