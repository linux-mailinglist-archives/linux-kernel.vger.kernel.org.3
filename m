Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F5B55E260
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbiF0MaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiF0MaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:30:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E3B64D8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:30:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E55C460C66
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CA7C3411D;
        Mon, 27 Jun 2022 12:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656333000;
        bh=bf1hSYJqFeSB0yfJ08Jubf8Nw0Aqq11+gwvcPoJtXvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YH75glbB7MNamTtykFB8MSGCQKjerYQK/KbwiTVdcbK6+WdcNVT/2hFPX93sQES3x
         4MA1ZbJ+flVEeHHidE2+uY5Nbr7QQtDw2Rzx7o/iCNscQ3z5GT8zN+JBh/J/sZIctU
         XlE8rOGsT3jOH5cEuZSxPATLXiyrdi0daToRpZdg=
Date:   Mon, 27 Jun 2022 14:29:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yangxi Xiang <xyangxi5@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        nick black <dankamongmen@gmail.com>
Subject: Re: [PATCH] vt: fix memory overlapping when deleting chars in the
 buffer
Message-ID: <YrmixTj6aF3Pwq0I@kroah.com>
References: <YrmPi/D4dZAySgll@kroah.com>
 <20220627114016.11114-1-xyangxi5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627114016.11114-1-xyangxi5@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 07:40:16PM +0800, Yangxi Xiang wrote:
> > And what commit id does this fix, or has it always been broken?
> 
> It fixes the commit 81732c3 (tty vt: Fix line garbage in virtual
> console on command line edition). The line buffer is not always
> broken, because the memcpy utilized the hardware acceleration, whose
> result is not deterministic. I fix this issue by replacing the
> scr_memcpyw with scr_memmovew used in insert_char, and preserving the
> memcpy optimization when the buffers are not overlapping.

Great, can you please resend the patch with that information all in it,
and the proper Fixes: line tag added?

thanks,

greg k-h
