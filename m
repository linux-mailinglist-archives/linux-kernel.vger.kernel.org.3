Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1C15AE492
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbiIFJnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbiIFJmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:42:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0BA7647B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 02:42:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t7so9521601wrm.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 02:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=AZx+3K3BoIqYOQf32bjmF5LhfSd1CBJzz3H5OYRrses=;
        b=WW+LgiFVZWKYAY1s0egxDFDVyEeujteQa6G9ahhqfU/Uee6Ye4FG17Go/8iIsxq5Tj
         5EKTFU9qPAi+McU+k4Kjw8LqNU3wpVBfRe7o8LpsFSOIlHrWytu6BUP6M8olFxd77vpP
         5p4dZopHxbbjUn9q3sutXRQ5YAzWe6DGqQ8QN9lQbnMF96Qoybb9qYkBvK9mD0ueO6l3
         v1neSXgW0n/AB0nOZX+LZ8ZZ6w09TWn7dm+9u2NMB0xdSIH642dC+2e+nPl81uHzmMEw
         T7UN3sRg5yUllT6AlWxadli7eilDRloJ9DlIQEnddBtwmAnUlPfHXUz1o+5feaRGwdOr
         e5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AZx+3K3BoIqYOQf32bjmF5LhfSd1CBJzz3H5OYRrses=;
        b=rvXeLcNgnQdBtldVtWzhYkOm1WD54OHzf6tnoR1HIL/FtvaVU6kcC+EDKmtz22uuTj
         oyOwQLqjCvV5NLlzV/wdYz4cY/Cde1v8RRg6AGOEyNKpCCKgjqdaY34jCjL92yGTOJRk
         7v/v69l1ykMTmUMEr+snOlcsn43LOylUOjZKQeJ4UbeSMpNh455/tSidMmuIxiG3lvu4
         2i165KkoI8ARGwTYzApn41+4U4aq0LNzn7NI3ajdBqk8T+aFHfF4mt9NxQoxkNMlCQrH
         3jeYHSl4PqPHl8e+OVqW83tFQZZu2Z4COpkv7z9fjG9t6aIhXd6YFRABXG6xX1t1X2GC
         3gfg==
X-Gm-Message-State: ACgBeo3O392IB4CAb0vvIinMoCffSYJi4TFD0BV5LBo7amxgM0Il1t+s
        F2EmZV+teDnzu0s6PLMnOtwdNg==
X-Google-Smtp-Source: AA6agR4EN0Y+AtIIiMTu9ibUaomfMjFMz3Urbiy/6AlyQYadUGfPzqeqjDWoXYD8THtJGNTUuAeIWw==
X-Received: by 2002:a5d:6483:0:b0:226:db59:2f94 with SMTP id o3-20020a5d6483000000b00226db592f94mr23082304wri.200.1662457332102;
        Tue, 06 Sep 2022 02:42:12 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v13-20020a5d678d000000b00228a45eb045sm5020774wru.109.2022.09.06.02.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 02:42:11 -0700 (PDT)
Date:   Tue, 6 Sep 2022 12:42:10 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v8 1/2] dt-bindings: misc: fastrpc convert bindings to
 yaml
Message-ID: <YxcV8kAQoqr6Bs1X@linaro.org>
References: <20220906092415.1989720-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906092415.1989720-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-06 12:24:14, Abel Vesa wrote:
> Convert Qualcomm FastRPC bindings to yaml format, so that we could validate
> dt-entries correctly and any future additions can go into yaml format.
> 
> Use compute-cb@ subnodes instead of just cb@. Add qcom,glink-channels and
> qcom,smd-channels missing properties to make sure dtbs_check doesn't fail
> right off the bat. Correct the name of the parent node in the example from
> smd-edge to glink-edge.
> 
> Also change the file extension referenced in bindings
> remoteproc/qcom,glink-edge.yaml from txt to yaml.
> 
> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Co-developed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 

...

> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
> index fa69f7b21eed..170b0601839a 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
> @@ -25,7 +25,7 @@ properties:
>    fastrpc:
>      type: object
>      description:
> -      See Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> +      See Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml

On a second thought, this should be a $ref now that is yaml.

Will resend.

>  
>    interrupts:
>      maxItems: 1
> -- 
> 2.34.1
> 
