Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3BF4FBFE2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241839AbiDKPLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347644AbiDKPLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:11:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9456356;
        Mon, 11 Apr 2022 08:09:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4837661526;
        Mon, 11 Apr 2022 15:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431F1C385A3;
        Mon, 11 Apr 2022 15:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649689741;
        bh=22S2yrevAEeFE4scZEMGrxj+dH0qEXV6ljblsP2XRkk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=rRBzsys0HqU8ZdjYOqL9oFRE7C+qqsTs9tSu6vKmX11f7BrV5Nz36ZSLjToT2hmtV
         NOhG2S33MsOZukl20/yQcIjPu7zhmHndMyebTTpHpRK68IWzSTqmi1LGHsUkdmG5+w
         l0Wza0vxiSNk45K8Rxz36u/9NoFv3LUGWJ8leHwDysacXK+urjOJqNTa8vLcIzENjc
         KB4Zdh7lA+Lx7KrkFfipftAfRMJ1PvC6IuyoFp32OnuXB44xMeDhe/vJSGxyJgp7U9
         q59j3H7uskuloY4e/FqCvsAapgNrp4F81KZ9bAcV6GtR1pm2s9seKlr7Rms/7cOAS0
         OuqdXm6USUnTg==
Date:   Mon, 11 Apr 2022 17:08:58 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Bastien Nocera <hadess@hadess.net>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ping Cheng <ping.cheng@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>
Subject: Re: [PATCH] HID: wacom: Correct power_supply type
In-Reply-To: <20220407115406.115112-1-hadess@hadess.net>
Message-ID: <nycvar.YFH.7.76.2204111708230.30217@cbobk.fhfr.pm>
References: <20220407115406.115112-1-hadess@hadess.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2022, Bastien Nocera wrote:

> POWER_SUPPLY_TYPE_USB seems to only ever be used by USB ports that are
> used to charge the machine itself (so a "system" scope), like the
> single USB port on a phone, rather than devices.
> 
> The wacom_sys driver is the only driver that sets its device battery as
> being a USB type, which doesn't seem correct based on its usage, so
> switch it to be a battery type like all the other USB-connected devices.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>  drivers/hid/wacom_sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 066c567dbaa2..620fe74f5676 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1777,7 +1777,7 @@ static int __wacom_initialize_battery(struct wacom *wacom,
>  	bat_desc->get_property = wacom_battery_get_property;
>  	sprintf(battery->bat_name, "wacom_battery_%ld", n);
>  	bat_desc->name = battery->bat_name;
> -	bat_desc->type = POWER_SUPPLY_TYPE_USB;
> +	bat_desc->type = POWER_SUPPLY_TYPE_BATTERY;
>  	bat_desc->use_for_apm = 0;
>  
>  	ps_bat = devm_power_supply_register(dev, bat_desc, &psy_cfg);

Thanks Bastien, makes sense. CCing Jason and Ping (the Wacom driver 
maintainers) to get their Ack.

-- 
Jiri Kosina
SUSE Labs

