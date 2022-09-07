Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDF65AFC5A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIGG2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGG2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:28:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24078C00E;
        Tue,  6 Sep 2022 23:28:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E3CEB81B6E;
        Wed,  7 Sep 2022 06:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C147C433C1;
        Wed,  7 Sep 2022 06:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662532088;
        bh=KWq6t8sirh/Dx0hC8hVA1xMEpvcF9InY07/Sx6GZjVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dk+troH/mm8ytfmLXVq5/BK3riMgMYefZY+iPzzRvWAiOMuH6Mnumq3C+YFVDi/CN
         buYa8yU5PV7Ucx4sYMd9eE1KA/s8CEVqxWB+3DH1OtBHXn5uI/DFbDI46pvIK32+DW
         sdVV4JussUV6VrdQgwLzO7mDSxuTh0pSW+O0VBUbfsgC7RU7rSd3QEKfiWc78bkdwE
         CvBG7ICYq9+eIqZf2S5LQjSNH0/fsw7SWyy3dAgEmjUXul3NIXS+Lo3eRGrr6qqX3y
         bChq43AknonEka1tGQ6Jvi5G+q2FokK9HmVVhDu6So/hrsXkKoJCTg6jw5QgmkhFzx
         TPFFo8m3oBuyg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oVoXj-00074e-B3; Wed, 07 Sep 2022 08:28:11 +0200
Date:   Wed, 7 Sep 2022 08:28:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dianders@chromium.org
Subject: Re: [PATCH v2] regulator: dt-bindings: qcom,rpmh: Indicate
 regulator-allow-set-load dependencies
Message-ID: <Yxg5+9lkHnNsI30j@hovoldconsulting.com>
References: <20220906201959.69920-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906201959.69920-1-ahalaney@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:19:59PM -0500, Andrew Halaney wrote:
> For RPMH regulators it doesn't make sense to indicate
> regulator-allow-set-load without saying what modes you can switch to,
> so be sure to indicate a dependency on regulator-allowed-modes.
> 
> With this in place devicetree validation can catch issues like this:
> 
>     /mnt/extrassd/git/linux-next/arch/arm64/boot/dts/qcom/sm8350-hdk.dtb: pm8350-rpmh-regulators: ldo5: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
>             From schema: /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> 
> Suggested-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Looks good to me.

Reviewed-by: Johan Hovold <johan+kernel@kernel.org>

> ---
> 
> v1: https://lore.kernel.org/linux-arm-msm/20220902185148.635292-1-ahalaney@redhat.com/
> Changes since v1:
>   - Dropped first two patches in the series as they were user error
>     (thanks Krzysztof for highlighting this!)
>   - No change in the remaining patch
> 
> Krzysztof also asked if this patch in particular should apply to other
> regulators, which I think it should for those regulator's who implement
> set_mode(). Unfortunately I don't know of a good way to get that
> information in order to apply it at a broader scope for devicetree
> regulator validation. At least with this in place RPMH users can get
> better coverage... if someone has suggestions for how to broaden the
> scope I'm all ears!

I guess the commit message could have tried to capture that is feature
of the hardware (as Linux implementation details shouldn't impact the
binding). And apparently there are regulators that do not need this
(e.g. RPM).

Johan
