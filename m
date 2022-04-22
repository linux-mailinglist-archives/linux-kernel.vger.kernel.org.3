Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8404050B934
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448233AbiDVN4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiDVN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:56:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA0C5A0B1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=N9g5FPfq8uxs/XPuUy8BU7bUC5HJN88qs0ORLOBFKx8=;
        t=1650635617; x=1651845217; b=EftaVgC3EVc+9U9M3Fuv0Z6+0+nprkXC/8bSKA6Sm4JmNCr
        KRgUOloyZR13w/WlygYFKELkdG7tU3JlsIe3sdd4SoO5kIEdy/HYU8/+DqgP1Awcn9eIopSiH9oQF
        /8201u+Sw6jrCdrVYyhnSz/vlplW+fdd9BBgu8eOMcmZP7q9kUkd6aIKAk5DEJ2rKl6BWWnUljz2E
        VXxCrQT4kfHw0BJ2IqkMZhRARM50LI2ss+fJqgmK+cvB99puPcrrwgarQL8+dV4z174iIJvYaOHI4
        ekNPQhye5OoYDJfdR9un+/QjbOsD/JJRUG7HZEbupCECxfgDWfq7WwgUqSplLe2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nhtj6-00DXll-2O;
        Fri, 22 Apr 2022 15:53:36 +0200
Message-ID: <e59d076bc05ed319732ac3e234e423affae1cafe.camel@sipsolutions.net>
Subject: Re: [PATCH] devcoredump : Serialize devcd_del work
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Mukesh Ojha <quic_mojha@quicinc.com>, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, sboyd@kernel.org, rafael@kernel.org
Date:   Fri, 22 Apr 2022 15:53:35 +0200
In-Reply-To: <2a14c4f64ff3e029a76c85d064146e6c303c96bb.camel@sipsolutions.net>
References: <1650364077-22694-1-git-send-email-quic_mojha@quicinc.com>
         <2a14c4f64ff3e029a76c85d064146e6c303c96bb.camel@sipsolutions.net>
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

On Fri, 2022-04-22 at 15:41 +0200, Johannes Berg wrote:
> On Tue, 2022-04-19 at 15:57 +0530, Mukesh Ojha wrote:
> > In following scenario(diagram), when one thread X running dev_coredumpm() adds devcd
> > device to the framework which sends uevent notification to userspace
> > and another thread Y reads this uevent and call to devcd_data_write()
> > which eventually try to delete the queued timer that is not initialized/queued yet.
> > 
> > So, debug object reports some warning and in the meantime, timer is initialized
> > and queued from X path. and from Y path, it gets reinitialized again and
> > timer->entry.pprev=NULL and try_to_grab_pending() stucks.
> > 
> > To fix this, introduce mutex to serialize the behaviour.
> > 
> >  	cpu0(X)			                      cpu1(Y)
> > 
> >     dev_coredump() uevent sent to userspace
> >     device_add()  =========================> userspace process Y reads the uevents
> >                                              writes to devcd fd which
> >                                              results into writes to
> > 
> >                                             devcd_data_write()
> >                                               mod_delayed_work()
> >                                                 try_to_grab_pending()
> >                                                   del_timer()
> >                                                     debug_assert_init()
> >    INIT_DELAYED_WORK
> >    schedule_delayed_work
> > 
> 
> Wouldn't it be easier to simply schedule this before adding it to sysfs
> and sending the uevent?
> 

Hm. I think that would solve this problem, but not all of the problems
here ...

Even with your change, I believe it's still racy wrt. disabled_store(),
since that flushes the work but devcd_data_write() remains reachable
(and might in fact be waiting for the mutex after your change), so I
think we need an additional flag somewhere (in addition to the mutex) to
serialize all of these things against each other.

johannes
