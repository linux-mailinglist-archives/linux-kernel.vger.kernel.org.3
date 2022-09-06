Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8D45ADD87
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbiIFCqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiIFCqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:46:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E21402D4;
        Mon,  5 Sep 2022 19:45:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53B1EB815CB;
        Tue,  6 Sep 2022 02:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38D1C433C1;
        Tue,  6 Sep 2022 02:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662432356;
        bh=ghi35xw2bM6XkWJz3ZynG6KjYwLr/s0j/PUC4aSPkuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u0AldxqpC/s55xjzxvow+esfaO81KuYY/Pe/L2weWaNUAw60JFMc3Mm4lN089wi2q
         GjUvnnrjep+H2LR45evWWPOHTQKYljaJeXO0cK5XYGyEdI1QBk3C0j285hgCevlZsw
         5xHAyGem+wH5XVprGgxNF5zj48OsLf9jkgrKXwn0W4PUZdR9hoI69QtPwiS96oZY2x
         K53eMd3sVAdxCfLDumAj3xBk96FLNHlejrs8TOCQ6mMKtKMyy4of2IykxZzlr0/n6x
         wcmXyhoAeEyy8U5vhKjGGweU9sxccbuWk9R9doyWEbSQtIuL6XoKNQd+mOfFptNZco
         DRBAvz4xHlvWw==
Date:   Mon, 5 Sep 2022 21:45:52 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com
Subject: Re: [PATCH v12 2/3] phy: qcom-snps: Add support for overriding phy
 tuning parameters
Message-ID: <20220906024552.lob5k4q3iyagyo5e@baldur>
References: <1662201048-26049-1-git-send-email-quic_kriskura@quicinc.com>
 <1662201048-26049-3-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662201048-26049-3-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 04:00:47PM +0530, Krishna Kurapati wrote:
[..]
> +static void qcom_snps_hsphy_read_override_param_seq(struct device *dev)
> +{
> +	struct device_node *node = dev->of_node;
> +	s32 val;
> +	int ret, i;
> +	struct qcom_snps_hsphy *hsphy;
> +	const struct override_param_map *cfg = of_device_get_match_data(dev);

Given that you don't have any .data specified for the other compatibles
(which is fine), cfg would be NULL here and below loop would attempt to
access NULL[0].prop_name and crash.

Please add a check for !cfg and just return here.

With that I think the series looks good.

Regards,
Bjorn
