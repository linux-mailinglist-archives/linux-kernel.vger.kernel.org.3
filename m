Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3055556B2C9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiGHG3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbiGHG3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:29:43 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBCC24BDE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 23:29:42 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r22so14673562pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 23:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OxzlnlJQQW+AJLZaxxRnLlnUnRueupJTmSnVE0o02mw=;
        b=zEStfvLSPbT+0vqMFAaS74qIUp+eaKV3ktNkqsNvTQSBxYZodYjqZFdOcVoM5aiEhW
         hfq3BlfBqNnASiqYQSSmA05An0FlDp2NPTaXBf4p9nh9tlscZa0u1Q1tXBPID6thL4vd
         v/L965NTucQ3/ZDV7GQpKDBXs+NMVOSqx2wTziQCnFyzZfs1VODX7/ik9o+GzHpVfABV
         tRW2R/K0oBSsjK2u+PdcB+t7ScLB2zwR2w+FLFT0PzheDnPn39A+L61d3zgx+WD/4lOF
         ZxQWaLNRnVZ7g8BrobxJ52cy23LULENK2+jNrQDWpQp67XrlcDKHr3rzcvU3jE5RNc3G
         mcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OxzlnlJQQW+AJLZaxxRnLlnUnRueupJTmSnVE0o02mw=;
        b=JX5yJxlYbAKEFv8fvumoH08djYP7FGv2MJ9BFg7CNpvHA5LgyIAp6q3ixEFXfBBTr/
         YBU2Li/Yh3iV+9RBXyZ7KQPT0yUNuytvMKS+zYe51bbj8yPJvIr/G6sAN4U0v4AUx7AY
         +G8/ddxBVs28NiC9g4hDogWc1Qyw81DLWu7fkzO+iqPD6wpEahV0jcgQxF1lyEVZbRqH
         vfOCuEbPl4ziE8YSaaFMNVsrlhJdqpkZZjijnuYSxaYe7xS5NmNOfnKiS9SV/Y1wl0Xy
         fMWgbpdtSuTPodaU2KdbKiRXW0g2wn4ovVnzZFg03e8e/u/PytMVG3CAun4Hpq4EPqJd
         px+w==
X-Gm-Message-State: AJIora+zaISClWIN/yOf/yNQoxQdoxgSyuPUigiu6vtvDHRQKqq4QpNN
        b+6gdjmUQNBtC8mIrE+q05eXEbXF9RYWgCq5
X-Google-Smtp-Source: AGRyM1vx5F5PLe2M6kbtNv22VitB1eggD2eJ+w2NdziPJN4Sg8QPSijHXrkDRjBNReGg3SnuseQCvQ==
X-Received: by 2002:a65:430a:0:b0:412:1877:7def with SMTP id j10-20020a65430a000000b0041218777defmr1946422pgq.93.1657261781329;
        Thu, 07 Jul 2022 23:29:41 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id bk21-20020aa78315000000b005254e44b748sm27802126pfb.84.2022.07.07.23.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 23:29:40 -0700 (PDT)
Date:   Fri, 8 Jul 2022 14:29:36 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] interconnect: qcom: icc-rpm: Support multiple
 buckets
Message-ID: <20220708062936.GA195591@leoy-ThinkPad-X240s>
References: <20220705072336.742703-1-leo.yan@linaro.org>
 <20220705072336.742703-5-leo.yan@linaro.org>
 <1d0fec7d-ed83-e1ff-92a1-e721bcc50298@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d0fec7d-ed83-e1ff-92a1-e721bcc50298@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 05:29:16PM +0300, Georgi Djakov wrote:

[...]

> > +/**
> > + * qcom_icc_rpm_pre_bw_aggregate - cleans up values before re-aggregate requests
> 
> This does not match with the name of the function below.

Will fix it.

> > + * @node: icc node to operate on
> > + */
> > +static void qcom_icc_pre_bw_aggregate(struct icc_node *node)

Thanks,
Leo
