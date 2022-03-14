Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26794D8E17
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbiCNU07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiCNU04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:26:56 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1F383917E;
        Mon, 14 Mar 2022 13:25:45 -0700 (PDT)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 88CEF7A00E3;
        Mon, 14 Mar 2022 21:25:43 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] pata_parport: add driver (PARIDE replacement)
Date:   Mon, 14 Mar 2022 21:25:40 +0100
User-Agent: KMail/1.9.10
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220312144415.20010-1-linux@zary.sk> <202203132015.18183.linux@zary.sk> <5161ed17-5f55-e851-c2e2-5340cc62fa3b@kernel.dk>
In-Reply-To: <5161ed17-5f55-e851-c2e2-5340cc62fa3b@kernel.dk>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202203142125.40532.linux@zary.sk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 March 2022 00:19:30 Jens Axboe wrote:
> On 3/13/22 1:15 PM, Ondrej Zary wrote:
> > On Saturday 12 March 2022 15:44:15 Ondrej Zary wrote:
> >> The pata_parport is a libata-based replacement of the old PARIDE
> >> subsystem - driver for parallel port IDE devices.
> >> It uses the original paride low-level protocol drivers but does not
> >> need the high-level drivers (pd, pcd, pf, pt, pg). The IDE devices
> >> behind parallel port adapters are handled by the ATA layer.
> >>
> >> This will allow paride and its high-level drivers to be removed.
> >>
> >> paride and pata_parport are mutually exclusive because the compiled
> >> protocol drivers are incompatible.
> >>
> >> Tested with Imation SuperDisk LS-120 and HP C4381A (both use EPAT
> >> chip).
> >>
> >> Note: EPP-32 mode is buggy in EPAT - and also in all other protocol
> >> drivers - they don't handle non-multiple-of-4 block transfers
> >> correctly. This causes problems with LS-120 drive.
> >> There is also another bug in EPAT: EPP modes don't work unless a 4-bit
> >> or 8-bit mode is used first (probably some initialization missing?).
> >> Once the device is initialized, EPP works until power cycle.
> >>
> >> So after device power on, you have to:
> >> echo "parport0 epat 0" >/sys/bus/pata_parport/new_device
> >> echo pata_parport.0 >/sys/bus/pata_parport/delete_device
> >> echo "parport0 epat 4" >/sys/bus/pata_parport/new_device
> >> (autoprobe will initialize correctly as it tries the slowest modes
> >> first but you'll get the broken EPP-32 mode)
> > 
> > Found a bug - the same device can be registered multiple times. Fix
> > will be in v2. But this revealed a bigger problem: pi_connect can
> > sleep (uses parport_claim_or_block) and libata does not like that. Any
> > ideas how to fix this?
> 
> I think you'd need two things here:
> 
> - The blk-mq queue should be registered with BLK_MQ_F_BLOCKING, which
>   will allow blocking off the queue_rq path.

My knowledge about blk-mq is exactly zero. After grepping the code, I guess that BLK_MQ_F_BLOCKING should be used by the block device drivers - sd and sr?
 
> - You need to look at making libata safe wrt calling ata_qc_issue()
>   outside the lock. Should probably be fine if you just gate that on
>   whether or not the queue was setup in blocking mode, as that doesn't
>   currently exist in libata.
> 


-- 
Ondrej Zary
