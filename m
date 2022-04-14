Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22163500B44
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiDNKkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiDNKkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:40:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FAB76E07
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:38:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649932693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7e5ZzPkHK9QOZm4nJmcXHhBGDf8hlvT6sPGCcVRYlE=;
        b=LhH123nqtQFrvb7Bc6vNeG+oLVx3w52cQrHKqBZV+VKbg8VsH6x6Hw2//Ifwu0z2tD2fOo
        OW4uEOsViDfEu7m9K0k/zO2mp8wa/J2wY/kHZwRO6IJH9WvW0pmL21TJ7O4l44m5hRIE9V
        lEme73zQaQuHdPdfogvfjj0QthfMnHHVRNxIwwZoSJlnYoXJ5BR13FbJNAC7ddsg7fHo2C
        pf98tGh81+HZCo1D1Gfpr4mj3CEb1Nvoqa073Z+ykmPUtHiIX4vSoAHcVnK7ahktZGvaaE
        2NUv1qJAyXzRP5B9z9hNu7KT08pm4ctw8jkFKS0DpQTDmjH1e8Uxmyhqa8hoEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649932693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7e5ZzPkHK9QOZm4nJmcXHhBGDf8hlvT6sPGCcVRYlE=;
        b=xqrcZ+HuKzc3eBQspe8fQxWo6vAsy1o+iHyrYAaxx7MAA/2TsGpz6d34aNZj2kbeJvhvpK
        Rn3Lu3vMo58pLABA==
To:     Greg KH <gregkh@linuxfoundation.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        johannes@sipsolutions.net, rafael@kernel.org
Subject: Re: Possible race in dev_coredumpm()-del_timer() path
In-Reply-To: <Ylas6F75Y7O6R87U@kroah.com>
References: <2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com>
 <YlZg4KkiAgODr45d@kroah.com>
 <20220413101639.GA24349@hu-mojha-hyd.qualcomm.com>
 <Ylas6F75Y7O6R87U@kroah.com>
Date:   Thu, 14 Apr 2022 12:38:13 +0200
Message-ID: <87pmlkdk6i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13 2022 at 12:58, Greg KH wrote:
> On Wed, Apr 13, 2022 at 03:46:39PM +0530, Mukesh Ojha wrote:
>> 	p1 					p2(X)
>> 
>>    dev_coredump() uevent sent to userspace
>>    device_add()  =========================> userspace process X reads the uevents
>>                                             writes to devcd fd which
>>                                             results into writes to
>> 
>>                                             devcd_data_write()
>> 					      mod_delayed_work()
>>                                                 try_to_grab_pending()
>> 						  del_timer()
>> 						   debug_assert_init()
>>   INIT_DELAYED_WORK 
>>   schedule_delayed_work
>> 						    debug_object_fixup()
>
> Why do you have object debugging enabled?  That's going to take a LONG
> time, and will find bugs in your code.  Perhaps like this one?

It's not finding bugs in his code. It finds bug in the upstream
dev_coredump code.

> And if you turn object debugging off, what happens?

The debugobject splat goes away, but the problem persists.

    device_add()        -> uevent

Preemption or concurrency:

    devcd_data_write()
       mod_delayed_work(..., w, 0);      <- Uninitialized.

The dev_coredump code exposes the device before it is fully initialized
and a write ending up in devcd_data_write() touches uninitialized work.

It does not help to move the initialization before device_add() as that
creates another problem:

    INIT_DELAYED_WORK(w)
    ...
    device_add()        -> uevent

Preemption or concurrency:

    devcd_data_write()
      mod_delayed_work(..., w, 0);      <- Schedules work immediately

    work_queue_runs()
      devcd_del(w)
        device_del()
        put_device()                    <- Drops the last reference

    initialization continues...
    
So, yes this needs serialization of some sort.

Same problem vs. disabled_store().

Thanks,

        tglx
