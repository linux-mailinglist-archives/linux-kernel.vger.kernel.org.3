Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F85050CBF2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 17:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbiDWPwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 11:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236154AbiDWPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 11:52:37 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E1B1F8D88
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:49:40 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id a10so12330922oif.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v0ylInl64i1hrDqBe9LG4snd53LOWIsND9Zo4cq727k=;
        b=oVqzYjyQU1wu4npBfpRZe+pc8DzrfKOPAh/ztdLQcN1LoLZrTAsC227FUJ6cNEMI/Y
         Z9THlv266Q+z+3IQD3gM0EDhas6CZU5FUX0nXKMXL9PAbDlYM95lx3IHQkPUEQ7bB3u1
         eQLoXJU8PCBd7HMIFftoCoIXzPjUlcvTDS+EuMBbflgaEH+b98SR7Zc+nFl38QrYt5lI
         t2CH0LEBdP7BRRSIetG5gmWLOqZe1fThnDoFQz+ky5jBtEuF4cRKmL//lFBYfligWAei
         CUaU43SWG7A0kWoD/koKwNjoKUZCtOdtPQCHKL6Rd8wDPG1/yfMk0AfKVfClUOtHPoRr
         +t6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v0ylInl64i1hrDqBe9LG4snd53LOWIsND9Zo4cq727k=;
        b=58jg35y7bcfkuMfE+iW+oo34Yfq1G31obBAM2c4IOw7eIV/hgGVjQULTAj3++JXA20
         bETanLgqWwdI6nlLNhU3e5MqKYDl/S57EtWrhjF2+No3ZyHt2AfYMgkZuOXby99Ihjf1
         7GsTniyZujPoTFEb/3wpfSdK/ZWGNetXEC4zKiDqeJx1n5eD/uJ981g6y9WkudrUtDYA
         n0/Frw5RgIQOJZMxYBpYdOfAsMmwI/4UdOrWltomlYcTAUlRAvgFCKXj3kZ71710sUGs
         D7DCvcX79xXNIzL0o7lhMbvToICcKzLYLNDx2xLhu5Dd5q2x6a7JV74TdaFGekKCsaBv
         jfmA==
X-Gm-Message-State: AOAM5325L3Lhjp7stNKE7+fic/U1dRjUG9Pht2uM2fHcJBG5H6D2RVPq
        6EnhtrOTjnHBnpl36XW6Nkt8cA==
X-Google-Smtp-Source: ABdhPJx8fCal4anqgjvarWztx1n3sowp/1yUkWS9TO0WIVk/1YCyKPGDiPvo6UGPkRylM+OeJ69yzQ==
X-Received: by 2002:aca:919:0:b0:324:eab4:748d with SMTP id 25-20020aca0919000000b00324eab4748dmr3471818oij.123.1650728979741;
        Sat, 23 Apr 2022 08:49:39 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id 88-20020a9d0361000000b006056fd81aacsm1980494otv.40.2022.04.23.08.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:49:39 -0700 (PDT)
Date:   Sat, 23 Apr 2022 08:51:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        bhupesh.linux@gmail.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, vkoul@kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/4] dt-bindings: phy: qcom,qmp: Describe phy@ subnode
 properly
Message-ID: <YmQgi0i9PDCVqrGz@ripper>
References: <20220418205509.1102109-1-bhupesh.sharma@linaro.org>
 <20220418205509.1102109-4-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418205509.1102109-4-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 Apr 13:55 PDT 2022, Bhupesh Sharma wrote:

> Currently the qcom,qmp-phy dt-binding doesn't describe
> the 'reg' and '#phy-cells' properties for the phy@ subnode.
> 
> Fix the same.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../devicetree/bindings/phy/qcom,qmp-phy.yaml       | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> index 411c79dbfa15..c553c8ad0d1a 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -118,6 +118,19 @@ patternProperties:
>        Each device node of QMP phy is required to have as many child nodes as
>        the number of lanes the PHY has.
>      properties:
> +      reg:
> +        minItems: 1
> +        maxItems: 6
> +        items:
> +          description: |
> +            List of offset and length pairs of register sets for PHY blocks.
> +            common block control registers, such as - SW_RESET, START_CTRL.
> +            pcs registers, such as - PCS_STATUS, POWER_DOWN_CONTROL,
> +            pcs misc registers, such as - PCS_MISC_TYPEC_CTRL.

The two cases we have is:

  tx
  rx
  pcs
  pcs_misc

and:

  tx
  rx
  pcs
  tx2
  rx2
  pcs_misc

So I think we should express that explicitly here.

Regards,
Bjorn

> +
> +      "#phy-cells":
> +        const: 0
> +
>        "#clock-cells":
>          enum: [ 0, 1, 2 ]
>  
> -- 
> 2.35.1
> 
