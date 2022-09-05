Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403055AD54C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbiIEOoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238416AbiIEOnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:43:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D18A1EC62;
        Mon,  5 Sep 2022 07:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D08F7B811E9;
        Mon,  5 Sep 2022 14:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED9FC433C1;
        Mon,  5 Sep 2022 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662388860;
        bh=z+kDqX33jrhb82AEByjlMWgt9j5tQ/K93wDMIdLY0mM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/R6CPVXbZ7n/nvdrNybUQZdtuWGiton1smrVIscsz0hP6ijQssCTe6D73mN16x8A
         EzASL50uSnvu05vKJoTJdMPiHpsuqqZRjSHQY9ue4DmQ7Iqu2WYI9SIJiWJ3zi4v21
         mpD5474tGpsZ5SnjJEAHkG+48eLfSfh7BPk5lrOJShjTLR2HR08oMu/emGvgj/QyEQ
         K99/VWGRJXK05CbssvXcDR5zEFkFDlUm8uUNRqqjw3r50iGm6x7QiGIwEWAA3gRahs
         bW5mGiO4OgBlZIUCJ+OkSxpF9DN5Md2KoM/no5AibRJccrLAJ86fw50oIDFuDbO0s3
         RILL0rqcVOR2Q==
Date:   Mon, 5 Sep 2022 15:40:49 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yu Chen <chenyu56@huawei.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Carvalho Chehab <mchehab+huawei@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: mfd: syscon: require specific
 compatible also for simple-mfd
Message-ID: <YxYKcTavYef/ByKe@google.com>
References: <20220817142246.828762-1-krzysztof.kozlowski@linaro.org>
 <20220817142246.828762-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220817142246.828762-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022, Krzysztof Kozlowski wrote:

> The syscon bindings require a device specific compatible, beside the
> "syscon".  However schema counts "simple-mfd" as such, which allows
> simple-mfd+syscon to sneak in.
> 
> Adjust the match to be sure simple-mfd also comes with a device specific
> compatible.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
