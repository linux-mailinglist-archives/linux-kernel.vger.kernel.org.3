Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0975528812
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245005AbiEPPIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbiEPPH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:07:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAE73B3DA
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:07:59 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nqcK8-0004pp-1e; Mon, 16 May 2022 17:07:52 +0200
Message-ID: <c3bd0397-d0e3-6b98-512c-9cbb01759673@pengutronix.de>
Date:   Mon, 16 May 2022 17:07:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 02/17] Revert "ARM: dts: imx6qdl-apalis: Avoid
 underscore in node name"
Content-Language: en-US
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Max Krummenacher <max.oss.09@gmail.com>,
        max.krummenacher@toradex.com, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220516115846.58328-1-max.oss.09@gmail.com>
 <20220516115846.58328-3-max.oss.09@gmail.com>
 <86815346-209e-304e-3565-b4160afa48e8@pengutronix.de>
 <20220516145354.GA121079@francesco-nb.int.toradex.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220516145354.GA121079@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Francesco,

On 16.05.22 16:53, Francesco Dolcini wrote:
> On Mon, May 16, 2022 at 02:49:12PM +0200, Ahmad Fatoum wrote:
>> On 16.05.22 13:58, Max Krummenacher wrote:
>>> From: Max Krummenacher <max.krummenacher@toradex.com>
>>>
>>> The STMPE MFD device binding requires the child node to have a fixed
>>> name, i.e. with '_', not '-'. Otherwise the stmpe_adc, stmpe_touchscreen
>>> drivers will not be probed.
>>
>> IMO, the Linux driver should be fixed and the requirement to use a fixed
>> node name be dropped from the binding. The driver itself already probes
>> by compatible, the node name seems only to be used by the MFD driver to
>> detect which functions to enable. It could do the same by checking for
>> compatibles. Otherwise you invite a game of cat and mouse, where in
>> future, this is changed back again reintroducing the regression..
> 
> How would you handle in general such kind of change? Would you keep the
> driver probing for both the old name with the `_` and the compatible or
> you just break the compatibility?

The Binding requires child nodes to have both a specific node name and
compatible. So if we remove the node name restriction, we stay compliant
to the binding.

The MFD driver requires specific node names, while the MFD cell drivers
seem to be matched by compatibles. It's thus should be safe to replace
the node name readout in the MFD driver with a compatible check.

Existing device trees will continue to work. Newer device trees can use
dashes. Once the binding is converted to YAML, we could enforce a name
to get everyone aligned, but it will be just a binding checker warning,
not a breakage on update.

Cheers,
Ahmad

> 
> Francesco
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
