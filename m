Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123AC500C37
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242717AbiDNLeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiDNLeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:34:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB4485BE1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:31:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649935910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OhOliN3feJAcg8egEr0Pq0MQjPTQ0OB0mYDEEBGa4ug=;
        b=GiQqD6pzJn6lo/8W7ye/VRUD6iDDEBwvXkq3RyQ03+yXCsZvDcL5lFu7nWJgWrXs5vTxub
        HFFucvOHSZdMNxsAbyBTntqCvwLM1H/6nCCOSPrwqixLH8BeyRemiFmpsds9pkAuw2h/R2
        sQBNlTYS+WfOGGD4RK/3JBMTXq9w6UjXi45HDBCZrFU4NJYdpaelc69EFYRq0vOrjfzevz
        QQW/oUm+RtHWdVu9h17eFBK6mlLOhn7XkwpuqfQ53qYWTFAUuRUkrg4QCXkVpMF9+0sJ+G
        vCfsXI3TWGx/C19CSld9ql1rK3vdOGOcQjvZeYYPs63GCcJ/dELGdtvhctEDkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649935910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OhOliN3feJAcg8egEr0Pq0MQjPTQ0OB0mYDEEBGa4ug=;
        b=4AKUXXK22wjmcqompFNUy6pFMfHLVgAS7l2EUAqGqeK+a7pdsSxcfN+yhAicoOQGpDKoak
        wncdRjLSjrE+fDDQ==
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, johannes@sipsolutions.net, rafael@kernel.org
Subject: Re: Possible race in dev_coredumpm()-del_timer() path
In-Reply-To: <20220414112055.GA14124@hu-mojha-hyd.qualcomm.com>
References: <2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com>
 <YlZg4KkiAgODr45d@kroah.com>
 <20220413101639.GA24349@hu-mojha-hyd.qualcomm.com>
 <Ylas6F75Y7O6R87U@kroah.com> <87pmlkdk6i.ffs@tglx>
 <20220414112055.GA14124@hu-mojha-hyd.qualcomm.com>
Date:   Thu, 14 Apr 2022 13:31:49 +0200
Message-ID: <87k0brew9m.ffs@tglx>
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

On Thu, Apr 14 2022 at 16:50, Mukesh Ojha wrote:
> On Thu, Apr 14, 2022 at 12:38:13PM +0200, Thomas Gleixner wrote:
>> So, yes this needs serialization of some sort.
>
> Thanks for understanding the problem.
> Can the patch mentioned at below link helps with the first problem ?
>
> https://lore.kernel.org/lkml/57a04278-0a60-cc7d-7ce8-a75c2befd568@quicinc.com/

Something like that.

>> Same problem vs. disabled_store().
>
> you mean, while userspace is reading the data and suddenly disable_store() done from
> sysfs.

No, that's not a problem because the reader holds a reference, but it's
the same problem vs. initialization:

  device_add()
                        disable_store()
                          devcd_free()
                           mod_delayed_work()
                           ....
Thanks,

        tglx
