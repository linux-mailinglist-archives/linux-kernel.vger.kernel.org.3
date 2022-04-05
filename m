Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFFB4F20AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 04:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiDECAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiDECA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807D63571FD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:16:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFB6D61793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 01:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4482C2BBE4;
        Tue,  5 Apr 2022 01:07:48 +0000 (UTC)
Date:   Mon, 4 Apr 2022 21:07:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Bluetooth: hci_qca: Use del_timer_sync() before freeing
Message-ID: <20220404210746.32bb4df6@rorschach.local.home>
In-Reply-To: <97d1cc84-890c-3fcf-2efc-645633cd36b2@gmail.com>
References: <20220404182236.1caa174e@rorschach.local.home>
        <97d1cc84-890c-3fcf-2efc-645633cd36b2@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2022 17:22:00 -0700
Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index f6e91fb432a3..73a8c72b5aae 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -696,8 +696,8 @@ static int qca_close(struct hci_uart *hu)
> >   	skb_queue_purge(&qca->tx_wait_q);
> >   	skb_queue_purge(&qca->txq);
> >   	skb_queue_purge(&qca->rx_memdump_q);
> > -	del_timer(&qca->tx_idle_timer);
> > -	del_timer(&qca->wake_retrans_timer);
> > +	del_timer_sync(&qca->tx_idle_timer);
> > +	del_timer_sync(&qca->wake_retrans_timer);  
> 
> 
> It seems the wake_retrans_timer could be re-armed from a work queue.
> 
> So perhaps we need to make sure qca->workqueue is destroyed
> 
> before these del_timer_sync() calls ?
> 
> >   	destroy_workqueue(qca->workqueue);  
> 
> 
> ie move this destroy_workqueue() up ?

Yeah, that could be a problem. I would think moving it up would help,
if that's what requeue's the timers.

-- Steve


> 
> 
> >   	qca->hu = NULL;
> >     

