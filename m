Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3677F4BE22B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377489AbiBUOQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:16:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377480AbiBUOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:16:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A3B1EACF;
        Mon, 21 Feb 2022 06:16:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E6801F38E;
        Mon, 21 Feb 2022 14:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645452978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mPTCpil1Xfewi9hc/9wbClZOT5+wqwBi6ip5bNMm1LU=;
        b=bJAL3wv6AlwrsGWj8iy/HRJxm1B2talmVuRmMmMnQRrK8neMV9wz6E/ugtNaxqrJxS4oSE
        AQSZNsJulpvr0grIXQs4CrZdFjDp2BiZByYkM+WFExBTq84L6vhrEHvAYgcnRsf2o3kjub
        UzcjkMHuOe+2pW2ne1khaUiuJy1dq0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645452978;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mPTCpil1Xfewi9hc/9wbClZOT5+wqwBi6ip5bNMm1LU=;
        b=54ldWsPwPjV1CceJ8NT334S8dS1AZvP2mnT8W+iRdGulTOlBSbNVNv3dXKeW9cGEdgrjYF
        V1zUXgWV94mey/Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B1DE13B21;
        Mon, 21 Feb 2022 14:16:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yEanE7KeE2IzIQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 21 Feb 2022 14:16:18 +0000
Message-ID: <a2326220-e39e-cde7-e695-17e9441c2e66@suse.de>
Date:   Mon, 21 Feb 2022 15:16:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 08/15] crypto: testmgr - add known answer tests for
 ffdheXYZ(dh) templates
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
 <20220221121101.1615-9-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220221121101.1615-9-nstange@suse.de>
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
> Add known answer tests for the ffdhe2048(dh), ffdhe3072(dh), ffdhe4096(dh),
> ffdhe6144(dh) and ffdhe8192(dh) templates introduced with the previous
> patch to the testmgr. All TVs have been generated with OpenSSL.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   crypto/testmgr.c |  37 ++
>   crypto/testmgr.h | 871 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 908 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
