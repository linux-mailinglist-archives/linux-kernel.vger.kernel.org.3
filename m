Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB634C28BA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbiBXKAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiBXKAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:00:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0381451E7;
        Thu, 24 Feb 2022 01:59:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40FA0B8234E;
        Thu, 24 Feb 2022 09:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C47C340E9;
        Thu, 24 Feb 2022 09:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645696778;
        bh=7eguQjJYyrMKQoojwbWhxFNmQYcJas6sOvBXxv+Jklw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=IEWfxImdwfWYbTxagwFfgsHz0DBVEBVKvth39hjXUrwzMBB3Gt6yPT/liUcTHl4/i
         BfpyuzPrG+2qBVnMcWSPcpDsKPKYfnE+3/6NhjAIMpKRcFaRHsSQGQHf1OFav/9bRD
         8PRGNQOABS1w/lGulhLDct8DR6no5SC8+AjE/y/B+8GAQFSJJtEBtOcJqGPVk/l9Qa
         +Z0/dxDtuX7RGPMUJfSH/a8P8XacaYsquR6//0AikC9f7YNNVdegSmITqNNcaYi9eF
         om3hQQa/ItOuuzpxAnHMFq1irbUUPhxbNQqX1Nbc9WgWoLjfauregYUnV16A+3Eduk
         d63R4yr5wwzXQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Francesco Magliocca <franciman12@gmail.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, rmanohar@qti.qualcomm.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Use of void pointer arithmetic?
References: <20220221122638.7971-1-franciman12@gmail.com>
        <e32de43c-e00a-5766-e988-fe192d36d719@quicinc.com>
        <CAH4F6utmtAM3CzX2_Fbn94Sb-X8m0patPh8yWwbuBB0t1VYH=g@mail.gmail.com>
        <87o82wvhtk.fsf@kernel.org> <20220224075346.GL3943@kadam>
Date:   Thu, 24 Feb 2022 11:59:31 +0200
In-Reply-To: <20220224075346.GL3943@kadam> (Dan Carpenter's message of "Thu,
        24 Feb 2022 10:53:46 +0300")
Message-ID: <87fso8vb3w.fsf_-_@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Changing subject, adding Linus and linux-kernel)

Dan Carpenter <dan.carpenter@oracle.com> writes:

> On Thu, Feb 24, 2022 at 09:34:31AM +0200, Kalle Valo wrote:
>> Francesco Magliocca <franciman12@gmail.com> writes:
>> 
>> > Hi, I picked (void*) to be conformant with the other examples in htt_rx.c
>> > For example at line 1431:
>> >>    rxd = HTT_RX_BUF_TO_RX_DESC(hw,
>> >>                    (void *)msdu->data - hw->rx_desc_ops->rx_desc_size);
>> >
>> > But for me it is ok. Maybe we should fix all the occurrences of this kind.
>> 
>> Yeah, it would be good to fix the void pointer arithmetic in a separate
>> patch. I have planning to enable -Wpointer-arith in my ath10k-check and
>> ath11k-check scripts, so patches are very welcome.
>
> Void * casts simplify a lot of code.  Less noise.  More readable.
> They're more accurate in a sense because it's not a u8 at all.  The
> kernel can't compile with other compilers besides GCC and Clang so why
> care about that the C standard hasn't caught up?
>
> What does -Wpointer-arith buy us?

A good question. I have always just thought we should avoid void pointer
arithmetic due to the C standard, but now that you mention it void
pointers can indeed simplify the code. So I'm not so sure anymore.

Any opinions? Is there a kernel wide recommendation for this?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
