Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62B353899B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242956AbiEaB0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiEaB0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:26:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA312635;
        Mon, 30 May 2022 18:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Ds+KfoJMXHXnqY00VfiyAi1F5QPiRuohuFJ4n9H5i2w=; b=mcOypx+WSjjm/dQAXwvNYSetYO
        kGukONNYdUur1IwENJjJ9hprw2tJNq0E4Hu47nK0+d1MG4mhypGuusYsh2BYEfXZvbyOgY1GGGUZB
        t7oQ1ro5cki7WknUV3VYuggAZcQOQV8K2lSZMhbLmZTgBcILw53JPhab4cX89TxmnUPiWMhALoSJ+
        y0rQ/DfVyW5F962brz7V3n9zla2TSmmml+jHrsT5izaxd3KeEGuAayGrtWGqdAUoe3+HHyBAaYHTa
        0paSg5teVBXuDvMQeNdlwsc4Y1OC/Kzvrdv8A0JE1LjWvEwnPtgNsXQ2qURTlvoMeZE54En4k037j
        TaXyG8IQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvqeX-004wHb-IK; Tue, 31 May 2022 01:26:33 +0000
Message-ID: <ecb3f627-3379-1b18-02c0-44782a2623d4@infradead.org>
Date:   Mon, 30 May 2022 18:26:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 2/6] drivers/input/joystick: sensehat: Raspberry Pi
 Sense HAT joystick driver
Content-Language: en-US
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Daniel Bauman <dbauman@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
References: <20220419205158.28088-1-cmirabil@redhat.com>
 <20220419205158.28088-3-cmirabil@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220419205158.28088-3-cmirabil@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/19/22 13:51, Charles Mirabile wrote:
> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
> index 3b23078bc7b5..505a032e2786 100644
> --- a/drivers/input/joystick/Kconfig
> +++ b/drivers/input/joystick/Kconfig
> @@ -399,4 +399,15 @@ config JOYSTICK_N64
>  	  Say Y here if you want enable support for the four
>  	  built-in controller ports on the Nintendo 64 console.
>  
> +config JOYSTICK_SENSEHAT
> +	tristate "Raspberry Pi Sense HAT joystick"
> +	depends on INPUT && I2C
> +	select MFD_SIMPLE_MFD_I2C

Looks like this also needs
	depends on HAS_IOMEM

since everything in drivers/mfd/Kconfig depends on HAS_IOMEM and
since this 'select' causes a kconfig warning when HAS_IOMEM is not set:

WARNING: unmet direct dependencies detected for MFD_SIMPLE_MFD_I2C
  Depends on [n]: HAS_IOMEM [=n] && I2C [=y]
  Selected by [y]:
  - JOYSTICK_SENSEHAT [=y] && INPUT_JOYSTICK [=y] && INPUT [=y] && I2C [=y]


> +	help
> +	  Say Y here if you want to enable the driver for the
> +	  the Raspberry Pi Sense HAT.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sensehat_joystick.
> +
>  endif

Thanks.
