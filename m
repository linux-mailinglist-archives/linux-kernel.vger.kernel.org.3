Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D91853E0DE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiFFFnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFFFnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:43:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6811BF72
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 22:43:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48E3FB80F9B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6B3C385A9;
        Mon,  6 Jun 2022 05:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654494193;
        bh=7Zp038j/zSkCCliFc52iUh2W+hvLb5xcunWPvnZKqZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NlJfS7pqw5Vj0h3oBGFxII1TnA8vLIVvBi/TO/L0Sk+hBosZvqJTp3JmHRB0ao3q5
         zguX60SMunn+IZBBtK8IrrgzWJ6fakiypiER/GWdeDesgPI9d4cbta8a+TG4AhWio0
         TQhNqcd2HKhMCHT5ulBIjo0ASpGYzxVqt2XpYA6s=
Date:   Mon, 6 Jun 2022 07:43:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     linux-staging@lists.linux.dev, davem@davemloft.net,
        kuba@kernel.org, alexander.deucher@amd.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: Fix sleep in atomic context bug in
 dm_fsync_timer_callback
Message-ID: <Yp2T7xSM8YX7lX0/@kroah.com>
References: <20220520061541.14785-1-duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520061541.14785-1-duoming@zju.edu.cn>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:15:41PM +0800, Duoming Zhou wrote:
> There are sleep in atomic context bugs when dm_fsync_timer_callback is
> executing. The root cause is that the memory allocation functions with
> GFP_KERNEL parameter are called in dm_fsync_timer_callback which is a
> timer handler. The call paths that could trigger bugs are shown below:
> 
>     (interrupt context)
> dm_fsync_timer_callback
>   write_nic_byte
>     kzalloc(sizeof(data), GFP_KERNEL); //may sleep
>   write_nic_dword
>     kzalloc(sizeof(data), GFP_KERNEL); //may sleep
> 
> This patch changes allocation mode from GFP_KERNEL to GFP_ATOMIC
> in order to prevent atomic context sleeping. The GFP_ATOMIC flag
> makes memory allocation operation could be used in atomic context.
> 
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

What commit id does this fix?

And how did you find this issue?  Did you run the code to verify it
still works properly?

thanks,

greg k-h
