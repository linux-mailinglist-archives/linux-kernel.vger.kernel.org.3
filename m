Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CC5463E20
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245639AbhK3Szf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbhK3Szc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:55:32 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AADC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:52:13 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id lt10-20020a17090b354a00b001a649326aedso11989740pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ax2cs9gnIhnLhPV4f/S92IYbeytX9QqEe2LLX10LPbM=;
        b=GyB1V5n5ZJ1DqlPv1nDxRk91+7AmpJig+WkLz4HrD3TWO/dPhUm+papPU8BHFxbZzw
         q4acpB/xnWgukYkRn50u3TApCr0vhlHUJl0iDfFa3p17wbJOr3ySMdPdvvSGRbfw2C/I
         BWEqCbgMdRGPRi6zNkLCHqRtGYM7/EO6NqOJ3heifgMBv+B/jzYFQA4m/Vr0FSCbINFn
         qRT7s2K9Tf3B6a3yfFBvhHu98XBpr9OLQsIL21jLuCskCqRNIohevwZP15P4vwyMXjhC
         SS1UF0niFoPyXkEphUV0h3LoTlUkICrR+DSSZ9ea4m4RrDemdgJrwP1xRQ5pxc5N80OD
         MEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ax2cs9gnIhnLhPV4f/S92IYbeytX9QqEe2LLX10LPbM=;
        b=WVLCaDQ7mPi0WBWwoIGRx8vIxIyJJYxOM42g5XMLsqmQBdvuaJl9VHcIzWI7D2gsQv
         23XxgF3g9Zv89fDZVw96z3HgYooP4Z4/bxAKbe1scKkfVuP0Hv0AaW25wZipVeWVsuKc
         3oetK0hFQ0mtJRt1vLvgmWiRKPstc0b5hmRvBUWoGidmg5fgwxii+l/WUnbhgQQPGdqx
         GnArC6ISYWGycyxphkW80wwH0PbNBhv/yH4PQC1OMKro6SKziBxQZvAjft2epfMhLW2o
         v1Quw+BnHBp/ZlGfFPmtwJLRqJkIAFwu+bCNuQrFR34zDkluvu6fHh2pfU8Nhrloq9nt
         OLlQ==
X-Gm-Message-State: AOAM5319IeY2S8fdlowRvkCzpP9OXyfiU+YAmQjex3TpEk87B/Cws58l
        bx4SLVaaVOa2Lmi6nT4UCRKUaljZUw==
X-Google-Smtp-Source: ABdhPJyE3Ak7KQaYu5oLp8Q8aO9eeRuwNI3j0agSDy055CtVhXmdwtfJvpi5l/0GY1Re1G8fNzCOf+Vigg==
X-Received: from tkjos-desktop.mtv.corp.google.com ([2620:15c:211:200:2355:b4ef:3d57:5d7d])
 (user=tkjos job=sendgmr) by 2002:a05:6a00:2405:b0:4a8:3294:743e with SMTP id
 z5-20020a056a00240500b004a83294743emr673446pfh.61.1638298332805; Tue, 30 Nov
 2021 10:52:12 -0800 (PST)
Date:   Tue, 30 Nov 2021 10:51:48 -0800
Message-Id: <20211130185152.437403-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 0/4] binder: Prevent untranslated sender data from being
 copied to target
From:   Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, christian@brauner.io,
        arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com, avakj45@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binder copies transactions directly from the sender buffer
to the target buffer and then fixes up BINDER_TYPE_PTR and
BINDER_TYPE_FDA objects. This means there is a brief time
when sender pointers and fds are visible to the target
process.

This series reworks the the sender to target copy to
avoid leaking any untranslated sender data from being
visible in the target.

Todd Kjos (4):
  binder: binder: fix handling of error during copy
  binder: defer copies of pre-patched txn data
  binder: read pre-translated fds from sender buffer
  binder: avoid potential data leakage when copying txn

v2:
- add "binder: fix handling of error during copy" to fix
  bug noticed by Dan Carpenter
- address Dan Carpenter's comments

 drivers/android/binder.c | 442 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 387 insertions(+), 55 deletions(-)
