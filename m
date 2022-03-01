Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850194C859C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiCAHzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbiCAHz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:55:29 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190E77084D;
        Mon, 28 Feb 2022 23:54:49 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id z4so13743469pgh.12;
        Mon, 28 Feb 2022 23:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KEx2JGViLwcI+BrMNbHeZh7nenUs9gi67goKdHZSYc8=;
        b=e8KXOBibxwQZRKcDEUvVd6vFCs4MQClZJig4pCXA4K2kpzJEYl1sH4KUmVuSSBN6wV
         9WtpNc0rKThPBANdm0DjKOumpIWZJYeSjJVgnu+BQWIFk5gmZdONb2dAJnM7XEgJWSP3
         X35+XXx5un117T53vhWVhSovk4iwnDb0n2b0snYOS95F1sK9d7hsVR6Ii0EOqGI/mh4f
         xhcp1Aa0Y+wOIruy64n84WJCmmUqjp/rPOqxFyw3z/rpADerWC7hKZcDCUwKSfAxVkzJ
         DGV+UrxwqFv8a/rWbFobivtd5994p0KnXCLC/WFeJZgSLZ89uGE0woefHnR+jkHNwGK4
         QcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KEx2JGViLwcI+BrMNbHeZh7nenUs9gi67goKdHZSYc8=;
        b=O8eUdArIR47e68Z5V4wgWgNNoExkqpW4o4EGAO0XrGhIztOAUVkymdR9olk05yo0rg
         wi5ptC7bb53FaVMDUdq04H9K2VnFFfwfxQjQ4GXf0rnnSkbpEg71kltG/vHz51Uwshf/
         w9b2qFWvXuVUie5QI9kDr4x8NBOgjeY6ErBOQRmpDR1QyJeEz+9DyMC8u+ukr780lDxu
         jiLaORBruC6lyW/iJDDR2y+aXS5abZMWVITLzbyXHwYoQtyxfUExbjmEiyDAVjU/HOXO
         cYyR5qSBUNAmdnM83vlW8ptVRMlyGwHcBgnCr/C9AMO/zH6FB5TBFH9vYgNGnwjzYm0s
         HUiw==
X-Gm-Message-State: AOAM530NWbxp482kjZzQCwHpwmqqYR2SoO8TVOnbypfnL5oyRUjzBj6f
        KJK1K0Udov1quG33NvcscLc=
X-Google-Smtp-Source: ABdhPJwmYurVDHM3TNl9YIqF98zayucUEXhgtjAyOLqNoZBvPBYsp8eKH0LTsQjPORvpTe/p+ex04Q==
X-Received: by 2002:a63:3587:0:b0:374:a41b:6d78 with SMTP id c129-20020a633587000000b00374a41b6d78mr20430679pga.138.1646121288423;
        Mon, 28 Feb 2022 23:54:48 -0800 (PST)
Received: from google.com ([2620:15c:202:201:c174:264:5e49:f2cb])
        by smtp.gmail.com with ESMTPSA id lp4-20020a17090b4a8400b001bedba2df04sm1066669pjb.30.2022.02.28.23.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 23:54:47 -0800 (PST)
Date:   Mon, 28 Feb 2022 23:54:45 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, tiwai@suse.de,
        mpdesouza@suse.com, arnd@arndb.de, samuel@cavoj.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] input/i8042: Add TUXEDO/Clevo devices to i8042 quirk
 tables
Message-ID: <Yh3RRT7xgY+PJfrQ@google.com>
References: <20220228114819.32949-1-wse@tuxedocomputers.com>
 <af476269-0722-218d-0fe6-404a9bab736f@redhat.com>
 <a6bfc728-dd47-84fa-1587-3af3049cb0c9@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6bfc728-dd47-84fa-1587-3af3049cb0c9@tuxedocomputers.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 28, 2022 at 07:50:55PM +0100, Werner Sembach wrote:
