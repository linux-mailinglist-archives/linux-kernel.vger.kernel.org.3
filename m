Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287A04C29C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiBXKmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiBXKmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:42:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0FE16A5AA;
        Thu, 24 Feb 2022 02:42:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D288E1F37F;
        Thu, 24 Feb 2022 10:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645699340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=un0BuqJuVU1sQinMUaFtlLJAo+Lpb+W/ppoYZ+BlX8g=;
        b=eUgnJqMNMhrsuPaaKDC61tdG0ULuVATBZqrbXZVSyS94IBluKCFDdWdpZj7qpihfVrbpvK
        3QtT0lMV2PeOadwn4RbM6SVBH2FI4/OYKmYpl2Ad2B4jJdJXNQcz8GWXFnRBxoIPVb9Di/
        69xH5Cc8FAE2KFKULBzA+bHCfp0KdHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645699340;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=un0BuqJuVU1sQinMUaFtlLJAo+Lpb+W/ppoYZ+BlX8g=;
        b=h0J/heLskiTMueR9Db4IvRC3vPtuEudjanAG3sfvRbDxd7P4sDhuhhjKhPSfAbsvcIXY25
        PHdX08wy60TaT/AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AFBE3132C1;
        Thu, 24 Feb 2022 10:42:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ypukKQxhF2LkQwAAMHmgww
        (envelope-from <jslaby@suse.cz>); Thu, 24 Feb 2022 10:42:20 +0000
Message-ID: <b8e3d88c-2340-2247-2e1a-37c089d9065a@suse.cz>
Date:   Thu, 24 Feb 2022 11:42:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/5] tty: serial: define UART_LCR_WLEN() macro
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220224095517.30872-1-jslaby@suse.cz>
 <20220224095558.30929-1-jslaby@suse.cz> <YhdZjDO2mBgjSLep@kroah.com>
From:   Jiri Slaby <jslaby@suse.cz>
In-Reply-To: <YhdZjDO2mBgjSLep@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 02. 22, 11:10, Greg KH wrote:
> On Thu, Feb 24, 2022 at 10:55:54AM +0100, Jiri Slaby wrote:
>> Define a generic UART_LCR_WLEN() macro with a size argument. It can be
>> used to encode byte size into an LCR value. Therefore we can use it to
>> simplify the drivers using tty_get_char_size() in the next patches.
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
>>   include/uapi/linux/serial_reg.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
>> index f51bc8f36813..c9d5ff6dd4c6 100644
>> --- a/include/uapi/linux/serial_reg.h
>> +++ b/include/uapi/linux/serial_reg.h
>> @@ -111,6 +111,7 @@
>>   #define UART_LCR_WLEN6		0x01 /* Wordlength: 6 bits */
>>   #define UART_LCR_WLEN7		0x02 /* Wordlength: 7 bits */
>>   #define UART_LCR_WLEN8		0x03 /* Wordlength: 8 bits */
>> +#define UART_LCR_WLEN(x)	((x) - 5)
> 
> I'm all for this, but why does it need to be in a uapi .h file?

I'd love to put it somewhere else. But I didn't find an appropriate 
place. Should I put it simply to
include/linux/serial_core.h
or
include/linux/serial.h
? Or create a new:
include/linux/serial_reg.h
to contain only this def?

thanks,
-- 
js
suse labs
