Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F239B50B8D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243446AbiDVNow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiDVNos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:44:48 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE9857B22
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=gbXx4b6Mgu586f0vx1b0zCF4+cN4TmN4X1RYmCd7jxQ=;
        t=1650634915; x=1651844515; b=GaaYwB42fDVob+cTYuyab6OZQfmWOwfUX2ZKubFIY34p38B
        ld7criHiSdXeVxBtJYBDV9F9fHhiMV+okzDJ+6QeK2o6jL+lNdOtgr+D4ZJ1IgXm1zo5eZTkBh5db
        fvrQFeLrmF7mDsvCf93AUJX0LQ/WQNmeX0nqgfhDMQU3+kF82CEtt9unVG9CkDXELAHLCuRImwV4M
        AYsdKvnOBgKbwFA8jBCMgAVrAov9zXPca/jnXHTefFhjCQw+pRvnnl3ILadt1rFA/OMLuEV+ghVFH
        KRRaYDuznYLsi5/xkep0pfAsQV+hK+aNHfqb2nOS9Tgj+MHsClQ4z+SQUxbb15Mg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nhtXk-00DXWL-CB;
        Fri, 22 Apr 2022 15:41:52 +0200
Message-ID: <2a14c4f64ff3e029a76c85d064146e6c303c96bb.camel@sipsolutions.net>
Subject: Re: [PATCH] devcoredump : Serialize devcd_del work
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Mukesh Ojha <quic_mojha@quicinc.com>, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, sboyd@kernel.org, rafael@kernel.org
Date:   Fri, 22 Apr 2022 15:41:51 +0200
In-Reply-To: <1650364077-22694-1-git-send-email-quic_mojha@quicinc.com>
References: <1650364077-22694-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-19 at 15:57 +0530, Mukesh Ojha wrote:
> In following scenario(diagram), when one thread X running dev_coredumpm() adds devcd
> device to the framework which sends uevent notification to userspace
> and another thread Y reads this uevent and call to devcd_data_write()
> which eventually try to delete the queued timer that is not initialized/queued yet.
> 
> So, debug object reports some warning and in the meantime, timer is initialized
> and queued from X path. and from Y path, it gets reinitialized again and
> timer->entry.pprev=NULL and try_to_grab_pending() stucks.
> 
> To fix this, introduce mutex to serialize the behaviour.
> 
>  	cpu0(X)			                      cpu1(Y)
> 
>     dev_coredump() uevent sent to userspace
>     device_add()  =========================> userspace process Y reads the uevents
>                                              writes to devcd fd which
>                                              results into writes to
> 
>                                             devcd_data_write()
>                                               mod_delayed_work()
>                                                 try_to_grab_pending()
>                                                   del_timer()
>                                                     debug_assert_init()
>    INIT_DELAYED_WORK
>    schedule_delayed_work
> 

Wouldn't it be easier to simply schedule this before adding it to sysfs
and sending the uevent?

johannes
