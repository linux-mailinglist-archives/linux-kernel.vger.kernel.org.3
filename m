Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A9358AA9D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbiHEMQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiHEMQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:16:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D84E00D;
        Fri,  5 Aug 2022 05:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99F06B82499;
        Fri,  5 Aug 2022 12:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF72C433C1;
        Fri,  5 Aug 2022 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659701803;
        bh=5UHdzuuFV8kmaDUIDaJ0bB1eL8ArPmNMQE+pegWiMIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ysy0ubfxuKe5LEp1KN0RXvbDjtQJeyzn6TnW1BR/mtr+HtGBn4m9B05OfRaJ5vbIk
         v94GfnQ4dzvKq5N2PPeHvJiyxbuULAdICCJboOrftXAVYtYKrtvntWSgTel4TcmTRg
         xzKZt+GIQ6ND1YrkiG3jdRzoIX9vcXiMFD1wVN+9vz3fB8wVzwAJjk+r/bN79TC4qR
         /6WVmNst9d2bIluPu0KUCKByMNzsdPiFFaly7e7bFpFSXHlWkWkxWRtLsjpT3UJA6c
         H7VdZIdFRWnZZVoq3c1XeLeR+7Zc5MvKAAJt8715vHKwqtTng6q5phkZ7ZmB9LR5xY
         G+WP8eXW3QdcQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oJwGJ-0002kM-KT; Fri, 05 Aug 2022 14:17:07 +0200
Date:   Fri, 5 Aug 2022 14:17:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] arm64: dts: qcom: sc8280xp: HID wakeup sources and
 alt. touchpad
Message-ID: <Yu0KQyGaa4vHclDR@hovoldconsulting.com>
References: <20220805092317.4985-1-johan+linaro@kernel.org>
 <03f115b0-74ae-7793-5248-61df76ab184b@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f115b0-74ae-7793-5248-61df76ab184b@somainline.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 01:02:14PM +0200, Konrad Dybcio wrote:
> On 5.08.2022 11:23, Johan Hovold wrote:

> > Included is also support for the alternate (second-source) touchpad
> > found on some X13s laptops. Note that the node is disabled for now as
> > ideally the boot firmware should be determining which touchpad is
> > actually populated.

> Interesting, what bootloader is used on these? Are you chainloading
> something on top of Qualcomm's XBL UEFI?

We're using GRUB currently. Not sure how we'd go about implementing
this, and perhaps we'll just end up enabling both in DT instead
eventually.

> > With some additional fixes it is possible to have both nodes enabled and
> > letting Linux do the probing, but let's wait for a conclusion to the
> > discussion about whether that is desirable before enabling them both:
> > 
> > 	https://lore.kernel.org/all/YuJXMHoT4ijUxnRb@hovoldconsulting.com

Johan
