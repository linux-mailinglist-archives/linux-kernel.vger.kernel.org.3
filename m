Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91253512B25
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243248AbiD1F42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiD1F41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:56:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8756B7C250;
        Wed, 27 Apr 2022 22:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CBBFB82B2D;
        Thu, 28 Apr 2022 05:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072D4C385AD;
        Thu, 28 Apr 2022 05:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651125191;
        bh=lKtkYrn4+FEITxrNkaxTIFUj/JANxMH5XgcAihKDUWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0GljVB0aWZgPoOHP/BiDDxothhRUBzk7FA++ZYidfpNqHrw7mDnJ2ZdjEpAndeYO
         GkwmtrZ6g4uUa3eHN441PadRrVUR1Vui9xCZ4Py7Mx2y70WM5XWAtMyVA//jZ6FfOs
         p5g8o6lOd2zLXJRoiWIzJhbhJ31enHYi3lyg0Ino=
Date:   Thu, 28 Apr 2022 07:53:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     arnd@arndb.de, catalin.marinas@arm.com, rostedt@goodmis.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, quic_psodagud@quicinc.com, quic_tsoni@quicinc.com,
        will@kernel.org
Subject: Re: [PATCHv11 6/6] asm-generic/io: Add logging support for MMIO
 accessors
Message-ID: <YmorwEGw/SATMUKt@kroah.com>
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

Also, this should be split up into 2 patches, one to add the "disable
the feature" flag, and one to enable it for the specific driver(s) you
want.

Hint, when you say "also" in a changelog text, that's a huge sign that
it perhaps should be split up into smaller pieces.

thanks,

greg k-h
