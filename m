Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BF6519B99
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347096AbiEDJ2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240819AbiEDJ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:28:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD451EEC3
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ja8c4EKZyr8StyWNFS1D9IdR075oIiqW9K28X3bzmHY=;
        t=1651656273; x=1652865873; b=a3V7QFB6qbm/RlNGaRFa6sipWnZNzC4Nts7pq8e9twnFZ7m
        W2r5szXx6oi3p0gDO6us+VKE+NJDuJunzOCec+Ba2KddAIMfoNjoJOIyE36w+FFJpE4avTPjEspo+
        lz4SoVadAutgVu8UNAWEeNG1qdMPd2WYW88ZJrVtM8TUd000jHlIQaUSlmkMPVaPV6VsJgKLdGDOe
        TTTYUTBFBDBUfR6Q9YsygPOjcATpZYQJU8qlS5dmNtfTiC4sn3uw0qziQce/dX73q2Cwi5vnwqeIu
        LUvCicCEUcB16A0rJD8AUk4FkvtW/gm1JzYKvQPeiFdnNwZR1WrrH22D9RSqiYNg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmBFB-001zBz-KS;
        Wed, 04 May 2022 11:24:25 +0200
Message-ID: <05280c37163d08ff2d00d71c5454baf651867bd3.camel@sipsolutions.net>
Subject: Re: [syzbot] INFO: task hung in hci_dev_close_sync
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+c56f6371c48cad0420f9@syzkaller.appspotmail.com>
Date:   Wed, 04 May 2022 11:24:24 +0200
In-Reply-To: <a58edafc-0a60-2eee-4058-8d69e5f1310b@I-love.SAKURA.ne.jp>
References: <20220504044800.4966-1-hdanton@sina.com>
         <a58edafc-0a60-2eee-4058-8d69e5f1310b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-04 at 05:12 +0000, Tetsuo Handa wrote:
> 
> This seems to be a question regarding commit 87915adc3f0acdf0 ("workqueue: re-add lockdep dependencies for flushing").
> > 
> > syzbot should have been able to catch cancel_work_sync() in work context
> > by checking lockdep_map in __flush_work() for both flush and cancel.
> > 
> > Hillf
> > 
> > --- y/kernel/workqueue.c
> > +++ x/kernel/workqueue.c
> > @@ -3075,10 +3075,10 @@ static bool __flush_work(struct work_str
> >       if (WARN_ON(!work->func))
> >               return false;
> > 
> > -     if (!from_cancel) {
> > +     //if (!from_cancel) {
> > 

I think this is explained in commit d6e89786bed9 ("workqueue: skip
lockdep wq dependency in cancel_work_sync()")

johannes
