Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DF75A724C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiHaARN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHaARK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:17:10 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7F78E981
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:17:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-340a4dcb403so171049157b3.22
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date;
        bh=E8CDFOqlCaKG90iMqEwm/LfKwcjkQWKMwvI704mam+A=;
        b=sRSEFmv5Eq+OrHQG3bjz9zFYirORCkjJLzQnOIMBnWRXsvlU7fvBlPXYxpI9FDc2rd
         a/dMnWyZQgek0+mvBdyUF1z0nTKA8/Z8jfLK4eJ5yIf/1+RK9bfak4wP3pwawLcZRa8Z
         NejyAOBmxYlk+ml03JnVVb8A2J9/4eJq9/UMjnqU3XWsEUvtP36HsP5R865fdUKQKdVq
         SFCKMPBiJg8WaXiAibhA9+mDJIme+ONB8hCAmF5pEfwMcEfZXwgCKPCDwdcwBG9ghuUP
         FQmFT+FnN3Q5xmIkNtU5bHjLLK/W2uL9i6v1b3JVtGTGKvZ7m7a5HZai1Xcd5fiJdTKY
         HVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date;
        bh=E8CDFOqlCaKG90iMqEwm/LfKwcjkQWKMwvI704mam+A=;
        b=1kF1gu9d7zpX6aCOYh1IjDAmIw1NmIR8IZiy0RJgJimh8k5JRlvW1hErulmFIm5d46
         DF1mGfTMBLimndjbhJrSvmank3y7VgXNHhdCUtyemLAvjl7g4zbe5cv+lqyUYU8jZm+3
         QT4Hp7VUUJN6GQ+KkRLejmyuJzpZgRwZ1v5CfUbFBL3X70XFJMd6M3wHkIk6FOKKK6uj
         Aqx4bEs6g+qIXxtbBtYQ+tPYNKY4vc0dhR9WVUU2H+HsuOZe/YCkXnez0MIAdb/OxA4n
         sk7fb33Gw3/SVwWaVK12VE2NnD1JmAk65tSjpV9KeNmlrvJhDr0XcyrM2bv0HFwEdC0c
         OzkA==
X-Gm-Message-State: ACgBeo0BZzNf3eFgf7jqoBM2JSzflS1TnXUKxL7bp7xkxdOLweZld9Ed
        VIW0m0CkpTsfR95misJEuC5HiSvjMwI=
X-Google-Smtp-Source: AA6agR7YMMnxH+GyS5OiH482L8sF/qgGgkG7TztN8IlTCjBXU6MAfEV2RmSP2UNuzGvtNEBs+Yo5GGW6HIQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c685:0:b0:692:a21b:bd54 with SMTP id
 k127-20020a25c685000000b00692a21bbd54mr13279505ybf.262.1661905028768; Tue, 30
 Aug 2022 17:17:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 31 Aug 2022 00:17:03 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831001706.4075399-1-seanjc@google.com>
Subject: [PATCH 0/3] KVM: x86: Clean up MSR filtering+exiting docs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to improve the documentation for MSR filtering+exiting.  The
existing documentation is quite verbose, but manages to avoid stating what
KVM actually does, and unnecessarily introduces new terminology, e.g. uses
"deflect" where KVM typically use "intercept".

Sean Christopherson (3):
  KVM: x86: Delete documentation for READ|WRITE in
    KVM_X86_SET_MSR_FILTER
  KVM: x86: Reword MSR filtering docs to more precisely define behavior
  KVM: x86: Clean up KVM_CAP_X86_USER_SPACE_MSR documentation

 Documentation/virt/kvm/api.rst | 117 +++++++++++++++++----------------
 1 file changed, 59 insertions(+), 58 deletions(-)


base-commit: 2c65ad2d8ed2b4a5ddeeec2406eda74a4a4c5230
-- 
2.37.2.672.g94769d06f0-goog

