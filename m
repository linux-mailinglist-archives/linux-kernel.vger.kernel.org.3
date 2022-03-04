Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1A64CD710
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbiCDPDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbiCDPDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:03:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BED312CC10;
        Fri,  4 Mar 2022 07:03:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0717B6197F;
        Fri,  4 Mar 2022 15:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA16C340E9;
        Fri,  4 Mar 2022 15:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646406180;
        bh=q/5HTsfHv6Qp7MvW9s/gAPx713GuVfILXBu+XgJHFHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aRtpdfZxtf2YM6tfcM2HKnxubE4/UPqmqWo/cFlqL0fvmAMMZtISZN2CD1Dk3llXm
         GtsQ+tUb3UKDW6N0d04uVW08AzTmrBkfl5G+ksitG/UNI16/IpV3Lw8wmgGGD8oFUD
         9Lpj+UOtPPuRXrJLXVTrEYajLGUAzul9Gf0QzYE9ZH3PlG2xiY9e/EMsl2W0jz9hDD
         H/yUOW01blipNHdPeMnWy9orQKtWvJ14TJPAQaCw0RXpOL7RDT7apapITaZTBcmiHV
         rgur2JD4ziS6nKSygDiQsvoyT+lCRrm7sCk5pheSSZrGq9TPr4dQI9q/UbnPTJKJZ2
         EgGaqDJGUKPUA==
Date:   Fri, 4 Mar 2022 07:02:57 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv4 5/8] lib: add rocksoft model crc64
Message-ID: <20220304150257.GD2824821@dhcp-10-100-145-180.wdc.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-6-kbusch@kernel.org>
 <30e059eca211460780442e2ded092722@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30e059eca211460780442e2ded092722@AcuMS.aculab.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 07:53:44AM +0000, David Laight wrote:
> 
> That can be speeded up by using the identity:
> 	table[x ^ y] == table[x] ^ table[y]
> 
> something like:
> 	crc = poly;  /* actually crc(1) */
> 	table[0] = 0;
> 	table[1] = crc;
> 	for (i = 2; i < 8; i++) [
> 		crc = crc & 1 ? (crc >> 1) ^ poly : crc >> 1;
> 		for (j = 0; j < 1u << i; j++)
> 			table[j + (1i << i)] = table[j] ^ crc;
> 	}
> 
> I think the same code can be used for a normal MSB first crc
> provided both the polynomial and crc(1) are passed in.
> 
> OTOH initialisation speed may not matter.

I don't think speed is an issue here. This part is executed just once
for the initial kernel compile, then never again.
