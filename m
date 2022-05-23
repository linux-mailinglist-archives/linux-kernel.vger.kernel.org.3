Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3745308D5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349120AbiEWFfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbiEWFfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:35:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F2E6369;
        Sun, 22 May 2022 22:35:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3781BB80EEA;
        Mon, 23 May 2022 05:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8566FC385AA;
        Mon, 23 May 2022 05:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653284098;
        bh=59aObhjNO8Z2LsPLJEv4aHcBY2sHGOp9xKD+PqwFhAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUCrrRvA88IECsXfWkp6n3zw/ONyN7raP6WiBgjISWGHfclJomg0wJU3wwXwtf7kc
         vTdzHa43QK7IblMUR2hZBk0giWK+VpVN565OPfe1eTLjWgKRfwqxtIoDl8LLby0Th2
         iPlA4qiUIUrvaUvmB/8KEi2Af1roL43YRWk7H4perfo/KvYhdiwrVo4e5qDUAXds4e
         n10sW7oFjJmrHtnTJl5rYGe6JNO2hjU95DnaZfrzd5Cr7WRq8UhMS45IH6o5J0/Zm7
         UlcaoEDxyYVzNOpmZviXOjAPg7/KC1PUjvHMPi2Jid6DmW7uZz04xI2Plr+qrZ4XNg
         v9XNcaeHGMHNw==
Date:   Mon, 23 May 2022 13:34:55 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] platform/chrome: cros_kbd_led_backlight: support
 EC PWM backend
Message-ID: <Yosc/6izBDYYKpFC@google.com>
References: <20220321085547.1162312-1-tzungbi@kernel.org>
 <20220321085547.1162312-6-tzungbi@kernel.org>
 <YobHVST2Nfn+z8n6@google.com>
 <YocewB/lLJhIAuQP@google.com>
 <YoezzzLdVfb0K7Ak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoezzzLdVfb0K7Ak@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 08:29:19AM -0700, Matthias Kaehlcke wrote:
> On Fri, May 20, 2022 at 12:53:20PM +0800, Tzung-Bi Shih wrote:
> > On Thu, May 19, 2022 at 03:40:21PM -0700, Matthias Kaehlcke wrote:
> > > On Mon, Mar 21, 2022 at 04:55:47PM +0800, Tzung-Bi Shih wrote:
> > > > +struct keyboard_led_private {
> > > 
> > > Why 'private', isn't this more a 'cros_ec_kdb_bl' or similar?
> > 
> > It is just drvdata.
> 
> The data structure represents an instance of the device, as such it
> is an important part of the driver, drvdata is just a way to attach
> it to the platform device.
> 
> > I would prefer to keep the original prefix "keyboard_led_" if you wouldn't
> > have strong opinion.
> 
> I'm fine with 'keyboard_led', but object to the 'private' part. In the
> kernel 'private' fields are typically used when a driver consists of a
> generic part and a device specific part. The driver has a 'private'
> void* field that points to a device specific data structure about which
> the generic driver is agnostic. This data structure is only used by the
> device specific implementation. That isn't the case here, so naming the
> structure anything 'private' is misleading.

The struct in the case is device specific.  I don't see a problem to name it
*private* as there are a lot of more existing examples.

$ grep -R 'struct .*_priv.* {' drivers/
drivers/pinctrl/bcm/pinctrl-bcm6358.c:struct bcm6358_priv {

$ grep -R 'struct .*_priv.* {' sound/soc/codecs/
sound/soc/codecs/rt286.c:struct rt286_priv {

I would get rid of the term "private" if it could be confusing.

> > > > +static int keyboard_led_init_ec_pwm(struct platform_device *pdev)
> > > > +{
> > > > +	struct keyboard_led_private *private = platform_get_drvdata(pdev);
> > > > +
> > > > +	private->ec = dev_get_drvdata(pdev->dev.parent);
> > > > +	if (!private->ec) {
> > > > +		dev_err(&pdev->dev, "no parent EC device\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > 
> > > The only thing this 'init' function does is assigning private->ec. Wouldn't
> > > it be clearer to do this directly in probe() from where callback is called?
> > > It could be with the condition that the device as a DT node.
> > 
> > No.  The probe() isn't aware of the device is from ACPI or OF.
> 
> But it could be:
> 
> 	if (pdev->dev.of_node)
> 		kbd_led->ec = dev_get_drvdata(pdev->dev.parent);

The 'init' callback isn't only for OF but also ACPI.  I would prefer to keep
the 'init' function and let probe() have no awareness about them.

> > > Is it actually possible that the keyboard backlight device gets instantiated
> > > if there is no EC parent?
> > 
> > It shouldn't be but just in case.
> 
> If this can only occur due to an error in common kernel frameworks then
> the check should be omitted IMO.

The check is referenced from [1].  I would prefer to keep it instead of
crashing kernel if anything went wrong.

[1]: https://elixir.bootlin.com/linux/v5.18-rc7/source/drivers/pwm/pwm-cros-ec.c#L244

> 
> > > > +static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {
> > > > +	.init = keyboard_led_init_ec_pwm_null,
> > > 
> > > Is this really needed?
> > > 
> > > keyboard_led_probe() checks if .init is assigned before invoking the callback:
> > > 
> > > 	if (drvdata->init) {
> > > 		error = drvdata->init(pdev);
> > > 
> > > The whole 'else' branch could be eliminated if .of_match_table of the driver
> > > only is assigned when CONFIG_CROS_KBD_LED_BACKLIGHT_EC_PWM is set. IMO that
> > > would preferable over creating 'stubs'.
> > 
> > CONFIG_CROS_KBD_LED_BACKLIGHT_EC_PWM and CONFIG_OF are independent.  The stubs
> > were created to avoid compile errors if CONFIG_OF=y but
> > CONFIG_CROS_KBD_LED_BACKLIGHT_EC_PWM=n.
> 
> Is there functional version of the driver that uses instantiation through the
> device tree if CONFIG_CROS_KBD_LED_BACKLIGHT_EC_PWM=n? If not .of_match_table
> should not be assigned.

CONFIG_CROS_KBD_LED_BACKLIGHT_EC_PWM and CONFIG_OF are independent.
CONFIG_CROS_KBD_LED_BACKLIGHT_EC_PWM is also designed to work with CONFIG_ACPI.
