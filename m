Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836B04A7142
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344205AbiBBNLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:11:15 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57486 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiBBNLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:11:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8CC97212B5;
        Wed,  2 Feb 2022 13:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643807473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y1vdxpzI7EjUSPvPN4bFfe0t93Iya3IKe+RvVci8dVo=;
        b=X3+GP8crsfhgoy2q8nRId53w++uim/wW9Wa65WLnT3/MmpkL7KnMD/MqFWKL5esiUgmSZo
        Xwv6qfkIQX8KqrzSHDrmFCwLHlpjyGabJ6zlVM+r4lMvI8vw1vkuawR/SWUATE/IUZgsXX
        KMQGcUgQGBCHu45ZspB9i/zOucIXBn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643807473;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y1vdxpzI7EjUSPvPN4bFfe0t93Iya3IKe+RvVci8dVo=;
        b=wXLwDVkH0dWasbv9g8lh5s9tt/SJ3sUza+RgqnkfR9klA5mjPk+nsQkASQFPO649Epay5p
        BTIa9XrSriYZLuCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C02413E48;
        Wed,  2 Feb 2022 13:11:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BybZHfGC+mGtPgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 02 Feb 2022 13:11:13 +0000
Message-ID: <fe7f1960-2c1d-cbde-11e4-989408e41881@suse.de>
Date:   Wed, 2 Feb 2022 14:11:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv2 1/7] block: support pi with extended metadata
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de
References: <20220201190128.3075065-1-kbusch@kernel.org>
 <20220201190128.3075065-2-kbusch@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220201190128.3075065-2-kbusch@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 20:01, Keith Busch wrote:
> The nvme spec allows protection information formats with metadata
> extending beyond the pi field. Use the actual size of the metadata field
> for incrementing the protection buffer.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/bio-integrity.c         | 1 +
>   block/t10-pi.c                | 4 ++--
>   include/linux/blk-integrity.h | 1 +
>   3 files changed, 4 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
