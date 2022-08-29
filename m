Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390DB5A5560
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiH2UND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiH2UM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:12:59 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8928695E7B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:12:58 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id r74-20020a632b4d000000b0041bc393913eso4514979pgr.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc;
        bh=uqHUoZfTdvbY1QkERHZdR/htcU1OMwPMgXPQ3z9IokU=;
        b=O583rz8bjT46gbhtE7PR64LQzDsu+I5Jq9bPPo6SKcPZmSv0Y9Br4VWqKBqzkg6Mgu
         2vP3wdsOIIocLncCVLR6A1b1CvhxKexkEKAKbKSbJpPGrvQ5x53/syel/n2CUaKYzFsy
         Qn6Cgwq+ZR5afqZJykvAr8ActNXXkzQb9MI0TujSCzfL7GiSB/ND8F6SBugnPNwX0Hyo
         uwoXF6U4Z7LMMFQMzvviCo/g38QckQ2vXg2H6ro66CcxYcfr7HyGrdwCOiA6xSVC57Fp
         oyc+5RpxDesbKQqx8fsdGJdDlhfW0I8kwjQKaagST28HEu5c2B3MO2fy0to5waWyamtt
         6htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc;
        bh=uqHUoZfTdvbY1QkERHZdR/htcU1OMwPMgXPQ3z9IokU=;
        b=XjVI6eSPnc/cHVSJWtg1qAOj5C7Th9h0usgCoH1MVigojqy2V7N016vMzKoLDdGscU
         Yce9yxjVlIHIrNeQ6z8GgvbWO5i/xyrK0B+JHAnRfRAEWN0VmF3y5AwdjRYE9nywrRN8
         3WAs5SKCj9tLfn4e/3MsWwpgJuJHeZUtaw+qcKXOg3D5Cr4h5A7GfiQSLe9JVxxofwyJ
         Zr8WNu3mdi0FocV28W7Pvg6MOCdLb8wBruzWUhYREknseRBr1n7ge2vUHeLYxBU/tw3Q
         n83NzgKxk4/Zkv7IiIbh7sAstjKBujJWXuQHmfI203qIm8C8LqGjowxVvdVxxWLUjF2y
         R8QA==
X-Gm-Message-State: ACgBeo2TNtp67mew1SxWQQSItY3Fy58UvoKhUuLjDD6nxPebqbFSOktW
        XBlwbxeNXT67og3J+dA33VxMz2AEhnj5LQ==
X-Google-Smtp-Source: AA6agR6mW7YktKTVsQ/Ge/ABV3JL+tNitO3oXV+eC5HsZtDWgjZSvQ/lKm77/KB67vWiN56cyZl12V5IC18oww==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:aa7:888d:0:b0:538:328b:2ffb with SMTP id
 z13-20020aa7888d000000b00538328b2ffbmr7159243pfe.82.1661803978001; Mon, 29
 Aug 2022 13:12:58 -0700 (PDT)
Date:   Mon, 29 Aug 2022 20:12:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829201254.1814484-1-cmllamas@google.com>
Subject: [PATCH 0/7] fix null-ptr-deref in binder_alloc and others
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-team@android.com, Carlos Llamas <cmllamas@google.com>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

This patch series fixes primarily a null dereference of alloc->vma_vm_mm
reported by syzbot which unfortunately is quite easy to reproduce. Also,
included here are several other patches for more trivial things I found
along the way.

--
Carlos Llamas

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Arve Hj=C3=B8nnev=C3=A5g" <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Martijn Coenen <maco@android.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: kernel-team@android.com
Cc: linux-kernel@vger.kernel.org

Carlos Llamas (7):
  binder: fix alloc->vma_vm_mm null-ptr dereference
  binder: fix trivial kernel-doc typo
  binder: rename alloc->vma_vm_mm to alloc->mm
  binder: remove binder_alloc_set_vma()
  binder: remove unused binder_alloc->buffer_free
  binder: fix binder_alloc kernel-doc warnings
  binderfs: remove unused INTSTRLEN macro

 drivers/android/binder_alloc.c | 55 +++++++++++-----------------------
 drivers/android/binder_alloc.h | 12 ++++----
 drivers/android/binderfs.c     |  1 -
 3 files changed, 22 insertions(+), 46 deletions(-)

--=20
2.37.2.672.g94769d06f0-goog

