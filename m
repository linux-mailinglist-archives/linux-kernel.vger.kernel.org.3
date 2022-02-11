Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41A94B1FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347867AbiBKIE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:04:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237830AbiBKIE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:04:26 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4087DBC4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:04:25 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s10so246601wrb.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/lcEOr4uqjKNofumghLHP70Sk12EtIo5iskvCPhpIT8=;
        b=0EqUeIzqvPaZiaFn1tjWOUcGQ8QzV+DdWjPdiPzg+cAQtuKSAt6ufW+5FT8PvmmRrN
         5burrJjB5mpE0DsAkSCwsf2cggLbJgOREIPMNCnQIHioY72CF9jLttI9vQS+rmj3UI+9
         nlP/YeKxTNFHGNaq03tBkO8U6z/LAeI0ti2JXyYZjungMfE68JHIwQoFFuSMP43fW4z4
         vSjoNa96xCS657CO+J2Pr/zzLuqkhJLNPKDpXacY97H8sXCcIxQ1zANtRmRwcs8/z3Ux
         vbgGjVp1tjj1NlHGWy3bw1ETpJWnkYzpIKi2/M2D7YrY3MalKhPAL6iJ7AbDhihvCuLa
         JNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/lcEOr4uqjKNofumghLHP70Sk12EtIo5iskvCPhpIT8=;
        b=0br0/oE15zbIR5lIAF8vumBq9tBq1zO6+h0Aa1uFdntNQDrKsSxsChdw1r+4+NkBgW
         nzmAQF7XNh54QBlX9H2STv8XRvMxHEkfnEcVED6wE2JqAtcD+iB/E6SJgmJTGAPPVWKx
         FMNPA4w+I3JB9MHe57scz0Ta6VA0lC2YwskeXSGX/UkUCXe5IufHSIlXULItiqzyf92m
         Z1BHqQ6vmEQCbHq5ZZ+pL7AX8BTc5zFBb02YqP05I74qMHabGs0UREGp9CuxfIcx5B+S
         jfGDNN1TnMgMk+ILhkjq35Pp5/zG4RDq5lYPwbF1JHeUmatJfwwtsYe3Ky/ya7l7YdWI
         KYjw==
X-Gm-Message-State: AOAM531bwsIGlGTSu2MoHSlpuawuQd3YGAU5pCUhE0LgON8dN4xXZsOe
        fcjb2BCjER86sHe03u0RBIv8cEgJTAIThuFY
X-Google-Smtp-Source: ABdhPJwUaPbV+hpspCv+07XTweqV+qV7F9YlImFo8czFokOghyZPvgvkNPEvIXv29cTCyqj5fGceyw==
X-Received: by 2002:a05:6000:1363:: with SMTP id q3mr365638wrz.468.1644566663486;
        Fri, 11 Feb 2022 00:04:23 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:97e4:3830:c79:136e])
        by smtp.gmail.com with ESMTPSA id u7sm12601533wrq.112.2022.02.11.00.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 00:04:22 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, robert.foss@linaro.org
Cc:     biju.das.jz@bp.renesas.com, Laurent.pinchart@ideasonboard.com,
        jernej.skrabec@gmail.com, kieran.bingham@ideasonboard.com,
        dri-devel@lists.freedesktop.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org, jonas@kwiboo.se
Subject: Re: [PATCH v3] drm/bridge: dw-hdmi: use safe format when first in bridge chain
Date:   Fri, 11 Feb 2022 09:04:21 +0100
Message-Id: <164456659389.920211.13712775936606850365.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204143337.89221-1-narmstrong@baylibre.com>
References: <20220204143337.89221-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 4 Feb 2022 15:33:37 +0100, Neil Armstrong wrote:
> When the dw-hdmi bridge is in first place of the bridge chain, this
> means there is no way to select an input format of the dw-hdmi HW
> component.
> 
> Since introduction of display-connector, negotiation was broken since
> the dw-hdmi negotiation code only worked when the dw-hdmi bridge was
> in last position of the bridge chain or behind another bridge also
> supporting input & output format negotiation.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/bridge: dw-hdmi: use safe format when first in bridge chain
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=1528038385c0a706aac9ac165eeb24044fef6825

-- 
Neil
