Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DBC598871
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344147AbiHRQOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245298AbiHRQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:14:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3890F474DC
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:14:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 65EB9CE20E1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15074C433D6;
        Thu, 18 Aug 2022 16:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660839248;
        bh=3yNt5Kqiwl2aUSnygBJDnjmyZm7Hyuhg3PJ++2+gJ8g=;
        h=From:To:Cc:Subject:Date:From;
        b=KyeGjGyQY4tAuUTQMtnGIt89ONINk7I+XxpeeleLUh6sOtt10CaeI20Rx46yXoIHL
         z87H3i3+13KRNpKuYR3PnFYgW3Ixcti6X1EaztztxooNgSLgsP4XfdkYKrkmfCTa0H
         nwfQSW3KY1JLdRqKpd8Iafxyzft1rfQcAtnv6k02VH2wqQJRPoFQlUQLASvgtpVLjf
         q7BUNtlWw2M/Bn7a/dAXiIphb6JGJWT3UTZsh0QydZtiTfAsKMaCNV3Sl+VYwQveAA
         P3p6Pn+Hdu29JVHY5Pv6I2/3ptJ+q853EIs+Bm1NZzgGbz/iQp5KnMmQjR4VRcZxqv
         2R+3YXYdyHHcA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Pengfei Xu <pengfei.xu@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Su, Heng" <heng.su@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/3] x86/kvm, objtool: Fix KVM "missing ENDBR" bug
Date:   Thu, 18 Aug 2022 08:53:40 -0700
Message-Id: <cover.1660837839.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the "missing ENDBR" KVM bug, along with a couple of preparatory
patches.

Josh Poimboeuf (3):
  x86/ibt, objtool: Add IBT_NOSEAL()
  x86/kvm: Simplify FOP_SETCC()
  x86/kvm: Fix "missing ENDBR" BUG for fastop functions

 arch/x86/include/asm/ibt.h | 10 ++++++++++
 arch/x86/kvm/emulate.c     | 26 ++++++--------------------
 tools/objtool/check.c      |  3 ++-
 3 files changed, 18 insertions(+), 21 deletions(-)

-- 
2.37.2

