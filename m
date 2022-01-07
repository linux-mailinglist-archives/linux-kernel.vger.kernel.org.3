Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DAC48795A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239477AbiAGO4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239425AbiAGO4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:56:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4023C061401;
        Fri,  7 Jan 2022 06:56:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 829E561560;
        Fri,  7 Jan 2022 14:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8184C36AEB;
        Fri,  7 Jan 2022 14:56:39 +0000 (UTC)
Date:   Fri, 7 Jan 2022 09:56:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        gregkh <gregkh@linuxfoundation.org>, <quic_psodagud@quicinc.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: Re: [PATCHv6 4/5] tracing: Add register read/write tracing support
Message-ID: <20220107095638.7d81c1b9@gandalf.local.home>
In-Reply-To: <df9b5a82-5f00-f3ec-14cf-0b212be2a7a7@quicinc.com>
References: <cover.1638858746.git.quic_saipraka@quicinc.com>
        <76983c26d889df7252a17017a48754163fb6b0d5.1638858747.git.quic_saipraka@quicinc.com>
        <20220106131824.073fbe5c@gandalf.local.home>
        <df9b5a82-5f00-f3ec-14cf-0b212be2a7a7@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 10:40:05 +0530
Sai Prakash Ranjan <quic_saipraka@quicinc.com> wrote:

> Hi Steve,
> 
> On 1/6/2022 11:48 PM, Steven Rostedt wrote:
> > This should not be in the kernel/trace directory. It should be in the  
> 
> Hmm these are called from low level generic io header file 
> (include/asm-generic/) where
> we wouldn't have any Kconfig to control this feature flexibly and as we 
> can have this as
> a generic feature selectable by other architectures, wouldn't this be 
> suited in kernel/trace?

Isn't there a place for generic rwmmio code?

> I thought you were ok with the folder structure in the initial versions 
> of the series?

Sorry, I missed the C file in kernel/trace. The files in kernel/trace tend
to be specific for the internals of tracing. This C file is more to hold
helper functions for mmio, which to me should be someplace for mmio code.
Perhaps in mm/ ?

-- Steve
