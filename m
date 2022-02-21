Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780BB4BE0B1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377535AbiBUOSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:18:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377571AbiBUOSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:18:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CA6220EE;
        Mon, 21 Feb 2022 06:18:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A445A210F2;
        Mon, 21 Feb 2022 14:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645453094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=82gPLlO5QtF+AVWw4iuCJXbOsPmXgwlp7fLL/sWjtlk=;
        b=EmGlhXXswhR5ta0SlhrxSpWxYvZ/ZgrlTKCcXj5XvPw5hRlSXBobok7dnnvn2ATiJ4o5yf
        6XRos5++IsecPGcd04LG64vntay2mao2OeurSHfY2RsdqpvedjitkIxrMYL0YZuQM8XRG9
        DgOiT4R6ClCuIoKPFa2NTy1uV/k0uwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645453094;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=82gPLlO5QtF+AVWw4iuCJXbOsPmXgwlp7fLL/sWjtlk=;
        b=2NL4vm6cNzkmUyOC/S7oEPpxickSfBBK78dv3VioTqFBRNROGBHf84liwseKlK/5hSpl+N
        3gRS9h+S/ddkSwCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73A2913B2F;
        Mon, 21 Feb 2022 14:18:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pjCSGSafE2JNIgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 21 Feb 2022 14:18:14 +0000
Message-ID: <efa504c2-f3a6-fab4-60aa-7d9e0e90b4c4@suse.de>
Date:   Mon, 21 Feb 2022 15:18:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 10/15] crypto: testmgr - add keygen tests for
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
 <20220221121101.1615-11-nstange@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220221121101.1615-11-nstange@suse.de>
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
> Now that the ffdheXYZ(dh) templates support ephemeral key generation, add
> ->keygen = 1 TVs for each of them to the testmgr.c.
> 
> In order to facilitate string merging by the compiler, set party B's secret
> and public keys to the ones specified for party A in the respective
> existing known answer test. With GCC 7.5 on x86_64, this leads to an
> increase of testmgr.o size by less than half a kB.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>   crypto/testmgr.h | 578 ++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 568 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
