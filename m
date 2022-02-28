Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501884C6D52
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiB1NBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiB1NBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:01:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E869D58E4A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646053235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pTt4lYeTqsTlzf044iKbn+rWbhrDH0dtdcXABS1pKsI=;
        b=MQbZZbcA5UvrsMaFtlcntZTVjtdQZRvqY1mVNX3j0b6lZ0/7ldckjYKL0nlH97oATjCSOF
        RF2LGeJkDw3NCdrUxne1EgwPHIcwjTWjReTQ6FOs8YjU+6s4SSPVxR+eC/hDaF+iepTjjK
        7eyMpRpdmB9XLL6rmp62JyFVGfJkTXM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-h0wrLzDrPN2nvnjg0wlnlg-1; Mon, 28 Feb 2022 08:00:34 -0500
X-MC-Unique: h0wrLzDrPN2nvnjg0wlnlg-1
Received: by mail-ed1-f71.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso5846976edh.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pTt4lYeTqsTlzf044iKbn+rWbhrDH0dtdcXABS1pKsI=;
        b=rrHlY8IoibGNiVxgGMELPMQQB1yqi7daRVjibARWBbcrhUQls0nK+IxRw2ka3p/7PI
         4Lmn5cx5SNdF8U3T7ahPSkbgwLo/la2puelFZjSdQXvJ+eQrdquOllbyP0ujP0ZLpmi6
         eY/S/SSy6Mjjb2o/vuq+gAVwuXcfDFyBzuzM/kYvKY3+1/lRLeXLNem6EhiE1yy60l4a
         hG6latXmtl3e3S5bV6rXma7gGzWSLkRuIWYX6RoEYqtBvCGVR/4uHNP43QXQMJ4LnfTy
         ndCCX7WjXTT+campY1tsATod8rXSNWW1w3RFJQmZ9IH0tsSiJUoK+m+YqZkqYQ2Wzf2o
         aJSw==
X-Gm-Message-State: AOAM530t9XmcjdW07MO4bdb4vnsTLmi9mjwqUjpqmuZ/+SeXh+eqz5ZD
        7nXmSklvwtqmBfhavuRwxfO319JxWvnnFKlAgo4FpNSfxySE5E1wh3UoNDQJfw0N6PZ1pbJL0Iu
        lrwKY6ReYVn4LUCIPLNhCYTzZ
X-Received: by 2002:a05:6402:c10:b0:40f:33cd:a39 with SMTP id co16-20020a0564020c1000b0040f33cd0a39mr19233936edb.234.1646053231924;
        Mon, 28 Feb 2022 05:00:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwJPeyFgPejYaVxgadpG62Do9kEPvLmj6vQBIwXxheVpNV4BYJ/ZdfJXNTDnIPg8i1fSrBjQ==
X-Received: by 2002:a05:6402:c10:b0:40f:33cd:a39 with SMTP id co16-20020a0564020c1000b0040f33cd0a39mr19233811edb.234.1646053230657;
        Mon, 28 Feb 2022 05:00:30 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906608e00b006d1455acc62sm4349309ejj.74.2022.02.28.05.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 05:00:30 -0800 (PST)
Message-ID: <af476269-0722-218d-0fe6-404a9bab736f@redhat.com>
Date:   Mon, 28 Feb 2022 14:00:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] input/i8042: Add TUXEDO/Clevo devices to i8042 quirk
 tables
Content-Language: en-US
To:     Werner Sembach <wse@tuxedocomputers.com>,
        dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, samuel@cavoj.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220228114819.32949-1-wse@tuxedocomputers.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220228114819.32949-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 2/28/22 12:48, Werner Sembach wrote:
> A lot of modern Clevo barebones have touchpad and/or keyboard issues after
> suspend, fixable with reset + nomux + nopnp + noloop. Luckily, none of them
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
> This is revision 2 where the Clevo N150CU barebone is removed again, as it
> might have problems with the fix and needs further investigations. Also
> the SchenkerTechnologiesGmbH System-/Board-Vendor string variations are
> added.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org

Looking at the patch I think it would be better to split this into
2 patches":

1. Merge all the existing separate tables into 1 table and use the dmi_system_id.driver_data
field to store which combination of the 4 quirks apply to which models.

This will already help reducing the tables since some of the models are
already listed in 2 or more tables. So you would get something like this:

