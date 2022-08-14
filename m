Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65278592664
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 22:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiHNUpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 16:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNUpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 16:45:12 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F0415FC9;
        Sun, 14 Aug 2022 13:45:11 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id q6-20020a05683033c600b0061d2f64df5dso4292251ott.13;
        Sun, 14 Aug 2022 13:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YQ24aMe/dl9r0PZh5GuKRz4u2A7KWVezV59s4/QRS2I=;
        b=EnswMA2T+f32Cj+qzcAFIZGze77HdYNXcDch/lHu7FnhfJG+42TggjA+g/UyABWHBA
         V8Eo/54K1+QYJW/IbosqqIhPlc1yL4bDPSQLzbhTGAvMSjMPpUpdsXDcQvD/OLyIE5EE
         xNrRrVRdXSBFQQ/Qrx/fin5+DQNCubRsKWOZFMsFIum+T2ECW6NHdX9RyFSLe0pLTRqp
         SHY7mINnnrJFFR96FwjekthiOmCpt3OUbm9p5GMtb5C/tV6pOvoSNiRkwFBfcDlpfTDp
         YYvgKkKoIn9xS4jjaOe4p66koAVc+aX0SkmXw1jKKgPtSg4V4OrVX8bAf/+xpdkHcaxl
         Bmlw==
X-Gm-Message-State: ACgBeo2ENQWP3qqyb513R4myy6XHFxyCFRImbol+YZFgakI6epqkJ+pY
        aeUYhg01/Wj7yHXgFX2L3Q==
X-Google-Smtp-Source: AA6agR77dO+eZKZQyuXR5uxJOVdoQGt5EmocLw+lc/TntWA731e8TDoVyWZA5XWjInQmbdTHKP436A==
X-Received: by 2002:a9d:5e83:0:b0:636:dcb4:6c2a with SMTP id f3-20020a9d5e83000000b00636dcb46c2amr4871205otl.242.1660509910621;
        Sun, 14 Aug 2022 13:45:10 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.176.57])
        by smtp.gmail.com with ESMTPSA id e17-20020a9d7311000000b006371a0ff355sm1724619otk.77.2022.08.14.13.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 13:45:10 -0700 (PDT)
Received: (nullmailer pid 677581 invoked by uid 1000);
        Sun, 14 Aug 2022 20:45:05 -0000
Date:   Sun, 14 Aug 2022 14:45:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, broonie@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        quic_plai@quicinc.com, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        quic_rohkumar@quicinc.com, bgoswami@quicinc.com,
        swboyd@chromium.org, srinivas.kandagatla@linaro.org,
        linux-arm-msm@vger.kernel.org, judyhsiao@chromium.org
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom: adsp: Make ADSP
 pil loader as generic
Message-ID: <20220814204505.GA677523-robh@kernel.org>
References: <1660117558-21829-1-git-send-email-quic_srivasam@quicinc.com>
 <1660117558-21829-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660117558-21829-2-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022 13:15:51 +0530, Srinivasa Rao Mandadapu wrote:
> Rename sdm845 adsp pil bindings to generic name, for using same binings
> file for subsequent SoCs.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
> Changes since V2:
> 	-- Generate patch with -M flag.
> 
>  .../{qcom,sdm845-adsp-pil.yaml => qcom,lpass-adsp-pil.yaml}           | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/remoteproc/{qcom,sdm845-adsp-pil.yaml => qcom,lpass-adsp-pil.yaml} (97%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
