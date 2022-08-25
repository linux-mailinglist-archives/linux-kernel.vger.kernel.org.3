Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C975A1721
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243429AbiHYQql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbiHYQqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:46:20 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E22BD08B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:44:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u15so31999160ejt.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0munu3yIWBKbqa5N9fVL9R0QjP27n/k1A2/CHCKaVlM=;
        b=GEoh2Q+dvqaEjLHYO/gFaopeSVtB8iQBQXEZF0FjASY2ZI3/bAPkz+uucE4CJVqreK
         +phexkzE+7x+nGWMK6C3tYDr0FhuxxlcF3zWwMUMB4EqnwmT2rz0zFxxcpi6W2s7Ml19
         GtWc4DXlD7VPuK4Qpcq6RkRTgTbBPXb+FOpZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0munu3yIWBKbqa5N9fVL9R0QjP27n/k1A2/CHCKaVlM=;
        b=XtsOQCx9zC5DYwDJzfkQjkS/WZO5Bn+FwWna32fEFYRV527GpCXMy+rP5o3SJAlvPX
         IuyQ0XqH0Lr+1sigoiP5tfx+GYppnyNQkwMJmtyfoWoOyuYgJ6qYPs0ZcZoyKraSU93g
         1GU7QoVnfrkCvFPv0vO7U9v4WGIcRQvh9l6N1OH72qhDASFjJfIWjmhy8YxXue2gvPHg
         Z9YBXSMHykSB2gClvQ0aBy1brb/VpPMEeJbD2GZ668jkV6TB+pNc2oJiPkjImAltUQyy
         Tp56yhzpjygzbZIHq2S2xuebY+9S5bGxoo0MqfFXz++yEBAbXi8GQIwsFB0RmAVSqrro
         /oSg==
X-Gm-Message-State: ACgBeo0g7PkmajnYTcA9TvwA5EFklD7Mm8VS27YdcbCEhO1KV0afh25u
        C4viA5nIl5NEG90uYE2UDOOzNS7T3ChJy14mMhI=
X-Google-Smtp-Source: AA6agR4OYwhcnNLNsXqm2peV+z0lu+MJGk9mPfRFeQTzN54q/CXEi6w98jx2/pYWXOG3dCkffPmTmg==
X-Received: by 2002:a17:906:58ca:b0:73d:c7d5:bb39 with SMTP id e10-20020a17090658ca00b0073dc7d5bb39mr3058405ejs.305.1661445839157;
        Thu, 25 Aug 2022 09:43:59 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id n26-20020a5099da000000b0043bbf79b3ebsm5329628edb.54.2022.08.25.09.43.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 09:43:58 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so2832519wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:43:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8b:b0:3a5:f5bf:9c5a with SMTP id
 f11-20020a05600c4e8b00b003a5f5bf9c5amr8968677wmq.85.1661445837335; Thu, 25
 Aug 2022 09:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220824142229.RFT.v2.1.I137e6bef4f6d517be7b081be926059321102fd3d@changeid>
 <20220824142229.RFT.v2.2.I6f77860e5cd98bf5c67208fa9edda4a08847c304@changeid> <20220825151427.dux3luxs6sxx5tno@halaneylaptop>
