Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4344EB3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbiC2TBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbiC2TBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:01:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BFB6972B;
        Tue, 29 Mar 2022 11:59:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E29D21A3C;
        Tue, 29 Mar 2022 18:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648580372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M66GhZe9D7qdNGZfGxtVYXFdPB17L/eVci5Q35NKtCU=;
        b=HgMxx8nAALzazkyZ4NbkvzaG+Lws6pkHx7doK6pIZ6xcaXhV1+3Kt0Ezql+ahlnTBjmGXC
        D+7jCLzsgd58k2esGMPkDqw0MleG9+rBcHUf+2to1VM7AdStt/GP5x2PXDFjcdiojhcXEe
        /LVa0dN9kPcdYQGxdPv/F/gr7EOrcW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648580372;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M66GhZe9D7qdNGZfGxtVYXFdPB17L/eVci5Q35NKtCU=;
        b=oqSe923tTqJK8QAT79UXlScANn4Vk36IhVSv72dLOZjvHnvhh2dP+OPfpOzUdkVJ9vcrZS
        gK6B7SEKOANmMrCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 773BB13A7E;
        Tue, 29 Mar 2022 18:59:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9AxmHBRXQ2J3TwAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 29 Mar 2022 18:59:32 +0000
Message-ID: <7b7dbb47-c7cf-36f7-1d6b-2f943a7a2a1f@suse.de>
Date:   Tue, 29 Mar 2022 20:59:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] aha152x: Stop using struct scsi_pointer
Content-Language: en-US
To:     Finn Thain <fthain@linux-m68k.org>,
        "Juergen E. Fischer" <fischer@norbit.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <bdc1264b6dd331150bffb737958cab8c9c068fa1.1648070977.git.fthain@linux-m68k.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <bdc1264b6dd331150bffb737958cab8c9c068fa1.1648070977.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/22 22:29, Finn Thain wrote:
> Remove aha152x_cmd_priv.scsi_pointer by moving the necessary members
> into aha152x_cmd_priv proper.
> 
> Tested with an Adaptec SlimSCSI APA-1460A card.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>   drivers/scsi/aha152x.c | 235 ++++++++++++++++++++---------------------
>   1 file changed, 113 insertions(+), 122 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

