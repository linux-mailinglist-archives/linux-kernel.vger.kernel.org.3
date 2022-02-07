Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851AD4AC363
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359019AbiBGP3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443868AbiBGPQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:16:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55C03C03E96D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644246945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=yRS0jwicXufc7zZ+ZjLAedvo4qD1/VIqyE355apXrv8=;
        b=bbWNLUnN/+aOIdXG1SWJgPcKTauFo5YCyt0aZdXi18iyjqUN1UhkmHfmTQaP0x2CK7jF+b
        zKV2Dm+6l+IYzapCGXW8mvWFNJY+A1Uugg08ApcuXvcoDJR8Y4IXq3YV+LVAL0k4CeIlAM
        fsWErq2OjR6SnSU+UjabzclbZh74L3o=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-neyFT63nOFSBzSrThIra2Q-1; Mon, 07 Feb 2022 10:15:44 -0500
X-MC-Unique: neyFT63nOFSBzSrThIra2Q-1
Received: by mail-yb1-f198.google.com with SMTP id y4-20020a5b0f44000000b00611862e546dso28936959ybr.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 07:15:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yRS0jwicXufc7zZ+ZjLAedvo4qD1/VIqyE355apXrv8=;
        b=moJpIyCz1nySaZkEp7fbRGrsgsXyG0TFOmAs9VibSvIYrT/adAvJVpyliKXRszZCYg
         zFNbtxPk92pblZrDAhv1zN6EnRzSh4mAVzB6paV4VIuyNtAquyDPMAG9PELdYMGHom5a
         e1P5awx6fqRWJ9wOGgscZeQpTIJNz82a6rMJdmCrCOBH0wpxQPMjqKTuxeVS7zi5vCaf
         YQfMZbh4VxtXlKbg3NMUxMFV+f9w666GyN9lszJigKk7/eF9CMbHMLBzj1sIiwWmVy27
         ZwOMriFg81kGX+96cvFX3QUiNG8woOH+uRJld/md2q2CymsoAWfR7Vc1vN7LDKr0eaBN
         2d6Q==
X-Gm-Message-State: AOAM530BGCgNGSUSlgxs5B6VUX3Ux4++ky2XK2eGiu+h4IWCKIddIReB
        zuOGifyFHsZhrI5RUgBHo+dhrwoSBJT3PqZOnYL1BPdU/+YAx+SQ5ZSLOjLjQUU929PyVSWobda
        3JhhzAD7NLn15fjy87NRxXE2Dud8RZWNX8Wex63Ql
X-Received: by 2002:a25:eb06:: with SMTP id d6mr154240ybs.318.1644246943914;
        Mon, 07 Feb 2022 07:15:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXeoD3ojnTOZwKa5lUfxhmIBl5fyP9msdolVbDq/zqr50MBXuutrVFsOhfOWyA9jOd9gjS0pyGenm4USUc87Y=
X-Received: by 2002:a25:eb06:: with SMTP id d6mr154219ybs.318.1644246943702;
 Mon, 07 Feb 2022 07:15:43 -0800 (PST)
MIME-Version: 1.0
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 7 Feb 2022 16:15:27 +0100
Message-ID: <CAFqZXNt0Xp1j7+hTrV9XZ936Yz+H8Le0pqazhLr3drO0tEzB2w@mail.gmail.com>
Subject: Semantics vs. usage of mutex_is_locked()
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

(This is addressed mainly to the kernel/locking/ maintainers.)

In security/selinux/ima.c, we have two functions for which we want to
assert the expected locking status of a mutex. In the first function
we expect the caller to obtain the lock, so we have
`WARN_ON(!mutex_is_locked(&state->policy_mutex));` there. The second
one, on the contrary, takes the lock on its own, so there is an
inverse assert (that the caller hasn't already taken the lock) -
`WARN_ON(mutex_is_locked(&state->policy_mutex));`.

Recently, I got a report that the second WARN_ON() got triggered,
while there was no function in the call chain that could have taken
the lock. Looking into it, I realized that mutex_is_locked() actually
doesn't check what we assumed ("Are we holding the lock?"), but
instead answers the question "Is any task holding the lock?". So in
theory it can happen that the second WARN_ON() gets hit randomly in an
otherwise correct code simply because some other task happens to be
holding the mutex. Similarly, the first assert might not catch all
cases where taking the mutex was forgotten, because another task may
be holding it, making the assert pass.

Grepping the whole tree for mutex_is_locked finds about 300 uses, the
vast majority of which are variations of the
warn-if-mutex-not-locked-by-us pattern. Then there are a handful of
cases where the usage of mutex_is_locked() seems correct and a few
cases of the inverse warn-if-mutex-already-locked-by-us pattern.

It seems like introducing a new helper with the "is the mutex locked
by current task?" semantics would be fairly straightforward, however
fixing all the mutex_is_locked() misuses would be a rather big and
noisy patch(set). That said, would it be okay if I send patches that
introduce a new helper and only fix misuses that can lead to wrong
behavior when the code is correct (e.g. can yield a false positive
WARNING/BUG) and documentation? That should be a reasonably small set
of changes, yet should take care of the most important issues. If
anyone cares enough for the rest, they can always send further
patches.

Also, any opinions on the name of the new helper? Perhaps
mutex_is_held()? Or mutex_is_locked_by_current()?

Thanks,

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

