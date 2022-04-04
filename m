Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCA74F1EDE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380389AbiDDVsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379421AbiDDRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:10:20 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938A940A28
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:08:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ot30so11392428ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r1zkJrNdBsylC60WvH06cd0bPpn4EnJLrdZZGYAa/sc=;
        b=E9Vlp22XYvkxd7YEPEuFE+wQ25YJpYkx7Qq32CiCiX890h4/54mhUnxPHcBqnV5eP8
         hERzVj/rR3n+8bWRN5xw42YfmBMvhDD+N/so6NnEBy9oYvtDP/awq9JZbEnzCYNsGuRm
         UN2i44rwyAOzgug+pWESqUxxr0wBtRo7PxBSpOcSRfNKm3mr7HgD/J4/hO904T8VpgxC
         A8PmM3rQvTLJLS3S6vCwp8aeWE9wf/F851rMQ1kq+PyUpPTRbDYN0yPXBIZ06WaWEITH
         h4eJrYNHWnpVQ0DNFaK54QRIEAzB+PwAZDnjOdUkDO1U3MVbkpzDv3orgrgD0CuRHyCz
         LrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r1zkJrNdBsylC60WvH06cd0bPpn4EnJLrdZZGYAa/sc=;
        b=04x06KGz83Noi+JDLmS+HjZoFBVT+3JyPmfaQ6P7lrGgFrmwu8ElYQhpxA43SG6opv
         Ls90TQAj/bfzGACOmVH+99GaOvEqWLTuDiz+WDx3rwaj5EG1muh9YNfjdWIzZaQmfGEa
         YxA3tGf/1n/O880hmj1kN51NJ9mIoObDUZWJiwHCNseFKQ+yo7cA2QmISoNvgEDeLcL4
         cJ/XrJXl9u2iCFDHjJcXcfvL5bh81PxOLReID12oiSkrMNUCSG+tD/mL7CDBH+GScPR5
         jBdtHMWGNqzb86jyq1RfZvqVa1kPM+w4xAfcdu0Fn9SnSVN2Tsa0/H2vDCPKlCVswonO
         gPjA==
X-Gm-Message-State: AOAM531vOxgm7elBhVtVZuUZT4EN8pjzonRAcLZ6FQ/jCYKfC032N4Zi
        6nQd/87+vcQDASKYjCAKTGBODA==
X-Google-Smtp-Source: ABdhPJzMF6ihdQPNitGJDwCXZWdZhtRQGR16dy/3fZHEG6Wk7BbKyFBBz6Ea6jpPeG6R+sSeiCvOCA==
X-Received: by 2002:a17:907:7242:b0:6da:b561:d523 with SMTP id ds2-20020a170907724200b006dab561d523mr1083208ejc.118.1649092102075;
        Mon, 04 Apr 2022 10:08:22 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id u25-20020a170906b11900b006e08588afedsm4565827ejy.132.2022.04.04.10.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:08:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Johan Hovold <johan@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: renesas-rpc-if: fix platform-device leak in error path
Date:   Mon,  4 Apr 2022 19:08:15 +0200
Message-Id: <164909209237.1690243.4007351899063550816.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220303180632.3194-1-johan@kernel.org>
References: <20220303180632.3194-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022 19:06:32 +0100, Johan Hovold wrote:
> Make sure to free the flash platform device in the event that
> registration fails during probe.
> 
> 

Applied, thanks!

[1/1] memory: renesas-rpc-if: fix platform-device leak in error path
      commit: b452dbf24d7d9a990d70118462925f6ee287d135

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
