Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EA647A27E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 22:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbhLSV5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 16:57:25 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:45882 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbhLSV5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 16:57:24 -0500
Received: by mail-oi1-f177.google.com with SMTP id 7so12984252oip.12;
        Sun, 19 Dec 2021 13:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=e2wJOEkGqL57M+FK41D9nVh8+UoyDiWRtyVQE+OdR54=;
        b=5FI+7VjfNqI1EeTSpEMecrPqP+i6gSRAMnwn4e1HvfIp78iVL0Ja5w+0eUckGolad0
         bh7qahi3wiGURpV8XEuJymwWRo/x2XxK0Py1JaDfMVcc/sZuHeEUQYBCL/opK0lfC0qc
         0vu/jGpfkutGMmrpcGtkAMRFJOmKWLaxSZxD04cynk1OLB1cOZxM0rB2IiH1Fem1JAtQ
         2YIJtHyf+Hcg0AKS13hEIOBpR1ig/2wsnEHmWX1pAIyTDWNWIpiN4QRFRuzJ4rz1nuVS
         h36WQto1hqu24SbSZy9PSmjYGOo3eRZrKhisBYZYdz9gMZ/hObd/KpI4dHs9eMCJFcfe
         Uflw==
X-Gm-Message-State: AOAM532Y+DvwZX87iXTzY8dvnM/I+fIhk+skPnw5M92z/ySlNdMDa4Z4
        hxktZ/ejNW7P+8XFjfjVbQ==
X-Google-Smtp-Source: ABdhPJyLFh4Ey3YDVQxhAqEMt2z6iRmUSSYZHC/ZNmCMR8rrXILPUijWix/WR7nK+i/SPZMwKks/1Q==
X-Received: by 2002:aca:1115:: with SMTP id 21mr15504945oir.137.1639951043901;
        Sun, 19 Dec 2021 13:57:23 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j5sm2900172ots.68.2021.12.19.13.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 13:57:23 -0800 (PST)
Received: (nullmailer pid 2758867 invoked by uid 1000);
        Sun, 19 Dec 2021 21:57:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
        ~okias/devicetree@lists.sr.ht, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211218194038.26913-1-david@ixit.cz>
