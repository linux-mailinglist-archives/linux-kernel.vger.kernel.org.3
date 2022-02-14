Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713114B4464
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbiBNIi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:38:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242179AbiBNIiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:38:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A6D3700D;
        Mon, 14 Feb 2022 00:38:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A0E57210E5;
        Mon, 14 Feb 2022 08:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644827922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fZM0iWT3T1NBMBOBN+XzRKxKKp985I1SF7a8fvxA5Ag=;
        b=GFXQ5jt8/QGNzR9y65U0AabFpRzoYWwpAw5tNKniJhnjx0EFXKnmNObU+N9zD+ajILDKVK
        rl1umzWT//J6ooKlbVTLTL/OFWRn62sdzzx0c5mmi52OgJYSSf/NXO7OMAD3q9hZncY/in
        P7vO/bvwrQjsdzdkDgqiiBEYjGZ9P10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644827922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fZM0iWT3T1NBMBOBN+XzRKxKKp985I1SF7a8fvxA5Ag=;
        b=oKx0dGME2ywwYTPDnkr0WWVD1wpOp/xk7IiBLOovWVFEFnnYe6TjXusPz3Sj3gC0hMeUaK
        cIFvhBI41mBmXBCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A11213780;
        Mon, 14 Feb 2022 08:38:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iNxhDBIVCmLoCQAAMHmgww
        (envelope-from <nstange@suse.de>); Mon, 14 Feb 2022 08:38:42 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Nicolai Stange <nstange@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        Stephan =?utf-8?Q?M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: Re: [PATCH v3 07/15] crypto: dh - implement ffdheXYZ(dh) templates
References: <20220202104012.4193-1-nstange@suse.de>
        <20220202104012.4193-8-nstange@suse.de>
        <YgYn3R5w65kgg3ri@gondor.apana.org.au>
Date:   Mon, 14 Feb 2022 09:38:42 +0100
In-Reply-To: <YgYn3R5w65kgg3ri@gondor.apana.org.au> (Herbert Xu's message of
        "Fri, 11 Feb 2022 20:09:49 +1100")
Message-ID: <87ilthvo4t.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> writes:

> On Wed, Feb 02, 2022 at 11:40:04AM +0100, Nicolai Stange wrote:
>>
>> +config CRYPTO_DH_RFC7919_GROUPS
>> +	bool "Support for RFC 7919 FFDHE group parameters"
>> +	default n
>
> default n should be removed as that is the default default :)

Ah! :)

Will fix that in v4.

Thanks,

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, G=
ermany
(HRB 36809, AG N=C3=BCrnberg), GF: Ivo Totev
