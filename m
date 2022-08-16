Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20D8595F96
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbiHPPtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbiHPPsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:48:40 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 Aug 2022 08:45:03 PDT
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D751288DFB
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:45:01 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-qpeCTJYqNdyWCkUQKw-9yw-1; Tue, 16 Aug 2022 11:43:52 -0400
X-MC-Unique: qpeCTJYqNdyWCkUQKw-9yw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDD6985A581;
        Tue, 16 Aug 2022 15:43:51 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.40.208.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 585FE2166B26;
        Tue, 16 Aug 2022 15:43:50 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH v1] sysctl: Allow change system v ipc sysctls inside ipc namespace
Date:   Tue, 16 Aug 2022 17:42:42 +0200
Message-Id: <cover.1660664258.git.legion@kernel.org>
In-Reply-To: <87wnc1i2wo.fsf@email.froward.int.ebiederm.org>
References: <87wnc1i2wo.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 11:16:07AM -0500, Eric W. Biederman wrote:
> Alexey Gladkov <legion@kernel.org> writes:
>
> > Rootless containers are not allowed to modify kernel IPC parameters such
> > as kernel.msgmnb.
> >
> > It seems to me that we can allow customization of these parameters if
> > the user has CAP_SYS_RESOURCE in that ipc namespace.
> >
> > CAP_SYS_RESOURCE is already needed in order to overcome mqueue limits
> > (msg_max and msgsize_max).
>
>
> For changing the permissions on who can modify the SysV limits, I don't
> think this change is safe.  I don't see anything that will prevent abuse
> if anyone can modify these limits.  Replacing the ordinary unix DAC
> permission check with ns_capable will allow anyone to modify the limits.

All limits are set to almost maximum values - ULONG_MAX. Limit values
are not inherited and are counted in the each ipc namespace (shm_tot is
not global and is located in ipc_ns). In fact, limits are disabled by
default. They can only be reduced.

> That said there is RLIMIT_MSGQUEUE that limits the posix messages queues
> so those should be safe to allow anyone to modify their limits.
>
> The code in mqueue_get_inode is where that limiting happens.
>
> For the posix message queues all that should be needed is to change the
> owner of the sysctl files from the global root to the user namespace
> root.  There are also two capable calls in ipc/mqueue.c that can
> probably be changed to ns_capable calls.
>
>
> The only posix message queue limit that I don't immediately see
> something that will prevent abuse of is /proc/sys/fs/mqueue/queus_max.
> That probably still runs into RLIMIT_MSGQUEUE somewhere but it was
> not immediately obvious at first glance.

Everything always ends in mqueue_get_inode. In mqueue_create_attr we
check mq_queues_max and call mqueue_get_inode almost immediately.

I suggest allowing root in user namespace to change ipc namespace
limits.

--

Alexey Gladkov (3):
  sysctl: Allow change system v ipc sysctls inside ipc namespace
  sysctl: Allow to change limits for posix messages queues
  docs: Add information about ipc sysctls limitations

 Documentation/admin-guide/sysctl/kernel.rst | 14 ++++++--
 ipc/ipc_sysctl.c                            | 34 ++++++++++++++++---
 ipc/mq_sysctl.c                             | 36 +++++++++++++++++++++
 3 files changed, 76 insertions(+), 8 deletions(-)

-- 
2.33.4