> Am 28.02.22 um 14:00 schrieb Hans de Goede:
> > Hi all,
> >
> > On 2/28/22 12:48, Werner Sembach wrote:
> >> A lot of modern Clevo barebones have touchpad and/or keyboard issues after
> >> suspend, fixable with reset + nomux + nopnp + noloop. Luckily, none of them
> >> have an external PS/2 port so this can safely be set for all of them.
> >>
> >> I'm not entirely sure if every device listed really needs all four quirks,
> >> but after testing and production use. No negative effects could be
> >> observed when setting all four.
> >>
> >> The list is quite massive as neither the TUXEDO nor the Clevo dmi strings
> >> have been very consistent historically. I tried to keep the list as short
> >> as possible without risking on missing an affected device.
> >>
> >> This is revision 2 where the Clevo N150CU barebone is removed again, as it
> >> might have problems with the fix and needs further investigations. Also
> >> the SchenkerTechnologiesGmbH System-/Board-Vendor string variations are
> >> added.
> >>
> >> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> >> Cc: stable@vger.kernel.org
> > Looking at the patch I think it would be better to split this into
> > 2 patches":
> >
> > 1. Merge all the existing separate tables into 1 table and use the dmi_system_id.driver_data
> > field to store which combination of the 4 quirks apply to which models.
> >
> > This will already help reducing the tables since some of the models are
> > already listed in 2 or more tables. So you would get something like this:
> >
> > #define SERIO_QUIRK_RESET		BIT(0)
> > #define SERIO_QUIRK_NOMUX		BIT(1)
> > #define SERIO_QUIRK_NOPNP		BIT(2)
> > #define SERIO_QUIRK_NOLOOP		BIT(3)
> > #define SERIO_QUIRK_NOSELFTEST		BIT(4)
> > // etc.
> >
> > static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
> >         {
> >                 /* Entroware Proteus */
> >                 .matches = {
> >                         DMI_MATCH(DMI_SYS_VENDOR, "Entroware"),
> >                         DMI_MATCH(DMI_PRODUCT_NAME, "Proteus"),
> >                         DMI_MATCH(DMI_PRODUCT_VERSION, "EL07R4"),
> >                 },
> > 		.driver_data = (void *)(SERIO_QUIRK_RESET | SERIO_QUIRK_NOMUX)
> >         },
> > 	{}
> > };
> >
> > I picked the Entroware EL07R4 as example here because it needs both the reset and nomux quirks.
> >
> > And then when checking the quirks do:
> >
> > #ifdef CONFIG_X86
> > 	const struct dmi_system_id *dmi_id;
> > 	long quirks = 0;
> >
> > 	dmi_id = dmi_first_match(i8042_dmi_quirk_table);
> > 	if (dmi_id)
> > 		quirks = (long)dmi_id->driver_data;
> >
> > 	if (i8042_reset == I8042_RESET_DEFAULT) {
> > 		if (quirks & SERIO_QUIRK_RESET)
> > 			i8042_reset = I8042_RESET_ALWAYS;
> > 		if (quirks & SERIO_QUIRK_NOSELFTEST)
> > 			i8042_reset = I8042_RESET_NEVER;
> > 	}
> >
> > 	//etc.
> >
> >
> > This way you can reduce all the tables to just 1 table. Please
> > also sort the table alphabetically, first by vendor, then sub-sort
> > by model. This way you can find more entries to merge and it
> > is a good idea to have big tables like this sorted in some way
> > regardless.
> >
> >
> > And then once this big refactoring patch is done (sorry), you
> > can add a second patch on top:
> >
> > 2. Add the models you want to quirk to the new merged tabled
> > and now you only need to add 1 table entry per model, rather
> > then 4, making the patch much smaller.
> >
> >
> > This is a refactoring which IMHO we should likely already
> > have done a while ago, but now with your patch it really is
> > time we do this.
> >
> > I hope the above makes sense, if not don't hesitate to ask
> > questions. Also note this is how *I* would do this, but
> > I'm not the input subsys-maintainer, ultimately this is
> > Dmitry's call and he may actually dislike with I'm proposing!
> Yes, it does make sense. I could follow you and I too think it's a good idea. I will hopefully find time to work on this
> refactoring in the next days.

Yes, I think this is a great idea as we have many instances where
the same entries are present in several tables.

> >
> > I don't expect that Dmitry will dislike this, but you never know.
> >
> > Also unfortunately Dmitry lately has only a limited amount of
> > time to spend on input subsys maintenance so in my experience
> > it may be a while before you get a reply from Dmitry.
> 
> Ok, thanks for the info. As I wrote in the other mail, I was worried (or paranoid xD) that I got flagged as spam or
> something.

It did indeed, I am not sure why. This does not invalidate what Hans
said - lately I was not able to spend as much time on input as I wanted.

Regarding this patch - it looks like board names are pretty unique in
many cases, so I wonder if we could not save some memory by omitting the
vendor info (especially because some, like "Notebook", are very generic
anyways) and go simply by the board.

Thanks.

-- 
Dmitry
