Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BA547661B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhLOWo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhLOWoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:44:54 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4021C061401
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:44:54 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so26769337otl.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ODZh3LX8rxekmA6I2tJF7ir+ztlDboOkBn9B1Wfhg78=;
        b=Ilyft1dzTaqhA4dsa7o72TIAHzIyqoxEuvevRLLw/r/yRjrYub5lYOd/tPvmDoA1gt
         rAI+9fCoa/RLeTPok6HIXjKieSu64770AQG12n6kZ2nmyLtGIfDLmYqiBhH6/DJYmasv
         iFkHf2b/Xqmha0XUXmv3vl++pebg99dJaqwsG648N5OdgmibrxEsGybory29EsnhY7rF
         O67OJQjTWj6Blr3K9tmPxZjCb9p3bFEqch1XNtiCcG6/O1CDWH0ZfQh3mRkUjkN31Rzv
         6GLNQK/tV3J//eJmnYDngi7BUjrMZp3PQInXB+FZ3z7BiqmZiRdGLX/SzRl0uQCynsP1
         vGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODZh3LX8rxekmA6I2tJF7ir+ztlDboOkBn9B1Wfhg78=;
        b=rd/zZOgNIjSpTWIqS+Gw8x/Sqwxem1HvkZWRjkSkia9tH3m12R1ya+g4X1FSoIbhjw
         yrOCHP2q5zISrRL4sOl44FqqLuUMXxAr+hITxA+aWLRQOEvc8tsAqdYLZPMkXnaJlu3M
         zjkYRRi/USOTfjLjiA2B5oGxsC4Ib/99Qla9iJ1micrsn8A86MJa9H7CjmtNhd7+KREY
         wbLu9/19AvSonweT/qHaAifUHVAuSET/rhekfIM6Cbj2xYrJNL5Joh6HKlB45Olt4W7W
         38ZNIPv6UIwJrV5Z/PVhAggm3e4tDpfV0NhIjCX6N2ev69Go1Yi1URhgIA/62cfnqviG
         CuRQ==
X-Gm-Message-State: AOAM530PaZTrnErnSwQHkV81Ms2DQQvbxX0QJNOnofX5y/K4DfvqBASK
        oc/LkYDihUVVPmz+tMfSNCZFGA==
X-Google-Smtp-Source: ABdhPJz66avsF5VVA/jN4gjxWPFRUGBPvvVSkW2CKLJanxKhxZcEkmVzwocZFLWOnGJmd7gqYZgJAg==
X-Received: by 2002:a9d:5c04:: with SMTP id o4mr10900043otk.339.1639608294064;
        Wed, 15 Dec 2021 14:44:54 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id bf17sm624189oib.27.2021.12.15.14.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:44:53 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        mathieu.poirier@linaro.org, o.rempel@pengutronix.de,
        ohad@wizery.com
Cc:     s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, festevam@gmail.com,
        shawnguo@kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH V2] remoteproc: imx_rproc: correct firmware reload
Date:   Wed, 15 Dec 2021 16:44:47 -0600
Message-Id: <163960827806.3071514.13082003413170863890.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210602064206.27004-1-peng.fan@oss.nxp.com>
References: <20210602064206.27004-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 14:42:06 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> ENABLE_M4 should be set to 1 when loading code to TCM, otherwise
> you will not able to replace the firmware after you stop m4.
> 
> Besides ENABLE_M4, we still need set SW_M4C_RST, because this bit
> will be automatically set with SW_M4C_NON_SCLR_RST set.
> 
> [...]

Applied, thanks!

[1/1] remoteproc: imx_rproc: correct firmware reload
      commit: da87976921bba27199ee4df94081ac10fa0cf76f

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
