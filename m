Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD0F48F2E8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiANXUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:20:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56560 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiANXUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:20:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03159B82A4F;
        Fri, 14 Jan 2022 23:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8DBC36AE7;
        Fri, 14 Jan 2022 23:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642202448;
        bh=NGSaF/WGmhkbF37ukIBly91h03FIlvCv0XyffSi0nE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ugpH/Q10bH2MLiQAqjCaNxJQr1MSw63iJQkyAvCVO5yVnH+zr8vwR45jBtXF086c4
         AsJh1ZjS5MYbPBs73cytI7Zopub2A/Pur72AcMfAKXz9l0RIlC0rZ+zDonJyKEvHZz
         NHVV/FDhPzRgxUbj8SB3tbMqjsaRt4iZwlpgmpMOqWo9Q+x0F+0SjDxIUVsfwDvCcW
         kXcVR0+IhJ8GlJ0QPfSGRu7cdcWPzckNhyOFyx/0oHQuwsbF0s+3MxTxw2d+mzLQiL
         TVYc+at5bMSeoaJ9Yxy3JZiyG0v1RfYvEEC4AMlF9AOcA8JrCRrBuAbHPCU8a6tGdV
         C4NST9hw3XD3w==
Received: by pali.im (Postfix)
        id 53A057D1; Sat, 15 Jan 2022 00:20:46 +0100 (CET)
Date:   Sat, 15 Jan 2022 00:20:46 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 0/6] serial: mvebu-uart: Support for higher baudrates
Message-ID: <20220114232046.ucpxsdiitow5huwj@pali>
References: <20210930095838.28145-1-pali@kernel.org>
 <20211103214209.azo2z3z4gy7aj5hu@pali>
 <87ee6bm9hn.fsf@BL-laptop>
 <20220114105100.im6gmkt6fjl2aiwl@pali>
 <20220114225659.D5D79C36AE9@smtp.kernel.org>
 <20220114230549.56co4qcpnq32muwj@pali>
 <20220114231657.AB353C36AE7@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220114231657.AB353C36AE7@smtp.kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 January 2022 15:16:55 Stephen Boyd wrote:
> Quoting Pali Rohár (2022-01-14 15:05:49)
> > On Friday 14 January 2022 14:56:58 Stephen Boyd wrote:
> > > 
> > > If we're adding new support why can't we break with backwards
> > > compatibility for the binding and do it a different way?
> > 
> > Because DTS are backwards compatible. I was told more times that kernel
> > drivers should work correctly with older DTS files. On some boards are
> > DTB files provided by bootloader and they do not use in-kernel DTS
> > files.
> 
> I'm not suggesting to break the kernel driver when used with older DTBs.
> New features are fair game to change the compatible string and do
> something different. If the user wants the new feature they update their
> DTB. We shouldn't be constrained by backwards compatibility here.

And what do you suggest to do? Separate UART0 and UART1 nodes are still
needed because as Mark wrote stdin-path and stdout-patch could be
different.
