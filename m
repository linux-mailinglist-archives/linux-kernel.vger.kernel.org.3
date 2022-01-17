Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59FF4911E6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243668AbiAQWrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbiAQWrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:47:06 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E0FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 14:47:06 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id bx18so7334258oib.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 14:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ANjXnpcTiTZDft6xud3z4FpNe3JYReVbUAezN3rR7PY=;
        b=ih3vSnHK09IxqQ1Wd3gWiKLIMaPCoJhkY0Vx4WmF9NWuyFM/DV/pP5XyH50Hgz7E1F
         suNyi57iFo22vX+BlrAIHO6bPXADjdG/tLhV/G6DE48gqAiNmdDVQhmGIUzUhHnFkBaP
         /JcOttPUBY7XZk4zxNY+OTQSBw+1dCEBioVwYcMGddygoj83Ci6/5/kuFXTvXGVXBsE0
         hfBDuUEV/pxZA2pzeTl/qGHuofW5AHL1WopMQgmHaddhXG27SihMWNOmxHw6u7hAaGQs
         /PrQSSoI4UBUL1vYGj2FTDVCsLNA4C3rOHIs/MIbePfo9K1+wr61FLt8Gg4nFpwPeXw9
         3WTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ANjXnpcTiTZDft6xud3z4FpNe3JYReVbUAezN3rR7PY=;
        b=XgJPmCWaShndFgqZT8z4lSLJx6xaMQUDr7QORHyWNOwiFtENiyFZLerTEvZrnQsOr7
         DlEDMj0qUCKnpRr7q5CQ6Yy2BpuHH04u+dmw8Ph5z0LXdJN5/KUno/GnNWJBw3uDu0Fj
         0rt+ssLHj18PI8CYx8t1+P9B6FhmlLbvUAifzuxpYrxEcIoZDJrMkOOo49KzV9+X3LyZ
         CqawtW3YhCJwnoZUOwUFw1bYH83rfcl03v5HsnitFxuvocRL3Cs4TjRUyy1YN06YM4u5
         TSLi6tappttmPLCCQm+o9iI3qhkWYJCC639w/neaYO0xPaZkj77NS1CdIuhZXfWahUqg
         yWsw==
X-Gm-Message-State: AOAM530XUFomtSylz8jtfWMg4mscLaldkymXHYdIGLw7B61xT+1AAQCT
        qXzO/za9QKfYdKBEDWpSQ7s+qExmglxpFQ==
X-Google-Smtp-Source: ABdhPJy5kyigHfvkrqTv51mXPFNCW0V3QyVj01cz4CFVnXRWA+rU+Wk366yL3V5X/BPa5yVn2X3g1Q==
X-Received: by 2002:a05:6808:301e:: with SMTP id ay30mr24670958oib.36.1642459625116;
        Mon, 17 Jan 2022 14:47:05 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f9sm3853490otq.26.2022.01.17.14.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 14:47:04 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     Sujit Kautkar <sujitka@chromium.org>, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v6 1/2] rpmsg: char: Fix race between the release of rpmsg_ctrldev and cdev
Date:   Mon, 17 Jan 2022 16:46:59 -0600
Message-Id: <164245960510.1698571.4998090450663669237.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220110104706.v6.1.Iaac908f3e3149a89190ce006ba166e2d3fd247a3@changeid>
References: <20220110104706.v6.1.Iaac908f3e3149a89190ce006ba166e2d3fd247a3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 10:47:36 -0800, Matthias Kaehlcke wrote:
> From: Sujit Kautkar <sujitka@chromium.org>
> 
> struct rpmsg_ctrldev contains a struct cdev. The current code frees
> the rpmsg_ctrldev struct in rpmsg_ctrldev_release_device(), but the
> cdev is a managed object, therefore its release is not predictable
> and the rpmsg_ctrldev could be freed before the cdev is entirely
> released, as in the backtrace below.
> 
> [...]

Applied, thanks!

[1/2] rpmsg: char: Fix race between the release of rpmsg_ctrldev and cdev
      commit: b7fb2dad571d1e21173c06cef0bced77b323990a
[2/2] rpmsg: char: Fix race between the release of rpmsg_eptdev and cdev
      commit: 7a534ae89e34e9b51acb5a63dd0f88308178b46a

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
