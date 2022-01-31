Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270874A4E21
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355806AbiAaSYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350576AbiAaSYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:24:39 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9BAC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:24:39 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id m10so3311355oie.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DMU9AZ9IHe9vHLy7t44zKNg+xudXJC08v+EXB0Qau88=;
        b=eE3owyETd86rhiBoFQjfQCbd3zoTyOn7J7I7j1tKYVNaybZKuI+UYZX5/rrH5IkNbn
         qPD2IHMEzaWJYo1c021WfPL23XeASt8IK96uh5ZmHK5/Vj/pqZKu6Df6IkRYF5upCWlg
         ZkzT8Qgs9dv7S6deVCH5YPSH1yIxG1/OUYu1bY1DTiHcS12IiWKHLkIDFU66V2pPO7N4
         tGBFXcUF8mxqa4xiIePkiADB8nkstet9ECvfZxsnGMfkU+Bci+rkMNbP6vLUUDIguoNX
         DSeJ6hXDm9kPwj3lyJEAoJNxhIjcdjWR1rCQK2YkH122o3j3uSZMr6gIbjCQOhIW9GM+
         hVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DMU9AZ9IHe9vHLy7t44zKNg+xudXJC08v+EXB0Qau88=;
        b=Fnx+ssbNWAvaz0pfjHOuxK2xOVLld4Fu8g065zDU6TLMx4jrjAChWKJrP39AYkKQGP
         lKYOQqkUoCdX5ASw8HlTtCaxYfa2FB5YE+WuYc7wk8Qo1s7vg5AHB4RVRPpdye4VFH4z
         rlANoOMwKbv/kRQYMmh9CMjOGMX3ixlpGWVMXFFbpvFPCZWFmAB8HvoKXFsVCoaC8sZy
         9RXAZRbe2/IhZjEEdVScdSHEwrpw3p9LRzrrVFEY7wjoQVR3XBIbo7AtDCetmqfmLj6J
         7HFVQmrIPqs28EAoy6VD6zUQKwKssDpQUHk7oQeT9abLchATND95LJNHVat6+zjk02sv
         8XPQ==
X-Gm-Message-State: AOAM531CyavJ8SL32Dh0d9maON5a7/aO4fFIELMu4A75ZGxjoO2avUBD
        PHEKbjgXWvC8l6EGpPf6CxwE6Q==
X-Google-Smtp-Source: ABdhPJxt0KJaiklBho/V1Ui+XsEAZA5Z3/ybA635AsaKfaB6rAOtODj3zteALDtbdIVqTZwrEtYSGA==
X-Received: by 2002:a05:6808:1247:: with SMTP id o7mr17349933oiv.75.1643653478569;
        Mon, 31 Jan 2022 10:24:38 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id y19sm3273722oti.49.2022.01.31.10.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:24:37 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_khsieh@quicinc.com, quic_kalyant@quicinc.com,
        quic_abhinavk@quicinc.com, Kuogee Hsieh <khsieh@codeaurora.org>,
        quic_mkrishn@quicinc.com, swboyd@chromium.org, robdclark@gmail.com,
        seanpaul@chromium.org, dianders@chromium.org
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: sc7280: Add Display Port node
Date:   Mon, 31 Jan 2022 12:24:26 -0600
Message-Id: <164365345128.3009281.16859131025980734527.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1637580555-1079-1-git-send-email-quic_sbillaka@quicinc.com>
References: <1637580555-1079-1-git-send-email-quic_sbillaka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 16:59:15 +0530, Sankeerth Billakanti wrote:
> From: Kuogee Hsieh <khsieh@codeaurora.org>
> 
> 

Applied, thanks!

[4/4] arm64: dts: qcom: sc7280: Add Display Port node
      commit: fc6b1225d20de0298a7b0e52eb3843d71e1992e8

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
