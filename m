Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAC35504FE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 15:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbiFRNI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 09:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbiFRNIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 09:08:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E6E167E5;
        Sat, 18 Jun 2022 06:08:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6341C60B63;
        Sat, 18 Jun 2022 13:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71232C3411A;
        Sat, 18 Jun 2022 13:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655557721;
        bh=/QwGfDf6kYui15a8Igc4mfWEBIwRmra1YgsyS0TRMaU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ESMxcyIMqq4A+Uu99HzmhdwFPJzv+wlvWXV3vwLR5k2X+TQSVG+TXYnPACg/7AnKr
         +u4lpf1/vaOWsWOFn2yysuXeEAX83zTHAKAtwxKizWmgP6IdjlKYhqR8mGJAH4eKjV
         K70truEf0ys2TlQDDtiVXFiUtgh1vGK3cDjJV7NLkREc0arJ/4K+0GSXohWbzJxCc0
         NgyKr5jHGM3o4lSCvWrBazlEi/4BxIiLxHJjP5whbneiTpLHu7KTVO2oUEcRYoDa/o
         sPP/LH8tu2Ltsv0CKzs0uAEw87R8UGOq2YzytTymsI8LlJXnwwaAreLihbILtSo14i
         5vWhdGytdeV9A==
Date:   Sat, 18 Jun 2022 14:17:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v14 00/10] iio: adc: introduce Qualcomm SPMI Round Robin
 ADC
Message-ID: <20220618141757.625f86c4@jic23-huawei>
In-Reply-To: <20220618140913.49fd1dc2@jic23-huawei>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
        <20220618140913.49fd1dc2@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jun 2022 14:09:13 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 29 Apr 2022 23:08:55 +0100
> Caleb Connolly <caleb.connolly@linaro.org> wrote:
> 
> > The RRADC is responsible for reading data about the current and
> > voltage from the USB or DC in jacks, it can also read the battery
> > ID (resistence) and some temperatures. It is found on the PMI8998 and
> > PM660 Qualcomm PMICs.
> > 
> > The RRADC has to calibrate some ADC values based on which chip fab
> > the PMIC was produced in, to facilitate this the patches
> > ("mfd: qcom-spmi-pmic: expose the PMIC revid information to clients")
> > and ("mfd: qcom-spmi-pmic: read fab id on supported PMICs")
> > expose the PMIC revision information and fab_id as a struct and register
> > them as driver data in the Qualcomm SPMI PMIC driver so that it can be
> > read by the RRADC.
> > 
> > The first 3 patches add support for looking up an SPMI device from a
> > struct device_node, as well as introducing support for looking up the
> > base USID of a Qcom PMIC, see patch comments for more details. These
> > Address Bjorns comments on v2.  
> 
> Hi Caleb / All
> 
> Rather than waste time going for a v15 for the 3 minor issues in reviews
> I've just fixed them up whilst applying.
> 
> As spmi or mfd maintainers may want an immutable branch I've
> just pushed one out at
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git immutable-qcom-spmi-rradc
> that has the first 5 patches. I assume the dts changes will go via qcom -> arm-soc
> as normal.
> 
> 0-day should run on that branch shortly but I'll be optimistic and pull it
> into my testing branch in the meantime (mostly so I don't forget about it and
> can mark it applied in patchwork :)

Gah.  Merge into IIO doesn't build because of dropping of.h from includes
in iio.h.  This driver should directly include property.h directly.

New 'immutable' branch with same name pushed out.  Guessing no one picked
it up in the minute or so previous version was available for!

