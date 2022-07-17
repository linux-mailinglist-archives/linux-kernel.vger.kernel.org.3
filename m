Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B944C5773A2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 05:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiGQDIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 23:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiGQDIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 23:08:31 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FD014D01
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:08:29 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10bec750eedso15616403fac.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ynAOO9CZ9StHQlEHTH05LIi5z337DmRK0e6hHcwdInI=;
        b=YaRTBJU4BL94GgMIGKxn11jkhWTQLK/9wZM2dJsDylmVgM+jZvzJUCjKPeTy9cm3kn
         5irg4ankQ8/11NgvN/2wUeKUSSHzceBEC4jma00h7ltdAWt1c2ka5n1FMBLnDnnUDo50
         leM56fbxN+G3fG0QvPYjvr7IfyujpsJrib0y+rXXN17mMxAiReQpMhyXwaq8ktnSffn9
         6D6ixOKjRpQ9HAZd/Xkl6n7sBlvd2ArooGmHRCkdHVc2+QqlnGyBx/ygio2t0hjVcNMh
         w66hJHXBsDa8PlqmhV1FGC00ZLir+e7ykYYOZMqX2GtEOqgETWyUlo6g5DFGby7hYcnt
         4vgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ynAOO9CZ9StHQlEHTH05LIi5z337DmRK0e6hHcwdInI=;
        b=iEtD3zQ2zpqV2i46SHpPGr+tdBI7AmKUSEFrOVHNWEk1ZZZA/3nSCreuLnMxf5jKja
         IiS16EQNUMnSvADO1qTGa09qiUt0QklsxH2QIiW0I+u9/iunOJ4xsP56+y2jNkuEIJU0
         MLOwQXpDVnxXZcZoHYpxcvLEsL8+Pnvpc5QB0A7svCWHpZDOykq/4b/mXtS3HiL8d/Ss
         H5sjV9JPzDro3ZXy5P0RckbHMGhHCAvy8q+HFnhxsCLNLVQlvJjbMMOTQRilHnAPsFJd
         P1bGFK5WIPUitgbApu/PbC2R7q0Dz2yyCZr1J8FM8rUQB87Cqw890ZGvNBcMKNkGMPSF
         S/Kw==
X-Gm-Message-State: AJIora+IV50L5rgeZc+Cbz63+lRR029rsMOG2lJpgQCVaI6de73zwmsQ
        x9cd7D+84EJ/GF/iegz/fpYAgw==
X-Google-Smtp-Source: AGRyM1stdMaxorJhXL9zYA1MOlxPwHPWVni1RHgJSTPWlHXpqxBGN0amEkHy9CnNlgnHm5Di5Fce2Q==
X-Received: by 2002:a05:6870:33a5:b0:f5:febe:1b27 with SMTP id w37-20020a05687033a500b000f5febe1b27mr13657612oae.229.1658027309005;
        Sat, 16 Jul 2022 20:08:29 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z203-20020a4a49d4000000b0043577be222bsm3203928ooa.22.2022.07.16.20.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 20:08:28 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-remoteproc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/3] hwspinlock: qcom: Add support for mmio usage to sfpb-mutex
Date:   Sat, 16 Jul 2022 22:08:19 -0500
Message-Id: <165802729676.1737676.16934005507379997077.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220707102040.1859-1-ansuelsmth@gmail.com>
References: <20220707102040.1859-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2022 12:20:38 +0200, Christian Marangi wrote:
> Allow sfpb-mutex to use mmio in addition to syscon.
> 
> 

Applied, thanks!

[2/3] ARM: dts: qcom: add missing hwlock for ipq8064 dtsi
      commit: fbe4be367b2169602f6a5949a20d2917b25714d4
[3/3] ARM: dts: qcom: add missing smem compatible for ipq8064 dtsi
      commit: 4fefb5434c4b735daf913abaef12431405368031

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