References: <20211218194038.26913-1-david@ixit.cz>
Subject: Re: [PATCH] dt-bindings: firmware: convert Qualcomm SCM binding to the yaml
Date:   Sun, 19 Dec 2021 15:57:22 -0600
Message-Id: <1639951042.365082.2758866.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2021 20:40:37 +0100, David Heidelberg wrote:
> Convert Qualcomm SCM firmware binding to the yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> This patch comes with followup question -> since not all definitions
> follow `"qcom,scm-*chipset*", "qcom,scm"`, should I change them or adjust this
> binding to cover all cases?
> 
>  .../devicetree/bindings/firmware/qcom,scm.txt |  54 ---------
>  .../bindings/firmware/qcom,scm.yaml           | 112 ++++++++++++++++++
>  2 files changed, 112 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/qcom,scm.example.dt.yaml: scm: compatible:0: 'qcom,msm8916' is not one of ['qcom,scm-apq8064', 'qcom,scm-apq8084', 'qcom,scm-ipq4019', 'qcom,scm-ipq806x', 'qcom,scm-ipq8074', 'qcom,scm-mdm9607', 'qcom,scm-msm8226', 'qcom,scm-msm8660', 'qcom,scm-msm8916', 'qcom,scm-msm8953', 'qcom,scm-msm8960', 'qcom,scm-msm8974', 'qcom,scm-msm8994', 'qcom,scm-msm8996', 'qcom,scm-msm8998', 'qcom,scm-sc7180', 'qcom,scm-sc7280', 'qcom,scm-sdm845', 'qcom,scm-sdx55', 'qcom,scm-sm8150', 'qcom,scm-sm8250', 'qcom,scm-sm8350']
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/qcom,scm.example.dt.yaml: scm: $nodename:0: '/' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/qcom.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/qcom,scm.example.dt.yaml: scm: compatible: 'oneOf' conditional failed, one must be fixed:
	['qcom,msm8916', 'qcom,scm'] is too short
	['qcom,msm8916', 'qcom,scm'] is too long
	Additional items are not allowed ('qcom,scm' was unexpected)
	'qcom,msm8916' is not one of ['qcom,apq8016-sbc']
	'qcom,msm8916' is not one of ['lg,lenok']
	'qcom,msm8916' is not one of ['asus,nexus7-flo', 'lg,nexus4-mako', 'sony,xperia-yuga', 'qcom,apq8064-cm-qs600', 'qcom,apq8064-ifc6410']
	'qcom,msm8916' is not one of ['qcom,apq8074-dragonboard']
	'qcom,msm8916' is not one of ['qcom,apq8060-dragonboard', 'qcom,msm8660-surf']
	'qcom,msm8916' is not one of ['qcom,apq8084-mtp', 'qcom,apq8084-sbc']
	'qcom,msm8916' is not one of ['samsung,s3ve3g']
	'qcom,msm8916' is not one of ['qcom,msm8960-cdp']
	'qcom,msm8916' is not one of ['fairphone,fp2', 'lge,hammerhead', 'samsung,klte', 'sony,xperia-amami', 'sony,xperia-castor', 'sony,xperia-honami']
	'qcom,msm8916' is not one of ['alcatel,idol347']
	'qcom,msm8916' is not one of ['longcheer,l8150', 'samsung,a3u-eur', 'samsung,a5u-eur']
	'qcom,msm8916' is not one of ['sony,karin_windy', 'sony,karin-row', 'sony,satsuki-row', 'sony,sumire-row', 'sony,suzuran-row', 'qcom,msm8994']
	'qcom,msm8996-mtp' was expected
	'qcom,msm8916' is not one of ['qcom,ipq4019-ap-dk01.1-c1', 'qcom,ipq4019-ap-dk04.1-c3', 'qcom,ipq4019-ap-dk07.1-c1', 'qcom,ipq4019-ap-dk07.1-c2', 'qcom,ipq4019-dk04.1-c1']
	'qcom,msm8916' is not one of ['qcom,ipq8064-ap148']
	'qcom,msm8916' is not one of ['qcom,ipq8074-hk01', 'qcom,ipq8074-hk10-c1', 'qcom,ipq8074-hk10-c2']
	'qcom,msm8916' is not one of ['qcom,sc7180-idp']
	'qcom,msm8916' is not one of ['qcom,sc7280-idp', 'qcom,sc7280-idp2', 'google,piglin', 'google,senor']
	'qcom,msm8916' is not one of ['xiaomi,lavender']
	'qcom,msm8916' is not one of ['qcom,sdx55-mtp', 'qcom,sdx55-telit-fn980-tlb', 'qcom,sdx55-t55']
	'qcom,msm8916' is not one of ['qcom,sdx65-mtp']
	'qcom,msm8916' is not one of ['qcom,ipq6018-cp01', 'qcom,ipq6018-cp01-c1']
	'qcom,msm8916' is not one of ['qcom,sa8155p-adp']
	'qcom,msm8916' is not one of ['fairphone,fp4']
	'qcom,msm8916' is not one of ['qcom,sm8150-mtp']
	'qcom,msm8916' is not one of ['qcom,qrb5165-rb5', 'qcom,sm8250-mtp']
	'qcom,msm8916' is not one of ['qcom,sm8350-hdk', 'qcom,sm8350-mtp']
	'qcom,apq8016' was expected
	'qcom,apq8026' was expected
	'qcom,apq8064' was expected
	'qcom,apq8074' was expected
	'qcom,msm8660' was expected
	'qcom,apq8084' was expected
	'qcom,msm8226' was expected
	'qcom,msm8960' was expected
	'qcom,msm8974' was expected
	'qcom,msm8916-mtp/1' was expected
	'qcom,msm8916' was expected
	'qcom,apq8094' was expected
	'qcom,ipq4019' was expected
	'qcom,ipq8064' was expected
	'qcom,ipq8074' was expected
	'qcom,sc7180' was expected
	'qcom,sc7280' was expected
	'qcom,sdm660' was expected
	'qcom,sdx55' was expected
	'qcom,sdx65' was expected
	'qcom,ipq6018' was expected
	'qcom,sa8155p' was expected
	'qcom,sm7225' was expected
	'qcom,sm8150' was expected
	'qcom,sm8250' was expected
	'qcom,sm8350' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/qcom.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1570591

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

