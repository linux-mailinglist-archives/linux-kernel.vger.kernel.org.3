Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB614B819B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiBPHfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:35:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiBPHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:35:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481DE17185C;
        Tue, 15 Feb 2022 23:35:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D0651F37D;
        Wed, 16 Feb 2022 06:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644993565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7GGMtEIGANtAaJZgWgs4fHi8bEqaZzSeIEHxY3YZQSM=;
        b=m54ylZrQ963wIR6zi/BQOguiJ0LS7VKESk6EZVzEEtdNitM7NhSeOR6d8YfWns9fyd+rKO
        JQf8TMGuCoyo6S5CNhgOtJi4Pr7kJ2boPw9pJnDQjgv+PrGMTZgLqzMGym7//FPLFmH3hz
        GMdFeegXjZsFRhDkJm5JwTpI0ta8AIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644993565;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7GGMtEIGANtAaJZgWgs4fHi8bEqaZzSeIEHxY3YZQSM=;
        b=i5cHX04eaVceesCbkAEE3R3DVeOG/2Qc1y6CzyyOpK21iDbNYaNV813kGh1GjuqRkR6YDM
        AcIAcFu6O9glNJBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0673213A1A;
        Wed, 16 Feb 2022 06:39:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hQkqAB2cDGLUIwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 16 Feb 2022 06:39:24 +0000
Message-ID: <da0e1493-bdfb-f510-7cf9-ffbf4baf6159@suse.de>
Date:   Wed, 16 Feb 2022 07:39:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH] nvme: prevent hang on surprise removal of NVMe disk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Markus_Bl=c3=b6chl?= <markus.bloechl@ipetronik.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>
References: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
 <20220215191731.GB25076@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220215191731.GB25076@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 20:17, Christoph Hellwig wrote:
> On Mon, Feb 14, 2022 at 10:51:07AM +0100, Markus Blöchl wrote:
>> After the surprise removal of a mounted NVMe disk the pciehp task
>> reliably hangs forever with a trace similar to this one:
> 
> Do you have a specific reproducer? At least with doing a
> 
> echo 1 > /sys/.../remove
> 
> while running fsx on a file system I can't actually reproduce it.

You should be able to reproduce it doing a PCI hotplug from qemu.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
