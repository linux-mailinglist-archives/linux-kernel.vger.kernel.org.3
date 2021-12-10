Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFCD470029
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbhLJLkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:40:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46980 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhLJLks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:40:48 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED6CB1F3A0;
        Fri, 10 Dec 2021 11:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639136231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lngrIVtYMbZhKQO26V52lBf3QiqSOpE1elMOcFTE+k0=;
        b=wu6MJ1PDLlL8D0vDxz1UMG4rlI/VuCaNyKcPtyzOWl2Un5WlYuw9NzFIkJ2sJTNOmzvb2O
        8TOa7HrZx0xQMAkLjCj0rgZT2mPvQDQcIxFYt7H2GjVXTbGJ4Z6PSuBMMnq6lZj8JvrDsR
        46zaMt+3v8XSpdDF+nZMK820EDPs/68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639136231;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lngrIVtYMbZhKQO26V52lBf3QiqSOpE1elMOcFTE+k0=;
        b=OrAEkTDLveSpD2xMOsrCuGALxmHqxW65gYb2kGkgNRWu1bCa5+N5UFAZWZHzg53dmglrAo
        HEvUz6A0PCVSjZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D936213DDE;
        Fri, 10 Dec 2021 11:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /Ra+NOc7s2GMcAAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 10 Dec 2021 11:37:11 +0000
Subject: Re: [PATCH v2 13/18] crypto: testmgr - add DH test vectors for key
 generation
To:     Nicolai Stange <nstange@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?Q?Stephan_M=c3=bcller?= <smueller@chronox.de>,
        Torsten Duwe <duwe@suse.de>, Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org
References: <20211209090358.28231-1-nstange@suse.de>
 <20211209090358.28231-14-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <dd2af30b-aa5a-616d-f6c8-de49f328f161@suse.de>
Date:   Fri, 10 Dec 2021 12:37:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211209090358.28231-14-nstange@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 10:03 AM, Nicolai Stange wrote:
> Now that all DH implementations support ephemeral key generation triggered
> by passing a ->key_size of zero to ->set_secret(), it's certainly
> worthwhile to build upon the testmgr's do_test_kpp() ->genkey facility to
> test it.
> 
> Add two ->genkey DH test vectors to the testmgr, one for the RFC 7919
> ffdhe3072 group and another one for the RFC 3526 modp2048 group. For the
> resp. party B's keypair, just reuse the already available values
> previously specified for party A in the existing known answer tests. This
> will enable the compiler to merge these rather large data strings.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  crypto/testmgr.h | 164 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