#define SERIO_QUIRK_RESET		BIT(0)
#define SERIO_QUIRK_NOMUX		BIT(1)
#define SERIO_QUIRK_NOPNP		BIT(2)
#define SERIO_QUIRK_NOLOOP		BIT(3)
#define SERIO_QUIRK_NOSELFTEST		BIT(4)
// etc.

static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
        {
                /* Entroware Proteus */
                .matches = {
                        DMI_MATCH(DMI_SYS_VENDOR, "Entroware"),
                        DMI_MATCH(DMI_PRODUCT_NAME, "Proteus"),
                        DMI_MATCH(DMI_PRODUCT_VERSION, "EL07R4"),
                },
		.driver_data = (void *)(SERIO_QUIRK_RESET | SERIO_QUIRK_NOMUX)
        },
	{}
};

I picked the Entroware EL07R4 as example here because it needs both the reset and nomux quirks.

And then when checking the quirks do:

#ifdef CONFIG_X86
	const struct dmi_system_id *dmi_id;
	long quirks = 0;

	dmi_id = dmi_first_match(i8042_dmi_quirk_table);
	if (dmi_id)
		quirks = (long)dmi_id->driver_data;

	if (i8042_reset == I8042_RESET_DEFAULT) {
		if (quirks & SERIO_QUIRK_RESET)
			i8042_reset = I8042_RESET_ALWAYS;
		if (quirks & SERIO_QUIRK_NOSELFTEST)
			i8042_reset = I8042_RESET_NEVER;
	}

	//etc.


This way you can reduce all the tables to just 1 table. Please
also sort the table alphabetically, first by vendor, then sub-sort
by model. This way you can find more entries to merge and it
is a good idea to have big tables like this sorted in some way
regardless.


And then once this big refactoring patch is done (sorry), you
can add a second patch on top:

2. Add the models you want to quirk to the new merged tabled
and now you only need to add 1 table entry per model, rather
then 4, making the patch much smaller.


This is a refactoring which IMHO we should likely already
have done a while ago, but now with your patch it really is
time we do this.

I hope the above makes sense, if not don't hesitate to ask
questions. Also note this is how *I* would do this, but
I'm not the input subsys-maintainer, ultimately this is
Dmitry's call and he may actually dislike with I'm proposing!

I don't expect that Dmitry will dislike this, but you never know.

Also unfortunately Dmitry lately has only a limited amount of
time to spend on input subsys maintenance so in my experience
it may be a while before you get a reply from Dmitry.

Regards,

Hans












