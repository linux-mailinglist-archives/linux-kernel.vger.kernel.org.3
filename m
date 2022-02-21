Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0454BDF4C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377374AbiBUONG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:13:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352856AbiBUOND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:13:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A96BCF8;
        Mon, 21 Feb 2022 06:12:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 168331F390;
        Mon, 21 Feb 2022 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645452758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ik/5/sClcPJ22cFlMbYZvoK5hwioeXaRCfcbVmrQpxY=;
        b=hj+ZkDa1XMJzVxurVlzIxccc2eeDnH0qiGT6AC/ZeQ2UhF+wyi4AVgCwszadbBQYq0YvFV
        C4aXZ3Wx0W20K4YU1Lkbym2gMuowwleFOjtWDnI7tAydgArajHc0HeE/tSr2TQWE+lYIQF
        QerZ0nCPRFmqiUuqT/94VYIay2zZhsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645452758;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ik/5/sClcPJ22cFlMbYZvoK5hwioeXaRCfcbVmrQpxY=;
        b=8qR8Xn2gqsbSmv3msiLaJeXhGwrRPkuR/e6Q7JY9YlwvlbsUxW+IRmMksEjtM2ZidGE4Q4
        AP6TyzDp53Pm/PBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB21813B21;
        Mon, 21 Feb 2022 14:12:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5dLRM9WdE2LiHgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 21 Feb 2022 14:12:37 +0000
Message-ID: <ee57afe1-9bfc-14a0-0139-1360e2bb4946@suse.de>
Date:   Mon, 21 Feb 2022 15:12:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 04/15] crypto: dh - constify struct dh's pointer
 members
Content-Language: en-US
To:     Nicolai Stange <nstange@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?Q?Stephan_M=c3=bcller?= <smueller@chronox.de>,
        Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20220221121101.1615-1-nstange@suse.de>
 <20220221121101.1615-5-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220221121101.1615-5-nstange@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 13:10, Nicolai Stange wrote:
> struct dh contains several pointer members corresponding to DH parameters:
> ->key, ->p and ->g. A subsequent commit will introduce "dh" wrapping
> templates of the form "ffdhe2048(dh)", "ffdhe3072(dh)" and so on in order
> to provide built-in support for the well-known safe-prime ffdhe group
> parameters specified in RFC 7919. These templates will need to set the
> group parameter related members of the (serialized) struct dh instance
> passed to the inner "dh" kpp_alg instance, i.e. ->p and ->g, to some
> constant, static storage arrays.
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
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
