Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C5157B5B3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbiGTLje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbiGTLjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:39:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D8A71BDC;
        Wed, 20 Jul 2022 04:39:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 61E2B33F64;
        Wed, 20 Jul 2022 11:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658317170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RCe2TPU9LUFhoFV6W5YhCg+pI/RXtQ+1Mlh93H/op3s=;
        b=brz1gVTaifMcXXbNkLEyUhtoworyKdlkxCk2J9bDnyHgsrlnQRAX6qMehh4oS21IA9BPt1
        7AnuyP5IqAY7CZi1tNvBKY0l+aJ/pPXU5DTyfj92P3d8Toj6Ge7ADpYVrL/R/8DJfQfk1N
        p4pi1sdI4Swt7rZb50MYSOr4u4arGEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658317170;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RCe2TPU9LUFhoFV6W5YhCg+pI/RXtQ+1Mlh93H/op3s=;
        b=BAGq1G93Yesa+YgZdJgR9n8g2e1baneV3S2NlLLA/5rfKCuI+8eD4PVYJ7QByimRJCoF5Z
        5YsgawL3J9A9IyDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4318C13AA1;
        Wed, 20 Jul 2022 11:39:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s0W1D3Lp12K4SwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 20 Jul 2022 11:39:30 +0000
Message-ID: <1f8867c6-1bdf-0614-aeed-d39e328fda82@suse.de>
Date:   Wed, 20 Jul 2022 13:39:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvmet-auth: select the intended CRYPTO_DH_RFC7919_GROUPS
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220720113717.31854-1-lukas.bulwahn@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220720113717.31854-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/22 13:37, Lukas Bulwahn wrote:
> Commit 71ebe3842ebe ("nvmet-auth: Diffie-Hellman key exchange support")
> intends to select 'Support for RFC 7919 FFDHE group parameters' for using
> FFDHE groups for NVMe In-Band Authentication.
> 
> It however selects CRYPTO_DH_GROUPS_RFC7919, instead of the intended
> CRYPTO_DH_RFC7919_GROUPS; notice the swapping of words here.
> 
> Correct the select to the intended config option.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>   drivers/nvme/target/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
> index f0c91f7686a3..79fc64035ee3 100644
> --- a/drivers/nvme/target/Kconfig
> +++ b/drivers/nvme/target/Kconfig
> @@ -93,7 +93,7 @@ config NVME_TARGET_AUTH
>   	select CRYPTO_SHA256
>   	select CRYPTO_SHA512
>   	select CRYPTO_DH
> -	select CRYPTO_DH_GROUPS_RFC7919
> +	select CRYPTO_DH_RFC7919_GROUPS
>   	help
>   	  This enables support for NVMe over Fabrics In-band Authentication
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
