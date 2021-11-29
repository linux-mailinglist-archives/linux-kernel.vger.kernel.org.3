Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF450461AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242184AbhK2Pfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:35:52 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:45815 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344160AbhK2Pdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:33:51 -0500
Received: by mail-oi1-f181.google.com with SMTP id 7so35212744oip.12;
        Mon, 29 Nov 2021 07:30:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=m4n1c0DkMDGMvar0IQu4WXywqga4uflTYXHUTLO3idE=;
        b=VWWRkUZUIk7d7Dxc1K1JMLfZS3K4HMojbsCcQ7HcxPegJu74EEPMVmf9DsAc/52uHe
         G0SM3w5sNfC6EGO0S8inL0O4dMbFHAfOw7QpwdQJnZ9HlgyVVJzYNjbLjh0djEXbf3vd
         qqBRHmZ+9tIaq9XP45h3r16Me+7X6NcRvVmhGy6+ABjxXi1l76DXCeuUgmmDouyyP9Ht
         Am+PTu8FeDxEZ2Ne0b2hchPdOMv8q41Uhtnf5CNGm9HE+z8KeEdRS4Y7Ms+8X41rMzI+
         ptj1NcEXvAzrKpPdavVqB7gic8zKd+sTgMMAbU6vfB7kpKi8DiK61KXwfHCKZkcBV9Eo
         Rl8w==
X-Gm-Message-State: AOAM5334tw6nnCmAt1sWf38ZIvwNPAFzGGENRnsMprBIMsfW7dxZ7OpG
        UYyXIMFjK7uNuKe49FqZfQ==
X-Google-Smtp-Source: ABdhPJzkwkUaXI6PG8tzsGAmXouYAAtD/aY86iaymO28QoeayfkXaFCBwnqJhl86e+24aOT2mM0y8w==
X-Received: by 2002:a05:6808:1589:: with SMTP id t9mr41980146oiw.108.1638199833168;
        Mon, 29 Nov 2021 07:30:33 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s17sm2273404ooj.42.2021.11.29.07.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:30:32 -0800 (PST)
Received: (nullmailer pid 123612 invoked by uid 1000);
        Mon, 29 Nov 2021 15:30:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     sboyd@kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, collinsd@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>, subbaram@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1638174137-23290-11-git-send-email-quic_fenglinw@quicinc.com>
References: <1638174137-23290-1-git-send-email-quic_fenglinw@quicinc.com> <1638174137-23290-11-git-send-email-quic_fenglinw@quicinc.com>
Subject: Re: [PATCH v3 10/10] dt-bindings: convert qcom,spmi-pmic-arb binding to YAML format
Date:   Mon, 29 Nov 2021 09:30:31 -0600
Message-Id: <1638199831.114024.123611.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 16:22:17 +0800, Fenglin Wu wrote:
> Convert the SPMI PMIC arbiter documentation to JSON/yaml. While at it,
> update SPMI bus "reg" items constraint for SPMI PMIC arbiter to carry
> it and update it with a smaller range.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  .../bindings/spmi/qcom,spmi-pmic-arb.txt           |  67 -----------
>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml          | 128 +++++++++++++++++++++
>  Documentation/devicetree/bindings/spmi/spmi.yaml   |   3 +-
>  3 files changed, 130 insertions(+), 68 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml:37:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml:41:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt: Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt

See https://patchwork.ozlabs.org/patch/1561055

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

