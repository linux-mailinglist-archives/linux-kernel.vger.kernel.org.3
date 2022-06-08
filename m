Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD7E5427EC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiFHH2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345627AbiFHHVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:21:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A66D1E0AD1;
        Tue,  7 Jun 2022 23:56:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3C7DF1F892;
        Wed,  8 Jun 2022 06:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654671353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IebUOuXZgGMy6rP6OXWxE6gEj78V4TN+Hj4F0d0N5dU=;
        b=ajwnL4PUcLY1j9dRjoQXPjxlOHNenz0KMt+wfS8+qgyME5mhN+GMuOyjnovlVoQ51ggvyc
        /5Yb1Cf3fRr5nfLk2gHHugShl3QQ2bmsXDAuqZ3wE4snTRNS2vjRizytSfp2tZDuYLVUTI
        0m/DiEjSNJ2iqVyyOqTeY282cJQI+xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654671353;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IebUOuXZgGMy6rP6OXWxE6gEj78V4TN+Hj4F0d0N5dU=;
        b=OdL/YLPirGKwgC+6hRMQR8eUBqwCeczQz+TgN70t4rALeHL87u7A1HKdY7hECnVgiwKHrq
        BtBMR9CtC67IYZAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F99D13A15;
        Wed,  8 Jun 2022 06:55:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MbNZBvlHoGJvDAAAMHmgww
        (envelope-from <jslaby@suse.cz>); Wed, 08 Jun 2022 06:55:53 +0000
Message-ID: <ab9bf4c2-48ed-1a14-9788-8a1672e29849@suse.cz>
Date:   Wed, 8 Jun 2022 08:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 03/36] tty/vt: consolemap: define UNI_* macros for
 constants
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220607104946.18710-1-jslaby@suse.cz>
 <20220607104946.18710-3-jslaby@suse.cz>
 <59e0ae93-c7b-2087-75f8-4da0de918250@linux.intel.com>
From:   Jiri Slaby <jslaby@suse.cz>
In-Reply-To: <59e0ae93-c7b-2087-75f8-4da0de918250@linux.intel.com>
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

On 07. 06. 22, 15:21, Ilpo Järvinen wrote:
> On Tue, 7 Jun 2022, Jiri Slaby wrote:
> 
>> The code uses constants for sizes of dictionary substructures on many
>> places. Define 3 macros and use them in the code, so that loop bounds,
>> local variables and the dictionary always match. (And the loop bounds
>> are obvious now too.)
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
>> -			for (k = 0; k < 64; k++) {
>> +			for (k = 0; k < UNI_ROW_GLYPHS; k++) {
>>   				glyph = p2[k];
>>   				if (glyph >= 0 && glyph < MAX_GLYPH
>>   					       && q[glyph] < 32)
> 
> Probably unrelated to this change but what's that < 32? It seems to appear
> twice related to the inverse mapping (and you didn't end up naming it).

That's ascii C0 test _IMO_.

thanks,
-- 
js
suse labs
