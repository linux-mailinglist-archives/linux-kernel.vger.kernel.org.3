Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C805AEDA9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbiIFOkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242338AbiIFOjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:39:08 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8609A9E3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:01:10 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id h12-20020a170902f54c00b0016f8858ce9bso7812550plf.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date;
        bh=Lq7riar+uQ6X+8Gvp5Fg5gDGB/Hhk+iwQZcEdky3g/c=;
        b=OY34NkbflE4C0bujvyFI1q5sEh4NBLhkhXVGmh455fMAcD2cS3JvWWpv1A1L03vlp5
         l8GuIovmdSzJRowa7Vae9B+hzH5mr14KsiM+wg94715AhRO0a6uciIiekIrJdqUKmuhe
         30UnwznzPoIo5tYVatPhLIhChyBQjYmSjK2MLoB82z0/j6gOZhTyw2aDGyqcVDvNbFRN
         9jr/1M1tIVq0jyJXBHFzIQkHrGae17nQD/gEgDF7mvqZLbr+xYtJGElMogVDBT8YMOC6
         3PqUiTdXANzwA69b6ncSWXW9SZYrkdegsWFP/abITp6c/vQPD9+XHZGF7hb0CwpCQMLn
         4IJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Lq7riar+uQ6X+8Gvp5Fg5gDGB/Hhk+iwQZcEdky3g/c=;
        b=rtJruG7z/Cf7MA6/8dh5iYf/GvbGhTsgBy7h/8qMbGmSHT3itV3O2WouO/z+chjI7o
         l/Cx/o4sAfa8QeO4qMZ/qsZ66c4Nz6i29GWNoyM2EGECQK4oJKgyo80iTwZ9IEpWWny8
         ZGmWipnl0u5/EBPWk3keZrs569BMPsSOv7SDEQr89nEey14o3CNTZpnJSyziebWI5QN6
         BjQPFSgirEzAzWLRY/XWvoyWDOubYtdAL4JVoSN0rumpuE+J7ObQtPqYUxKtkP7/KC7s
         u/c7028XCVmNxb8TbQWjW5/66WSETKPJTRb+XzWTglYRfm68QJsqF1GR4X26zv6zA4Mj
         3KgQ==
X-Gm-Message-State: ACgBeo02B264na2LELi1VdDD1z/SswDep4HgwwWLFD3vjeaYha6sxlIQ
        6J5zT8yT5TiGVjRAvbgbgat8d8UVkU25cg==
X-Google-Smtp-Source: AA6agR4AOXnEJ0/4hCB4m20xugoN0ph9ftdVhDv4bwb/GGvYsT//uszeEW9chiXzk/HwkZxEhumLNSXANorVww==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:b484:b0:170:a2d8:80f6 with SMTP
 id y4-20020a170902b48400b00170a2d880f6mr53978078plr.97.1662472796815; Tue, 06
 Sep 2022 06:59:56 -0700 (PDT)
Date:   Tue,  6 Sep 2022 13:59:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220906135948.3048225-1-cmllamas@google.com>
Subject: [PATCH RESEND 0/3] binder: rebase remaining alloc->vma patches
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-team@android.com, Carlos Llamas <cmllamas@google.com>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rebase of the remaining patches previously sent in [1], which
depended on commit 1da52815d5f1 ("binder: fix alloc->vma_vm_mm null-ptr
dereference") being merged into mainline. Now we can proceed with these
remaining patches rebased against the char-misc-next branch.

[1] https://lore.kernel.org/all/20220829201254.1814484-1-cmllamas@google.co=
m/

--
Carlos Llamas

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Arve Hj=C3=B8nnev=C3=A5g" <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Martijn Coenen <maco@android.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: kernel-team@android.com
Cc: linux-kernel@vger.kernel.org

Carlos Llamas (3):
  binder: rename alloc->vma_vm_mm to alloc->mm
  binder: remove binder_alloc_set_vma()
  binder: fix binder_alloc kernel-doc warnings

 drivers/android/binder_alloc.c | 55 +++++++++++-----------------------
 drivers/android/binder_alloc.h |  9 +++---
 2 files changed, 21 insertions(+), 43 deletions(-)

--=20
2.37.2.789.g6183377224-goog

