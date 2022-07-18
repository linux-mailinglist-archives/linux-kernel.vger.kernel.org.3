Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DE5578BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbiGRUnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGRUng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:43:36 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06A030F50;
        Mon, 18 Jul 2022 13:43:34 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 792945C006B;
        Mon, 18 Jul 2022 16:43:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Jul 2022 16:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1658177012; x=1658263412; bh=5UQ8RFWU7O
        NBLKEkTnik1gSjKCz/vCRxpHJp1gCJCdc=; b=vcf9+TK/0hbdoa11pQUjeBfvjb
        z7GLo6j1LON1St7PpNFj/lhHsbc71eEsl1TQatUjtrHtol1hUa2HvlmtfGG+TLvm
        tJ0eOzAPkVn/e2rDWr2eq0Ynle8GHO2GHvsQrAHAVJjMjZQlq+9/vgRD5q72bC0B
        LN5+GI/xxzvnpWVDaOoxFESmyRO3+GxdnkviFh2pfypd/T0E5L8utMEjSX78QLSU
        5j7g5qAy+aawWnpfzpZtqUTHA0UhrkYuPuC3TYSGVb0C/4S71UNn0UwVjbTpXkhC
        zVj/LWj8r4AskalCAHYZMMzLVVNDlniegY+RKyDdjYxJhnvnWFY/drkdCBQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658177012; x=1658263412; bh=5UQ8RFWU7ONBLKEkTnik1gSjKCz/
        vCRxpHJp1gCJCdc=; b=wmIoLWD0WaK5pbGlGPg6MVhkOXgFYzs7PIHb+jafYimA
        RxWi/z6U2KnBfxdOJFIaxY0ANI2v/Wyrk5ODSF8EV3JAzz+TMpC5aPg937Uz2vPs
        RzEF+ztSE9hrpMajNwZ/W/X1YOlH+YWZWzla+GiiAq1WYM0vYGvEVNmfDmLQY01D
        LPUdMYml9m2m/ZHoQcSc6vz+0vh39cvEoVOPAjwlRGIu3MwxjJYoDUy98CYrANpA
        soeOanAYI1SA3mQth2cJTUr8LfXF58YsBHTrhPS/kHIco2usHsF+iQchlRGd80k6
        SHM33p9XfbNoybH8z5fXxcuSeBZdN6MvfJpAqFOq1w==
X-ME-Sender: <xms:9MXVYs-H2NHbEVVjX0MvYecfbTGZL-bA1gGM-sZvByUR0DLvvuG8ow>
    <xme:9MXVYkvp_9--teHuKxqL5Eu24Uh6B8aswGFXhq2Rc5tSZhX4heQw7e4S84HvdCfsd
    2TW1ZSW1ZzmcA>
X-ME-Received: <xmr:9MXVYiAPFF5Okab9RxkM_lZzKrwQetDhNQCbeCywVNyYbiiiIny5JsqUkvxb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekkedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:9MXVYsechAo8Vr4YUN6Umgk1Mm9kC2gY7Llo6V0NH3f9PYeIe0-GoA>
    <xmx:9MXVYhNPCfUFYfCiSspz1lj0T3frV5a1Scanz2p38rDhaLJwwKfuvA>
    <xmx:9MXVYmlZbJLtAEq-bvWAcVeuAiAqS7pd6JpyoUqk3VwtTr6gqN6ITQ>
    <xmx:9MXVYolweTQ2Gr4v1X0aE0nRAmTzuISRCxOkZrl6vaVQYslnm2S7UA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Jul 2022 16:43:31 -0400 (EDT)
Date:   Mon, 18 Jul 2022 22:43:29 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Prashant Malani <pmalani@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <YtXF8TUZHNRUUyJh@kroah.com>
References: <20220718163158.42176b4e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718163158.42176b4e@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 04:31:58PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the usb tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> drivers/platform/chrome/cros_typec_switch.c: In function 'cros_typec_cmd_mux_set':
> drivers/platform/chrome/cros_typec_switch.c:52:16: error: implicit declaration of function 'cros_ec_command'; did you mean 'cros_ec_cmd'? [-Werror=implicit-function-declaration]
>    52 |         return cros_ec_command(sdata->ec, 0, EC_CMD_TYPEC_CONTROL, &req,
>       |                ^~~~~~~~~~~~~~~
>       |                cros_ec_cmd
> drivers/platform/chrome/cros_typec_switch.c: In function 'cros_typec_register_switches':
> drivers/platform/chrome/cros_typec_switch.c:244:23: error: implicit declaration of function 'acpi_evaluate_integer'; did you mean 'acpi_evaluate_object'? [-Werror=implicit-function-declaration]
>   244 |                 ret = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &index);
>       |                       ^~~~~~~~~~~~~~~~~~~~~
>       |                       acpi_evaluate_object
> drivers/platform/chrome/cros_typec_switch.c:244:49: error: invalid use of undefined type 'struct acpi_device'
>   244 |                 ret = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &index);
>       |                                                 ^~
> 
> Caused by commit
> 
>   e54369058f3d ("platform/chrome: cros_typec_switch: Add switch driver")
> 
> and commits
> 
>   34f375f0fdf6 ("platform/chrome: cros_typec_switch: Set EC retimer")
>   bb53ad958012 ("platform/chrome: cros_typec_switch: Add event check")
> 
> interacting with commit
> 
>   b1d288d9c3c5 ("platform/chrome: cros_ec_proto: Rename cros_ec_command function")
> 
> from the chrome-platform tree.
> 
> I have used the usb tree from next-20220715 for today.
> 
> I will fix up the cros_ec_command() rename with a merge fix patch after
> the apci usage problem is solved.

The ACPI issue should now be solved in my tree.

thanks,

greg k-h
