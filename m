Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A684C8F54
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbiCAPnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiCAPnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:43:39 -0500
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0384B866;
        Tue,  1 Mar 2022 07:42:57 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 69332C8008D;
        Tue,  1 Mar 2022 16:42:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id x_E1zIiXs8qD; Tue,  1 Mar 2022 16:42:55 +0100 (CET)
Received: from [192.168.176.112] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id D1AE9C80089;
        Tue,  1 Mar 2022 16:42:54 +0100 (CET)
Message-ID: <16c301ff-6e38-11e9-9305-efb91213e811@tuxedocomputers.com>
Date:   Tue, 1 Mar 2022 16:42:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] input/i8042: Add TUXEDO/Clevo devices to i8042 quirk
 tables
Content-Language: de-DE
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, tiwai@suse.de,
        mpdesouza@suse.com, arnd@arndb.de, samuel@cavoj.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220228114819.32949-1-wse@tuxedocomputers.com>
 <af476269-0722-218d-0fe6-404a9bab736f@redhat.com>
 <a6bfc728-dd47-84fa-1587-3af3049cb0c9@tuxedocomputers.com>
 <Yh3RRT7xgY+PJfrQ@google.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <Yh3RRT7xgY+PJfrQ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 01.03.22 um 08:54 schrieb Dmitry Torokhov:
> Hi,
>
> On Mon, Feb 28, 2022 at 07:50:55PM +0100, Werner Sembach wrote:
>> Am 28.02.22 um 14:00 schrieb Hans de Goede:
>>> Hi all,
>>>
>>> On 2/28/22 12:48, Werner Sembach wrote:
>>>> A lot of modern Clevo barebones have touchpad and/or keyboard issues after
>>>> suspend, fixable with reset + nomux + nopnp + noloop. Luckily, none of them
>>>> have an external PS/2 port so this can safely be set for all of them.
>>>>
>>>> I'm not entirely sure if every device listed really needs all four quirks,
>>>> but after testing and production use. No negative effects could be
>>>> observed when setting all four.
>>>>
>>>> The list is quite massive as neither the TUXEDO nor the Clevo dmi strings
>>>> have been very consistent historically. I tried to keep the list as short
>>>> as possible without risking on missing an affected device.
>>>>
>>>> This is revision 2 where the Clevo N150CU barebone is removed again, as it
>>>> might have problems with the fix and needs further investigations. Also
>>>> the SchenkerTechnologiesGmbH System-/Board-Vendor string variations are
>>>> added.
>>>>
>>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>>> Cc: stable@vger.kernel.org
>>> Looking at the patch I think it would be better to split this into
>>> 2 patches":
>>>
>>> 1. Merge all the existing separate tables into 1 table and use the dmi_system_id.driver_data
>>> field to store which combination of the 4 quirks apply to which models.
>>>
>>> This will already help reducing the tables since some of the models are
>>> already listed in 2 or more tables. So you would get something like this:
>>>
>>> #define SERIO_QUIRK_RESET		BIT(0)
>>> #define SERIO_QUIRK_NOMUX		BIT(1)
>>> #define SERIO_QUIRK_NOPNP		BIT(2)
>>> #define SERIO_QUIRK_NOLOOP		BIT(3)
>>> #define SERIO_QUIRK_NOSELFTEST		BIT(4)
>>> // etc.
>>>
>>> static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
>>>         {
>>>                 /* Entroware Proteus */
>>>                 .matches = {
>>>                         DMI_MATCH(DMI_SYS_VENDOR, "Entroware"),
>>>                         DMI_MATCH(DMI_PRODUCT_NAME, "Proteus"),
>>>                         DMI_MATCH(DMI_PRODUCT_VERSION, "EL07R4"),
>>>                 },
>>> 		.driver_data = (void *)(SERIO_QUIRK_RESET | SERIO_QUIRK_NOMUX)
>>>         },
>>> 	{}
>>> };
>>>
>>> I picked the Entroware EL07R4 as example here because it needs both the reset and nomux quirks.
>>>
>>> And then when checking the quirks do:
>>>
>>> #ifdef CONFIG_X86
>>> 	const struct dmi_system_id *dmi_id;
>>> 	long quirks = 0;
>>>
>>> 	dmi_id = dmi_first_match(i8042_dmi_quirk_table);
>>> 	if (dmi_id)
>>> 		quirks = (long)dmi_id->driver_data;
>>>
>>> 	if (i8042_reset == I8042_RESET_DEFAULT) {
>>> 		if (quirks & SERIO_QUIRK_RESET)
>>> 			i8042_reset = I8042_RESET_ALWAYS;
>>> 		if (quirks & SERIO_QUIRK_NOSELFTEST)
>>> 			i8042_reset = I8042_RESET_NEVER;
>>> 	}
>>>
>>> 	//etc.
>>>
>>>
>>> This way you can reduce all the tables to just 1 table. Please
>>> also sort the table alphabetically, first by vendor, then sub-sort
>>> by model. This way you can find more entries to merge and it
>>> is a good idea to have big tables like this sorted in some way
>>> regardless.
>>>
>>>
>>> And then once this big refactoring patch is done (sorry), you
>>> can add a second patch on top:
>>>
>>> 2. Add the models you want to quirk to the new merged tabled
>>> and now you only need to add 1 table entry per model, rather
>>> then 4, making the patch much smaller.
>>>
>>>
>>> This is a refactoring which IMHO we should likely already
>>> have done a while ago, but now with your patch it really is
>>> time we do this.
>>>
>>> I hope the above makes sense, if not don't hesitate to ask
>>> questions. Also note this is how *I* would do this, but
>>> I'm not the input subsys-maintainer, ultimately this is
>>> Dmitry's call and he may actually dislike with I'm proposing!
>> Yes, it does make sense. I could follow you and I too think it's a good idea. I will hopefully find time to work on this
>> refactoring in the next days.
> Yes, I think this is a great idea as we have many instances where
> the same entries are present in several tables.
No problem. I hope mail mails get through now ^^.
>
>>> I don't expect that Dmitry will dislike this, but you never know.
>>>
>>> Also unfortunately Dmitry lately has only a limited amount of
>>> time to spend on input subsys maintenance so in my experience
>>> it may be a while before you get a reply from Dmitry.
>> Ok, thanks for the info. As I wrote in the other mail, I was worried (or paranoid xD) that I got flagged as spam or
>> something.
> It did indeed, I am not sure why. This does not invalidate what Hans
> said - lately I was not able to spend as much time on input as I wanted.
>
> Regarding this patch - it looks like board names are pretty unique in
> many cases, so I wonder if we could not save some memory by omitting the
> vendor info (especially because some, like "Notebook", are very generic
> anyways) and go simply by the board.
Think in this case it would be helpful to have a DMI_MATCH_NOT at hand, just in case there is a collision in the future.

Kind regards,

Werner Sembach

>
> Thanks.
>