In-Reply-To: <20220825151427.dux3luxs6sxx5tno@halaneylaptop>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Aug 2022 09:43:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wf90u_DdczAeOqP8aXTO-CSei+9SGxytwS=M0LA9+w-g@mail.gmail.com>
Message-ID: <CAD=FV=Wf90u_DdczAeOqP8aXTO-CSei+9SGxytwS=M0LA9+w-g@mail.gmail.com>
Subject: Re: [RFT PATCH v2 2/2] regulator: core: Don't err if allow-set-load
 but no allowed-modes
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 25, 2022 at 8:14 AM Andrew Halaney <ahalaney@redhat.com> wrote:
>
> On Wed, Aug 24, 2022 at 02:22:57PM -0700, Douglas Anderson wrote:
> > Apparently the device trees of some boards have the property
> > "regulator-allow-set-load" for some of their regulators but then they
> > don't specify anything for "regulator-allowed-modes". That's not
> > really legit, but...
> >
> > ...before commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> > get_optimum_mode(), not set_load()") they used to get away with it, at
> > least on boards using RPMH regulators. That's because when a regulator
> > driver implements set_load() then the core doesn't look at
> > "regulator-allowed-modes" when trying to automatically adjust things
> > in response to the regulator's load. The core doesn't know what mode
> > we'll end up in, so how could it validate it?
> >
> > Said another way: before commit efb0cb50c427 ("regulator: qcom-rpmh:
> > Implement get_optimum_mode(), not set_load()") some boards _were_
> > having the regulator mode adjusted despite listing no allowed
> > modes. After commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> > get_optimum_mode(), not set_load()") these same boards were now
> > getting an error returned when trying to use their regulators, since
> > simply enabling a regulator tries to update its load and that was
> > failing.
> >
> > We don't really want to go back to the behavior from before commit
> > efb0cb50c427 ("regulator: qcom-rpmh: Implement get_optimum_mode(), not
> > set_load()"). Boards shouldn't have been changing modes if no allowed
> > modes were listed. However, the behavior after commit efb0cb50c427
> > ("regulator: qcom-rpmh: Implement get_optimum_mode(), not set_load()")
> > isn't the best because now boards can't even turn their regulators on.
> >
> > Let's choose to detect this case and return "no error" from
> > drms_uA_update(). The net-result will be _different_ behavior than we
> > had before commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> > get_optimum_mode(), not set_load()"), but this new behavior seems more
> > correct. If a board truly needed the mode switched then its device
> > tree should be updated to list the allowed modes.
> >
> > Reported-by: Andrew Halaney <ahalaney@redhat.com>
> > Fixes: efb0cb50c427 ("regulator: qcom-rpmh: Implement get_optimum_mode(), not set_load()")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Tested-by: Andrew Halaney <ahalaney@redhat.com>
>
> As you made clear in the commit message, a good number of boards will
> have a change in behavior since efb0cb50c427 ("regulator: qcom-rpmh: Implement
> get_optimum_mode(), not set_load()") and associated fixes. I agree that
> these devices are not properly described. Is there any sort of heads up we
> should give? Just looking at the Qualcomm devicetrees for aarch64, I see all
> of these are affected:
>
>     apq8016-sbc.dts
>     apq8096-db820c.dts
>     apq8096-ifc6640.dts
>     msm8916-alcatel-idol347.dts
>     msm8916-asus-z00l.dts
>     msm8916-huawei-g7.dts
>     msm8916-longcheer-l8150.dts
>     msm8916-longcheer-l8910.dts
>     msm8916-samsung-a2015-common.dtsi
>     msm8916-samsung-j5.dts
>     msm8916-samsung-serranove.dts
>     msm8916-wingtech-wt88047.dts
>     msm8992-lg-bullhead.dtsi
>     msm8992-xiaomi-libra.dts
>     msm8994-msft-lumia-octagon.dtsi
>     msm8994-sony-xperia-kitakami.dtsi
>     msm8996-sony-xperia-tone.dtsi
>     msm8996-xiaomi-common.dtsi
>     msm8998-clamshell.dtsi
>     msm8998-fxtec-pro1.dts
>     msm8998-mtp.dts
>     msm8998-oneplus-common.dtsi
>     msm8998-sony-xperia-yoshino.dtsi
>     sa8155p-adp.dts
>     sa8xxxp-auto-adp.dtsi
>     sc8280xp-crd.dts
>     sc8280xp-lenovo-thinkpad-x13s.dts
>     sda660-inforce-ifc6560.dts
>     sdm630-sony-xperia-nile.dtsi
>     sdm660-xiaomi-lavender.dts
>     sm8150-sony-xperia-kumano.dtsi
>     sm8250-sony-xperia-edo.dtsi
>     sm8350-hdk.dts

True, it would be a good idea to send out fixes. OK, so let's see. We
can probably get fairly close to seeing who is affected with these
greps:

rpmh_users=$(git grep -l -i rpmh -- arch/arm*/boot/dts/qcom)
set_modes=$(grep -l regulator-allow-set-load ${rpmh_users})
but_no_allowed_modes=$(grep -l -v regulator-allowed-modes ${set_modes})

That actually gives a (much)shorter list than yours. Why?

Ah. Your list includes not just RPMH users but also RPM users. RPM
users _won't_ be affected. In RPM regulators we don't actually track
the modes in the kernel--we actually pass the load directly to the
remote processor and it handles translating that into loads. RPM
regulators don't even have a way to directly set the mode.

...so we only need to fix a small number (7) boards.

Posting up patches now. OK, the cover letter should show up shortly at:

https://lore.kernel.org/r/20220825164205.4060647-1-dianders@chromium.org

-Doug
