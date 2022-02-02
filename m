Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7964A7165
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344300AbiBBNT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:19:29 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58186 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiBBNT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:19:27 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 34DEB212B5;
        Wed,  2 Feb 2022 13:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643807966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ulFfKXoRq8QJukyKpX0WjkN9+vmh3h2i2KxS5J3haRQ=;
        b=DGEwghLPcWpzoCyyuOkZszuDl1Q8nqded/8dPqG8Q4YU7UWvuMuws+oda0lX7DvFwZ+65W
        XLmqjEpMg3A4TrGv93zlxgQ+Qy09zlx1ClX33wXVIJnWV+LhMQb61MKYsIUi4IlLy2c44/
        lsHCp3gnEtoVC69tYvIoR77t/2E1jZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643807966;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ulFfKXoRq8QJukyKpX0WjkN9+vmh3h2i2KxS5J3haRQ=;
        b=MK6+KnaE5ttkGnMgjHwh7+EWvFddHB6ebwBy9l80HtxfBniDhBKSGdFapKAUgiUVemN/AT
        0MJWjC+AmEHj1gCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23CC913E48;
        Wed,  2 Feb 2022 13:19:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GJBXCN6E+mFeQwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 02 Feb 2022 13:19:26 +0000
Message-ID: <7a8e472b-8534-957e-6c32-49d3b919f382@suse.de>
Date:   Wed, 2 Feb 2022 14:19:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv2 6/7] block: add pi for nvme enhanced integrity
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de
References: <20220201190128.3075065-1-kbusch@kernel.org>
 <20220201190128.3075065-7-kbusch@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220201190128.3075065-7-kbusch@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 20:01, Keith Busch wrote:
> The NVMe specification defines larger data integrity formats beyond the
> t10 tuple. Add support for the specification defined CRC64 formats,
> assuming the reference tag does not need to be split with the "storage
> tag".
> 
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/Kconfig          |   1 +
>   block/t10-pi.c         | 194 +++++++++++++++++++++++++++++++++++++++++
>   include/linux/t10-pi.h |  20 +++++
>   3 files changed, 215 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
