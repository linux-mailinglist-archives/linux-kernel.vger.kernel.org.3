Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A51512B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243209AbiD1FzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiD1FzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:55:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F347C250;
        Wed, 27 Apr 2022 22:51:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37F12B818FC;
        Thu, 28 Apr 2022 05:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB6BC385A9;
        Thu, 28 Apr 2022 05:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651125106;
        bh=BL/ztcIdTOHAttqORil3BUGJFYSYBXhS93ayc6l+nXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2rK9PWY7j41JX0nmeJkE6BBYRs1hKWOhGXMrtGRYSB8txFNFL3XlocI6+ubQ/O+8J
         t/DragmyB5XIeryU9mwNV9Fm0GJEA7fqErUp42mLVkCLZ8+SRzskjqgHOchg3WdaiK
         hLMSHBjS85b+PVwAFaAJJMJuu6PhU3Au1bOEGx5U=
Date:   Thu, 28 Apr 2022 07:51:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     arnd@arndb.de, catalin.marinas@arm.com, rostedt@goodmis.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, quic_psodagud@quicinc.com, quic_tsoni@quicinc.com,
        will@kernel.org
Subject: Re: [PATCHv11 6/6] asm-generic/io: Add logging support for MMIO
 accessors
Message-ID: <YmorayBozWWRlTpP@kroah.com>
References: <cover.1645772606.git.quic_saipraka@quicinc.com>
 <3de35c9f4a3a070d197bab499acefc709a6f5336.1645772606.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3de35c9f4a3a070d197bab499acefc709a6f5336.1645772606.git.quic_saipraka@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 09:00:13AM +0530, Sai Prakash Ranjan wrote:
> Add logging support for MMIO high level accessors such as read{b,w,l,q}
> and their relaxed versions to aid in debugging unexpected crashes/hangs
> caused by the corresponding MMIO operation. Also add a generic flag
> (__DISABLE_TRACE_MMIO__) which is used to disable MMIO tracing in nVHE KVM
> and if required can be used to disable MMIO tracing for specific drivers.

This "add a build flag to a Makefile to change how a driver operates"
feels very wrong to me given that this is now a totally new way to
control how a driver works at build time.  That's not anything we have
done before for drivers and if added, is only going to create much added
complexity.

How about requiring that the #define be in the .c files, and not in the
Makefile, as Makefile changes are much much harder to notice and review
over time.

Also, I see that this "disable the trace" feature has already been asked
for for 2 other drivers in the Android kernel tree, why not include
those changes here as well?  That kind of shows that this new feature is
limited in that driver authors are already wanting it disabled, even
before it is accepted.

Because of that, who _will_ be using this feature?

thanks,

greg k-h
