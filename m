Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E090054ACD0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbiFNJDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237318AbiFNJDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:03:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCF736E20;
        Tue, 14 Jun 2022 02:03:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 47F0021AC5;
        Tue, 14 Jun 2022 09:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655197396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZalrUwXcMUE8CIDPQn8NdTkEdaFMvMEgN/XeVrNXZ54=;
        b=H7ybuSDCf8e0hmfQK2WI5YmfH1VAdK1zuap9bliQFVToyLNx2tyG/UGOoDkwY2rmXzDbKH
        xMo+ngCJ2iiZBDppg5SNOju6qKCbLI1tIw495VFtvpJBWlf26AhDP9tIoI0iMlXQl87gaE
        tc1GmTAYTHhopoVOApkKn2DweLavBfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655197396;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZalrUwXcMUE8CIDPQn8NdTkEdaFMvMEgN/XeVrNXZ54=;
        b=zE9wIcsFY8YElhYssHhnnLbNj1hkES6wI39NEgL1ci9S9GOc3SILn0+9BulTLsQrPfEP+i
        tXukehRbrfREo4Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15E07139EC;
        Tue, 14 Jun 2022 09:03:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Hv/OA9ROqGKiLgAAMHmgww
        (envelope-from <jslaby@suse.cz>); Tue, 14 Jun 2022 09:03:16 +0000
Message-ID: <3681d7dd-94f0-5b40-85ec-5fa5e22d213f@suse.cz>
Date:   Tue, 14 Jun 2022 11:03:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/7] tty/vt: consolemap: use ARRAY_SIZE(), part II.
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220614075713.32767-1-jslaby@suse.cz>
 <68107f11-58bb-5c55-8f45-891717d08d33@linux.intel.com>
From:   Jiri Slaby <jslaby@suse.cz>
In-Reply-To: <68107f11-58bb-5c55-8f45-891717d08d33@linux.intel.com>
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

On 14. 06. 22, 10:17, Ilpo Järvinen wrote:
> On Tue, 14 Jun 2022, Jiri Slaby wrote:
> 
>> The code still uses constants (macros) as bounds in loops after commit
>> 17945d317a52 (tty/vt: consolemap: use ARRAY_SIZE()). The contants are at
>> least macros used also in the definition of the arrays. But use
>> ARRAY_SIZE() on two more places to ensure the loops never run out of
>> bounds even if the array definition change.
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
>>   drivers/tty/vt/consolemap.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
>> index fff97ae87e00..8aa7a48b3647 100644
>> --- a/drivers/tty/vt/consolemap.c
>> +++ b/drivers/tty/vt/consolemap.c
>> @@ -232,7 +232,7 @@ static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *p,
>>   	}
>>   	memset(q, 0, MAX_GLYPH);
>>   
>> -	for (j = 0; j < E_TABSZ; j++) {
>> +	for (j = 0; j < ARRAY_SIZE(translations[i]); j++) {
> 
> Any particular reason why you left its definition to have 256 instead of
> E_TABSZ (even after the patch series I mean):
> 
> static unsigned short translations[][256] = {

I will. (Only if it wasn't so badly chosen name. And even exported to 
userspace.)

thanks,
-- 
js
suse labs
