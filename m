Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A718F476621
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhLOWpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhLOWo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:44:57 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B2CC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:44:56 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id b1-20020a4a8101000000b002c659ab1342so6361948oog.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m7eXdYQSfHOMEV4rFRIDaD0pSvXJQjL3uNKMI5fpepU=;
        b=KfMsZOgt7Y6Z3amFQl5cblfkWJ9BsLsgs6F59tO+WP9r1E/SX0knZhjqFEqY8rza2P
         WYaqNWKLj61f+icTxKSItTfiEcGhGL4m+W2Yi09RtgSxrtNX7KtLu01F4z1IntRF7qsm
         lQjR6AQYSMKlKJfiXDsJo6JrjaeVAd/hoG6tZlashgwMkqt40yKv5Sz9gD2CU0llzPp4
         kA3QvEcn5npPgXOuYmee1ZppIpt19TtD1J+vMFHj0dy6V5cZgRyemvXSAhVlUD/RwHzi
         tqKqk/a4FCRTDiGZ9WplIyq7PNEI2SU5ewboAybDUKqS2BZ5LSwA49Epo+zjkgNbOBrY
         TE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m7eXdYQSfHOMEV4rFRIDaD0pSvXJQjL3uNKMI5fpepU=;
        b=NwrKdYi7jV8XP2Ts0jO3ckWA3opns7+uF1YaW+Rdllxe3yeOtPx+p0Afy9/+eVlR+C
         BRZ/EtlahZ4wBxJK6PXDhFqFGqfwOw8o+ACpzXQElEUCeucMJMu9v487bWr8AX3DHpBn
         xQgaeheuz1ZNN6qGBQt7HrBLvfbkG9qwIxtEBZa05NiTcJN+das/ghUnBiaJ/6teTmyN
         4gc0sWYyWO73DoZrxmL/Kq23xpajE/xzMLc2x1sK3Dw8so3mPgOPOCqXSWiygOYYCYtU
         nDXfhqd12ZKfSJnb89KU5V7AIdfh2IllHQT/BVeiGb/xr+muRGBXA3WxudpNJE9XtZe4
         QQrQ==
X-Gm-Message-State: AOAM532PL889iapNrKyRcL3blVd+5vNXX4YrfIH+iV3WUJcAYQak0CSg
        0FudSYWE/3Uei8UYuo2iTVd1Dg==
X-Google-Smtp-Source: ABdhPJwvuPMPfn2q5FP6SmmHtIMpypDWQyCMWMOoQqkrQwLhZNM4sZYqSqMw/ItoXQoAbeA14nUTcA==
X-Received: by 2002:a4a:cf12:: with SMTP id l18mr9110518oos.25.1639608296178;
        Wed, 15 Dec 2021 14:44:56 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id bf17sm624189oib.27.2021.12.15.14.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:44:55 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: Don't memcpy_toio more than is provided
Date:   Wed, 15 Dec 2021 16:44:49 -0600
Message-Id: <163960827806.3071514.11059170619331104073.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211117065454.4142936-1-swboyd@chromium.org>
References: <20211117065454.4142936-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 22:54:54 -0800, Stephen Boyd wrote:
> If the string passed into qcom_pil_info_store() isn't as long as
> PIL_RELOC_NAME_LEN we'll try to copy the string assuming the length is
> PIL_RELOC_NAME_LEN to the io space and go beyond the bounds of the
> string. Let's only copy as many byes as the string is long, ignoring the
> NUL terminator.
> 
> This fixes the following KASAN error:
> 
> [...]

Applied, thanks!

[1/1] remoteproc: qcom: Don't memcpy_toio more than is provided
      commit: fdc12231d885119cc2e2b4f3e0fbba3155f37a56

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
