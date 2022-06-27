Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B742155DEE8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbiF0UEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240946AbiF0UDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:03:47 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78671CB05
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:46 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id j2-20020a4ab1c2000000b00425813b407bso1946635ooo.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HmW7NHlc2F8dYXX3wKYrd6wCu9K6Bcpsop4DyzRdkHM=;
        b=y/3xEwxBw8ybGgCtx4O5OFcrlVpfbSP9Zc498vJXiryyW0PE9qMreg72ZMKyrZsohI
         cfRa1z7qs26T7x4ZUmpfxa6JSKJ1ynKaV3WJQQE/u59ijdbaKgum3BDNF7NS1GqJn541
         I+HnLRfDQhnouwz40a8mTyUdMQ738zpB2qI8ZeU3TdWQ5z482fNO1JrRlSyl6wZ4r2RG
         iWpsCN349kDrvya1IjsXh9xwhOQ0+M3K+5lgcJWQEOMaeETbJQKkXeEkCJhoLD4vrkzP
         n9pvIRM0wbQlTBcziEuKVktF9HAwQTk9ACkgW/gPDLL0HLcWNwELvyRfGOUdQ9ZPDL+F
         hfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HmW7NHlc2F8dYXX3wKYrd6wCu9K6Bcpsop4DyzRdkHM=;
        b=1rgm1x/MH3r8d2BqKWQMwpKHup7KhsEFsnUatcF0QhGzwOhkwiC8h1CCeKr9g8nerQ
         vGxWKkZ0kX8ZfgY6+nKrrDDR6dX2OS29isfbLkrngBBdIBoNjwQ+ExJpe8C1NzDdq1En
         s6nl4IIchuhMpF1LelXRyJrV2iaMFF5tZZpA16JUC3ParkuqnsrqAQ2Xfb16MwYAfSGd
         Rbh+mxiPxWOG6+qY8CHRaM73bOeejKkWgjNLk3G+ztCNN5f8yw3EQTsHYiL47+W49YFs
         GVebj4r8/+Hm4Q6natgLCZigRhXw036WUgLRWetD3J8fsmp4C2Av+MLs5Zx6urGS0+D+
         47Cg==
X-Gm-Message-State: AJIora+BzibmMCyap44IKEH3zcBQb8F7MswgndSwOCOuJk+5OODLTfxZ
        4tHViFahRstkVHJVeJd4/KTzmw==
X-Google-Smtp-Source: AGRyM1v1LT4W3dC8w/TKrwuSEDNmyV/FvjO4VpiI4Y1XKqqVkN5+VZtz0FFB46abdtCjVbJeKT14/g==
X-Received: by 2002:a4a:81c1:0:b0:425:b01b:f757 with SMTP id s1-20020a4a81c1000000b00425b01bf757mr1022959oog.1.1656360226076;
        Mon, 27 Jun 2022 13:03:46 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m16-20020a4a9510000000b0041bdf977c6dsm6428729ooi.31.2022.06.27.13.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:03:45 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     quic_rohkumar@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org,
        robh+dt@kernel.org, swboyd@chromium.org,
        devicetree@vger.kernel.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        judyhsiao@chromium.org, agross@kernel.org, dianders@chromium.org
Subject: Re: [PATCH v14 0/4] Add lpass pin control support for audio on sc7280 based targets
Date:   Mon, 27 Jun 2022 15:03:01 -0500
Message-Id: <165636016349.3080661.6166496276966890494.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1651763004-32533-1-git-send-email-quic_srivasam@quicinc.com>
References: <1651763004-32533-1-git-send-email-quic_srivasam@quicinc.com>
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

On Thu, 5 May 2022 20:33:20 +0530, Srinivasa Rao Mandadapu wrote:
> This patch set is to add lpass pin control support for Audio over I2S,
> wcd codec and digital mics.
> 
> Changes Since V13:
>     -- Remove redundant properties in lpass lpi pin control nodes.
>     -- Sort lpass lpi pin control nodes.
> Changes Since V12:
>     -- Split common lpass lpi pin control nodes to functionality specific nodes.
>     -- Move common pin control properties to corresponding default nodes.
> Changes Since V11:
>     -- Move CRD specific pinmux nodes to crd specific file.
> Changes Since V10:
>     -- Add lpass lpi pinmux and MI2S pinmux support for rev5+ boards.
>     -- Remove dependency patches link in the cover-letter as it is merged.
> Changes Since V9:
>     -- Remove redundant prefix in node name.
> Changes Since V8:
>     -- Modify label and node names to lpass specific.
>     -- Sort nodes as per node names and kind of nodes like pinctrl and device nodes.
> Changes Since V7:
>     -- Sort mi2s pincontrol nodes as per node name.
>     -- Fix typo errors.
> Changes Since V6:
>     -- Move amp_en node to corresponding consumer patch.
>     -- Update label and node names.
>     -- Remove redundant drive-strengths.
>     -- Remove herobrine crd specific mi2s configuration.
> Changes Since V5:
>     -- Remove redundant function property in amp_en node.
>     -- Move board specific properties of lpass pin control node to board specific file.
>     -- Remove redundant properties in pin control nodes.
>     -- Move wcd938x codec reset and CTIA/OMTP pin control patches to other series.
> Changes Since V4:
>     -- Add primary and secondary I2S pinmux nodes for herobrine specific targets.
> Changes Since V3:
>     -- Add pinctrl nodes for wcd codec reset and CTIA/OMTP headset selection.
> Changes Since V2:
>     -- Move lpass pin control node to main dtsi file.
>     -- Sort nodes alphabetically.
>     -- Remove redundant wcd reset gpio nodes.
>     -- Remove redundant input-enable field in dmic pin control nodes.
>     -- Update amp_en node.
>     -- Fix typo errors.
>     -- Modify node names.
>     -- Create patches on latest kernel.
> Changes Since V1:
>     -- Merge pinmux and pinconf properties in amp_en and wcd pin reset node.
>     -- Split common i2s pin control nodes to functionality specific nodes.
>     -- Move board specific properties to board specific dtsi file.
>     -- Update dmic pin control node name.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: sc7280: Add pinmux for I2S speaker and Headset
      commit: b9e3f65ecf85854c9717467c3cffaca194edd19f
[2/4] arm64: dts: qcom: sc7280: Add secondary MI2S pinmux specifications for CRD 3.0/3.1
      commit: 06c73a39c38b9321e638002450dcb22aa592ae99
[3/4] arm64: dts: qcom: sc7280: add lpass lpi pin controller node
      commit: 32d4541abe0f981cbcc45e142543d5811fd07692
[4/4] arm64: dts: qcom: sc7280-herobrine: Add lpi pinmux properties for CRD 3.0/3.1
      commit: a4c1fc8cff056461b9bd0e07e775f93073b4d527

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
