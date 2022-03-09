Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D186E4D26F6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiCIBV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiCIBVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:21:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D1E517E7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:17:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E667612CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33317C340EB;
        Wed,  9 Mar 2022 01:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646788472;
        bh=KMmFpphAkJw5H4xtgMoUXBjVB0II6e0xEoEd+Ma14SA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQ2VHAKm0dkruIO7sm8cDWuBpBCF8q3ht9jRbIb/eteVP4X+X4R+6OtFhPCXGi7Bs
         mmbhG2qCUR4C6QWdT/BLnFb/vK7he71VqEj2BpOS9aZBVPVfCpJ2K2mWq6OKJf0WJ8
         P/aYodaUm9eMOD35Aan2VNFIwBhQ/+CVkO19nHUuPreLgwXEGzdilyMAYSUPAO0wLp
         4SWSXetvELZ6Jbp0kOUSI1ponykJQZnuqw26VTDXkWY+QnuwrYhYHgTtZKdtq7BXLR
         VLNuc6DGjEzf8eGnKrzpkEdgm6Z3hh3LvXXOfZDdfFENJqqy06NSLzX3Vs1HXd8XrM
         SIHnOOKvs35OA==
Date:   Tue, 8 Mar 2022 17:14:29 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Maurizio Lombardi <mlombard@redhat.com>,
        linux-nvme@lists.infradead.org, axboe@fb.com,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Ming Lei <minlei@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: nvme-host: disk corruptions when issuing IDENTIFY commands via
 ioctl()
Message-ID: <20220309011429.GA3948855@dhcp-10-100-145-180.wdc.com>
References: <CAFL455n1WaRxZuqCeQGWt1MVDnK8uUytUsAUVEUV9-LLQYv9gQ@mail.gmail.com>
 <20220308195238.GC3501708@dhcp-10-100-145-180.wdc.com>
 <YifyZ9MoUws/7esK@T590>
 <20220309003904.GA3948780@dhcp-10-100-145-180.wdc.com>
 <Yif8svaBscrL9WZk@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yif8svaBscrL9WZk@T590>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 09:02:42AM +0800, Ming Lei wrote:
> On Tue, Mar 08, 2022 at 04:39:04PM -0800, Keith Busch wrote:
> > On Wed, Mar 09, 2022 at 08:18:47AM +0800, Ming Lei wrote:
> > > Given NVMe spec states that data length of IDENTIFY command should be
> > > 4096bytes, and PRP list can't be used. 
> > > 
> > > So looks nvme driver need to validate the command before submitting to
> > > hardware, otherwise any buggy application can break FS or memory easily.
> > 
> > No way. The driver does not police the user passthrough interface for
> > these kinds of things.
> 
> So you trust application to provide correct data always?
>
> From user viewpoint, this defect provides one easy hole to break FS or
> memory, it is one serious issue, IMO. The FS/memory corruption can
> be reproduced easily even in VM.

It doesn't seem so serious considering it's been this way for 10 years,
and we already knew about this. It's even been reported before:

  http://lists.infradead.org/pipermail/linux-nvme/2013-August/000365.html

> > It couldn't ever be complete or future proof if
> > it did.
> 
> But the spec states clearly the data length of IDENTIFY command is 4096
> and PRP list can't be used, so why do you think it isn't complete or
> future proof to validate data length of IDENTIFY in nvme driver?

The current spec says that opcode uses 4k today. What about some time in
the future? And why are you focusing on Identify anyway? The same
potential for abuse exists with any of the other numerous opcodes that
don't have a fixed transfer size, most of which the driver couldn't
possibly ever know what the transfer length is supposed to be. This is a
priviledged operation; the applications get to own the fallout if they
misuse it.
