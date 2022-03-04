Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111C64CCC05
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbiCDC47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbiCDC46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:56:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B76FE43B;
        Thu,  3 Mar 2022 18:56:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A85AB8273F;
        Fri,  4 Mar 2022 02:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559DEC004E1;
        Fri,  4 Mar 2022 02:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646362568;
        bh=zIsF6583ND1nmCG72k5Y+Sn5CLZX1lUZlZX0tJyDatc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cr5ZaYYFzKVvur8uNdE7MgBal6PbAnnUTyPlnpGIPRqzQxTrvzCP/zGtjQw87+IDf
         UE5A6OWqSsv//soVosJ0tZrr00ttX0sOuaM9awpPeKOuHpMcHDT26ISfsQFrqLbOCx
         /I7xLNmSpN5yFfYkgwiDTraf43xhwyH6BeKiZYavROadP89ffJtfMFJ+Qd6z9Lf4tM
         dbpLKf0IFb9eJb5VMRTIQul7xTIrY7xaE3dKT55sY0pc9BxU1FGySw96m1/58lIa9u
         kTcA8n6MpW6rZEId6D7dYAJF2sAghENNuH4k4IdOZi2xDdsDSNorGpqX7CW9NH4PSh
         lZf//Hsl/BxNw==
Date:   Thu, 3 Mar 2022 18:56:05 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv4 3/8] asm-generic: introduce be48 unaligned accessors
Message-ID: <20220304025605.GB2824821@dhcp-10-100-145-180.wdc.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-4-kbusch@kernel.org>
 <2d8895d24fff46738f98c2dae74fa440@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d8895d24fff46738f98c2dae74fa440@AcuMS.aculab.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 01:31:26AM +0000, David Laight wrote:
> From: Keith Busch
> > Sent: 03 March 2022 20:13
> > 
> > The NVMe protocol extended the data integrity fields with unaligned
> > 48-bit reference tags.
> 
> If they are reference tags, are they only interpreted by the
> sending system?

No, this field participates in end-to-end data protection formats, so is
verified on both sides.
