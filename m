Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A3C4EA445
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 02:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiC2As0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 20:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiC2AsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 20:48:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115574DF4B;
        Mon, 28 Mar 2022 17:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Z090xxy0mS/RL1+QQaoOIVpjulUsnQ5bu8HpBoON1x0=; b=WyQfeMzQNH5kroUtmpjRLwoU4e
        EZMOp9aBVZwTh42qSYikgp5m0ozyZg8F+ZepQZA1Aiih87kXu3S4gQ5jGswoZstHpObGgZ+pzmGSp
        7T39clh+C6hEl22cxvNCdJQzvUS2H6TBK5E9dXLCQKbQ75I4K2QWKw5+zCZGhY+R9wwpKQGh8fT5U
        MDZQuB3eym30HmJOqDozfxH/sQ9uDeOFFDY8svR9psHoPiiseMlooZ2tcjgN30iU9QzIh3eqhWOuA
        R4wOskHPXvWJvv//64UxkQDaUo8cV9R8iAa5bdwfeKSPeKYhVQ65d3S6XI/gTcxX1e6h8fYFoDVG8
        7PYNdlOw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZ00H-00HPl2-OX; Tue, 29 Mar 2022 00:46:34 +0000
Message-ID: <f4932722-c577-f03c-8296-c49a8dd8b14f@infradead.org>
Date:   Mon, 28 Mar 2022 17:46:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] HID: Add driver for Google Hangouts Meet Speakermic
Content-Language: en-US
To:     Pablo Ceballos <pceballos@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
References: <20220328185704.1.I7a855580ce9f43fc2f598bdccf088c978d4af822@changeid>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220328185704.1.I7a855580ce9f43fc2f598bdccf088c978d4af822@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 3/28/22 16:03, Pablo Ceballos wrote:
> This driver works around a problem with the HID usage sent by this
> device for the mute button. It prevents key events from being generated
> for that HID usage since they would be incorrect.
> 
> Signed-off-by: Pablo Ceballos <pceballos@google.com>
> ---
> 
>  drivers/hid/Kconfig            | 12 ++++++++
>  drivers/hid/Makefile           |  1 +
>  drivers/hid/hid-google-atrus.c | 55 ++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-ids.h          |  1 +
>  4 files changed, 69 insertions(+)
>  create mode 100644 drivers/hid/hid-google-atrus.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index f5544157576c..dc6ae9970054 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -403,6 +403,18 @@ config HOLTEK_FF
>  	  Say Y here if you have a Holtek On Line Grip based game controller
>  	  and want to have force feedback support for it.
>  
> +config HID_GOOGLE_ATRUS
> +	tristate "Google Hangouts Meet Speakermic"
> +	depends on USB_HID
> +	---help---

Just	help

The ---help--- form is no longer used.

> +	This selects a driver for the Google Hangouts Meet Speakermic.
> +
> +	This driver works around a problem with the HID usage sent by this
> +	device for the mute button. It prevents key events from being generated
> +	for that HID usage since they would be incorrect.
> +
> +	Say Y here if you have a Google Hangouts Meet Speakermic.
> +
>  config HID_GOOGLE_HAMMER
>  	tristate "Google Hammer Keyboard"
>  	depends on USB_HID && LEDS_CLASS && CROS_EC


-- 
~Randy
