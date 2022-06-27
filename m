Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5E255C2B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbiF0UEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240935AbiF0UDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:03:43 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979081C92B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:42 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id r8-20020a4abf08000000b00425b1256454so179883oop.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IqQ60DVkYXHzaSF2fU/ZpR6bciE+8kvqX7brRDnIpRc=;
        b=LJ9ap9eiaUu8v0xxpI8xSG1noHQaHaFUxc+NxG3SioYRjtvbp1A1CMswmhYrNa5tN2
         ToDx2KtrwLAjjH2BQtUF5FkyujBqtHCZg2upJuJTivfMKDhgIDnzdqrO3faA72Tbgqgy
         MQFet7fhe7mtkMEF9XC5IN/3aak3U8z8RhxIFvFEBS9HtwgHegWiZd4VERyFhAcCxBJB
         EJtrB/yGAwoAHL/DMoKwlBz3A05VbJQrv7ivvtgnxAXubAQP+c/O4gxtd2EPSeKE4phK
         FyqvEN3zWJzqYyu4oG+oEMp2G3oGRCueAK41/RGTFk6mSxam4l7hYS5DNSa3iE0G7fZ5
         5LQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IqQ60DVkYXHzaSF2fU/ZpR6bciE+8kvqX7brRDnIpRc=;
        b=P79gZTPPPTBu0FcItS+Y8vGjWsRiohiQHxrz6Bs0XoKDHNXrVrmaCkGYW1cyzuUBj4
         y7bCfNlcLttYomj/4M6Y1i114ItnyVcVTTSJRXMrtyymodJNkenz9gTvLo14c5KuTlkV
         cEsOjTnBxPfWbKnsEp48hmMAzmH1ccRnfXrtwV1zn1GeeLOauCwwmQsdnK98vhxCVIlL
         xyRDy0ZzVtgW6PEuwin4T7yQH0Bhq8F1s8Xg7B5mSjiaEjvlpeS56JZg8Y39k36pcQ6g
         Z1gh8eML9zNZB1JZfeaZ5UaYX5R5ANRNzK/Vv1HAdBiRExmQkgSvrEyy2vWSh6UB9y2n
         u+rg==
X-Gm-Message-State: AJIora83hFEHy8ik5sefXoxVVaN3PoZ2cbu5ovDys3iIURXzhiz+VYgc
        luo28WbjJwO0/6k5YtRE6yne8w==
X-Google-Smtp-Source: AGRyM1t6R87DEHumvZmpDHkCpKxjPQWb4Ulgmu4EX6bHpT7pZcDUadbMMSl1MHG7XW5dT4MXJQoTiQ==
X-Received: by 2002:a4a:d418:0:b0:425:753e:4d79 with SMTP id n24-20020a4ad418000000b00425753e4d79mr6511324oos.64.1656360221604;
        Mon, 27 Jun 2022 13:03:41 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m16-20020a4a9510000000b0041bdf977c6dsm6428729ooi.31.2022.06.27.13.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:03:40 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kevin Lund <kglund@google.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: (subset) [PATCH] arm64: dts: qcom: sc7280: Enable wifi for Chrome OS boards
Date:   Mon, 27 Jun 2022 15:02:58 -0500
Message-Id: <165636016348.3080661.13734395442073652475.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220518155252.1.I176d4254c79cfaafa38cbe36f066f02f819df9b6@changeid>
References: <20220518155252.1.I176d4254c79cfaafa38cbe36f066f02f819df9b6@changeid>
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

On Wed, 18 May 2022 15:52:55 -0700, Matthias Kaehlcke wrote:
> Enable the 'wifi' and 'remoteproc_wpss' nodes for all sc7280
> based Chrome OS boards. Delete the corresponding entries from
> sc7280-idp.dtsi since this file includes sc7280-chrome-common.dtsi.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Enable wifi for Chrome OS boards
      commit: 2a77ada5168af6c4ab8df1ea13655245f149b3fe

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
