Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5779855CEC7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbiF0UDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240819AbiF0UDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:03:21 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A581A056
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:20 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w193so14332572oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZ8+R3M0S1nQaMEUYxJlIWhu0Gas0lB13VSI9mi3gCo=;
        b=jE9NBHIDH149VkRLhIk0yOTrQtpNiFaKNTUGDK89EhVFqEKC4abCikb/nksZMiAEsT
         PDSAwpHsp5Yek0S95rRDahLASN3U+sDCAz6qZlTsANiRMVrBrcXqals463swf2TiOKr1
         5AZCZe8m3u+jGC/GNgVhHgbvChx5BbL18SFS2+7KCiO3NljI3o6g+/bOe87gggHJnCu/
         LG1Cn6RSFhOTyv/ycAqKp/ayCeCgMgILVHRHqVbGRezAdJ59yC93ziKTJzR6Xz8x/0uM
         7GH4mlpCHuFO9QN1fyfSt1ylMQXp1PwT5WHYHlnKDCp1grBgD2cvqDrFjwZscvqrBOnP
         1ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZ8+R3M0S1nQaMEUYxJlIWhu0Gas0lB13VSI9mi3gCo=;
        b=3aKbNL5zR5vm4O/+csAgPyd4fIhsADbi0afNy8MlAbOVIUQN5p3loEB1PnEjni7lEW
         PA/Q0dy4Q9SVtZ2buyYqVB38JpQcKxI6ZS4cgV88paOzyjCr/5lExn2sUD/stygtQ43u
         0FMTcBFI27Q4z/W+u0t/gL02sSsgYiZvandKAahZpgwfegp8ctv14LlxrUrVl0oWLxiB
         88kpHo3k7lca4ReqbALDCLuXtFKhc16WwXjiMUUofRjD6JWS4m+A2WR0GpC/tWbFNPmi
         xmGh3Cny7bl3zlXpOv8StD2G3xdFXuWo3yZx3d5pXpayImSVKFXAGb19fwuhBjXwRCLo
         YlIA==
X-Gm-Message-State: AJIora8BfMcgVeD4+aSe3mOqVLNo+xEm1OwIbIxt+GaOP57jmRwkEOpp
        6au+Vw7yYcu4A2jv5a9mATD5UA==
X-Google-Smtp-Source: AGRyM1sirrNSgfMuD2r1cwuzZWm2Oqngu9wBvfSeMbPZ5IiVWM+Vhp6aZ5l2qx23ivcg184/EjcZ8A==
X-Received: by 2002:a05:6808:1648:b0:333:45ae:3777 with SMTP id az8-20020a056808164800b0033345ae3777mr12078448oib.4.1656360199747;
        Mon, 27 Jun 2022 13:03:19 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m16-20020a4a9510000000b0041bdf977c6dsm6428729ooi.31.2022.06.27.13.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:03:19 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Alexandru M Stan <amstan@chromium.org>,
        devicetree@vger.kernel.org, Julius Werner <jwerner@chromium.org>,
        linux-doc@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        patches@lists.linux.dev, Matthias Kaehlcke <mka@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: Document how Chromebooks with depthcharge boot
Date:   Mon, 27 Jun 2022 15:02:40 -0500
Message-Id: <165636016348.3080661.58233739131121561.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220520143502.v4.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
References: <20220520143502.v4.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
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

On Fri, 20 May 2022 14:38:41 -0700, Douglas Anderson wrote:
> This documents how many Chromebooks pick the device tree that will be
> passed to the OS and can help understand the revisions / SKUs listed
> as the top-level "compatible" in many Chromebooks.
> 
> 

Applied, thanks!

[1/5] dt-bindings: Document how Chromebooks with depthcharge boot
      commit: 59228d3b9060b0e5e6b37ceca078fd81a165cfc9
[2/5] dt-bindings: arm: qcom: Mention that Chromebooks use a different scheme
      commit: dbbccb3db122558b35ecb4c87a86bbad37c80862
[3/5] dt-bindings: arm: qcom: Add sc7180 Chromebook board bindings
      commit: 3b8bfe002c4ba633b48cc497238a69eb88346a60
[4/5] dt-bindings: arm: qcom: Add / fix sc7280 board bindings
      commit: 707b9b08789bf3312c9cf23c621ad942de9aa48c
[5/5] dt-bindings: arm: qcom: Add more sc7180 Chromebook board bindings
      commit: 5069fe941f76c9f37abc98636a7db33a5ac72840

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
