Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924F2561338
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiF3H2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiF3H2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:28:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CF6FD2E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 491B561206
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 07:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3A1C34115;
        Thu, 30 Jun 2022 07:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656574088;
        bh=pH/xoO4PIubE9L5cyy2MmAuYYPk1Vk6KDxujHpTzHis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYdKbHrok1mxhBGc71fcOwRPfRdDNuEEy7hNAPhyKw7g/zRTpw1TcZc1ODjaH32xs
         4G4Qi2u02v4jXei9NWBnI/l+rP092u9PWxX/9mYhSLt3qEPi0UKxXEv7DjaASs7IX0
         GUiBs9puYxCWSmWdP8DlrN4s0kwwabJ+d36HsKTk=
Date:   Thu, 30 Jun 2022 09:28:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zys.zljxml@gmail.com
Cc:     tj@kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, katrinzhou <katrinzhou@tencent.com>
Subject: Re: [PATCH] kernfs: fix potential NULL dereference in __kernfs_remove
Message-ID: <Yr1QhjNGVJ7oPpRX@kroah.com>
References: <20220630040047.3241781-1-zys.zljxml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630040047.3241781-1-zys.zljxml@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 12:00:47PM +0800, zys.zljxml@gmail.com wrote:
> From: katrinzhou <katrinzhou@tencent.com>
> 
> When lockdep is enabled, lockdep_assert_held_write would
> cause potential NULL pointer dereference.
> 
> Fix the folloeing smatch warnings:
> 
> fs/kernfs/dir.c:1353 __kernfs_remove() warn: variable dereferenced before check 'kn' (see line 1346)
> 
> Signed-off-by: katrinzhou <katrinzhou@tencent.com>

Can you please submit this with your legal name that you use to sign
documents?

Also, what commit id does this fix?  Did you actually hit this with a
real workload?  How can this be reproduced and tested?

thanks,

greg k-h
