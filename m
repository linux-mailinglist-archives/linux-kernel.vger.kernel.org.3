Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCC64D9CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349005AbiCOODQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349013AbiCOODD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:03:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD807546BC;
        Tue, 15 Mar 2022 07:01:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id q20so11308801wmq.1;
        Tue, 15 Mar 2022 07:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6v123dHCCsOJtTJvGC+VnaP4Nv3UWBYufrflzDBOQBs=;
        b=lYilOcXdx2VQxAYxa2v/7DNG0Wh4kP2ilXaGAuIrjfEjQNqDr+YImN4ICA8vn65MZO
         2ngwYfP7mRWfrn34VTPPmJ/BAZ1aF+v2pQj/EHgwbWjHTNedGTwhybaKhrpfad5yZVoN
         FUM0HxSKoDeFI6N7ZcRU0Uv258orgWaX60Smsi5Fjw0LgMVNbcFyMYxej5CZbXYkzgnx
         PRTrET13NP6C0/Z9CMnt14csABKzhEwBK+JX31MYU7NOVwqm/17m753CoDpEmolU1g8r
         zFLGejeAnxvc14XhKh38VBAZYknvqv4LJj7+i57+x/x3Vb2tga6aoG1thEWVpwQ7hcvD
         f3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6v123dHCCsOJtTJvGC+VnaP4Nv3UWBYufrflzDBOQBs=;
        b=uikVOuAzpiPDBoFWs+4mZAz5AbRLsLf95xuw99UGik6284O1i4CkkWtAwjMGm6Od4m
         wzPR2Eq/0be/7esTNr9zjOTmfUUP4Hs1VYskDagR6emz0B51FFo3QIhInnyAnfwAHcdg
         RB9KdWxWf3Pr7hz1UALOv0nY6gaPSRXkQlkGKNouMunpCS3ew9S83bYqWhfWR8mJe5kj
         Gx4IsZLM//U9pczIT6+X+0OVfaBBo8cHY4JhZC8Olu1GZAPIQtF/WgcEJQm9nwc6TAuP
         1WS3XPcbfZxoTZhrWxjopfhInGtyfvgnT3GI6OiLMWFzrQ1jCmQe/rDnB6+1p/zJTlg7
         +0Sw==
X-Gm-Message-State: AOAM5337nGBRLkKqQKsr8c2G1X6nW8gO0/dGV086HdHtfMVYrh0NspUs
        xObhLfdXmUPJs2e6Fba8430=
X-Google-Smtp-Source: ABdhPJz/FT85q+INrm11sWSpa461VrEebgeDXHHY2E/V+1vYHeL+7GgLOP/wkEetve8caUeUM8yzvg==
X-Received: by 2002:a05:600c:4f09:b0:389:cf43:eaf8 with SMTP id l9-20020a05600c4f0900b00389cf43eaf8mr3486624wmq.201.1647352903140;
        Tue, 15 Mar 2022 07:01:43 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d6d89000000b00203d62072c4sm1696768wrs.43.2022.03.15.07.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 07:01:42 -0700 (PDT)
Date:   Tue, 15 Mar 2022 15:01:40 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: Convert rda,8810pl-timer to YAML
Message-ID: <20220315140140.GA2558@standask-GA-A55M-S2HP>
References: <20220225173734.GA7573@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225173734.GA7573@standask-GA-A55M-S2HP>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

anything holding this back? It's been sitting on the mailing lists
with 2 R-B's for ~2 weeks.

Thanks,
Stanislav
