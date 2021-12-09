Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7CC46E520
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhLIJLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:11:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36214 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhLIJLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:11:40 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 86AB71FD2A;
        Thu,  9 Dec 2021 09:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639040886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tLFdjNZfLY6f0ElyPXyDTCXm0HIogDmC64cCR6wLmps=;
        b=FL5isFmtRC7uaXOrAWIpLTKgFIfgdZCJ0ixXMmTTiJH8PelasSleVhEz044eZm3Ic1CqI3
        XcQntN2JbusXeBWCxdrTX8Dqc+b5abjZjoDwZO6GMnUNiMG2lzdPdxKdmIrIALLlO/2+t5
        /idG98E0249KFMz5t3qWzI3zx4KzGNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639040886;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tLFdjNZfLY6f0ElyPXyDTCXm0HIogDmC64cCR6wLmps=;
        b=Opw+9q0OReRTSbbfIiFOSZlO71nJKRSyXkXh2gIPCpYdJ5NEU03/cNCpcSsUE8nXYD1kgz
        Ow56dzNZdSpfXlCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0069113CB1;
        Thu,  9 Dec 2021 09:08:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Cy3yOXXHsWHUawAAMHmgww
        (envelope-from <nstange@suse.de>); Thu, 09 Dec 2021 09:08:05 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Nicolai Stange <nstange@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stephan =?utf-8?Q?M=C3=BCller?= <smueller@chronox.de>,
        Torsten Duwe <duwe@suse.de>, Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org
Subject: Re: [PATCH 03/18] crypto: dh - optimize domain parameter serialization for well-known groups
In-Reply-To: <418bccca-9d84-76b3-1f87-03b677688ca4@suse.de> (Hannes Reinecke's
        message of "Wed, 1 Dec 2021 08:17:22 +0100")
References: <20211201004858.19831-1-nstange@suse.de>
        <20211201004858.19831-4-nstange@suse.de>
        <418bccca-9d84-76b3-1f87-03b677688ca4@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
Date:   Thu, 09 Dec 2021 10:08:05 +0100
Message-ID: <87wnkervre.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes Reinecke <hare@suse.de> writes:

> On 12/1/21 1:48 AM, Nicolai Stange wrote:
>> diff --git a/crypto/dh_helper.c b/crypto/dh_helper.c
>> index aabc91e4f63f..a6c9389d8219 100644
>> --- a/crypto/dh_helper.c
>> +++ b/crypto/dh_helper.c
>> @@ -10,7 +10,32 @@
>>   #include <crypto/dh.h>
>>   #include <crypto/kpp.h>
>>   -#define DH_KPP_SECRET_MIN_SIZE (sizeof(struct kpp_secret) + 3 *
>> sizeof(int))
>> +#define DH_KPP_SECRET_MIN_SIZE (sizeof(struct kpp_secret) + \
>> +				sizeof(enum dh_group_id) + 3 * sizeof(int))
>
> That is not a good practise; 'enum' doesn't have a defined size, and
> will typically default to 'unsigned int'.
> But this might well be compiler dependent, so I suggest using a fixes
> size here.

Good point, in particular as a certain encoding is assumed for the test
vectors. Changed in v2.

Thanks,

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, G=
ermany
(HRB 36809, AG N=C3=BCrnberg), GF: Ivo Totev
