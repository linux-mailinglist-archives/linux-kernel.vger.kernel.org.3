Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FB955DAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbiF0NOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbiF0NN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:13:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBFC12750
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:11:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21E2D612BC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED03AC341C7;
        Mon, 27 Jun 2022 13:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656335493;
        bh=Rs988u9Eymdqxe4O18vbigCP8EQbZ9AmvYeLXH5RRuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G49KI4A3kHUnC1byWToZ7rqMYGvXEx4jVLol0XqJ0HxmM+OWv7x7SqepVgPEcDYFz
         cn6i6T8OSgyn1y03oYMYXpW+aiqQoEEREnuQRvB6GDU/Bzg1UXmk2hCxBgromZbOoB
         QVC/X8k8E0/ooc5ZixTu3vg+MJTztxxRTOgEMwZ0=
Date:   Mon, 27 Jun 2022 15:11:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, sboyd@kernel.org,
        rafael@kernel.org, johannes@sipsolutions.net, keescook@chromium.org
Subject: Re: [PATCH v5] devcoredump : Serialize devcd_del work
Message-ID: <YrmsggY7L6E+LWJ+@kroah.com>
References: <1653660220-19197-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653660220-19197-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 07:33:40PM +0530, Mukesh Ojha wrote:
> In following scenario(diagram), when one thread X running dev_coredumpm()
> adds devcd device to the framework which sends uevent notification to
> userspace and another thread Y reads this uevent and call to
> devcd_data_write() which eventually try to delete the queued timer that
> is not initialized/queued yet.
> 
> So, debug object reports some warning and in the meantime, timer is
> initialized and queued from X path. and from Y path, it gets reinitialized
> again and timer->entry.pprev=NULL and try_to_grab_pending() stucks.
> 
> To fix this, introduce mutex and a boolean flag to serialize the behaviour.
> 
>  	cpu0(X)			                cpu1(Y)
> 
>     dev_coredump() uevent sent to user space
>     device_add()  ======================> user space process Y reads the
>                                           uevents writes to devcd fd
>                                           which results into writes to
> 
>                                          devcd_data_write()
>                                            mod_delayed_work()
>                                              try_to_grab_pending()
>                                                del_timer()
>                                                  debug_assert_init()
>    INIT_DELAYED_WORK()
>    schedule_delayed_work()
>                                                    debug_object_fixup()
>                                                      timer_fixup_assert_init()
>                                                        timer_setup()
>                                                          do_init_timer()
>                                                        /*
>                                                         Above call reinitializes
>                                                         the timer to
>                                                         timer->entry.pprev=NULL
>                                                         and this will be checked
>                                                         later in timer_pending() call.
>                                                        */
>                                                  timer_pending()
>                                                   !hlist_unhashed_lockless(&timer->entry)
>                                                     !h->pprev
>                                                 /*
>                                                   del_timer() checks h->pprev and finds
>                                                   it to be NULL due to which
>                                                   try_to_grab_pending() stucks.
>                                                 */
> 
> Link: https://lore.kernel.org/lkml/2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com/
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---

I need an ack from the devcoredump maintainer before I can take this...

thanks,

greg k-h
