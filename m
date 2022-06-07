Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0779E5414FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 22:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376276AbiFGU0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 16:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356311AbiFGTgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 15:36:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D6B1AA3FD;
        Tue,  7 Jun 2022 11:13:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 925351F8AB;
        Tue,  7 Jun 2022 18:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654625591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3y9oQxsxgLQFrSB/OPrvIt+A2m61bGJ7Vng43pViMbo=;
        b=29P4yZRt6ViS62lTjFMYGu+vcbqJOiMtOfQt3lmbRTdhSWgG4r00CofYzAHbK4eVmlP3x5
        gj7DMHTU79BCZT6dktEJw+vzV7U473tyY+GWcFoxE/qsXYuNxvreCG7fAGt1oxWHz0RqbF
        +DoXgklCaKlR/NPhXRzOqDcB2CX3wUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654625591;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3y9oQxsxgLQFrSB/OPrvIt+A2m61bGJ7Vng43pViMbo=;
        b=8bvrjGsUK6CVtP+9scEDo2jd0QG1SFNbQ7R60qz6tX74AiD8zMfzKdP1ZpHw4+fwsWCmeb
        DbTRokH6KkfmBZDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 611DC13638;
        Tue,  7 Jun 2022 18:13:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mbF1FjeVn2KgIwAAMHmgww
        (envelope-from <jslaby@suse.cz>); Tue, 07 Jun 2022 18:13:11 +0000
Message-ID: <37ced336-ac77-4c8f-1142-1f55c01383ca@suse.cz>
Date:   Tue, 7 Jun 2022 20:13:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 12/36] tty/vt: consolemap: use sizeof(*pointer) instead of
 sizeof(type)
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220607104946.18710-1-jslaby@suse.cz>
 <20220607104946.18710-12-jslaby@suse.cz>
 <8c809bd0-552d-8027-a1a7-96b77369d06e@linux.intel.com>
From:   Jiri Slaby <jslaby@suse.cz>
In-Reply-To: <8c809bd0-552d-8027-a1a7-96b77369d06e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 06. 22, 16:00, Ilpo Järvinen wrote:
> On Tue, 7 Jun 2022, Jiri Slaby wrote:
> 
>> It is preferred to use sizeof(*pointer) instead of sizeof(type). First,
>> the type of the variable can change and one needs not change the former
>> (unlike the latter). Second, the latter is error-prone due to (u16),
>> (u16 *), and (u16 **) mixture here.
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> This seems fine but see the comments below which are not directly related
> to the change itself.
> 
>> ---
>>   drivers/tty/vt/consolemap.c | 23 ++++++++++++-----------
>>   1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
>> index 097ab7d01f8b..79a62dcca046 100644
>> --- a/drivers/tty/vt/consolemap.c
>> +++ b/drivers/tty/vt/consolemap.c
>> @@ -251,12 +251,12 @@ static void set_inverse_trans_unicode(struct vc_data *conp,
>>   		return;
>>   	q = p->inverse_trans_unicode;
>>   	if (!q) {
>> -		q = p->inverse_trans_unicode =
>> -			kmalloc_array(MAX_GLYPH, sizeof(u16), GFP_KERNEL);
>> +		q = p->inverse_trans_unicode = kmalloc_array(MAX_GLYPH,
>> +				sizeof(*q), GFP_KERNEL);
>>   		if (!q)
>>   			return;
>>   	}
>> -	memset(q, 0, MAX_GLYPH * sizeof(u16));
>> +	memset(q, 0, MAX_GLYPH * sizeof(*q));
> 
> Convert kmalloc_array into kcalloc and place memset() into else branch?

IMO, the way it is now is more obvious.

>> @@ -514,11 +514,12 @@ con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
>>   	n = UNI_ROW(unicode);
>>   	p2 = p1[n];
>>   	if (!p2) {
>> -		p2 = p1[n] = kmalloc_array(UNI_ROW_GLYPHS, sizeof(u16), GFP_KERNEL);
>> +		p2 = p1[n] = kmalloc_array(UNI_ROW_GLYPHS, sizeof(*p2),
>> +				GFP_KERNEL);
>>   		if (!p2)
>>   			return -ENOMEM;
>>   		/* No glyphs for the characters (yet) */
>> -		memset(p2, 0xff, UNI_ROW_GLYPHS * sizeof(u16));
>> +		memset(p2, 0xff, UNI_ROW_GLYPHS * sizeof(*p2));
> 
> This could have been kcalloc'ed.

Why would you zero it before setting it to 0xff?

thanks,
-- 
js
suse labs
