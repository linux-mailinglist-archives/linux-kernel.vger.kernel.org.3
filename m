Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A304B4B82
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 11:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346472AbiBNKXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:23:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346722AbiBNKVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:21:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C217DE36;
        Mon, 14 Feb 2022 01:55:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9017BB80DBE;
        Mon, 14 Feb 2022 09:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3184C340E9;
        Mon, 14 Feb 2022 09:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644832555;
        bh=za+znYSgbhf0ycyD96oqYNU6ulxWPNb7LNxbXB3qlyo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=UV/d/E5DqMrcjwq2gyPTgsTVJ2O2VOKhR1K5uE6hIbFAqwyntn1IyxXoNAL7E1ccD
         A1gScG/iu9cPZziLQHZZxBaQGPtvnJWopYDRUdDjcTAQ8O2Z3Mq05QhG0JJUYgxlCd
         BeWXhhPJ4EQQuaSNQL/bfphY6h4Gh6Rk5UoqvOQ+MDhzKt+WXbDZ1oL6G/Tk1bR9oh
         1E9k6r3VwjojLR884/D5RSU1EaDpszAdrxq0DTlywNzyLajvIICF4olvmJyk57uQL/
         b0Iw6wBdYFeCzRA3jGvcEkQYCi6N8w5A0YtnlC/V9zD6Z/6d2TaRwXrb7aku5T8Sv3
         zMqygAXXDO0ug==
Date:   Mon, 14 Feb 2022 10:55:51 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Aditya Garg <gargaditya08@live.com>
cc:     "alexhenrie24@gmail.com" <alexhenrie24@gmail.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCH v2 1/3] HID: apple: Add support for keyboard backlight
 on certain T2 Macs.
In-Reply-To: <1088ECFE-B356-4731-AC8A-09A4421DD7D1@live.com>
Message-ID: <nycvar.YFH.7.76.2202141054070.11721@cbobk.fhfr.pm>
References: <67E7EA8B-CF21-4794-B7B4-96873EE70EF6@live.com> <1088ECFE-B356-4731-AC8A-09A4421DD7D1@live.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2022, Aditya Garg wrote:

> 
> 
> > On 24-Jan-2022, at 8:38 PM, Aditya Garg <gargaditya08@live.com> wrote:
> > 
> > From: Paul Pawlowski <paul@mrarm.io>
> > 
> > This patch introduces the requisite plumbing for supporting keyboard
> > backlight on T2-attached, USB exposed models. The quirk mechanism was
> > used to reuse the existing hid-apple driver.
> > 
> > Signed-off-by: Paul Pawlowski <paul@mrarm.io>
> > Signed-off-by: Aun-Ali Zaidi <admin@kodeit.net>
> > Signed-off-by: Aditya Garg <gargaditya08@live.com>
> > ---
> > drivers/hid/hid-apple.c | 125 ++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 125 insertions(+)
> > 
> > diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> > index 24802a4a6..c22d445a9 100644
> > --- a/drivers/hid/hid-apple.c
> > +++ b/drivers/hid/hid-apple.c
> > @@ -7,6 +7,7 @@
> >  *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
> >  *  Copyright (c) 2006-2007 Jiri Kosina
> >  *  Copyright (c) 2008 Jiri Slaby <jirislaby@gmail.com>
> > + *  Copyright (c) 2019 Paul Pawlowski <paul@mrarm.io>
> >  */
> > 
> > /*
> > @@ -33,6 +34,7 @@
> > /* BIT(7) reserved, was: APPLE_IGNORE_HIDINPUT */
> > #define APPLE_NUMLOCK_EMULATION	BIT(8)
> > #define APPLE_RDESC_BATTERY	BIT(9)
> > +#define APPLE_BACKLIGHT_CTL	0x0200
> Jiri, should it be BIT(10)? 0x0200 is BIT(9) if I ain’t wrong.

Yes, please use BIT(10). Thanks,

-- 
Jiri Kosina
SUSE Labs

