Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02435A155B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242481AbiHYPOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiHYPOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:14:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D987B69CE
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661440475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A4a7fLYze5sKk6BVAHJQd8XOo1ZuhlaCsjzUhFa01vY=;
        b=Xy2gMjxpxR9C9MleukhqE+6hhvFM131dbhVnJt+b9wElfz4zpwK3U9aQyZgspdxNkhT5cG
        Du2ADp68GEMhJ+xxMkZAtVUC1rDisFDH39JIMf9s0lrhDEed5MN+mBWdrafv5eIg0dDqIJ
        peu6TFUz3vMjCzeFw0o9a2tka4aEKI4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-130-smFjDCbzNMuNrsEmvmwzUQ-1; Thu, 25 Aug 2022 11:14:34 -0400
X-MC-Unique: smFjDCbzNMuNrsEmvmwzUQ-1
Received: by mail-qv1-f71.google.com with SMTP id lx4-20020a0562145f0400b00496ecf45ac4so7361870qvb.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=A4a7fLYze5sKk6BVAHJQd8XOo1ZuhlaCsjzUhFa01vY=;
        b=D7S+XSRIO+myfSzgfqotq9KrAULXpIvlPq1gZCPO43jw3xxSTGD+kv5u8B5qOVwdsK
         6At4EsJzqATueY7X0tpnaBu5Qf+kYGqrAHqGgrFxMxveg4f58k/eeVsJ84X+Gg7M8rhy
         efI+TgHXn91bBL+CKK+T+YacjYTpzf0FSrg0V7LlU6gJeqr+/ySotxZiVZquVzQstxxU
         xgE8WHGsQR9r2zyxWIUeho+g2GSudo9T5eBzCYaTrUujnxpYIrzZcvRifUUUAkoofOZ1
         aBBv4ShdlcgvK8xGusdvbr3Fwy1ZOa37Ppwxdu1o5xZ/89nzt8nUmPm0c1voCNmlcJh+
         M+9A==
X-Gm-Message-State: ACgBeo1U1KJIhGjGnCYhZoklCOf+rV0cjwNa90UdbasEet9P6+7BDbQ4
        wbPct6S0VrprxIAVloQFD38/XnepUkJCVm1z5NPt+WlHi2k7s0W+70WxFkmoGWlKumkwsTwMd1M
        9G6Xpn0HIU5ut25BTkjXWKsFP
X-Received: by 2002:a05:620a:2545:b0:6b6:6773:f278 with SMTP id s5-20020a05620a254500b006b66773f278mr3468575qko.390.1661440473517;
        Thu, 25 Aug 2022 08:14:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7gTT6fW66+6K1gqUKE1WfO+Dq0vZC008fh2BG5DQ6CZnl2TLSHyUyGLEQi8p9+5i+W2hM9qQ==
X-Received: by 2002:a05:620a:2545:b0:6b6:6773:f278 with SMTP id s5-20020a05620a254500b006b66773f278mr3468520qko.390.1661440472732;
        Thu, 25 Aug 2022 08:14:32 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::48])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a2a0400b006baf3ffba23sm18041390qkp.38.2022.08.25.08.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 08:14:31 -0700 (PDT)
Date:   Thu, 25 Aug 2022 10:14:27 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH v2 2/2] regulator: core: Don't err if allow-set-load
 but no allowed-modes
Message-ID: <20220825151427.dux3luxs6sxx5tno@halaneylaptop>
References: <20220824142229.RFT.v2.1.I137e6bef4f6d517be7b081be926059321102fd3d@changeid>
 <20220824142229.RFT.v2.2.I6f77860e5cd98bf5c67208fa9edda4a08847c304@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824142229.RFT.v2.2.I6f77860e5cd98bf5c67208fa9edda4a08847c304@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 02:22:57PM -0700, Douglas Anderson wrote:
> Apparently the device trees of some boards have the property
> "regulator-allow-set-load" for some of their regulators but then they
> don't specify anything for "regulator-allowed-modes". That's not
> really legit, but...
>
> ...before commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> get_optimum_mode(), not set_load()") they used to get away with it, at
> least on boards using RPMH regulators. That's because when a regulator
> driver implements set_load() then the core doesn't look at
> "regulator-allowed-modes" when trying to automatically adjust things
> in response to the regulator's load. The core doesn't know what mode
> we'll end up in, so how could it validate it?
>
> Said another way: before commit efb0cb50c427 ("regulator: qcom-rpmh:
> Implement get_optimum_mode(), not set_load()") some boards _were_
> having the regulator mode adjusted despite listing no allowed
> modes. After commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> get_optimum_mode(), not set_load()") these same boards were now
> getting an error returned when trying to use their regulators, since
> simply enabling a regulator tries to update its load and that was
> failing.
>
> We don't really want to go back to the behavior from before commit
> efb0cb50c427 ("regulator: qcom-rpmh: Implement get_optimum_mode(), not
> set_load()"). Boards shouldn't have been changing modes if no allowed
> modes were listed. However, the behavior after commit efb0cb50c427
> ("regulator: qcom-rpmh: Implement get_optimum_mode(), not set_load()")
> isn't the best because now boards can't even turn their regulators on.
>
> Let's choose to detect this case and return "no error" from
> drms_uA_update(). The net-result will be _different_ behavior than we
> had before commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> get_optimum_mode(), not set_load()"), but this new behavior seems more
> correct. If a board truly needed the mode switched then its device
> tree should be updated to list the allowed modes.
>
> Reported-by: Andrew Halaney <ahalaney@redhat.com>
> Fixes: efb0cb50c427 ("regulator: qcom-rpmh: Implement get_optimum_mode(), not set_load()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Tested-by: Andrew Halaney <ahalaney@redhat.com>

As you made clear in the commit message, a good number of boards will
have a change in behavior since efb0cb50c427 ("regulator: qcom-rpmh: Implement
get_optimum_mode(), not set_load()") and associated fixes. I agree that
these devices are not properly described. Is there any sort of heads up we
should give? Just looking at the Qualcomm devicetrees for aarch64, I see all
of these are affected:

    apq8016-sbc.dts
    apq8096-db820c.dts
    apq8096-ifc6640.dts
    msm8916-alcatel-idol347.dts
    msm8916-asus-z00l.dts
    msm8916-huawei-g7.dts
    msm8916-longcheer-l8150.dts
    msm8916-longcheer-l8910.dts
    msm8916-samsung-a2015-common.dtsi
    msm8916-samsung-j5.dts
    msm8916-samsung-serranove.dts
    msm8916-wingtech-wt88047.dts
    msm8992-lg-bullhead.dtsi
    msm8992-xiaomi-libra.dts
    msm8994-msft-lumia-octagon.dtsi
    msm8994-sony-xperia-kitakami.dtsi
    msm8996-sony-xperia-tone.dtsi
    msm8996-xiaomi-common.dtsi
    msm8998-clamshell.dtsi
    msm8998-fxtec-pro1.dts
    msm8998-mtp.dts
    msm8998-oneplus-common.dtsi
    msm8998-sony-xperia-yoshino.dtsi
    sa8155p-adp.dts
    sa8xxxp-auto-adp.dtsi
    sc8280xp-crd.dts
    sc8280xp-lenovo-thinkpad-x13s.dts
    sda660-inforce-ifc6560.dts
    sdm630-sony-xperia-nile.dtsi
    sdm660-xiaomi-lavender.dts
    sm8150-sony-xperia-kumano.dtsi
    sm8250-sony-xperia-edo.dtsi
    sm8350-hdk.dts

Thanks,
Andrew

