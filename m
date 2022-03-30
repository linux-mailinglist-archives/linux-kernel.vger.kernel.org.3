Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC2F4EBA6A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243067AbiC3Ft6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243073AbiC3Ftn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:49:43 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC57B25B93E;
        Tue, 29 Mar 2022 22:47:58 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so5154575pjf.1;
        Tue, 29 Mar 2022 22:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O8FHK49oyZWn74FeNySJBSL3ks9J8X4q4Z3RKKMnZzI=;
        b=k13vAHoVoxSxlHzttCL1KuZ9viD6tLQxgxOHhzpsZDcl3vmxrwH0RWUiA3vlgQVDi2
         KqGbP5HIRNO0O9vWOqdWNoaDh9twZc6W+SJWqhesc1sODe4ttxps4SATQjUefTW1e5SP
         Mp2AHpBe/KxyhLQtzfOBR8TdptDsFA1vxjmBpRAdkQVHuVOariNO5kSYaLanYXPUBZvw
         YeCENMQF0NzM7R53uBsisnOnNPDodjFYxPAsBxOLQdm77rTqeAwkZisfxxQbV7Pz65r5
         LBf3T06fuVivYQ8PlTrDUUDjU+N6wTR3Ag+TIxucBWKI+IeVjo45yL9cg517++JT9zt1
         NONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O8FHK49oyZWn74FeNySJBSL3ks9J8X4q4Z3RKKMnZzI=;
        b=bqumpsvUspD6ieYzMKAw/1clyiLCCttzky8JKnWFPrhNPWwz2woF5XCa6xGmXQDR5s
         HcVnB+L1Pb6hqfqze4AZhYBq1YO8UHlvBzH07X3Cu16IAygt6oOyjEHxcxVA8+LFMXxS
         uMZXq1GFYjse4xA/ra3e6I8EL9pt5AlFJw3JocFeh8JP2A+M62kEU+U3vxHccBdyt8tw
         Y3TUmu6F5CO8DY3+KbcEMwCyxnKLBLOEpxi5ZZaCy6vWGwoU5j5Xa0fw9EVZVFOxWnVr
         bK60xfiInpBC+dEbLfcypq+aOo9BO/lzC8uTip8i1kSxSiRjbAgi+chmHen4Y01Z+L1q
         /VFg==
X-Gm-Message-State: AOAM530sPOcwnDAJr94+bJBTJt0T/bekgnCxbJ1F0iivlqdjlwctm59z
        4hKzWmXkYO2gmuDwg8Qc8zsHdsnSSFI=
X-Google-Smtp-Source: ABdhPJxfJp755RdM5N/P9pxCWoNoYOupI8zgWEW3+VVcpmDWhoVFpCLGqCxG8IWg8HRqJv/SBVEKOg==
X-Received: by 2002:a17:90b:3e82:b0:1c7:2920:7c54 with SMTP id rj2-20020a17090b3e8200b001c729207c54mr3167884pjb.2.1648619278168;
        Tue, 29 Mar 2022 22:47:58 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id j22-20020a056a00235600b004faed937407sm21625451pfj.19.2022.03.29.22.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 22:47:57 -0700 (PDT)
Date:   Wed, 30 Mar 2022 11:17:51 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: qcom: update maintainers (drop Akash and
 Mukesh)
Message-ID: <20220330054751.GA51248@9a2d8922b8f1>
References: <20220329113718.254642-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329113718.254642-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 01:37:17PM +0200, Krzysztof Kozlowski wrote:
> Emails to Akash Asthana and Mukesh Savaliya bounce (550: Recipient
> address rejected: User unknown in virtual alias table), so switch
> maintainers to Andy and Bjorn (as Qualcomm platform maintainers).

Thanks Krzysztof as it was really anonoying to hear bounce emails.

One thing, I heard bounce from Akash only and not from Mukesh.
Did you hear bounce from Mukesh as well?

-Kuldeep
