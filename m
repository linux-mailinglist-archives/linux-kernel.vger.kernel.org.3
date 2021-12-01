Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E85F4647B3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhLAHRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:17:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60698 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347166AbhLAHQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:16:29 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 02501212CC;
        Wed,  1 Dec 2021 07:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638342788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dqrp32hZrM+7oG23uaij5da1W3SNDTnXoLoM6S5HqRM=;
        b=omETKKHi7FfweJqdbc2dh8vv2gaj1VXGsuqpAmqW+afT+W/4eZIWRTV44o3qPcsUCNj7pw
        snBBAygEYKBm2KfWXhNx40kki7YuRbNR1MD0TieLPimnOtxrXxzF2LK1I43Qmmhcc82Y4P
        TaiXFbdWuQ1PNNB89fqs6sbe3oclafY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638342788;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dqrp32hZrM+7oG23uaij5da1W3SNDTnXoLoM6S5HqRM=;
        b=V5/hvK2MTfygHvXk147YudpxEdr2EpR6XcZxGLQJOVCBt47zmhX8Cfi1jY1kF7B8A1Tx6m
        HPEzPK8rP5CyQBDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D58913AE2;
        Wed,  1 Dec 2021 07:13:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BztaJYMgp2G1EAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 01 Dec 2021 07:13:07 +0000
Subject: Re: [PATCH 02/18] crypto: dh - constify struct dh's pointer members
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
 <20211201004858.19831-3-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <70ff24ff-94ce-6391-df7b-76f06bb7b48f@suse.de>
Date:   Wed, 1 Dec 2021 08:13:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211201004858.19831-3-nstange@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 1:48 AM, Nicolai Stange wrote:
> struct dh contains several pointer members corresponding to DH parameters:
> ->key, ->p and ->g. A subsequent commit will make the struct dh
> deserialization function, crypto_dh_decode_key(), to set these to
> constant static storage arrays for some of the well-known safe-prime
> groups.
> 
> Turn the struct dh pointer members' types into "pointer to const" in
> preparation for this.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   include/crypto/dh.h | 6 +++---
>   security/keys/dh.c  | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
