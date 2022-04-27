Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBD8510F77
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 05:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357411AbiD0DYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355919AbiD0DYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:24:52 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825D7205D8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:21:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d15so483251plh.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GM2I1rKciZlMERQtkMZfhLt0vQhC1yhQUebWl8r/Ftc=;
        b=PAuYwkzn39WhGOmLN+8zMzQ1WBdfutgxwU5iZkZRy+TD2HWYFFW2FaCkD2lZqAkVht
         B+ykPt4C5gWCFpugnodO1SzYCSLgXM4elWCWzzW6vgtUOHyiszmBjZLqQEvRDEzpgcL0
         sUXTSQGaPa7wj2/GKBnLpVvCasFT4ZkBX+XsIScf8XgQWmCAEfITPYTHqEUdA1QUeiXT
         pA8mwPT40ayBdOPzct6AWk1j/6crg5ZPCYiy+H2mWOnt/s3jq4+PSPFUclP2C+A06UxL
         rI+cp0JuHUCffZupUtv0BJml2NFzUM7GRx2q4wQw5flOg225seTMPo0Sm5KMTFjC5Vn5
         spSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GM2I1rKciZlMERQtkMZfhLt0vQhC1yhQUebWl8r/Ftc=;
        b=x+0w+9T8s5Je0yjw9e73aZDM1KqL5OtpU/fHK3SLRUwGJh9T5xqy6aivX/J+zEgvq9
         BMRC79QEvGSItReBmmwKR8cGga3/uMNx9XTgkEj/HZ/bROvO6UnpL/hBG2WtJttctFx4
         7FUS3zeS/DdLYWRPJNZBPe6Qqbvg2XvXHfG5763yfY7K3yaf4ofB8OgG0c6XYhCmdG1F
         5j/oenbi7fKOFipfPFBfQE7U3S5Llz1xupr5ZIUQUcWaPCRIDB+BBINtaVFGD3hIQXxT
         AXX8p/smOz2LuFDVy60Jvn9cjMEtbB2fUGBTEdFkyzxl23CT5gNy+nMOL2OgNiYzIlJL
         kPew==
X-Gm-Message-State: AOAM532OF35VaMPxEF+efEN3C9L0FKpnlwasQbxWTGh1KNqy3NdoDJkf
        7WT85aNUGR8tkxdfE5YE05w22Q==
X-Google-Smtp-Source: ABdhPJzV2vdzAtHjQnsvfI1pw6Xr1L3VKxj4VdlGJPjfxSLca5WKu8NmWu/04ISxvSPeYZ0MTJbAQg==
X-Received: by 2002:a17:902:6bc4:b0:154:6b3d:a720 with SMTP id m4-20020a1709026bc400b001546b3da720mr26395959plt.104.1651029701054;
        Tue, 26 Apr 2022 20:21:41 -0700 (PDT)
Received: from localhost ([122.177.141.190])
        by smtp.gmail.com with ESMTPSA id y4-20020a056a00190400b004fac0896e35sm17135411pfi.42.2022.04.26.20.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 20:21:40 -0700 (PDT)
Date:   Wed, 27 Apr 2022 08:51:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 5/9] dt-bindings: opp: opp-v2-kryo-cpu: Remove SMEM
Message-ID: <20220427032138.smvcg2nxekz6go7m@vireshk-i7>
References: <T-ZqipM8xIaRroty0k9MEPCfD31BvtDXY6IaSm8uCD_ffIgJKYAcY-EZ49w0S-uX0w9sn1mUfBALTv0SqOb7OM1Uh6pskewGKxkOFYRJwfM=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <T-ZqipM8xIaRroty0k9MEPCfD31BvtDXY6IaSm8uCD_ffIgJKYAcY-EZ49w0S-uX0w9sn1mUfBALTv0SqOb7OM1Uh6pskewGKxkOFYRJwfM=@protonmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-04-22, 04:17, Yassine Oudjana wrote:
> qcom-cpufreq-nvmem no longer uses SMEM. Remove all references
> to SMEM and change the description and maximum value of
> opp-supported-hw to reflect the new set of possible values.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../bindings/opp/opp-v2-kryo-cpu.yaml         | 56 +++++++++----------
>  1 file changed, 26 insertions(+), 30 deletions(-)

Applied. Thanks.

-- 
viresh
