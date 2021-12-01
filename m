Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4BA4648D0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347778AbhLAHhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:37:02 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33820 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347928AbhLAHfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:35:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 71C6B212BE;
        Wed,  1 Dec 2021 07:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638343909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XkzVst0CeRLi4PN5VFMhw1lrXrKmtfeuvslxONhsuxM=;
        b=KDIYxXv9cvRQWuEbAoxyieahFcrny08DtawQqQtqSePXkXmTf+8plm0XQanksJGTC9EPZo
        CF9EIjI2/KehLiLxeAGi3FIkHImE7hYjB15hP5PhLwmoaWJyLu0iD4PpgJleI+7QXk75cE
        pb/e+JuFuxEQoCUvYZMEepdhAPvT4+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638343909;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XkzVst0CeRLi4PN5VFMhw1lrXrKmtfeuvslxONhsuxM=;
        b=IFb2DEbzV2CK7tg/UlYVRzyjTTbo/sjAW+cZEgo2m0bq82tW/D8cQiLRNyfbWTBIkjTpiP
        O/UfmmCTHM2hPBCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15FC513AE2;
        Wed,  1 Dec 2021 07:31:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oIayBOUkp2HbFgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 01 Dec 2021 07:31:49 +0000
Subject: Re: [PATCH 13/18] crypto: testmgr - add DH test vectors for key
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
References: <20211201004858.19831-1-nstange@suse.de>
 <20211201004858.19831-14-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <84bf73e5-1a4a-1c4e-8ee3-c5ba10324b05@suse.de>
Date:   Wed, 1 Dec 2021 08:31:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211201004858.19831-14-nstange@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 1:48 AM, Nicolai Stange wrote:
> Now that all DH implementations support ephemeral key generation triggered
> by passing a ->key_size of zero to ->set_secret(), it's certainly
> worthwhile to build upon the testmgr's do_test_kpp() ->genkey facility to
> test it.
> 
> Add two ->genkey DH test vectors to the testmgr, one for the RFC 7919
> ffdhe2048 group and another one for the RFC 3526 modp2048 group.
> 
As noted previously, maybe you can consider switching to ffdhe3072 here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
