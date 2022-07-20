Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900FC57B851
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiGTOTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240800AbiGTOTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:19:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5014B4A0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:19:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n12so13494882wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=p8rOXBXAqTpS6LdE3L0fRHyfdqOg9ZbjmkVTT9tGMWw=;
        b=d4bbDHUQ2rBWarQ+0J1tXvnF2xaIa1au5YpleFcaycUd31nqCGRvq2+AmvnPYHniYv
         w8E0a+ugnLBxRYfcEv3euDpLm5UR5rUE6MTVibSCXWNf7DHU/fkgNYYudkYnBRozMk0b
         MXXUFe+RNk0MnSYmtKMaAJ/TjPD0x+plvEAeJNPTXCtkIur8T+M/+ZJou8IGbZAEpXwL
         26me4PvZPpU1wsw91N2yakdCQ6BD4G9Ki+HSRhS+FXKoa0T6uf1Z6dwAZ7o8tdPcS0ME
         bAWen/5r5lEMMYGE+vMsff+EZHJKtFfxmw6jKsqtqWhtua9F2MPZoKfl00cHk/0AAsId
         rnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=p8rOXBXAqTpS6LdE3L0fRHyfdqOg9ZbjmkVTT9tGMWw=;
        b=l0dy5pcX2wHJ+r6WN158rhOAVRwmoMeXm7JVzoYqyPYRsURLtUsn5NCtenkG8Dx1ff
         EYn3ITRan7oDdco7k+wG9Vsufvf/nXyEuFcJaF0bQquo9Jx8cN3EEZf6WvsS2bdXNz6k
         Px5n4eO4PNpBk8S/c3lOy9lZu3tA7VdxF30KQXMerbt+J7c02LO/tQs+iGi2j/DFgkAW
         md6OEpgaKNSrdOWmya8HQSa82Q29vfP7BQKBKq1OTb8lHmcr5gyuSZzc9GR+gKlBPFnf
         qlWrdV02eZUg2ZCEucN8KL2wY0eyiGZiLokhHMNYrEYSoP4s8Qtsara90iHPEyOfmgIy
         35Lw==
X-Gm-Message-State: AJIora8UwzSdDtMp2YnTCQgaC1vQpiokaY8cY7xP2MorXCPalKNRIMm0
        ZT3Ac+4NlRFvbeWSQ8Rx4CsrAg==
X-Google-Smtp-Source: AGRyM1vfd/AlkTBCkW/ehFWCDJ8txqZSJ32LBYwBoD2v9GjFNv8uyGg6xnaibGoIVJ5ik8w08YzLIQ==
X-Received: by 2002:adf:e6c9:0:b0:21d:7f65:f1e7 with SMTP id y9-20020adfe6c9000000b0021d7f65f1e7mr29955063wrm.151.1658326754737;
        Wed, 20 Jul 2022 07:19:14 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id bv3-20020a0560001f0300b0021e3e73dec6sm4875210wrb.72.2022.07.20.07.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:19:14 -0700 (PDT)
Date:   Wed, 20 Jul 2022 15:19:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 4/5] mfd: sm5703: Add support for SM5703 MFD
Message-ID: <YtgO4J8BBqRnKPKs@google.com>
References: <20220423085319.483524-1-markuss.broks@gmail.com>
 <20220423085319.483524-5-markuss.broks@gmail.com>
 <Yqj+aUNLC00Tcu49@google.com>
 <5498bf71-66a5-957e-ed3d-13e68b982562@gmail.com>
 <YtUXFTx1+vSrXx70@google.com>
 <295e1809-f6f2-ca31-5c36-be133ffdc93b@gmail.com>
 <Yte7Tgq3w8fowTYA@google.com>
 <4be15cff-b0af-8671-57aa-6567c0206715@gmail.com>
 <YtgDSelfobu/a/be@google.com>
 <c14698f3-8f70-4cd7-1653-ed51630806c3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c14698f3-8f70-4cd7-1653-ed51630806c3@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022, Markuss Broks wrote:

> On 7/20/22 16:29, Lee Jones wrote:
> > On Wed, 20 Jul 2022, Markuss Broks wrote:
> > > > > > > > > +static const struct mfd_cell sm5703_devs[] = {
> > > > > > > > > +	{ .name = "sm5703-regulator", },
> > > > > > > > > +};
> > > > > > > > Where are the rest of the child drivers?
> > > > > > > Should those devices still be present even though there's no driver for them
> > > > > > > (yet) ? I have a WIP version of driver for almost every function, but I
> > > > > > > currently lack time to get them done.
> > > > > > Without them the driver-set is useless, no?
> > > > > > 
> > > > > > We try to refrain from applying dead code.
> > > > > > 
> > > > > > A lot of it has a tendency to stay that way.
> > > > > Well, in my opinion, having just the regulator driver is already useful
> > > > > enough: my board (Samsung Galaxy J5 (2015) ) uses one of LDO outputs for
> > > > > powering the touchscreen. Touchscreen is kind of vital functionality for a
> > > > > phone so I decided to upstream parts that are necessary for it first and
> > > > > finish up other stuff later. It's not the only board that uses SM5703's
> > > > > regulators for supplying all different kinds of hardware, either.
> > > > Upstreaming functionality which is useful on its own is fine, but that
> > > > doesn't tick all of the boxes to justify an MFD.  This is a lot of
> > > > code which is hard to justify if it only registers a Regulator driver.
> > > Do you think I should hold on this series until I have other things done?
> > > Alternatively, I could make the regulator driver standalone, dedicated, but
> > > then when I'd add other functionality I'd have to redo it and add the MFD
> > > driver back, that I believe would be quite annoying from maintainers' and
> > > sanity perspective. The other functions left on the main control I2C are
> > > also not really "vital" to device's functionality (Flash LED and charger),
> > > so the regulator function makes the most sense to be available first, which
> > > was my motivation behind upstreaming that first.

Can you configure your mailer to stop removing the space between
messages please?

> > What's the reason for this being an MFD in the first place?

> Well, the "main" I2C interface is shared between three functions:
> regulators, Flash LED and charger. I call this one the "main" one because
> the device is controlled with it: you can select internal clock rate, enable
> or disable the PMIC and do other things that more of apply to the whole
> PMIC, not just the separate functions (as is the case with fuel gauge and
> MUIC I2C) . That's the reason for this being an MFD: those three functions
> share one I2C interface. While they might not be implemented at the moment,
> this places a foundation for adding future support.

Okay, so the functions cannot be controlled separately?  That's fine.

For acceptance into MFD, you need to enable more than one function.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
