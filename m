Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B3B4E2758
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347780AbiCUNSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiCUNS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:18:29 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E33960069;
        Mon, 21 Mar 2022 06:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=dPqXoSF/BeSCZ7Job8RJ69pE2t1ba6D8uNorfi1dsLk=; b=djdxHbzrr4Tlwtv6Aw+XiehFc0
        frFLqPoENJSnbdMDNDHmwv3EVPrtXv43OXpoNz2JkpIBLNFn+CUfGbGROeOkxKBqJovdVVoVmuYJO
        yhbP74jYXh8QP1a+RIXtRSOV+zxKrwNkrZ6mGNLLV4LFaPrXU/t5KCdWLfiRWmfq9v5w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nWHu6-00Bwqw-7j; Mon, 21 Mar 2022 14:16:58 +0100
Date:   Mon, 21 Mar 2022 14:16:58 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Subject: Re: [PATCH 1/2] arm64: dts: uDPU: update partition table
Message-ID: <Yjh6ysD/fPT/IQLc@lunn.ch>
References: <20220321121728.414839-1-robert.marko@sartura.hr>
 <Yjhyg5cNe5KZ6SOp@lunn.ch>
 <CA+HBbNHw5v+R5WHPTvNj7oVtz0szsCm=JCXPFRtUf2GW7Qz35Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+HBbNHw5v+R5WHPTvNj7oVtz0szsCm=JCXPFRtUf2GW7Qz35Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 01:47:21PM +0100, Robert Marko wrote:
> On Mon, Mar 21, 2022 at 1:41 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Mon, Mar 21, 2022 at 01:17:27PM +0100, Robert Marko wrote:
> > > Partition currently called "uboot" does not only contain U-boot, but
> > > rather it contains TF-A, U-boot and U-boot environment.
> > >
> > > So, to avoid accidentally deleting the U-boot environment which is
> > > located at 0x180000 split the partition.
> > >
> > > "uboot" is not the correct name as you can't boot these boards with U-boot
> > > only, TF-A must be present as well, so rename the "uboot" partition to
> > > "firmware".
> >
> > Are there any ABI issues here? If these names are being used
> > somewhere, you are potentially breaking the boot. At minimum, i would
> > like to see something in the commit message which indicates you have
> > considered this and why you don't expect it to be a problem.
> 
> Hi Andrew, this won't break booting as BootROM does not care about
> partitions nor naming, it will just go to 0x0 of the NOR and boot it.
> 
> The same renaming had already been done:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/marvell?h=v5.17&id=a9d9bfcadfb43b856dbcf9419de75f7420d5a225
> 
> I can update the commit message if required.

Yes, please. It is always good to indicate you have thought about
issues like this. Not breaking the ABI is very important, and could
result in this getting reverted at some point. So indicating why you
think this is safe is useful information.

      Andrew
