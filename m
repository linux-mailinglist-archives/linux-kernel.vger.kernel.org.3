Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA5955F5BD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 07:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiF2Fgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 01:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiF2Fge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 01:36:34 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EB727FDE;
        Tue, 28 Jun 2022 22:36:31 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 128so14016680pfv.12;
        Tue, 28 Jun 2022 22:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=98E2vXeRSRjaARV6bPzIgmkPwqrdc9/cW924Gem45R8=;
        b=c4FxBwyRQ4YfwO/q1ACGSbqNlXNa/fQGXDNh8dxGsq7aHoiQH+mOe+Ferq3/vRHEeR
         ChpXLJuvtVWUEDOsZMF45u4U6zTwJBZZBBlCv+B0VNa/UJhYz//b0zO3tRSW/GMWIxde
         ceuJh01FxNVW0HP8HN+Lk06LK297uxEIVqUmRRp+JiwcB4/0AD5SY9GRwJx+MXM/IdbG
         LoVAHtc2cimizsVe/umZ4b0x8N/mT4h2SIaTUu/05PJd/HE1+a9kUEWj1OndR18BLFQu
         nSOHZlMZT90iuEPujsjT+xTnwFIDaget0xnXAaEa16qI9WVdB3cQGuUQBCSECj9WGocJ
         oHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=98E2vXeRSRjaARV6bPzIgmkPwqrdc9/cW924Gem45R8=;
        b=xwyocQqoAkp4tgmzLjdxx1BU1zsTSyrdNtlhZlGvUBMPKNi+80HblTbeZ72BuCHwQE
         PsUa+aEhMpG0oaf2atkXkvViB09LoFNwrsUIm6p1JsdU565USzqTkqh5Yku4PRoJVaUQ
         uqO/U+N2i/UnsJndR+cUdCEcdsHG3jG4OO5eXELFcgWl3bNyJ1KCfwWpyYLzeGcK4lEK
         gdlGDXgLGxJq/Zxs0S2mY7LgByE8JgPati3jqEndw0hVa4K+E8v3cDIfBzjO06+C7EaQ
         WOSI7LAzEKfNWnZP9SmiSRNNWx1h2wl8Xedmoxq/N/psRnvfP9AYVmZ+mows4SI5vwjT
         ARig==
X-Gm-Message-State: AJIora+IOIQ5rYi4INZn5if/3gmBoYHOm3GlnyB31ZiSIo7WYOwl3UmX
        rB8Whi9JjCarNcQqh+qmqbo=
X-Google-Smtp-Source: AGRyM1tFC4weV+O9qsyzB7HjGOkyI5RSTa68t7dkc+4l+I/7SdBMu83zJrIDle1KQ3Z64tkcDw4CPg==
X-Received: by 2002:a63:fa41:0:b0:408:9d1b:2e57 with SMTP id g1-20020a63fa41000000b004089d1b2e57mr1525186pgk.102.1656480991203;
        Tue, 28 Jun 2022 22:36:31 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ff79:92cc:7905:3272])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902e9c200b00168ba5ac8adsm10328904plk.163.2022.06.28.22.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 22:36:30 -0700 (PDT)
Date:   Tue, 28 Jun 2022 22:36:27 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     tiwai@suse.de, mpdesouza@suse.com, arnd@arndb.de,
        hdegoede@redhat.com, samuel@cavoj.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] input/i8042: Add TUXEDO devices to i8042 quirk
 tables
Message-ID: <Yrvk29RjekvMpJIk@google.com>
References: <20220329143622.31394-1-wse@tuxedocomputers.com>
 <20220329143622.31394-5-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329143622.31394-5-wse@tuxedocomputers.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Werner,

On Tue, Mar 29, 2022 at 04:36:22PM +0200, Werner Sembach wrote:
> A lot of modern Clevo barebones have touchpad and/or keyboard issues after
> suspend fixable with nomux + reset + noloop + nopnp. Luckily, none of them
> have an external PS/2 port so this can safely be set for all of them.
> 
> I'm not entirely sure if every device listed really needs all four quirks,
> but after testing and production use. No negative effects could be
> observed when setting all four.
> 
> The list is quite massive as neither the TUXEDO nor the Clevo dmi strings
> have been very consistent historically. I tried to keep the list as short
> as possible without risking on missing an affected device.
> 
> This is revision 3. The Clevo N150CU barebone is still removed as it might
> have problems with the fix and needs further investigations. The
> SchenkerTechnologiesGmbH System-/Board-Vendor string variations are
> added. This is now based in the quirk table refactor. This now also
> includes the additional noaux flag for the NS7xMU.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/input/serio/i8042-x86ia64io.h | 125 ++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 5c0eb5594fb1..a59c6aba7c75 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -1025,6 +1025,25 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>  		},
>  		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
>  	},
> +	/*
> +	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
> +	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
> +	 * none of them have an external PS/2 port so this can savely be set for

s/savely/safely/

> +	 * all of them. These two are based on a Clevo design, but have the
> +	 * board_name changed.
> +	 */
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
> +		},

Don't you need to set driver_data here and below?

> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
> +		},
> +	},
>  	{
>  		/* Mivvy M310 */
>  		.matches = {
> @@ -1054,6 +1073,112 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>  		},
>  		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
>  	},
> +	/*
> +	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
> +	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
> +	 * none of them have an external PS/2 port so this can savely be set for

safely

> +	 * all of them.
> +	 * Clevo barebones come with board_vendor and/or system_vendor set to
> +	 * either the very generic string "Notebook" and/or a different value
> +	 * for each individual reseller. The only somewhat universal way to
> +	 * identify them is by board_name.
> +	 */
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	/*
> +	 * At least one modern Clevo barebone has the touchpad connected both
> +	 * via PS/2 and i2c interface. This causes a race condition between the
> +	 * psmouse and i2c-hid driver. Since the full capability of the touchpad
> +	 * is available via the i2c interface and the device has no external
> +	 * PS/2 port, it is save to just ignore all ps2 mouses here to avoid

safe

> +	 * this issue. The know affected device is the

known

> +	 * TUXEDO InfinityBook S17 Gen6 / Clevo NS70MU which comes with one of
> +	 * the two different dmi strings below. NS50MU is not a typo!
> +	 */
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOAUX | SERIO_QUIRK_NOMUX |
> +					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
> +					SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOAUX | SERIO_QUIRK_NOMUX |
> +					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
> +					SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
> +					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
> +	},
>  	{ }
>  };
>  
> -- 
> 2.25.1
> 

Thanks.

-- 
Dmitry
