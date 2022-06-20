Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714945516AB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbiFTLI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbiFTLI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:08:56 -0400
X-Greylist: delayed 230 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Jun 2022 04:08:54 PDT
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149C0A7;
        Mon, 20 Jun 2022 04:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-ID:Content-Description;
        bh=CZYkuwuyEVUXwAO4XEMsBG16iYPMRoKYAzF0IBgK8jw=; b=wL0TKz6sUdFxt5robK9s3vw+3G
        vpCedd//rpevuhpOWvmzXtuI9V6if7lusAl/IUIO7gLmtPLmRydFYlzsTA4QGYxoPCryVFxTrC/ed
        DQj9X5V2Iofi04R4r3gi1vbNV0IOLuGlNKnJuNVSyssmuo/3RAZKQSFiLd42qpxAMrIiUaGzO2rL2
        eYln0Vxf/ZYHf820uZKfZF6B5lryx/pAgcnh1Y+juyqJJRzaS3IarO0crKCUX5GK0Bf0uLBs77Uvv
        DI1aX1UMTtVe6MYIosymILmwqyo/qFJFDvjRbHQyCr/4VyDlhzMRXBGp0sy8d3uTl621LW3GemvTg
        DxIbGEfQ==;
Received: from 92.40.170.2.threembb.co.uk ([92.40.170.2] helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1o3FGu-0002Pu-OT; Mon, 20 Jun 2022 12:08:44 +0100
Date:   Mon, 20 Jun 2022 12:08:43 +0100
From:   John Keeping <john@metanate.com>
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     heiko@sntech.de, ardb@kernel.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 00/33] crypto: rockchip: permit to pass self-tests
Message-ID: <YrBVO+2TWufDOrtH@donbot>
References: <20220508185957.3629088-1-clabbe@baylibre.com>
 <YqceGFafq7QoT+8w@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YqceGFafq7QoT+8w@Red>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 01:23:04PM +0200, LABBE Corentin wrote:
> Le Sun, May 08, 2022 at 06:59:24PM +0000, Corentin Labbe a écrit :
> > The rockchip crypto driver is broken and do not pass self-tests.
> > This serie's goal is to permit to become usable and pass self-tests.
> > 
> > This whole serie is tested on a rk3328-rock64, rk3288-miqi and
> > rk3399-khadas-edge-v with selftests (with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y)
> > 
> > Regards
> > 
> 
> This is a gentle ping since this serie has now, no comment to address.

I've just replied to patch 14 with a comment, but other than that I
agree that patches 1-24 look good.  It would be good to get these merged
soon as crypto acceleration on Rockchip hardware has been totally broken
for several releases now.

Patches 1-13 and 15-24 are:

	Reviewed-by: John Keeping <john@metanate.com>

I'm less sure about patches 25-33 as I don't really know much about the
crypto API, but it seems strange that dispatching requests to two
(nearly) identical accelerators should need so much special handling in
the driver and that there isn't some higher level management for this.
