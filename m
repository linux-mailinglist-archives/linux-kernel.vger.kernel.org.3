Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623324D274F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiCIDKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiCIDKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:10:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD43214F2BA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 19:09:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40D9DB81E05
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7E9C340EB;
        Wed,  9 Mar 2022 03:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646795390;
        bh=jWjiAqrUnpIhrBshclXWWixCzx//buFARMefUyobwqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oi2xzryvFZzBEi4JvZWKbqkaByE8vQttZgG8zIbfnUgoNheDANGSfJKw+UioNiZva
         PBhnAnyGTrQE+5pPlT6y2wAwpVFTI2Wnu5l4vRca2nP6GrfRn1gi1yDFaobyxKCPuB
         +loZQ/bexqdSU7TcmOrbKFxEYPr/ukyE7YI5ZSvMke3f5WglBq360s9m2RnPF9DeWP
         V6fxLY/1U7qHBTNOLkiDEtGAr6b92IBIJMNifgmutMP1ZilqMYWXPg3ARnbGEwYmm8
         Sc2acxK3Cm4Wkt5ichIXLW++MATAHZ7PjEB1BQBkTsr83d2V04HM02BunK9xeP9iUX
         /EQx5qiKfz9OQ==
Date:   Tue, 8 Mar 2022 19:09:48 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Maurizio Lombardi <mlombard@redhat.com>,
        linux-nvme@lists.infradead.org, axboe@fb.com,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Ming Lei <minlei@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: nvme-host: disk corruptions when issuing IDENTIFY commands via
 ioctl()
Message-ID: <20220309030948.GA3949054@dhcp-10-100-145-180.wdc.com>
References: <CAFL455n1WaRxZuqCeQGWt1MVDnK8uUytUsAUVEUV9-LLQYv9gQ@mail.gmail.com>
 <20220308195238.GC3501708@dhcp-10-100-145-180.wdc.com>
 <YifyZ9MoUws/7esK@T590>
 <20220309003904.GA3948780@dhcp-10-100-145-180.wdc.com>
 <Yif8svaBscrL9WZk@T590>
 <20220309011429.GA3948855@dhcp-10-100-145-180.wdc.com>
 <YigVg/URukuwwKWF@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YigVg/URukuwwKWF@T590>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:48:35AM +0800, Ming Lei wrote:
> > > On Tue, Mar 08, 2022 at 04:39:04PM -0800, Keith Busch wrote:
> 
> BTW, this issue is actually one real report from one Red Hat Customer.

And the correct fix has always been to fix the application.

> > > 
> > > But the spec states clearly the data length of IDENTIFY command is 4096
> > > and PRP list can't be used, so why do you think it isn't complete or
> > > future proof to validate data length of IDENTIFY in nvme driver?
> > 
> > The current spec says that opcode uses 4k today. What about some time in
> > the future?
> 
> spec change should only be applied on future hardware, which can not break
> current in-market hardware.

If a new Identify CNS were invented by committee that uses 8k, then the
older driver enforcing only 4k mappings will create more corruption, and
then it would be the driver's fault.

> nvme target has validated the Identify's transfer length already.

nvmet provides a fabrics targets, which uses SGL, not PRP. The SGL
encodes the length, so it's possible to validate it.
 
> > And why are you focusing on Identify anyway?
> 
> Nvme spec states explicitly that the following 4 commands can't use PRP list:
> 
> - Identify command
> - Namespace Attachment command
> - Namespace Management command
> - Set Features command
> 
> So it should be enough to just validate these commands.

Why are these 4 opcodes so special that the driver should provide
training wheels for broken apps, yet it must trust the same app with the
hundreds of other possible opcodes through the same interface?
