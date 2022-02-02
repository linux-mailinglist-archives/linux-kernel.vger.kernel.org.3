Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C2A4A714F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344276AbiBBNOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:14:25 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57702 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiBBNOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:14:23 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BE3032113D;
        Wed,  2 Feb 2022 13:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643807662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bcp04e1xn7q0Nbal9eCkQGo3QVCsVp3wNyotn26SUZc=;
        b=LZs0ZRhvdcYR4fHgsCej3MaQSN3G4oIpS/kCbCgOmUTVhOlkBQQhuDRxMjPwUMsMrI3SaT
        E6g7iLhxHav8I7ggM5n+2vqmangAHogtTcA2Orv4zkgue4a4HwosZZrYNwbvylYiromKcf
        p0+RbuqnABB705j7wYl/55XGBj4RebE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643807662;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bcp04e1xn7q0Nbal9eCkQGo3QVCsVp3wNyotn26SUZc=;
        b=r9xPJKaqrE/bIIJMhdvUrixtqOxNNTZ1cWRhDYeQhs7tG4PzA68uodopZ7ROBkL6z5kp+c
        S2gBwkyJ2d9Ct6Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0E5313E48;
        Wed,  2 Feb 2022 13:14:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id InP9Kq6D+mFFQAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 02 Feb 2022 13:14:22 +0000
Message-ID: <b46c5a9a-670a-2989-2429-f28b2bafdfc2@suse.de>
Date:   Wed, 2 Feb 2022 14:14:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv2 4/7] lib: add crc64 tests
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de
References: <20220201190128.3075065-1-kbusch@kernel.org>
 <20220201190128.3075065-5-kbusch@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220201190128.3075065-5-kbusch@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 20:01, Keith Busch wrote:
> Provide a module to test the rocksoft crc64 calculations with well known
> inputs and exepected values.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
>    Fixed Kconfig dependency
> 
>   lib/Kconfig.debug |  4 +++
>   lib/Makefile      |  1 +
>   lib/test_crc64.c  | 68 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 73 insertions(+)
>   create mode 100644 lib/test_crc64.c
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
