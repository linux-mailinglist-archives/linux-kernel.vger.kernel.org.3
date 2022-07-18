Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A1E578DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbiGRW7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbiGRW7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:59:30 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995142AE15
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:26 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10c0d96953fso27886708fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eAfbIHpTFOAoRjGkD90y7LO/4GgqXtETFx3Gy0RgRVA=;
        b=TaHYYcha7c1jmbc9+2dwQ0HCbWms1XRyIUpNXSDwRY+hLDP0Bhd/Tyo0BNcKvPaa4b
         XsGCFnSlzPhiz8fnku5L61LhLhj8RYzkH0jnOlW3RszoOvn8MOhYOmHpggZjAVOPnxVx
         Dklbw+rD+gVW03hoeT8lSCujbPUbo2yaABE2U/ICOyDCJujh9tBi5K4elCBxYg3Xs+lp
         l2DpmaBhAYle4UlTFImCla9muF4HzT/OwE0fxr6lw3iGIGXjPleGK9EvxkqRtmKYLMAW
         1LMmDyvTP5F8ZsxJU8Z1JYLhnnbRJ1FJOYwfcH50ZPHBiYg2nJK6aJ3MxfAoxnCxvpTc
         PA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eAfbIHpTFOAoRjGkD90y7LO/4GgqXtETFx3Gy0RgRVA=;
        b=MJVFFz2tG0FkIn2TRWJ40CpptLiXUuOPQhIHtpgNxtpVUP0QDgfQ6scTfw66Dmid8S
         oU7sEVIm3cA2ScfQYORZteEJRThxA8m0XQxz/mXyXF4zpvnIVZq9wZ51nwU38Mv/c6qk
         aHgONWBiaJ/6co1jZw4oUub8569dXr3rrL2KnfyiaJs3qbXuxci4GXrPNfKIgWWD7XHN
         K61u7b8QeVubmBg7OVQsFj2GcFALoX+rifv91vAg6KyrgSO002U8KcDHx64jN6FzV3Ee
         1deS61LpxX53azDrtfk9LV0e2ozI1zkSika/5kFmqeqwJNXSPTSKoP2avvYv5dYcR1Tk
         8apw==
X-Gm-Message-State: AJIora8Dw1ItiMMECh+UBqjWPwD2QRorcbcgXGgrDMUzQzugG6fyY+Mq
        eHFCKi0OunlHmJR9EYMyrPEhTNWsFM+p8A==
X-Google-Smtp-Source: AGRyM1v62qUIegP2TKUu29j7B01aXZQ9P5qTkYtcyO/nWOruXXEqGU0+Shj61aOOuVm+pox2/ebbmw==
X-Received: by 2002:a05:6808:1916:b0:335:5b1e:2594 with SMTP id bf22-20020a056808191600b003355b1e2594mr14190421oib.129.1658185166349;
        Mon, 18 Jul 2022 15:59:26 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j10-20020a4a908a000000b0041ba304546csm5330931oog.1.2022.07.18.15.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 15:59:25 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mojha@quicinc.com
Cc:     mathieu.poirier@linaro.org
Subject: Re: (subset) [PATCH v4 ] remoteproc: Use unbounded workqueue for recovery work
Date:   Mon, 18 Jul 2022 17:59:11 -0500
Message-Id: <165817634388.1905814.2453101244848449544.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1650367554-15510-1-git-send-email-quic_mojha@quicinc.com>
References: <1650367554-15510-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 16:55:54 +0530, Mukesh Ojha wrote:
> There could be a scenario when there is too much load on a core
> (n number of tasks which is affined) or in a case when multiple
> rproc subsystem is going for recovery, they queue their recovery
> work to one core so even though subsystem are independent their
> recovery will be delayed if one of the subsystem recovery work
> is taking more time in completing.
> 
> [...]

Applied, thanks!

[1/1] remoteproc: Use unbounded workqueue for recovery work
      commit: 0a7f201e4284b43a60ee286c0921002c7e42413d

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
