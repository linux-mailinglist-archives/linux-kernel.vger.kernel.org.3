Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC825A9AA1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiIAOk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiIAOkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:40:37 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 95FA64E624
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:40:20 -0700 (PDT)
Received: (qmail 235838 invoked by uid 1000); 1 Sep 2022 10:40:18 -0400
Date:   Thu, 1 Sep 2022 10:40:18 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
Subject: Re: [PATCH v3] usb: ohci-platform: fix usb disconnect issue after s4
Message-ID: <YxDEUnHIMiNr6Xa9@rowland.harvard.edu>
References: <20220901015446.22384-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901015446.22384-1-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:54:46AM +0800, Yinbo Zhu wrote:
> Avoid retaining bogus hardware states during resume-from-hibernation.
> Previously we had reset the hardware as part of preparing to reinstate
> the snapshot image. But we can do better now with the new PM framework,
> since we know exactly which resume operations are from hibernation.
> 
> According to the commit 'cd1965db054e ("USB: ohci: move ohci_pci_{
> suspend,resume} to ohci-hcd.c")' and commit '6ec4beb5c701 ("USB: new
> flag for resume-from-hibernation")', the flag "hibernated" is for
> resume-from-hibernation and it should be true when usb resume from disk.
> 
> When this flag "hibernated" is set, the drivers will reset the hardware
> to get rid of any existing state and make sure resume from hibernation
> re-enumerates everything for ohci.

The patch title mentions "usb disconnect issue", but the description 
says nothing about it.  Please explain what this disconnect issue is.

Alan Stern
