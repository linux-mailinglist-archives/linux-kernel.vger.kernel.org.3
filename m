Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF224ED5C2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiCaIim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiCaIik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:38:40 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DC71F044C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:36:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id s11so21278391pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=FfqJEQoGErwXNp6fBt9awHj++W7+1e1gnIfr7wj0C9Y=;
        b=F7XdH9Wq5B0XQUP2JI66crA6WPuRWEROHYIiyVUOf0f1P9BWJBWGgsabrRheMcLj2N
         ZdQgtRNDdNP37judw1XE08b+66FcpX7Tsp8NTQUJE1jK96ngLJc33MdcJhafx+r8i41L
         uyuNTzGvJIEyJHDA7qsGIuFaTvcUrkazCJVmu7EajH3G4/qd1JruznNCVrGfaeLcvxuv
         I7g/EcfSM5V0jAP0SKxOO3YegUyGVCBnTobJSXXBDolqbLx+AZwlKQs/r8Nva1B1zDky
         rciTf6d/lkzpQCNXiyFN/ALgs0AcZpgLCzQK1xSdOwSJxs+LdDthTJ7j6+OP0u5EX5xi
         SfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FfqJEQoGErwXNp6fBt9awHj++W7+1e1gnIfr7wj0C9Y=;
        b=zBwHWbk3rQtbvEjheV1ayA5o85nJSWqfgO5gQwQI/BWV0oRMK+5z9xPiVp4jRG1qbw
         XXHreYOo6iotSmAazR10ggLGpv2HKoHKJvUMwGgUkRxGxV9gSxjBowa7p2oPyYlSMMGl
         kD+DUSYoU4CNjAU60yAXTWynuR9dq7IEorZ5aFipDw3DYWyTs/FphRWL46MpIEIEB0oe
         Sr6PToCpz2Wv0Y0HD/FctMEln5k0gVXgjIwt7uDcAWw+i7+KuVRIwbWbWDPA8SJTy+xB
         EV0KAKZ6aZQyOWSzw7GnzuK/6Z4a15c7rLAgYMeToLocYbd6vkozTh20t9c8Jest5yj/
         hFlQ==
X-Gm-Message-State: AOAM533iAZxmM0WNN+BN5/I0xReox5lwMmKKyXsdlB1IN3tfWT6Wedhq
        KgQqFfJMstLTkR4o/1Us4LivcxUTLLtNobvwkFtspAbdMDTSaw==
X-Google-Smtp-Source: ABdhPJw9ShuF4A5LN1YGHAdRDiTzcViLOmY/7kHMVnT2dIkwWNl3NhCx/+T3MUxf/4IoDV/juNyPGm+L6YXtloQkW80=
X-Received: by 2002:a63:c24:0:b0:382:2a04:3dbe with SMTP id
 b36-20020a630c24000000b003822a043dbemr9819275pgl.158.1648715813184; Thu, 31
 Mar 2022 01:36:53 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= 
        <socketpair@gmail.com>
Date:   Thu, 31 Mar 2022 13:36:42 +0500
Message-ID: <CAEmTpZGJxtTuq8LDTLDK4V8to_Z30WEmo=p_2umboHvZaDr=Xg@mail.gmail.com>
Subject: BUG: vfork() returns EINVAL after unshare(CLONE_NEWTIME)
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test:
----------------------------------------
#define _GNU_SOURCE 1
#include <stdio.h>
#include <sched.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <err.h>

#ifndef CLONE_NEWTIME
#define CLONE_NEWTIME   0x00000080
#endif

int main (void)
{
  if (unshare (CLONE_NEWTIME))  err (EXIT_FAILURE, "UNSHARE_NEWTIME");

  pid_t pid;
  switch (pid=vfork ())
  {
  case 0:
    _exit(0);
  case -1:
    err(EXIT_FAILURE, "vfork BUG");
  default:
    waitpid(pid, NULL, 0);
  }
  return 0;
}
-----------------------------------------------

Seems the bug in kernel/fork.c. It does not check for CLONE_VFORK

if (clone_flags & (CLONE_THREAD | CLONE_VM)) {
    if (nsp->time_ns != nsp->time_ns_for_children)
        return ERR_PTR(-EINVAL);
}

-----------------------------------
Changing vfork() to fork() in the program works ok.
The bug has been found during regression in our system because Python
3.10 runs subprocesses using vfork()+execve().

-- 
Segmentation fault
