Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE5246FFFB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240522AbhLJLho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:37:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46502 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbhLJLhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:37:43 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0E87E1F3A1;
        Fri, 10 Dec 2021 11:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639136047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QHMN6OhdpnMUwdmm3MYUUGIG9YUa1qwQ4mmb1RDuZ10=;
        b=cgZc2DQOZJd1LWmwlepMjDJCP5gpeczqlmiU4ETaTHM13B5BoDkTzEKtQ18ET0EbQDAIBg
        q9ZV+tkFvAtBWTkgH3OhKpAy/yLKA6yb9vVRrlBAeq4PV/EX1NFZNXxmNgnOQOquz69nHT
        jJgfb8njjcAhJN2HYoGUkmEZN5+sB2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639136047;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QHMN6OhdpnMUwdmm3MYUUGIG9YUa1qwQ4mmb1RDuZ10=;
        b=UQJzSo1SSA+vvFzVQjcUJ5JtzCcX5dQ0zZBiLbzwQDmfW++d+pTaBDYaX7D1nhoQ/kEBI/
        zhYRoDIZ2rduo7Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E967E13DDE;
        Fri, 10 Dec 2021 11:34:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5MPIOC47s2FxbgAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 10 Dec 2021 11:34:06 +0000
Subject: Re: [PATCH v2 04/18] crypto: dh - introduce RFC 7919 safe-prime
 groups
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
 <20211209090358.28231-5-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e05bec05-eec1-3ce8-c2c3-02fc12fbca7c@suse.de>
Date:   Fri, 10 Dec 2021 12:34:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211209090358.28231-5-nstange@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 10:03 AM, Nicolai Stange wrote:
> The FFDHE groups specified by RFC 7919 are needed for the current work
> on NVME ([1]) and also among the safe-prime groups approved by
> SP800-56Arev3. Make them known to the kernel.
> 
> More specifically, introduce corresponding members to enum dh_group_id
> as well as entries with the resp. domain parameters to the
> safe_prime_groups[] array queried by crypto_dh_decode_key(). The resp.
> ->max_strength value is set to the maximum supported security strength as
> specified in SP800-56Arev3.
> 
> As the domain parameters consume an substantial amount of space, make
> RFC 7919 safe-prime group support selectable by means of the new
> CRYPTO_DH_GROUPS_RFC7919 Kconfig option.
> 
> [1] https://lkml.kernel.org/r/20211122074727.25988-4-hare@suse.de
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  crypto/Kconfig      |  11 ++-
>  crypto/dh_helper.c  | 219 +++++++++++++++++++++++++++++++++++++++++++-
>  include/crypto/dh.h |   7 ++
>  3 files changed, 235 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
