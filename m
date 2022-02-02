Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632E14A714D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344271AbiBBNNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:13:37 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52066 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiBBNNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:13:35 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A08521F3AC;
        Wed,  2 Feb 2022 13:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643807614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JlQUO8+UiXbI9p5AkFOPqUJ49XgowWktQfXDPY0CVBY=;
        b=qAQmbDDNlbwdOrfXmkONjHnYlZJSTA33fOEY83xMPUwZBTwaQ1zkGN3UZx06Ykf8J2tgVe
        6e4XSNmE+0+cVP2VTClabEBNLR152C1fuOoRB8ygLxtZllzO/Vnwc/m49JsY93kTO0MAmn
        qqTRBfsW0i5LflljRtikurUrcDhsbzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643807614;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JlQUO8+UiXbI9p5AkFOPqUJ49XgowWktQfXDPY0CVBY=;
        b=n+Xp2eOz4tUnUDhlfz56j0sVtYs+NL0aDL5lkCjN8ewDL9FXPiRiOzgdg+6vh5grW2X4cE
        Qoo008H2iWe2m3Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AA6813E48;
        Wed,  2 Feb 2022 13:13:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U+IUIX6D+mHbPwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 02 Feb 2022 13:13:34 +0000
Message-ID: <6acd13c3-5e98-b050-bcc4-9d075e013817@suse.de>
Date:   Wed, 2 Feb 2022 14:13:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv2 3/7] lib: add rocksoft model crc64
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de, Eric Biggers <ebiggers@kernel.org>
References: <20220201190128.3075065-1-kbusch@kernel.org>
 <20220201190128.3075065-4-kbusch@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220201190128.3075065-4-kbusch@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 20:01, Keith Busch wrote:
> The NVM Express specification extended data integrity fields to 64 bits
> using the Rocksoft^TM parameters. Add the poly to the crc64 table
> generation, and provide a library routine implementing the algorithm.
> 
> The Rocksoft 64-bit CRC model parameters are as follows:
>      Poly: 0xAD93D23594C93659
>      Initial value: 0xFFFFFFFFFFFFFFFF
>      Reflected Input: True
>      Reflected Output: True
>      Xor Final: 0xFFFFFFFFFFFFFFFF
> 
> Since this model used reflected bits, the implementation generates the
> reflected table so the result is ordered consistently.
> 
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
