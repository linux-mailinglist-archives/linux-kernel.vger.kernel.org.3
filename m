Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5EE54B344
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346057AbiFNOca convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Jun 2022 10:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345441AbiFNOcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:32:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130673A71D;
        Tue, 14 Jun 2022 07:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6682CCE1ABA;
        Tue, 14 Jun 2022 14:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E30BC3411B;
        Tue, 14 Jun 2022 14:32:07 +0000 (UTC)
Date:   Tue, 14 Jun 2022 10:32:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     <arnd@arndb.de>, <catalin.marinas@arm.com>,
        <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <coresight@lists.linaro.org>, <suzuki.poulose@arm.com>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <will@kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: Re: [PATCHv15 5/9] lib: Add register read/write tracing support
Message-ID: <20220614103205.2d134546@gandalf.local.home>
In-Reply-To: <f6d1b9e9d70968b506bdfd1b77129cb751b9df9d.1652891705.git.quic_saipraka@quicinc.com>
References: <cover.1652891705.git.quic_saipraka@quicinc.com>
        <f6d1b9e9d70968b506bdfd1b77129cb751b9df9d.1652891705.git.quic_saipraka@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 22:14:14 +0530
Sai Prakash Ranjan <quic_saipraka@quicinc.com> wrote:

> From: Prasad Sodagudi <psodagud@codeaurora.org>
> 
> Generic MMIO read/write i.e., __raw_{read,write}{b,l,w,q} accessors
> are typically used to read/write from/to memory mapped registers
> and can cause hangs or some undefined behaviour in following few
> cases,
> 
> * If the access to the register space is unclocked, for example: if
>   there is an access to multimedia(MM) block registers without MM
>   clocks.
> 
> * If the register space is protected and not set to be accessible from
>   non-secure world, for example: only EL3 (EL: Exception level) access
>   is allowed and any EL2/EL1 access is forbidden.
> 
> * If xPU(memory/register protection units) is controlling access to
>   certain memory/register space for specific clients.
> 
> and more...
> 
> Such cases usually results in instant reboot/SErrors/NOC or interconnect
> hangs and tracing these register accesses can be very helpful to debug
> such issues during initial development stages and also in later stages.
> 
> So use ftrace trace events to log such MMIO register accesses which
> provides rich feature set such as early enablement of trace events,
> filtering capability, dumping ftrace logs on console and many more.
> 
> Sample output:
> 
> rwmmio_write: __qcom_geni_serial_console_write+0x160/0x1e0 width=32 val=0xa0d5d addr=0xfffffbfffdbff700
> rwmmio_post_write: __qcom_geni_serial_console_write+0x160/0x1e0 width=32 val=0xa0d5d addr=0xfffffbfffdbff700
> rwmmio_read: qcom_geni_serial_poll_bit+0x94/0x138 width=32 addr=0xfffffbfffdbff610
> rwmmio_post_read: qcom_geni_serial_poll_bit+0x94/0x138 width=32 val=0x0 addr=0xfffffbfffdbff610
> 
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Co-developed-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> ---

From a tracing point of view, I do not see anything wrong with this patch.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
