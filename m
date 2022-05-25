Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2388A53373C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 09:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243957AbiEYHQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 03:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244266AbiEYHQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 03:16:35 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9066BD5B
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 00:16:33 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id fw21-20020a17090b129500b001df9f62edd6so3517947pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 00:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IHGVHIb5ANXtn4ibS4SthwwVSV0T3tFl9yqFg+S5efQ=;
        b=F7XE3r+vWerFvL4IXruqMH7czf8srjKfekGeCkpCgYTKzlooHsqHwKG6eAQeSpbsTK
         Uf4K2N3hxe7+X6UV9YGrWqY/EPVQam/GtrkmUTMCAfFQ4A4As7MZR7YjqKhfNnoje0Xk
         r/F7NXGY1a3ldVn64RMKLKyjeIWlAlhJPFdyWNVWgtcN3df+zMeZtgIdr3PsUL4dnr/M
         B7Q8i/PmDfv2ZC6myDdKv4BYbYWUEb4gQguW1APqZGGk/g7WKeVJwsa1dcTc3JmfTU+E
         C22uFvNIgbbAOZVW34zTQerXzsyz0MrYdaxvC0wKHw40nkEawGuFDjK2DFeD94FuEGSk
         a1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IHGVHIb5ANXtn4ibS4SthwwVSV0T3tFl9yqFg+S5efQ=;
        b=aLKdYqwTqrf7oFnEjMeA69BxqFG8eqQ9XWkmFX6htoRshuYDB7PYHvvF2B4XlLFjBH
         6h2tZYu2OJQpwPyaYGg0vEomcbc7mHT+bUFnJg+FhNVAX/DEngzQZ+jABB66/GKbA7wu
         TRE7sM0sTOlh19ddFLLwjvNZqllIt0nD2Kb2Wd56txse+m50z2rzxZ4OAhiwAXcXVvos
         oKpAIGjmGzTcL4o4/Ekzf78Q/yZgvwvlxgiCQva7tDAwV/ATxTw839UadDi+RxOh7lju
         lRUsks4ytR5U0+FLjAxzdH1zsztFiyU84Y2AP64b1928Ws7wBPqJgd3TKl8nGeJxTyjX
         +BMg==
X-Gm-Message-State: AOAM532PBl+IRFgqfgS9K7JeY6InZLHE1mEpsmj0fo0RJydkK99z992J
        UxqlozFdyze3hjGdUJsHfm1oeA==
X-Google-Smtp-Source: ABdhPJwOAlJnUaVM2rZHBFQG+/801GI+S/nUYZG7yHAVTLpi/shQAbFkHxuT+ks8sbo1NIkSrnuLzg==
X-Received: by 2002:a17:902:aa87:b0:162:39b5:3ba3 with SMTP id d7-20020a170902aa8700b0016239b53ba3mr8801134plr.158.1653462993113;
        Wed, 25 May 2022 00:16:33 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id r9-20020a170903020900b0015e8d4eb276sm8454954plh.192.2022.05.25.00.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 00:16:32 -0700 (PDT)
Date:   Wed, 25 May 2022 12:46:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 4/7] arm64: dts: qcom: sdm845: control RPMHPD
 performance states with UFS
Message-ID: <20220525071630.irrz24rs73l3ke4o@vireshk-i7>
References: <20220513061347.46480-1-krzysztof.kozlowski@linaro.org>
 <20220513061347.46480-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513061347.46480-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-05-22, 08:13, Krzysztof Kozlowski wrote:
> +			ufs_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-50000000 {
> +					opp-hz = /bits/ 64 <50000000
> +						 0
> +						 0
> +						 37500000
> +						 0
> +						 0
> +						 0
> +						 0
> +						 // FIXME: value 0 copied from freq-table-hz
> +						 0>;

One general comment, I think this should follow how we specify
multiple voltages or other fields and so each frequency should be part
of a different < > braces. Like: opp-hz = /bits/ 64 <5000000>, <0>, ....

Whatever is there between < > seems to be connected, like
min/max/target for voltage.

The code will process both in a similar way though eventually.

-- 
viresh
