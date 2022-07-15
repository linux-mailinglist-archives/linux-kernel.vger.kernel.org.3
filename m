Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E74F5760A1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiGOLgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiGOLg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:36:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9763528AB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:36:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5360762283
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 11:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6FCC34115;
        Fri, 15 Jul 2022 11:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657884987;
        bh=e3HNQC64nBw2WyevXyr595j5tzUxSJ88G/WsLfWoL70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UZSld7G0SWHW0Oi63abM24xuPXpgBXdvW41h//p3dSvuc2AwZ9/eCnIj/4obIfuKa
         j2WmowKaA5WSBtmqpilBPAi33MYryZSIWu1is9yI6tmIeSmKcEyw/R5b3+cfxpnj0J
         koPokUicHEnwbeeRcC4HHkB561lPtzmPDcdyIzYM=
Date:   Fri, 15 Jul 2022 13:36:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matt Hsiao <matt.hsiao@hpe.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, jerry.hoemann@hpe.com,
        scott.norton@hpe.com, camille.lu@hpe.com, geoffrey.ndu@hpe.com,
        gustavo.knuppe@hpe.com
Subject: Re: [PATCH v2 1/1] misc: hpilo: switch .{read,write} ops to
 .{read,write}_iter
Message-ID: <YtFROAbEJXfprB+y@kroah.com>
References: <20220713175452.4221-1-matt.hsiao@hpe.com>
 <20220713175452.4221-2-matt.hsiao@hpe.com>
 <Ys8OyLA35o/wr1jB@kroah.com>
 <20220715085557.GC15061@blofly.os1.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715085557.GC15061@blofly.os1.tw>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 04:55:57PM +0800, Matt Hsiao wrote:
> On Wed, Jul 13, 2022 at 08:28:24PM +0200, Greg KH wrote:
> > But my main question is I have no idea what the changelog means here.
> > What is a "dependent driver"?  What does "exclusive" mean here?  What is
> > a iter variant?
> 
> There is an out-of-box driver which is not in the upstream kernel yet
> that uses kernel_{read,write} to access the hpilo driver for talking
> to the iLO ASIC. Before commit 4d03e3cc59828c82ee89 ("fs: don't allow kernel
> reads and writes without iter ops"), kernel_{read,write} would call the
> .{read,write} file ops that hpilo already implemented, so there was no problem;
> But after that commit, kernel_{read,write} would only allow the .{read,write}_iter
> file ops, and disallowed the coexistence of .{read,write} file ops. Accessing
> hpilo now fails since it does not have the .{read,write}_iter file ops. To make it
> work, this patch implements the .{read,write}_iter file ops and removed the
> .{read,write} ones.

For obvious reasons, we can not take any changes for any out-of-tree
code.  Nor would you ever want me to do so.

So we can't take this, sorry.  Please work with your management to get
the drivers upstream and then we will be glad to take these types of
changes, as they well know the price they have to pay to have
out-of-tree code.

Also, your management knows we can't take changes for out-of-tree code.
They know better than to put you into this uncomfortable position.  This
is on them, not you, to resolve.  I suggest you have a stern talking to
with them as they are at fault here.

good luck!

greg k-h
