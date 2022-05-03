Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E5B518BD2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbiECSIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240820AbiECSIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:08:05 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F173EA8E
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:04:32 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id e189so18961208oia.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nGkSI+NXkk/TIaUfMbTS5LjDSixkddXSIamGkNlZLuI=;
        b=HqABJwqMfzZsj7GebOh4wS7vXKe4wQnSUTGFHifFQFAQFw3yciwClN7+rNvine68Ur
         SZwBLHGJHHMl6ow3HZfJ6qpG9G2kURPx49/ASJPY22WmWEt1ZV6NkgL5kgY54d54R/Ci
         ZdcGGIbC2rBpNoL8kc1VzyKUOLx+imv6fSRN4UbtMMDQcjskmMq30u6FqIT/TWFVtRia
         QSs9Jf3KDis5zmMMTZkU7OWyZWfz8wQdqRDkOtuACocG/jvi5oiM7B4228sE9e/nYRO0
         OsjvDn3Uv65buZkbSBhVJdAWyramIINDBfH3TgmI2zr/158e6I7WTm2y+IYgv18oXo15
         Y78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nGkSI+NXkk/TIaUfMbTS5LjDSixkddXSIamGkNlZLuI=;
        b=aZ9g+NXJ+k1eBGnhsAJ2tDdoTxQshbWAO5nmnrmoeK5EVWY7tSRBi8q+cmq+YI2UfX
         xMhxL1/LxP3HI/uBwTUeG22cyk9JGpyO597Z7+OWj9Z+x0c9w/ZK5xKSfuH2AGw0lyeR
         yOSPVEXQMRQ63dsfGY1n2t6QbC4jlgBop2KUuznDFC+XS4Hu51SD8uSFyD92cfvt2Wn1
         LpXRj1TtiFl9umAEc02IxyRfKcGh/3FtUcPVo0qLSdbEHzj1/uAJBh4M9tROHwrxlfR1
         DAhFN0Um9aliVV3ktf3ZRBR6nGPWpfUHgkjaFFaDZyy/guo+OIfE687ozxsS5kieUWkB
         muIA==
X-Gm-Message-State: AOAM531iea1vmj1Yv3fpPxo/j+vcRrl6nFXS17lWtgOo94EQcycJ6npX
        xRAgIMAA8lsSROcwXaEYNm4Z5g==
X-Google-Smtp-Source: ABdhPJwOR7cuH3Lr5GL3MW4mj80jqAeRSqQF0RECo7ESQmRtP9ETU6jus8olppiLtanbeXKpylin9g==
X-Received: by 2002:a54:4505:0:b0:325:e50c:a71 with SMTP id l5-20020a544505000000b00325e50c0a71mr2298779oil.70.1651601070242;
        Tue, 03 May 2022 11:04:30 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q23-20020a4adc57000000b0035eb4e5a6c7sm5138862oov.29.2022.05.03.11.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 11:04:29 -0700 (PDT)
Date:   Tue, 3 May 2022 13:04:27 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Alex Elder <elder@ieee.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@codeaurora.org>, vkoul@kernel.org
Subject: Re: [PATCH V7 3/7] MAINTAINERS: Add the entry for DCC(Data Capture
 and Compare) driver support
Message-ID: <YnFuq7h110fuMp5U@builder.lan>
References: <cover.1646285069.git.quic_schowdhu@quicinc.com>
 <141df53b42681ba3488f6db60983d4cdb6493f49.1646285069.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <141df53b42681ba3488f6db60983d4cdb6493f49.1646285069.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 Mar 00:27 CST 2022, Souradeep Chowdhury wrote:

> Added the entries for all the files added as a part of driver support for
> DCC(Data Capture and Compare).
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a61f4f3..e57d927 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5146,6 +5146,14 @@ F:	include/linux/tfrc.h
>  F:	include/uapi/linux/dccp.h
>  F:	net/dccp/
>  
> +DCC QTI DRIVER
> +M:	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/ABI/testing/debugfs-driver-dcc
> +F:	Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
> +F:	drivers/soc/qcom/dcc.c
> +
>  DECnet NETWORK LAYER
>  L:	linux-decnet-user@lists.sourceforge.net
>  S:	Orphan
> -- 
> 2.7.4
> 
