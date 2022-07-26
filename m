Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC9858150E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbiGZOXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiGZOXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:23:48 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F320425C6D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:23:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bn9so9507923wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+PzyWMPTLvynanWzQTq1j5aVlFoOcJhkH6UNz+5was=;
        b=sAUEvL4ZqSBjOOG3xhBYBiol0Z5DVO4bVp8amgsGz8AFj5OLXQDV7FfRJ3XRNJbe8E
         YyBcAbKRCpBfq762XkE2vnRKvYJ5jMLLuS90JFlhiNlp7/fPPzC8DkCixlAhOxAbe6Rd
         j24QTk0izVw/TJoW3g/34rDQ3Rm1SPfSmsNunDrZVaCrJ+oTOsWpMklWYN0tnvtzAwOh
         fSKne/Y4xMNerND8pmrwUTO9hfUVdzsYAYfCtRi2qaklTOo6cUHw3bJ6m8VdKWvK3k/W
         I8X0VNA+UGi9zty2aocrgY/mt+v68xFbOPEYkrX6acuB6vqmp4lk64HmQl3N2893LAR7
         B3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+PzyWMPTLvynanWzQTq1j5aVlFoOcJhkH6UNz+5was=;
        b=Sd6qAJ3koZLWheAVdpnV1qTqVwp9v6ALZHMb3qwfHJ7KW5fT7j7Oao36jI7ulEc4OM
         EdpaT8yXREfbJVVYn/RmjkEjCQ/pOMMWAgM6P/6RJuk4A+GCJjUOVEZGITEmhyKHAAHF
         OjQ4WMM4areeWMnkbaTEPQGFw0M/ChcgLw4+f6rnuExAkzP0OyKwOdwhRLCGouu/KaIS
         eOj8bT6L29FCMnF+VTLLU2YCMHpZ7G5p7t3TyyplTWEervmcvx5faetU6OUxq8KXZw6B
         mZWXkT84F7RUUVV2oFjXizLcFn33AjC9sfswxnirjccslWSeJOOaL9SJxy44I06q7wuk
         s3fw==
X-Gm-Message-State: AJIora/FOSnjwGy84MZuogrqboM+kYpEaGtkbhewwQQovMKdo9qjX1IQ
        AJ7RLtTLFjivxkSCdLKFSmiI6w==
X-Google-Smtp-Source: AGRyM1u7Dlvfu2onZmEN77PJZSPL+WwsrvGUqfsXOz1+2Aqs7GpaqP5AS4una0qyV3CVLKyu5LmRGQ==
X-Received: by 2002:a5d:64c7:0:b0:21d:a743:394 with SMTP id f7-20020a5d64c7000000b0021da7430394mr10721238wri.628.1658845422392;
        Tue, 26 Jul 2022 07:23:42 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id t21-20020a1c7715000000b003a331c6bffdsm17017119wmi.47.2022.07.26.07.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:23:41 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [RFC 0/9] clk: qcom: gcc-sdm845: Swicth from expanded definitions to compact macros
Date:   Tue, 26 Jul 2022 17:22:54 +0300
Message-Id: <20220726142303.4126434-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lets see where this goes.

This RFC is basically a proof-of-concept of how we could use more
compact macros rather than expanded definitions for clocks on QCOM
platforms. As the subject says, this is only for SDM845 GCC, for now.

Also, there are a couple of hacky solutions here that need to be
reworked before it could be merged (if ever). One that comes to mind is
the way the branch clock macros differentiate between having no parent,
a parent name, or a parent HW. I'm still looking into that, so ...

I tried to make them as compact and readable from the user's POV, but
there is some complexity needed in order to allow passing different
types (or number) of parents. Maybe that complexity is too crazy and
doesn't bring that much benefit.

I managed to put together some semi-automated way to do this for every
CC, on every platform, if it's decided so. The only testing I managed to
do so far was comparing the preprocessed output before and after. Oh,
and the MTP does boot. I still need time to make sure that nothing gets
broken.

Also, this series is still WIP, so everything can be reworked fast, if
needed.

Abel Vesa (9):
  clk: qcom: qcc-sdm845: Collapse gdsc structs into macros
  clk: qcom: gcc-sdm845: Switch from parent_hws to parent_data
  clk: qcom: rcg: Add macros to collapse definition
  clk: qcom: alpha-pll: Add macros to collapse definition
  clk: qcom: branch: Add macros to collapse definition
  clk: qcom: common: Add macro wrapper for all clock types
  clk: qcom: gcc-sdm845: Switch to macros to collapse branch clocks
    definitions
  clk: qcom: gcc-sdm845: Switch to macros to collapse rcg2 clocks
    definitions
  clk: qcom: gcc-sdm845: Switch to macros to collapse alpha-pll clocks
    definitions

 drivers/clk/qcom/clk-alpha-pll.h |   61 +
 drivers/clk/qcom/clk-branch.h    |   82 +
 drivers/clk/qcom/clk-rcg.h       |   40 +
 drivers/clk/qcom/common.h        |    3 +
 drivers/clk/qcom/gcc-sdm845.c    | 3222 ++----------------------------
 drivers/clk/qcom/gdsc.h          |   10 +
 6 files changed, 406 insertions(+), 3012 deletions(-)

--
2.34.3

