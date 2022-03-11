Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F884D6A46
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiCKWrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiCKWqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:46:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D4B2DBB8E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:37:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46AEF61FC4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 21:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36602C340E9;
        Fri, 11 Mar 2022 21:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1647034924;
        bh=qYfEAZ0lsjy7MH3vIWERStb/38N/rSLHEbynoNRnN90=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T+BedQfjTitAebQLVHdLEuxFWCeDg456J/YOKYAJy+r4JfiUXNrHLcQk752BoqJYr
         Ddl2hrxWOVGOcpNSI/HgRRJ9SnGOWnOUk9jkQ72RImApbuMJTyVKkF86gP38daa+rb
         TopL/+yqxfB5oTV48rzyF69ybCQi0rkhWT33VSYY=
Date:   Fri, 11 Mar 2022 13:42:03 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     <surenb@google.com>, <vbabka@suse.cz>, <rientjes@google.com>,
        <sfr@canb.auug.org.au>, <edgararriaga@google.com>,
        <minchan@kernel.org>, <nadav.amit@gmail.com>, <mhocko@suse.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2,0/2]mm: madvise: return correct bytes processed with
 process_madvise
Message-Id: <20220311134203.47cbeab087b731bada12d0f1@linux-foundation.org>
In-Reply-To: <cover.1647008754.git.quic_charante@quicinc.com>
References: <cover.1647008754.git.quic_charante@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2022 20:59:04 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:

> With the process_madvise(), always choose to return non zero processed
> bytes over an error. This can help the user to know on which VMA, passed
> in the 'struct iovec' vector list, is failed to advise thus can take the
> decission of retrying/skipping on that VMA.

Thanks, this is not good.

We should have added userspace tests for process_madvise() along with
the syscall itself.  But evidently that was omitted.  If someone
decides to contribute such tests, hopefully they will include checks
for these return values.

