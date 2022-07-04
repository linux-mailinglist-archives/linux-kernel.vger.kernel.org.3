Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67D556555E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbiGDM3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiGDM2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:28:52 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A37E271D;
        Mon,  4 Jul 2022 05:28:24 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0C45022175;
        Mon,  4 Jul 2022 14:28:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656937702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zR+tJ9UwOFekRbH/nZ7x+CvhxJgh39NwZ7//BFWpJE8=;
        b=PEtOjuv2nF248emeqfsIGMi+zFyBul4tZlMLfP3vqcZNWEJXluA84YSZSHLjzkX7lU1g3n
        JExq0nDqX9VKgXYuzU/ApwoPGS3uxgoH4Z9A/wV2m1jG40Mt7UcTsjKks8j0SZBfPH0fmy
        QE+i3o/hjMnv5lr34lDLoPuy2urbXig=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Jul 2022 14:28:21 +0200
From:   Michael Walle <michael@walle.cc>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] gpio: regmap: Support registers with more than one
 bit per GPIO
In-Reply-To: <20220703111057.23246-2-aidanmacdonald.0x0@gmail.com>
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com>
 <20220703111057.23246-2-aidanmacdonald.0x0@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <4c9092d20a35ef3fd6a1723e07adad79@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-07-03 13:10, schrieb Aidan MacDonald:
> Some devices use a multi-bit register field to change the GPIO
> input/output direction. Add the ->reg_field_xlate() callback to
> support such devices in gpio-regmap.
> 
> ->reg_field_xlate() builds on ->reg_mask_xlate() by allowing the
> driver to return a mask and values to describe a register field.
> gpio-regmap will use the mask to isolate the field and compare or
> update it using the values to implement GPIO level and direction
> get and set ops.

Thanks for working on this. Here are my thoughts on how to improve
it:
  - I'm wary on the value translation of the set and get, you
    don't need that at the moment, correct? I'd concentrate on
    the direction for now.
  - I'd add a xlate_direction(), see below for an example
  - because we can then handle the value too, we don't need the
    invert handling in the {set,get}_direction. drop it there
    and handle it in a simple_xlat. In gpio_regmap,
    store "reg_dir_base" and "invert_direction", derived from
    config->reg_dir_in_base and config->reg_dir_out_base.

static int gpio_regmap_simple_xlat_direction(struct gpio_regmap *gpio
                                              unsigend int base,
                                              unsigned int offset,
                                              unsigned int *dir_out,
                                              unsigned int *dir_in)
{
     unsigned int line = offset % gpio->ngpio_per_reg;
     unsigned int mask = BIT(line);

     if (!gpio->invert_direction) {
         *dir_out = mask;
         *dir_in = 0;
     } else {
         *dir_out = 0;
         *dir_in = mask;
     }

     return 0;
}

And in the {set,get}_direction() you can then check both
values and convert it from or to GPIO_LINE_DIRECTION_{OUT,IN}.

Thoughts?

-michael
