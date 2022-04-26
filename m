Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0955850F19B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbiDZHDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbiDZHDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:03:04 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71E5606DC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:59:56 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id ne12-20020a1709077b8c00b006f3aca1f2b2so926640ejc.17
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=Pl23pgw2QRmZxu/rVHBG/vRwq0BrcXgENMaH2heZ7ug=;
        b=b86lc2mydFvYH75fQREZ4C1BxVG0XfRGBq1e+5PLjfo9D0MM9Iu6ws1pvccyZZHjVR
         OuR7Hwv7NkvffG5FT4oV14TT5shJ6+B4z4VdaEJlbCih9kSFh6K9LQ41RSkUOy7FEnhJ
         iSkfBIdXImU9PY9ykGOEC1MJNywC/7knrmlXtRoYMIvzfJU6HFXUytjH1LMtaW6BDl1s
         xwhoFt5Fptv2hHCd+yNUXgxdX34pczjLnc1sh24p48fa+8zp8dpL7NMuefGPacSNYrrP
         U6ELCW/mMsd1oMlyqE5HaXtqwOup9HN+HGpYrcVRSNyLeebGvJS5UZy4WhVU4rkPNtRl
         BfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=Pl23pgw2QRmZxu/rVHBG/vRwq0BrcXgENMaH2heZ7ug=;
        b=IjaYF0Y7zEkeKVD693Yet+3FCPIY4uGSFmDGXKKFOhpitBNgsw7/+MswmbSKdwFMrZ
         KlLF/qkTjI96/2gpxgepY91/ZlmYNNicePsfvSjHXaBf/2nBbFefAMnZxvHcBAzIJKXK
         YkXh7/MBsU0woBjRVdp2Nmq96aGGeQKQYucRVyNQ8SjX1Zv2BTB7nT1mU6KAL5QvOjCa
         bkLOOxsph2bGMVROZKJlj08v/tZQn0ShIj1lXX2WIDFFuDvOAg/ElAgKgFPdJYJPpMHU
         XVZBWdLgYJboLfTRFNc/oMJ5Y8PWdmNeO4CNgSWS+ShLwvT8pJYstTkO/W10jvV7gXu5
         4mdQ==
X-Gm-Message-State: AOAM530B6kWoUxUztLaWEFnB8J3J9ecsfvYpTJ6+VCOvgIUX1GzWVdJI
        Tw1Ks3Vn+KpMs2Wa2B49jPE/6kP/vfq/gpM=
X-Google-Smtp-Source: ABdhPJxRJ5Q+ZfSN3aV125btZLVGedghKGIZZWs71YfysEhzwdbFFh7W2sjve9hon/ZiLtCcOUwQhnhTArDziOuX
X-Received: from bartoschek.muc.corp.google.com ([2a00:79e0:15:10:5734:8ae8:25cb:cd3])
 (user=bartoschek job=sendgmr) by 2002:a50:ed11:0:b0:425:c3d1:4547 with SMTP
 id j17-20020a50ed11000000b00425c3d14547mr19795956eds.410.1650956395087; Mon,
 25 Apr 2022 23:59:55 -0700 (PDT)
Date:   Tue, 26 Apr 2022 08:59:17 +0200
In-Reply-To: <8E281DF1-248F-4861-A3C0-2573A5EFEE61@fb.com>
Message-Id: <20220426065917.3123488-1-bartoschek@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: Re: [PATCH RFC fs/namespace] Make kern_unmount() use synchronize_rcu_expedited()
From:   Christoph Bartoschek <bartoschek@google.com>
To:     Chris Mason <clm@fb.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "riel@surriel.com" <riel@surriel.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Christoph Bartoschek <bartoschek@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regression that has been introduced with commit
e1eb26fa62d04ec0955432be1aa8722a97cb52e7 has hit us when building with Bazel
using the linux-sandbox
(https://github.com/bazelbuild/bazel/blob/master/src/main/tools/linux-sandbox.cc).
The sandbox tries to isolate build steps from each other and to ensure that
builds are hermetic and therefore sets up new namespaces for each step. For
large software packages and even with the time spend building we run out of
namespaces on larger machines that allow for enough parallelism. I have reduced
the sandbox to a simple test case:

#define _GNU_SOURCE
#include <errno.h>
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>

int pid1main(void *) {
   return 0;
}

int main(void) {
  int clone_flags = CLONE_NEWUSER | CLONE_NEWIPC | SIGCHLD;
  void * stack = malloc(1024*1024);
  const pid_t child_pid = clone(pid1main, stack + 1024*1024, clone_flags, NULL);

  if (child_pid < 0) {
    perror("clone");
  }
  int ret = waitpid(child_pid, NULL, 0);
  if (ret < 0) {
    perror("waitpid");
    return ret;
  }
  return 0;
}

Run it with
$ gcc clone-test.cc
$ seq 1 10000000 | parallel --halt now,fail=1 -j32 $PWD/a.out
clone: No space left on device
waitpid: No child processes
parallel: This job failed:
/usr/local/google/home/bartoschek/linux-sandbox-test/a.out 53070

I run the test on kernel v5.18-rc4.
Depending on your configured limits you will soon get an ENOSPC even though
never more than 32 additional namespaces should be in use by parallel.
During execution the whole system can become quite unresponsive.
This does not happen without e1eb26fa62d04ec0955432be1aa8722a97cb52e7.

I see that the issue was already reported in 2020:
http://merlin.infradead.org/pipermail/linux-nvme/2020-September/019565.html

Would it be possible to revert e1eb26fa62d04ec0955432be1aa8722a97cb52e7? It
seems to make the kernel less deterministic and hard to reason about active
namespaces.

Christoph
