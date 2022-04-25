Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6508C50E65E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243688AbiDYRDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbiDYRDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:03:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91243896
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:00:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650906008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=2XEvTZzG1lvUWu9yjgGpuGqcgvI8ptYR0o+dnNI30nI=;
        b=SoTDczs1wTsIbA5eWfbR6qdlnC1TCN8JgAwIu3ZM/uRzRdysEKG5QGezmRarqy7ISJnQDu
        Htrc6UhzsnGFfwSV6u79JohUzEkr7THhtwt2JOOEQSXcRZD1dsPX9kz9/GIa3B1RA/St4J
        2IziHn9YxoJFmL+D2srhnbBQrGgndeM4kbboJdNx7l9ZBSrL77KyUSu3KmqhkJXftk62qJ
        mliUNmkNXJ/VDvDQvp9CxEaiz1eu8lwnHZ/pot8R1etS7qilWoJL6jEx1zd1pUqy4ICt+l
        EaL8v6X8vLKL1kE2IPdh58KZyTpSCmL/hu7VsFxLkUUhMUsAuAt96DRBGoDOrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650906008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=2XEvTZzG1lvUWu9yjgGpuGqcgvI8ptYR0o+dnNI30nI=;
        b=ARlQ/tM7TH38XAqnVELArPJ0KBOlCKuu0gnfz7lULdWLe+PjyyLOBVcKzmvgm/1rWUUWR2
        n9RquYpzVXu8lRDA==
To:     Mukesh Ojha <quic_mojha@quicinc.com>, linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, rafael@kernel.org, johannes@sipsolutions.net,
        gregkh@linuxfoundation.org, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH v2 ] devcoredump : Serialize devcd_del work
In-Reply-To: <1650892193-12888-1-git-send-email-quic_mojha@quicinc.com>
Date:   Mon, 25 Apr 2022 19:00:08 +0200
Message-ID: <87levt14kn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25 2022 at 18:39, Mukesh Ojha wrote:
> v1->v2:
>  - Added del_wk_queued to serialize the race between devcd_data_write()
>    and disabled_store().

How so?

Neither the flag nor the mutex can prevent the race between the work
being executed in parallel.

disabled_store()                                worker()    

  class_for_each_device(&devcd_class, NULL, NULL, devcd_free)
    ...
    while ((dev = class_dev_iter_next(&iter)) {
    						devcd_del()
                                                 device_del()
                                                 put_device() <- last reference
          error = fn(dev, data)                   devcd_dev_release()
            devcd_free(dev, data)                  kfree(devcd)
              mutex_lock(&devcd->mutex);
      

There is zero protection of the class iterator against the work being
executed and removing the device and freeing its data. IOW, at the
point where fn(), i.e. devcd_free(), dereferences 'dev' to acquire the
mutex, it might be gone. No?

If disabled_store() really needs to flush all instances immediately,
then it requires global serialization, not device specific serialization.

Johannes, can you please explain whether this immediate flush in
disabled_store() is really required and if so, why?

Thanks,

        tglx
