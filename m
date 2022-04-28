Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DE6512E29
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiD1IYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242354AbiD1IXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:23:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA372A70F;
        Thu, 28 Apr 2022 01:20:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE04B61F92;
        Thu, 28 Apr 2022 08:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD006C385A0;
        Thu, 28 Apr 2022 08:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651134009;
        bh=hUg3NqrYzpqfbxvI31DgQCZm8Qlzr2+9eyH+hO38XPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tW21Ekx9h5h3RBhClupWydbxsdWCg43N6gEc3LEyky0bS/gXDJr9kTAlqvd4UKKdm
         AovcAX9t7ccizQNKWYH4nM+pfKfcLytjEeX8sv4A6b1RBAYD6e0cmjLu17VSAZda4z
         F2ekZ7/lZoOEvUV06mNdhydUrjwyI9qF1cvW6VYk=
Date:   Thu, 28 Apr 2022 10:20:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     arnd@arndb.de, catalin.marinas@arm.com, rostedt@goodmis.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, quic_psodagud@quicinc.com, quic_tsoni@quicinc.com,
        will@kernel.org
Subject: Re: [PATCHv11 6/6] asm-generic/io: Add logging support for MMIO
 accessors
Message-ID: <YmpONdU/zFhnYPgk@kroah.com>
References: <cover.1645772606.git.quic_saipraka@quicinc.com>
 <3de35c9f4a3a070d197bab499acefc709a6f5336.1645772606.git.quic_saipraka@quicinc.com>
 <YmorayBozWWRlTpP@kroah.com>
 <96dc5e2e-5d88-52ce-c295-779603e668f2@quicinc.com>
 <YmpD3tIQK2iiqt46@kroah.com>
 <8b0ad0da-55ab-7b8b-e4a6-cd134567fb44@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b0ad0da-55ab-7b8b-e4a6-cd134567fb44@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 01:14:59PM +0530, Sai Prakash Ranjan wrote:
> > > > Also, I see that this "disable the trace" feature has already been asked
> > > > for for 2 other drivers in the Android kernel tree, why not include
> > > > those changes here as well?  That kind of shows that this new feature is
> > > > limited in that driver authors are already wanting it disabled, even
> > > > before it is accepted.
> > > That can be done later on top of this series right? This series mainly deals with adding
> > > initial support for such tracing, there could be numerous drivers who might or might
> > > not want the feature which can be added onto later. We can't actually identify all
> > > the driver requirements upfront. As an example, we have already used the flag to
> > > disable tracing for nVHE KVM, so we know how to use the flag.
> > Again, make it explicit in the driver file itself that it is doing this,
> > not in the Makefile, and I will not have any objections.
> 
> Ok, for kernel drivers I will make the define at the top of the .c driver file and include
> those 2 driver changes in the series.

Thank you, that is a much better way forward.

greg k-h
