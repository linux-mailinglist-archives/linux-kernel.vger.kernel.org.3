Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FE3561F09
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiF3PS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbiF3PSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:18:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D81464DE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71CBD60F1B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5144AC34115;
        Thu, 30 Jun 2022 15:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656602293;
        bh=PdIQJJsnc4nBeLOxlJtfEmJmZ33t1MTFhwJmcl1cXMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zHjkKecnSpHYCW6EhTZ9oQ86e9OLULEXAHXc8U9uxF4kXUDV08NCKDbOd85eg4z1+
         eHutQMTtE7hLeGonI1IApqVOLnIrTb/8e1ey1zEf7NS1OMyLG4o4SYQ49S+3Cx4wW8
         vZHww0GtaA94kXT+UqeeLaduehtLW1KhuWzsr1+k=
Date:   Thu, 30 Jun 2022 17:18:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yangxi Xiang <xyangxi5@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        nick black <dankamongmen@gmail.com>
Subject: Re: [PATCH v3] vt: fix memory overlapping when deleting chars in the
 buffer
Message-ID: <Yr2+s6wQWSfq/Gl5@kroah.com>
References: <20220628093322.5688-1-xyangxi5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628093322.5688-1-xyangxi5@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 05:33:22PM +0800, Yangxi Xiang wrote:
> A memory overlapping copy occurs when deleting a long line. This memory
> overlapping copy can cause data corruption when scr_memcpyw is optimized
> to memcpy because memcpy does not ensure its behavior if the destination
> buffer overlaps with the source buffer. The line buffer is not always
> broken, because the memcpy utilizes the hardware acceleration, whose
> result is not deterministic.
> 
> Fix this problem by using replacing the scr_memcpyw with scr_memmovew.
> 
> Fixes: 81732c3b2fed ("Fix line garbage in virtual console")

Nit, this should have been:
	Fixes: 81732c3b2fed ("tty vt: Fix line garbage in virtual console on command line edition")

otherwise our tools complain.  I've fixed it up when applying it.

thanks,

greg k-h
