Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8372E55C17E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241055AbiF0UEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240938AbiF0UDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:03:44 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CEB1C936
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:43 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id s13-20020a0568301e0d00b00616ad12fee7so7272947otr.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aSgkNr+Wy+cJE6ENGqoAt60f9q5wsqDQGZ0v1ZRCI0o=;
        b=RUHsbVfHJq68hNJPmE2G5fMb1aR6hcE71G0i73jlyGh0YGNT6QGRK9tja+uoe+cfg8
         FwspwSUtfMrylnku1mhd5mVCaFGfkIQEU6MbXfoFCG8cPcXEmH0g+x6fb/6JoSId2NnC
         /WsEkcOe+i9Z63riIEFrBIafdANMwNeToLV0osq9udxbEOEsb+fNIhf6FNCpdRkiPX2Z
         kt4f2kA6DOmliQtHzUP6Rhr2iAQkITeTKM40N/E4l6fo5Pk22sJ9Oz6HSbOXlzAJ3fPe
         jJF/rU8wo9XaPtl08TL5oZj5KgWJGi9oeL4zll56zoiDgfjoB4fOuU8w8uOxfvTlChkf
         22gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aSgkNr+Wy+cJE6ENGqoAt60f9q5wsqDQGZ0v1ZRCI0o=;
        b=uJucy3xvqVuBUGIZR9SbYZkJ/+pEHB8cif27ugPQAmYcziprQy1Sn40ARbWjd0z6Ii
         /jI5jQC0B/cfQTgwYeG+TfyK/3EhKWUUNmkxd+o0YMHazPaUbNcMWBprJk7T8rcCqqAf
         Oj7lhftzOVRYKqsk+pSUHrqSH1v4PUt8EHwvbf9DamERq/pex+/7fUnDQB+sxEzOFfmU
         ZgYs9meINYUtxOkIyOsWDqHzWqyilfJrqs35TSbuj/iS+1zCJuCNPQMEqaF2+91Nw3HK
         C9qVjUorvd8JTc45kXDQKfsZlPq8vmMNbLKtTPRJ2rnHhP8abDPeHBpDdofBiEJuZGpK
         jqvg==
X-Gm-Message-State: AJIora/9bfxB5qetXSaetDIeRfxfq1NCWqDq7DRUKLqW+nY1KgkaSpXB
        GUa2Wpj+64+6lMyvmivSDlge9g==
X-Google-Smtp-Source: AGRyM1tnCRlObEKTZrZ5Go+Vs6PTOOMFCWM2W7rY/m+h//3o7OsQoSpWp7DER4ShmmyVacPdE306Kw==
X-Received: by 2002:a05:6830:1009:b0:616:cd1d:379e with SMTP id a9-20020a056830100900b00616cd1d379emr3469206otp.4.1656360223157;
        Mon, 27 Jun 2022 13:03:43 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m16-20020a4a9510000000b0041bdf977c6dsm6428729ooi.31.2022.06.27.13.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:03:42 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     "Joseph S . Barrera III" <joebar@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: (subset) [PATCH] arm64: dts: qcom: sc7280: Set modem FW path for Chrome OS boards
Date:   Mon, 27 Jun 2022 15:02:59 -0500
Message-Id: <165636016348.3080661.1609858570023001490.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220510104656.1.Id98b473e08c950f9a461826dde187ef7705a928c@changeid>
References: <20220510104656.1.Id98b473e08c950f9a461826dde187ef7705a928c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 10:47:08 -0700, Matthias Kaehlcke wrote:
> Specify the path of the modem FW for SC7280 Chrome OS boards in
> the 'remoteproc_mpss' node.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Set modem FW path for Chrome OS boards
      commit: 1c20d3dbaa673a5d5dc6bcef06df0e0813b95c7d

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
