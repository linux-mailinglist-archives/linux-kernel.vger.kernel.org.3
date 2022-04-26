Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77F650FB10
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345756AbiDZKhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241090AbiDZKgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:36:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717A91A83D;
        Tue, 26 Apr 2022 03:19:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 556D2CE1C0F;
        Tue, 26 Apr 2022 10:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755B4C385A4;
        Tue, 26 Apr 2022 10:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650968395;
        bh=W55oZtjkPnHmK771cWtrQXyrIgoUqcWYB7QpwB4zE9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PapPCGXt7mVgligOICQGKzj7IMeeHb1lIKzq/Ap3eOXOLSCHXmQq7EyvtRjyj4IIp
         TIXK2zk0gO3/E2Rpfx5FQ3bhOUpzQqKog8yXHKq2kFGtmurd3ktJOo0L265PLw44B6
         KaP37dhJ196zWAXCFlDeivKQ+IZq9BbOXB1BtphY=
Date:   Tue, 26 Apr 2022 12:19:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v4 0/5] add xhci-exynos driver
Message-ID: <YmfHR2AQ5kH3k+XC@kroah.com>
References: <CGME20220426092019epcas2p2ef5dfde273edaaadc2ff74414f1b2c7a@epcas2p2.samsung.com>
 <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:18:43PM +0900, Daehwan Jung wrote:
> This patchset is for Samsung Exynos xhci host conroller. It uses xhci-plat
> driver mainly and extends some functions by xhci hooks and overrides.
> 
> This driver supports USB offload which makes Co-processor to use
> some memories of xhci. Especially it's useful for USB Audio scenario.
> Audio stream would get shortcut because Co-processor directly write/read
> data in xhci memories. It could get speed-up using faster memory like SRAM.
> That's why this gives vendors flexibilty of memory management. This feature
> is done with xhci hooks and overrides.
> 
> Changes in v2 :
> - Fix commit message by adding Signed-off-by in each patch.
> - Fix conflict on latest.

Thanks for reworking these and submitting them.  I have some comments on
the individual commits from a non-xhci-knowledge point of view.

greg k-h