I'd advise that Lee / Stephen don't merge this for a few days at least so
any other issues have become visible and I can fix them up without making
for complex history.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> 
> > 
> > Changes since v13:
> >  * Address Lee Jones' feedback on the SPMI patches.
> >  * Pick up Jami's patch to enable the RRADC on the OnePlus 5
> > 
> > Changes since v12:
> >  * Apply Krzysztof's suggestions to rradc DT binding docs.
> > 
> > Changes since v11:
> >  * Remove debug logging which was left in ("mfd: qcom-spmi-pmic: expose the PMIC revid information to clients")
> >  * Picked up Dmitry's Tested-by and Reviewed-by tags.
> > 
> > Changes since v10:
> >  * Don't inline spmi_device_from_of()
> > 
> > Changes since v9:
> >  * Add back missing copyright, this driver is originally derived from
> >    downstream (Thanks Manivannan).
> > 
> > Changes since v8:
> >  * Drop Reported-by for the bugfix on previous revision reported by LKP
> >  * Apply Jonathans suggestions
> >  * Rework patch 2 ("expose the PMIC revid information to clients") to
> >    handle PMICs with a single USID (thanks Dmitry)
> > 
> > Changes since v7:
> >  * Addressed Jonathans comments
> >  * Fixed bug reported by LKP
> > 
> > Changes since v6:
> >  * Fix printf format warning in rradc
> > 
> > Changes since v5:
> >  * Add missing EXPORT_SYMBOL_GPL() to
> >    ("spmi: add a helper to look up an SPMI device from a device node")
> > 
> > Changes since v4:
> >  * Addressed Jonathan's comments on v4
> >  * Reworked the qcom-spmi-pmic patches to properly walk the devicetree
> >    to find the base USID. I've tested this on SDM845 which has two PMICs
> >    (pm8998 and pmi8998) and I'm able to look up the PMIC revid from all
> >    4 USIDs.
> > 
> > Changes since v3:
> >  * Split PMIC patch in two, rework to support function drivers on a
> >    sibling USID
> >  * Completely rework RRADC driver to make use of the modern IIO
> >    framework. This required re-arranging a lot of the equations and
> >    results in some lost precision, where relevant I've left comments to
> >    explain this. I don't think any of it is significant enough to
> >    justify doing post-processing in driver.
> >    Thanks a lot Jonathan and John Stultz for helping me out with
> >    this
> > 
> > Changes since v2:
> >  * Add missing include (thanks kernel test robot :D)
> >  * Rework some confusing function return values, specifically
> >    rradc_read_status_in_cont_mode and rradc_prepare_batt_id_conversion
> >    both of which didn't correctly handle "ret". This also bought up an
> >    issue as the previous implementation didn't actually wait for the
> >    channel to be ready. It doesn't seem like that's strictly necessary
> >    (same data is reported if I wait for the status to be good or not)
> >    but I've included it anyway for good measure.
> > 
> > Changes since v1:
> >  * Rework the RRADC driver based on Jonathan's feedback
> >  * Pick up Rob's reviewed by for the dt-binding patch.
> >  ---
> > Caleb Connolly (9):
> >   spmi: add a helper to look up an SPMI device from a device node
> >   mfd: qcom-spmi-pmic: expose the PMIC revid information to clients
> >   mfd: qcom-spmi-pmic: read fab id on supported PMICs
> >   dt-bindings: iio: adc: document qcom-spmi-rradc
> >   iio: adc: qcom-spmi-rradc: introduce round robin adc
> >   arm64: dts: qcom: pmi8998: add rradc node
> >   arm64: dts: qcom: sdm845-oneplus: enable rradc
> >   arm64: dts: qcom: sdm845-db845c: enable rradc
> >   arm64: dts: qcom: sdm845-xiaomi-beryllium: enable rradc
> > 
> > Jami Kettunen (1):
> >   arm64: dts: qcom: msm8998-oneplus-common: enable RRADC
> > 
> >  .../bindings/iio/adc/qcom,spmi-rradc.yaml     |   51 +
> >  .../boot/dts/qcom/msm8998-oneplus-common.dtsi |    4 +
> >  arch/arm64/boot/dts/qcom/pmi8998.dtsi         |    8 +
> >  arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |    4 +
> >  .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |    4 +
> >  .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |    4 +
> >  drivers/iio/adc/Kconfig                       |   12 +
> >  drivers/iio/adc/Makefile                      |    1 +
> >  drivers/iio/adc/qcom-spmi-rradc.c             | 1021 +++++++++++++++++
> >  drivers/mfd/qcom-spmi-pmic.c                  |  272 +++--
> >  drivers/spmi/spmi.c                           |   17 +
> >  include/linux/spmi.h                          |    3 +
> >  include/soc/qcom/qcom-spmi-pmic.h             |   61 +
> >  13 files changed, 1372 insertions(+), 90 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
> >  create mode 100644 drivers/iio/adc/qcom-spmi-rradc.c
> >  create mode 100644 include/soc/qcom/qcom-spmi-pmic.h
> >   
> 

