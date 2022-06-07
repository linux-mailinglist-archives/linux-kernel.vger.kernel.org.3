Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8782553FCDE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiFGLFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242235AbiFGLBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:01:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCB4B482
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:01:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18CAE6156A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED93C34115;
        Tue,  7 Jun 2022 11:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654599693;
        bh=D+6gnkjQuTp/gT1kk2TY3BFGoRR4S4mcAsiWxpLdG2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yu2gyUxFwJrx6gWlqtUlxYiXkJg+NrVJ5zSq4Xm5uTof1R1kd2bPRaVoCJa0iS95B
         i1ef7reb9rxUO/WVQV+9LfSU9SosySoVqH6YtD+sWJo8nTq0DpdglQtRPGFrsZUIOZ
         zSFUFjASwBNzTBV+Mm4lc6Qy2xgYx++l+AckcEJ4=
Date:   Tue, 7 Jun 2022 13:01:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     duoming@zju.edu.cn
Cc:     linux-staging@lists.linux.dev, davem@davemloft.net,
        kuba@kernel.org, alexander.deucher@amd.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: Fix sleep in atomic context bug in
 dm_fsync_timer_callback
Message-ID: <Yp8wBoXH+k9k7Jg+@kroah.com>
References: <20220520061541.14785-1-duoming@zju.edu.cn>
 <Yp2T7xSM8YX7lX0/@kroah.com>
 <6c014f68.52c9b.18137daddd9.Coremail.duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c014f68.52c9b.18137daddd9.Coremail.duoming@zju.edu.cn>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 03:11:39PM +0800, duoming@zju.edu.cn wrote:
> Hello,
> 
> On Mon, 6 Jun 2022 07:43:11 +0200 greg k-h wrote:
> 
> > On Fri, May 20, 2022 at 02:15:41PM +0800, Duoming Zhou wrote:
> > > There are sleep in atomic context bugs when dm_fsync_timer_callback is
> > > executing. The root cause is that the memory allocation functions with
> > > GFP_KERNEL parameter are called in dm_fsync_timer_callback which is a
> > > timer handler. The call paths that could trigger bugs are shown below:
> > > 
> > >     (interrupt context)
> > > dm_fsync_timer_callback
> > >   write_nic_byte
> > >     kzalloc(sizeof(data), GFP_KERNEL); //may sleep
> > >   write_nic_dword
> > >     kzalloc(sizeof(data), GFP_KERNEL); //may sleep
> > > 
> > > This patch changes allocation mode from GFP_KERNEL to GFP_ATOMIC
> > > in order to prevent atomic context sleeping. The GFP_ATOMIC flag
> > > makes memory allocation operation could be used in atomic context.
> > > 
> > > Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> > 
> > What commit id does this fix?
> 
> Thanks for your time and reply! 
> The commit id this patch fix is 8fc8598e61f6 ("Staging: Added Realtek rtl8192u driver to staging").
>  
> > And how did you find this issue?  Did you run the code to verify it
> > still works properly?
> 
> I find this issue by writing codeql query. I am trying to use usb raw-gadget to simulate
> rtl8192u card in order to test this code.
> 
> What`s more, I found the usb_control_msg() with GFP_NOIO parameter in write_nic_byte() 
> and write_nic_dword() may also sleep. So I think use the delayed queue to replace timer
> is better. 

Please explain all of this in the changelog text when you resend this.

thanks,

greg k-h
