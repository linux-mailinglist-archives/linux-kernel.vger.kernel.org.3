Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7246C51AC33
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353858AbiEDSGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359674AbiEDSGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:06:11 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DF46D3B3
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:21:31 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-d39f741ba0so1827959fac.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 10:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9uwOGnLYMEJR/9HVxcO1OnuSImbrqYL22DFR4CN456k=;
        b=kh2l6tCUfmXum7Viz5IbpjauRsyWy+uzfTkiP9KgnsQUkleUr4A6KD0Fe7X4vR5x1q
         KWopCu6yA3HGBZ1PE+2F4ru5MRJ1n6Ok3T2dOwRAUhCAuTsUWJkXK5BaNTl3Tq65rE0l
         VYU/2pnMkejXlkY+VqA38ZOHgEFHNUZE3RmHfqHZrK3NsxP0UjoyatuSS8su+i7JpWzk
         igX6QrQfKxO6QOGU+j+f0JexMpSIDTjTDtKQoN2mmQ1iTM763De2ptE4Xl2Du1h9/d2b
         YkF7ck96I8jcVIYoiESssMp9/8J7WRJljX/RhdiLkF3U3LkZWufAE1Dquc2yF+iC2J8F
         Ocrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9uwOGnLYMEJR/9HVxcO1OnuSImbrqYL22DFR4CN456k=;
        b=lq422/uFBwgFeBrvpf+7SxE7XQQG06goqb6LTekWD6gE/mXjFPA3DlNkD95t+QzSw3
         /kcMT6i8Q1R5RxT2O2sWDwvzRLnlA+NKpFfNhZsSG12cbaqBEiakaINaEkWZdbBfg60u
         RGwQWfV7oeq+UAlk7KRe0GGCs7weHHOvRj2Qm09/sNxkEs7brhwtckjKr6UohcqVeAhL
         wWQGNcGKN3V64wZeEKtoPd/aTjEGZEYwsZrlKHqEuloYD2C2sFii/MuUYe4Nx9PE/hcR
         sHRao431kEMWY/GpXjGoaermwwiF7/lLQwDNot0RBnTg4kV5KGKqSSqPBfbd/TxJrsmu
         BNmA==
X-Gm-Message-State: AOAM533usX3q8rzYA4FAz2jhALieMkWpHQx8yUwPS0wKUnjx0QMe56tf
        H3jwWzIYgzEpck6btT/QSjrjCASRjjtwzw0u
X-Google-Smtp-Source: ABdhPJw0NytvaSnOYdTa7GUSqGzJJxnqCVMGNXFaU+Bu60k1BERVeupvou3p01pEwFJ+Dhp7gFPtHw==
X-Received: by 2002:a05:6870:a910:b0:e6:dca:5fd3 with SMTP id eq16-20020a056870a91000b000e60dca5fd3mr264373oab.202.1651684891384;
        Wed, 04 May 2022 10:21:31 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a7-20020a056870b14700b000ead8b89484sm5785452oal.5.2022.05.04.10.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 10:21:30 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Alex Elder <elder@linaro.org>, Georgi Djakov <djakov@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Taniya Das <quic_tdas@quicinc.com>, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: Re: (subset) [PATCH 4/2] ARM: dts: qcom: sdx55: Remove ipa interconnect node
Date:   Wed,  4 May 2022 12:21:15 -0500
Message-Id: <165168485227.3730817.7400663039437041029.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220415005828.1980055-2-swboyd@chromium.org>
References: <20220412220033.1273607-1-swboyd@chromium.org> <20220415005828.1980055-1-swboyd@chromium.org> <20220415005828.1980055-2-swboyd@chromium.org>
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

On Thu, 14 Apr 2022 17:58:27 -0700, Stephen Boyd wrote:
> This device node is unused now that we've removed the driver that
> consumed it in the kernel. Drop the unused node to save some space.
> 
> 

Applied, thanks!

[4/4] ARM: dts: qcom: sdx55: Remove ipa interconnect node
      commit: 02fbeb1649534d564b100a994b05d4eaa167ea19

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
