Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDDD4FC7FF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 01:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiDKXNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 19:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiDKXNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 19:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F21CC12ACD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649718661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XDcurTcGd36SAvgvSXuyg9O2teM5Od2NYf3cFtsEL/0=;
        b=AQTOQK1GsmA6Iak9MEqsf2wbqEYtzoaU8sW2Twrjf5+u+c/PbZneJLLBfpkW/W+G/haKAP
        52GLMMp/RszJtnkiBO9G5obcZs3Vv3QCN9nSYbWpSTVdOotvxEYeI4Gwc6+Yp35K8lyojZ
        FZ2EuDUEET1wC5/8cMWlhC4qh6qcb8o=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-cwTn52-eNRufNAK8xKQpRg-1; Mon, 11 Apr 2022 19:11:00 -0400
X-MC-Unique: cwTn52-eNRufNAK8xKQpRg-1
Received: by mail-qk1-f197.google.com with SMTP id d12-20020a379b0c000000b0067d8cda1aaaso8503688qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XDcurTcGd36SAvgvSXuyg9O2teM5Od2NYf3cFtsEL/0=;
        b=IYNCLkoLt1Pxe9ww1Rvm909+9hbqBfaLbJcTEQwyOJbEP0HO6GhUsRABYv2HyQBOhm
         W0xsG+ySKo6OkwahpMKgbUZMI7fk86/9xMgqEt+L6OYate/l1EODlqSTxG0gfUmmR9I5
         6WxSWdtiAC/LKppzdTc8kXNnb+PUXzBbOxwpWqiMxIcG3e6SuS/7H5PBXh0l9v6tgd9D
         WHsTZc2H66jC08EYJBANMOYEfU48wDN6fdKVcaR6jk2qMHujAMvwWK/bqkl6Xbnm6Ggt
         B2Eqkeh4i6gC1j7LO5K4fI/OWEXpCJ+MzM0dgN+0YLYkU/qAQm0YpGAbhUxyJonqETN1
         eT+A==
X-Gm-Message-State: AOAM530mFCCtyKv3gk+dRex9/qfVMY2f4FPAuhAH0tPAqlaPoxfuSFTy
        EDtxlol0ZqCHAiPXCSAen9Gq35LDm/qegSrwNlX81d//GrGQaU1Jrl+2oaF4n++C9AFAe2LMgiH
        ZtIBudfdiBF8vWtv6jDQQqS/T
X-Received: by 2002:a0c:ed2b:0:b0:444:3f99:dc5d with SMTP id u11-20020a0ced2b000000b004443f99dc5dmr7382499qvq.2.1649718660025;
        Mon, 11 Apr 2022 16:11:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDImYr1FLJUnMW0+qIjyzg7rfZcdG+N+ldIMRTXaf0oUSISbRX6OYa1AwwCfl22uXSGAJPqQ==
X-Received: by 2002:a0c:ed2b:0:b0:444:3f99:dc5d with SMTP id u11-20020a0ced2b000000b004443f99dc5dmr7382489qvq.2.1649718659847;
        Mon, 11 Apr 2022 16:10:59 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id c3-20020ac87d83000000b002e1d1b3df15sm27243500qtd.44.2022.04.11.16.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 16:10:59 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] objtool: Fix fallthrough detection for vmlinux
Date:   Mon, 11 Apr 2022 16:10:28 -0700
Message-Id: <cover.1649718562.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the 'c_file' hack and fix function fallthrough detection for
vmlinux.

Josh Poimboeuf (4):
  x86/uaccess: Don't jump between functions
  objtool: Don't set 'jump_dest' for sibling calls
  objtool: Fix sibling call detection in alternatives
  objtool: Fix function fallthrough detection for vmlinux

 arch/x86/lib/copy_user_64.S             | 87 +++++++++++++++----------
 tools/objtool/check.c                   | 73 +++++++++++----------
 tools/objtool/include/objtool/objtool.h |  2 +-
 tools/objtool/objtool.c                 |  1 -
 4 files changed, 93 insertions(+), 70 deletions(-)

-- 
2.34.1

