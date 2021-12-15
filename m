Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8714765C9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhLOW20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhLOW2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:28:02 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DBDC061761
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:28:01 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id bf8so33743530oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tO9OvjlWQgMnpqUAi1fL5yqqo8vFsalTCr+DeKw7iAs=;
        b=d8ErCmKms+o1/Zn/sq+RLlNUOstpU2sU17TVwPIGK6cIX6amme+Thn2xHVY+4f9m49
         ZrAUcs6xvNClcjNmPZTTkfZ+tnRnGTDqlSxSRprIb4smCjOiDBOPQhHjOQ7oUwXVdqCG
         nAxJtrQ4SXEnf0LA8KEZYj5IZ76t1E5WQeDEmdxQ54vlF5Cm5CfZ+IIvn+HsBmUcgnOa
         FDQGvzzZq4NKXhpGbZDeiuMvkw1Db/M/3YvYvTdFW9oaURWAt6o5EvjDYO7Dhi5OqctQ
         Crcg1WmgvrQpoGuHawDC2//6PUqLjabnWz8423/mxGi9IvDzCtFokcorJUR/MLekKfoB
         v1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tO9OvjlWQgMnpqUAi1fL5yqqo8vFsalTCr+DeKw7iAs=;
        b=p12nTc00LIDiaVjNzQkXwqU/gPBWjQEVV0Rnp8aHVkPV3pLtRropCnhVA9ywZqnhRH
         AI3hK3H6VeSpLmC9ilid4qBhRJoSTdg7ZlLt/DgwDfgpmsCTU/A75sHC8V4reJbV4Hiv
         Kr2YTxXZ4ELc2Sn+E96CgkjfvfYIqbd+Ilz+ggaRknY63HGtuDgtBSjPPqVfjVEl7JcF
         ugDmJ75rfVB3nsS18xNJmV0lgSujBdUhehzjpQKE8KdtZ47bMpHEla+D+sEEtx/awK8t
         VhCTIGurVvagUCG74RxnkcCWZUiPZNWEuxuwQHDttAKeqatsEW2e8M4XxIkAACIIoIrS
         hNpw==
X-Gm-Message-State: AOAM531If571gnf+PlewyJ9J1b2v/mzzszIztXUEFdditrW1xTXpvyQx
        Hd3yc4yUpuE5Nhm7J4oioSYysg==
X-Google-Smtp-Source: ABdhPJwMB/3+smB7srZ+aOYzMN+Td6q3jqaXkb1hgsRtRZ1qSd6p5ggBHSgQPg5xqiZfhtlnMPgJVA==
X-Received: by 2002:aca:c650:: with SMTP id w77mr1910129oif.8.1639607281131;
        Wed, 15 Dec 2021 14:28:01 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t14sm700500oth.81.2021.12.15.14.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:28:00 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     agross@kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, quic_vamslank@quicinc.com
Cc:     manivannan.sadhasivam@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v7 0/3] Add PLL and GCC clock support for SDX65
Date:   Wed, 15 Dec 2021 16:27:33 -0600
Message-Id: <163960723735.3062250.6842300885668139659.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1638861860.git.quic_vamslank@quicinc.com>
References: <cover.1638861860.git.quic_vamslank@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 23:32:48 -0800, quic_vamslank@quicinc.com wrote:
> From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
> 
> Hello,
> Changes from v6:
>  - Addressed stephen's comments related to GCC and PLL patches
>  - separated PLL and GCC patches from rpmh patches as suggested by Bjorn
> 
> [...]

Applied, thanks!

[2/3] clk: qcom: Add LUCID_EVO PLL type for SDX65
      commit: 1b967c3f33f2c1e1d3dc1a4c110fd2cbe5fcaf16
[3/3] clk: qcom: Add SDX65 GCC support
      commit: 7a12dba6bf1e278a204b48b510f3670081303165

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
