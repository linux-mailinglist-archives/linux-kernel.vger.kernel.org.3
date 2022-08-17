Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D507597592
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 20:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbiHQSQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 14:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiHQSP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 14:15:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D958E0CB;
        Wed, 17 Aug 2022 11:15:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 811F5382B3;
        Wed, 17 Aug 2022 18:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660760156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oWKyLqcz7lrl+CiAU1rsL0GsIsfNDVw38F94vzTx4l4=;
        b=QjHq6re00SgNOzc57u5wVlbC6ab6/XW0yJv2zl65ZZfkTBKpuRRH0kgfzLypfhTHPyUjNb
        iQwvaqkWw2AO771Y3df5hFzX/IKJ9YaykZeICzLGdi3DYsdBoQafhrlrJCiQ8fMfP5lVYE
        b1PTDDQa4e38Jl3GV7a8LExEXQexhHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660760156;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oWKyLqcz7lrl+CiAU1rsL0GsIsfNDVw38F94vzTx4l4=;
        b=Bt+RTaHJX7B/IaK7vWnEj9soBiH5bDixlgtAUDCSFJO6R5jzEIlJ2VmuEe8vyD5Hmi75jz
        314mYoevkwp/BpCg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 329942C177;
        Wed, 17 Aug 2022 18:15:56 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1F6D0A066B; Wed, 17 Aug 2022 20:15:54 +0200 (CEST)
Date:   Wed, 17 Aug 2022 20:15:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Jan Kara <jack@suse.cz>,
        Holger =?utf-8?Q?Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Message-ID: <20220817181554.znqljc6mmci45ukd@quack3>
References: <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <7c830487-95a6-b008-920b-8bc4a318f10a@applied-asynchrony.com>
 <20220817114933.66c4g4xjsi4df2tg@quack3>
 <85a141ae-56a7-4dcd-b75a-04be4b276b3a@www.fastmail.com>
 <20220817163059.kigrvdfmxfswmhls@quack3>
 <f6f899a5-97e2-460f-ad73-73d4b5e38eb6@www.fastmail.com>
 <51cd43f9-ab6b-4dd6-814f-e0c1ace3143c@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51cd43f9-ab6b-4dd6-814f-e0c1ace3143c@www.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-08-22 13:57:00, Chris Murphy wrote:
> On Wed, Aug 17, 2022, at 12:47 PM, Chris Murphy wrote:
> Can you boot with
> >> "megaraid_sas.host_tagset_enable = 0" kernel option and see whether the
> >> issue reproduces?
> 
> This has been running an hour without symptoms. It's strongly suggestive,
> but needs to run overnight to be sure. Anecdotally, the max write IO is
> less than what I'm used to seeing.

OK, if this indeed passes then b6e68ee82585 ("blk-mq: Improve performance
of non-mq IO schedulers with multiple HW queues") might be what's causing
issues (although I don't know how yet...).

								Honza

> 
> [    0.583121] Kernel command line: BOOT_IMAGE=(md/0)/vmlinuz-5.12.5-300.fc34.x86_64 root=UUID=04f1fb7f-5cc4-4dfb-a7cf-b6b6925bf895 ro rootflags=subvol=root rd.md.uuid=e7782150:092e161a:68395862:31375bca biosdevname=1 net.ifnames=0 log_buf_len=8M plymouth.enable=0 megaraid_sas.host_tagset_enable=0
> ...
> [    6.745964] megasas: 07.714.04.00-rc1
> [    6.758472] megaraid_sas 0000:02:00.0: BAR:0x1  BAR's base_addr(phys):0x0000000092000000  mapped virt_addr:0x00000000c54554ff
> [    6.758477] megaraid_sas 0000:02:00.0: FW now in Ready state
> [    6.770658] megaraid_sas 0000:02:00.0: 63 bit DMA mask and 32 bit consistent mask
> [    6.795060] megaraid_sas 0000:02:00.0: firmware supports msix	: (96)
> [    6.807537] megaraid_sas 0000:02:00.0: requested/available msix 49/49
> [    6.819259] megaraid_sas 0000:02:00.0: current msix/online cpus	: (49/48)
> [    6.830800] megaraid_sas 0000:02:00.0: RDPQ mode	: (disabled)
> [    6.842031] megaraid_sas 0000:02:00.0: Current firmware supports maximum commands: 928	 LDIO threshold: 0
> [    6.871246] megaraid_sas 0000:02:00.0: Performance mode :Latency (latency index = 1)
> [    6.882265] megaraid_sas 0000:02:00.0: FW supports sync cache	: No
> [    6.893034] megaraid_sas 0000:02:00.0: megasas_disable_intr_fusion is called outbound_intr_mask:0x40000009
> [    6.988550] megaraid_sas 0000:02:00.0: FW provided supportMaxExtLDs: 1	max_lds: 64
> [    6.988554] megaraid_sas 0000:02:00.0: controller type	: MR(2048MB)
> [    6.988555] megaraid_sas 0000:02:00.0: Online Controller Reset(OCR)	: Enabled
> [    6.988556] megaraid_sas 0000:02:00.0: Secure JBOD support	: No
> [    6.988557] megaraid_sas 0000:02:00.0: NVMe passthru support	: No
> [    6.988558] megaraid_sas 0000:02:00.0: FW provided TM TaskAbort/Reset timeout	: 0 secs/0 secs
> [    6.988559] megaraid_sas 0000:02:00.0: JBOD sequence map support	: No
> [    6.988560] megaraid_sas 0000:02:00.0: PCI Lane Margining support	: No
> [    7.025160] megaraid_sas 0000:02:00.0: megasas_enable_intr_fusion is called outbound_intr_mask:0x40000000
> [    7.025162] megaraid_sas 0000:02:00.0: INIT adapter done
> [    7.025164] megaraid_sas 0000:02:00.0: JBOD sequence map is disabled megasas_setup_jbod_map 5707
> [    7.029878] megaraid_sas 0000:02:00.0: pci id		: (0x1000)/(0x005d)/(0x1028)/(0x1f47)
> [    7.029881] megaraid_sas 0000:02:00.0: unevenspan support	: yes
> [    7.029882] megaraid_sas 0000:02:00.0: firmware crash dump	: no
> [    7.029883] megaraid_sas 0000:02:00.0: JBOD sequence map	: disabled
> [    7.029915] megaraid_sas 0000:02:00.0: Max firmware commands: 927 shared with nr_hw_queues = 1
> [    7.029918] scsi host11: Avago SAS based MegaRAID driver
> 
> 
> 
> 
> -- 
> Chris Murphy
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