> ---
>  drivers/input/serio/i8042-x86ia64io.h | 2384 ++++++++++++++++++++++---
>  1 file changed, 2116 insertions(+), 268 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 148a7c5fd0e2..fb8da60d908f 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -226,566 +226,2414 @@ static const struct dmi_system_id __initconst i8042_dmi_noloop_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "ByteSpeed Laptop C15B"),
>  		},
>  	},
> +	/*
> +	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
> +	 * after suspend fixable with reset + nomux + nopnp + noloop. Luckily,
> +	 * none of them have an external PS/2 port so this can savely be set for
> +	 * all of them.
> +	 */
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{ }
> +};
> +
> +/*
> + * Some Fujitsu notebooks are having trouble with touchpads if
> + * active multiplexing mode is activated. Luckily they don't have
> + * external PS/2 ports so we can safely disable it.
> + * ... apparently some Toshibas don't like MUX mode either and
> + * die horrible death on reboot.
> + */
> +static const struct dmi_system_id __initconst i8042_dmi_nomux_table[] = {
> +	{
> +		/* Fujitsu Lifebook P7010/P7010D */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "P7010"),
> +		},
> +	},
> +	{
> +		/* Fujitsu Lifebook P7010 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "0000000000"),
> +		},
> +	},
> +	{
> +		/* Fujitsu Lifebook P5020D */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook P Series"),
> +		},
> +	},
> +	{
> +		/* Fujitsu Lifebook S2000 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S Series"),
> +		},
> +	},
> +	{
> +		/* Fujitsu Lifebook S6230 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S6230"),
> +		},
> +	},
> +	{
> +		/* Fujitsu Lifebook T725 laptop */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T725"),
> +		},
> +	},
> +	{
> +		/* Fujitsu Lifebook U745 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U745"),
> +		},
> +	},
> +	{
> +		/* Fujitsu T70H */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "FMVLT70H"),
> +		},
> +	},
> +	{
> +		/* Fujitsu-Siemens Lifebook T3010 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T3010"),
> +		},
> +	},
> +	{
> +		/* Fujitsu-Siemens Lifebook E4010 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E4010"),
> +		},
> +	},
> +	{
> +		/* Fujitsu-Siemens Amilo Pro 2010 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pro V2010"),
> +		},
> +	},
> +	{
> +		/* Fujitsu-Siemens Amilo Pro 2030 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO PRO V2030"),
> +		},
> +	},
> +	{
> +		/*
> +		 * No data is coming from the touchscreen unless KBC
> +		 * is in legacy mode.
> +		 */
> +		/* Panasonic CF-29 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Matsushita"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "CF-29"),
> +		},
> +	},
> +	{
> +		/*
> +		 * HP Pavilion DV4017EA -
> +		 * errors on MUX ports are reported without raising AUXDATA
> +		 * causing "spurious NAK" messages.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EA032EA#ABF)"),
> +		},
> +	},
> +	{
> +		/*
> +		 * HP Pavilion ZT1000 -
> +		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Notebook PC"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook ZT1000"),
> +		},
> +	},
> +	{
> +		/*
> +		 * HP Pavilion DV4270ca -
> +		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EH476UA#ABL)"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P10"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "EQUIUM A110"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE C850D"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ALIENWARE"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Sentia"),
> +		},
> +	},
> +	{
> +		/* Sharp Actius MM20 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SHARP"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "PC-MM20 Series"),
> +		},
> +	},
> +	{
> +		/* Sony Vaio FS-115b */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FS115B"),
> +		},
> +	},
> +	{
> +		/*
> +		 * Sony Vaio FZ-240E -
> +		 * reset and GET ID commands issued via KBD port are
> +		 * sometimes being delivered to AUX3.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ240E"),
> +		},
> +	},
> +	{
> +		/*
> +		 * Most (all?) VAIOs do not have external PS/2 ports nor
> +		 * they implement active multiplexing properly, and
> +		 * MUX discovery usually messes up keyboard/touchpad.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> +			DMI_MATCH(DMI_BOARD_NAME, "VAIO"),
> +		},
> +	},
> +	{
> +		/* Amoi M636/A737 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Amoi Electronics CO.,LTD."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "M636/A737 platform"),
> +		},
> +	},
> +	{
> +		/* Lenovo 3000 n100 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "076804U"),
> +		},
> +	},
> +	{
> +		/* Lenovo XiaoXin Air 12 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "80UN"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 1360"),
> +		},
> +	},
> +	{
> +		/* Acer Aspire 5710 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5710"),
> +		},
> +	},
> +	{
> +		/* Acer Aspire 7738 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7738"),
> +		},
> +	},
> +	{
> +		/* Gericom Bellagio */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Gericom"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "N34AS6"),
> +		},
> +	},
> +	{
> +		/* IBM 2656 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "2656"),
> +		},
> +	},
> +	{
> +		/* Dell XPS M1530 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "XPS M1530"),
> +		},
> +	},
> +	{
> +		/* Compal HEL80I */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "COMPAL"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HEL80I"),
> +		},
> +	},
> +	{
> +		/* Dell Vostro 1510 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro1510"),
> +		},
> +	},
> +	{
> +		/* Acer Aspire 5536 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5536"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
> +		},
> +	},
> +	{
> +		/* Dell Vostro V13 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V13"),
> +		},
> +	},
> +	{
> +		/* Newer HP Pavilion dv4 models */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv4 Notebook PC"),
> +		},
> +	},
> +	{
> +		/* Asus X450LCP */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "X450LCP"),
> +		},
> +	},
> +	{
> +		/* Avatar AVIU-145A6 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "IC4I"),
> +		},
> +	},
> +	{
> +		/* TUXEDO BU1406 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "N24_25BU"),
> +		},
> +	},
> +	{
> +		/* Lenovo LaVie Z */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo LaVie Z"),
> +		},
> +	},
> +	{
> +		/*
> +		 * Acer Aspire 5738z
> +		 * Touchpad stops working in mux mode when dis- + re-enabled
> +		 * with the touchpad enable/disable toggle hotkey
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5738"),
> +		},
> +	},
> +	{
> +		/* Entroware Proteus */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Entroware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Proteus"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "EL07R4"),
> +		},
> +	},
> +	/*
> +	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
> +	 * after suspend fixable with reset + nomux + nopnp + noloop. Luckily,
> +	 * none of them have an external PS/2 port so this can savely be set for
> +	 * all of them.
> +	 */
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{ }
> +};
> +
> +static const struct dmi_system_id i8042_dmi_forcemux_table[] __initconst = {
> +	{
> +		/*
> +		 * Sony Vaio VGN-CS series require MUX or the touch sensor
> +		 * buttons will disturb touchpad operation
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-CS"),
> +		},
> +	},
> +	{ }
> +};
> +
> +/*
> + * On some Asus laptops, just running self tests cause problems.
> + */
> +static const struct dmi_system_id i8042_dmi_noselftest_table[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
> +		},
> +	}, {
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /* Convertible Notebook */
> +		},
> +	},
> +	{ }
> +};
> +static const struct dmi_system_id __initconst i8042_dmi_reset_table[] = {
> +	{
> +		/* MSI Wind U-100 */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
> +		},
> +	},
> +	{
> +		/* LG Electronics X110 */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "X110"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LG Electronics Inc."),
> +		},
> +	},
> +	{
> +		/* Acer Aspire One 150 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "AOA150"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A114-31"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A314-31"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A315-31"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-132"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-332"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-432"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate Spin B118-RN"),
> +		},
> +	},
> +	{
> +		/* Advent 4211 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "DIXONSXP"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Advent 4211"),
> +		},
> +	},
> +	{
> +		/* Medion Akoya Mini E1210 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "E1210"),
> +		},
> +	},
> +	{
> +		/* Medion Akoya E1222 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "E122X"),
> +		},
> +	},
> +	{
> +		/* Mivvy M310 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "VIOOO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "N10"),
> +		},
> +	},
> +	{
> +		/* Dell Vostro 1320 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1320"),
> +		},
> +	},
> +	{
> +		/* Dell Vostro 1520 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1520"),
> +		},
> +	},
> +	{
> +		/* Dell Vostro 1720 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1720"),
> +		},
> +	},
> +	{
> +		/* Lenovo Ideapad U455 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "20046"),
> +		},
> +	},
> +	{
> +		/* Lenovo ThinkPad L460 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L460"),
> +		},
> +	},
> +	{
> +		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
> +		},
> +	},
> +	{
> +		/* Lenovo ThinkPad Twist S230u */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "33474HU"),
> +		},
> +	},
> +	{
> +		/* Entroware Proteus */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Entroware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Proteus"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "EL07R4"),
> +		},
> +	},
> +	/*
> +	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
> +	 * after suspend fixable with reset + nomux + nopnp + noloop. Luckily,
> +	 * none of them have an external PS/2 port so this can savely be set for
> +	 * all of them.
> +	 */
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
> +		},
> +	},
>  	{ }
>  };
>  
> -/*
> - * Some Fujitsu notebooks are having trouble with touchpads if
> - * active multiplexing mode is activated. Luckily they don't have
> - * external PS/2 ports so we can safely disable it.
> - * ... apparently some Toshibas don't like MUX mode either and
> - * die horrible death on reboot.
> - */
> -static const struct dmi_system_id __initconst i8042_dmi_nomux_table[] = {
> +#ifdef CONFIG_PNP
> +static const struct dmi_system_id __initconst i8042_dmi_nopnp_table[] = {
>  	{
> -		/* Fujitsu Lifebook P7010/P7010D */
> +		/* Intel MBO Desktop D845PESV */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "P7010"),
> +			DMI_MATCH(DMI_BOARD_NAME, "D845PESV"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
>  		},
>  	},
>  	{
> -		/* Fujitsu Lifebook P7010 */
> +		/*
> +		 * Intel NUC D54250WYK - does not have i8042 controller but
> +		 * declares PS/2 devices in DSDT.
> +		 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "0000000000"),
> +			DMI_MATCH(DMI_BOARD_NAME, "D54250WYK"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
>  		},
>  	},
>  	{
> -		/* Fujitsu Lifebook P5020D */
> +		/* MSI Wind U-100 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook P Series"),
> +			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
>  		},
>  	},
>  	{
> -		/* Fujitsu Lifebook S2000 */
> +		/* Acer Aspire 5 A515 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S Series"),
> +			DMI_MATCH(DMI_BOARD_NAME, "Grumpy_PK"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "PK"),
>  		},
>  	},
> +	/*
> +	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
> +	 * after suspend fixable with reset + nomux + nopnp + noloop. Luckily,
> +	 * none of them have an external PS/2 port so this can savely be set for
> +	 * all of them.
> +	 */
>  	{
> -		/* Fujitsu Lifebook S6230 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S6230"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
>  		},
>  	},
>  	{
> -		/* Fujitsu Lifebook T725 laptop */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T725"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
>  		},
>  	},
>  	{
> -		/* Fujitsu Lifebook U745 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U745"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
>  		},
>  	},
>  	{
> -		/* Fujitsu T70H */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "FMVLT70H"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
>  		},
>  	},
>  	{
> -		/* Fujitsu-Siemens Lifebook T3010 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T3010"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
>  		},
>  	},
>  	{
> -		/* Fujitsu-Siemens Lifebook E4010 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E4010"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
>  		},
>  	},
>  	{
> -		/* Fujitsu-Siemens Amilo Pro 2010 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pro V2010"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
>  		},
>  	},
>  	{
> -		/* Fujitsu-Siemens Amilo Pro 2030 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO PRO V2030"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
>  		},
>  	},
>  	{
> -		/*
> -		 * No data is coming from the touchscreen unless KBC
> -		 * is in legacy mode.
> -		 */
> -		/* Panasonic CF-29 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Matsushita"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "CF-29"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
>  		},
>  	},
>  	{
> -		/*
> -		 * HP Pavilion DV4017EA -
> -		 * errors on MUX ports are reported without raising AUXDATA
> -		 * causing "spurious NAK" messages.
> -		 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EA032EA#ABF)"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
>  		},
>  	},
>  	{
> -		/*
> -		 * HP Pavilion ZT1000 -
> -		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
> -		 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Notebook PC"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook ZT1000"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
>  		},
>  	},
>  	{
> -		/*
> -		 * HP Pavilion DV4270ca -
> -		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
> -		 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EH476UA#ABL)"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P10"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "EQUIUM A110"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE C850D"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ALIENWARE"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Sentia"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
>  		},
>  	},
>  	{
> -		/* Sharp Actius MM20 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "SHARP"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "PC-MM20 Series"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
>  		},
>  	},
>  	{
> -		/* Sony Vaio FS-115b */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FS115B"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
>  		},
>  	},
>  	{
> -		/*
> -		 * Sony Vaio FZ-240E -
> -		 * reset and GET ID commands issued via KBD port are
> -		 * sometimes being delivered to AUX3.
> -		 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ240E"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
>  		},
>  	},
>  	{
> -		/*
> -		 * Most (all?) VAIOs do not have external PS/2 ports nor
> -		 * they implement active multiplexing properly, and
> -		 * MUX discovery usually messes up keyboard/touchpad.
> -		 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> -			DMI_MATCH(DMI_BOARD_NAME, "VAIO"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
>  		},
>  	},
>  	{
> -		/* Amoi M636/A737 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Amoi Electronics CO.,LTD."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "M636/A737 platform"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
>  		},
>  	},
>  	{
> -		/* Lenovo 3000 n100 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "076804U"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
>  		},
>  	},
>  	{
> -		/* Lenovo XiaoXin Air 12 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "80UN"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 1360"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
>  		},
>  	},
>  	{
> -		/* Acer Aspire 5710 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5710"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
>  		},
>  	},
>  	{
> -		/* Acer Aspire 7738 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7738"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
>  		},
>  	},
>  	{
> -		/* Gericom Bellagio */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Gericom"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "N34AS6"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
>  		},
>  	},
>  	{
> -		/* IBM 2656 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "2656"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
>  		},
>  	},
>  	{
> -		/* Dell XPS M1530 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "XPS M1530"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
>  		},
>  	},
>  	{
> -		/* Compal HEL80I */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "COMPAL"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "HEL80I"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
>  		},
>  	},
>  	{
> -		/* Dell Vostro 1510 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro1510"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
>  		},
>  	},
>  	{
> -		/* Acer Aspire 5536 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5536"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
>  		},
>  	},
>  	{
> -		/* Dell Vostro V13 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V13"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
>  		},
>  	},
>  	{
> -		/* Newer HP Pavilion dv4 models */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv4 Notebook PC"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
>  		},
>  	},
>  	{
> -		/* Asus X450LCP */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "X450LCP"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
>  		},
>  	},
>  	{
> -		/* Avatar AVIU-145A6 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "IC4I"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
>  		},
>  	},
>  	{
> -		/* TUXEDO BU1406 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "N24_25BU"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
>  		},
>  	},
>  	{
> -		/* Lenovo LaVie Z */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo LaVie Z"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
>  		},
>  	},
>  	{
> -		/*
> -		 * Acer Aspire 5738z
> -		 * Touchpad stops working in mux mode when dis- + re-enabled
> -		 * with the touchpad enable/disable toggle hotkey
> -		 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5738"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
>  		},
>  	},
>  	{
> -		/* Entroware Proteus */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Entroware"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Proteus"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "EL07R4"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
>  		},
>  	},
> -	{ }
> -};
> -
> -static const struct dmi_system_id i8042_dmi_forcemux_table[] __initconst = {
>  	{
> -		/*
> -		 * Sony Vaio VGN-CS series require MUX or the touch sensor
> -		 * buttons will disturb touchpad operation
> -		 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-CS"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
>  		},
>  	},
> -	{ }
> -};
> -
> -/*
> - * On some Asus laptops, just running self tests cause problems.
> - */
> -static const struct dmi_system_id i8042_dmi_noselftest_table[] = {
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
>  		},
> -	}, {
> +	},
> +	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /* Convertible Notebook */
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
>  		},
>  	},
> -	{ }
> -};
> -static const struct dmi_system_id __initconst i8042_dmi_reset_table[] = {
>  	{
> -		/* MSI Wind U-100 */
>  		.matches = {
> -			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
> -			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
>  		},
>  	},
>  	{
> -		/* LG Electronics X110 */
>  		.matches = {
> -			DMI_MATCH(DMI_BOARD_NAME, "X110"),
> -			DMI_MATCH(DMI_BOARD_VENDOR, "LG Electronics Inc."),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
>  		},
>  	},
>  	{
> -		/* Acer Aspire One 150 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "AOA150"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A114-31"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A314-31"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A315-31"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-132"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-332"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-432"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
>  		},
>  	},
>  	{
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate Spin B118-RN"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
>  		},
>  	},
>  	{
> -		/* Advent 4211 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "DIXONSXP"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Advent 4211"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
>  		},
>  	},
>  	{
> -		/* Medion Akoya Mini E1210 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "E1210"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
>  		},
>  	},
>  	{
> -		/* Medion Akoya E1222 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "E122X"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
>  		},
>  	},
>  	{
> -		/* Mivvy M310 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "VIOOO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "N10"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
>  		},
>  	},
>  	{
> -		/* Dell Vostro 1320 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1320"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
>  		},
>  	},
>  	{
> -		/* Dell Vostro 1520 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1520"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
>  		},
>  	},
>  	{
> -		/* Dell Vostro 1720 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1720"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
>  		},
>  	},
>  	{
> -		/* Lenovo Ideapad U455 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "20046"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
>  		},
>  	},
>  	{
> -		/* Lenovo ThinkPad L460 */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L460"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
>  		},
>  	},
>  	{
> -		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
>  		},
>  	},
>  	{
> -		/* Lenovo ThinkPad Twist S230u */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "33474HU"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
>  		},
>  	},
>  	{
> -		/* Entroware Proteus */
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Entroware"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Proteus"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "EL07R4"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
>  		},
>  	},
> -	{ }
> -};
> -
> -#ifdef CONFIG_PNP
> -static const struct dmi_system_id __initconst i8042_dmi_nopnp_table[] = {
>  	{
> -		/* Intel MBO Desktop D845PESV */
>  		.matches = {
> -			DMI_MATCH(DMI_BOARD_NAME, "D845PESV"),
> -			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
>  		},
>  	},
>  	{
> -		/*
> -		 * Intel NUC D54250WYK - does not have i8042 controller but
> -		 * declares PS/2 devices in DSDT.
> -		 */
>  		.matches = {
> -			DMI_MATCH(DMI_BOARD_NAME, "D54250WYK"),
> -			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
>  		},
>  	},
>  	{
> -		/* MSI Wind U-100 */
>  		.matches = {
> -			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
> -			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
>  		},
>  	},
>  	{
> -		/* Acer Aspire 5 A515 */
>  		.matches = {
> -			DMI_MATCH(DMI_BOARD_NAME, "Grumpy_PK"),
> -			DMI_MATCH(DMI_BOARD_VENDOR, "PK"),
> +			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
> +			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
>  		},
>  	},
>  	{ }

