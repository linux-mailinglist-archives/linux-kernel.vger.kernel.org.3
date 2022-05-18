Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE60852B1BD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 07:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiERE54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiERE5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:57:53 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9B74968E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O2P8qr8IgXo7yU5pRDpSfGWoSMsjfEFgjVCoHap6jzI=; b=bLhmsyAIXPurJTjTTWqCJDMTDa
        tbMCKiUQA6AgEuBFDw9joalqSkJXOV52zFHg7q58k+QxjIG4U5/EIh1cE+yz3HfjIrAd2QSQvnDaf
        7LMIjsy9D5opIYlgdyKhzwm4a1MEIGiCcekAPhVZrGqAv6h+ZOrg1YtcYotjdscgY2+hndfdJR9Y9
        qFQClK6BP0Ngo0ZKG1cwa+ZHIbWcdigcSQeTwzJTAP6JToCeUxv7qLnF5qh/DzYgG5ughQwFxkK/1
        3YI0xzXt+/us070LTnSYcyqVSTNoXdrGK4iFv3ZPBTF1gBXzI8zJ+2QFKpGbw3AW2owxLJb4A/MQE
        O37v2QTA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrBko-00Fw73-Gh; Wed, 18 May 2022 04:57:46 +0000
Date:   Wed, 18 May 2022 04:57:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
Message-ID: <YoR8yrgorv8QssX6@zeniv-ca.linux.org.uk>
References: <20220517223806.2299-1-hdanton@sina.com>
 <000000000000be329205df3cf252@google.com>
 <YoQohxAFD3EPujRC@zeniv-ca.linux.org.uk>
 <YoRFAoe99ob/YzD5@zeniv-ca.linux.org.uk>
 <YoRHfB7lEGUwQBGU@zeniv-ca.linux.org.uk>
 <YoRS0L0ywSZkflq7@zeniv-ca.linux.org.uk>
 <YoR4XSN2fn2BjkXw@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoR4XSN2fn2BjkXw@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 04:38:53AM +0000, Al Viro wrote:
> On Wed, May 18, 2022 at 01:58:40AM +0000, Al Viro wrote:
> > On Wed, May 18, 2022 at 01:10:20AM +0000, Al Viro wrote:
> > > On Wed, May 18, 2022 at 12:59:46AM +0000, Al Viro wrote:
> > > > On Tue, May 17, 2022 at 10:58:15PM +0000, Al Viro wrote:
> > > > > On Tue, May 17, 2022 at 03:49:07PM -0700, syzbot wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > > > > WARNING in mntput_no_expire
> > > > > 
> > > > > Obvious question: which filesystem it is?
> > > > 
> > > > FWIW, can't reproduce here - at least not with C reproducer +
> > > > -rc7^ kernel + .config from report + debian kvm image (bullseye,
> > > > with systemd shite replaced with sysvinit, which might be relevant).
> > > > 
> > > > In case systemd-specific braindamage is needed to reproduce it...
> > > > Hell knows; at least mount --make-rshared / doesn't seem to suffice.
> > > 
> > > ... doesn't reproduce with genuine systemd either.  FWIW, 4-way SMP
> > > setup here.
> > 
> > OK, reproduced...
> 
> FWIW, it smells like something (cgroup?) fucking up percpu allocation/freeing.
> Note that struct mount has both refcount and writers count held in percpu;
> replacing the refcount with atomic_t gets rid of seeing negative refcount
> in mntput_no_expire(), but leaves negative writers count caught in
> cleanup_mnt(); turn that from WARN_ON into printk and we get past that,
> only to see
> 	percpu ref (css_release) <= 0 (-4294967294)
> immediately afterwards.
> 
> IOW, it looks like we are getting not messed refcounting on either side,
> but same refcount physically shared by unrelated objects.

Gotcha.
percpu_ref_init():
        ref->percpu_count_ptr = (unsigned long)
                __alloc_percpu_gfp(sizeof(unsigned long), align, gfp);
        if (!ref->percpu_count_ptr)
                return -ENOMEM;
        data = kzalloc(sizeof(*ref->data), gfp);
        if (!data) {
                free_percpu((void __percpu *)ref->percpu_count_ptr);
                return -ENOMEM;
        }

cgroup_create():
        err = percpu_ref_init(&css->refcnt, css_release, 0, GFP_KERNEL);
        if (err)
                goto err_free_css;

        err = cgroup_idr_alloc(&ss->css_idr, NULL, 2, 0, GFP_KERNEL);
        if (err < 0)
                goto err_free_css;

Now note that we end up hitting the same path in case of successful and
failed percpu_ref_init().  With no way to tell if css->refcnt.percpu_count_ptr
is an already freed object or needs to be freed.  And sure enough, we have

err_free_css:
        list_del_rcu(&css->rstat_css_node);
        INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
        queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);

with css_free_rwork_fn() starting with
        percpu_ref_exit(&css->refcnt);

which will give that double free.  That might be not the only cause of
trouble, but this looks like a bug and a plausible source of the
symptoms observed here.  Let's see if this helps:

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index af9302141bcf..e5c5315da274 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -76,6 +76,7 @@ int percpu_ref_init(struct percpu_ref *ref, percpu_ref_func_t *release,
 	data = kzalloc(sizeof(*ref->data), gfp);
 	if (!data) {
 		free_percpu((void __percpu *)ref->percpu_count_ptr);
+		ref->percpu_count_ptr = 0;
 		return -ENOMEM;
 	}
 
