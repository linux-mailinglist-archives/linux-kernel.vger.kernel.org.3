Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918745A1995
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbiHYTdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiHYTdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:33:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D9FAE9D5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661455986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TNLP2iAiq5IsaJIWWGU7TlP7Qn2xgSixyNiCP/wB9+M=;
        b=O8lexoy4O930mF8ItypPo+9MJeYzhxHxqlxri66ZsL/80xmPRKRdj0n/Bc2ASlz1YtgSs6
        Nk7D5m/wfFmV7D05NJ0aGGMQJ0Ffa4iaRaPoLK5GAlj2EYI2jhQt8bYycHXP3GOtU9P+fU
        Lgds3WPWx28JX3KxSA1FUo9yqBw5XYs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-0R0EmTTjNr2U0DQFW2VOxw-1; Thu, 25 Aug 2022 15:33:02 -0400
X-MC-Unique: 0R0EmTTjNr2U0DQFW2VOxw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59AFB80A0AE;
        Thu, 25 Aug 2022 19:33:02 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A93A9492C3B;
        Thu, 25 Aug 2022 19:33:00 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>, scorreia@redhat.com,
        omosnace@redhat.com, omoris@redhat.com
Subject: [PATCH ghak138 v2 0/4] issues from moving beyond syscalls
Date:   Thu, 25 Aug 2022 15:32:36 -0400
Message-Id: <cover.1661449312.git.rgb@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The primary motivation was to solve the mystery of the missing syscall
events filed in ghak138.  This is addressed by the audit_return_fixup()
patch and is most likely a stable candidate.

The others were a number of not so critical issues observed in the
process of examining the bisected patch to see what caused it.

changelog v2:
- split into 4 patches
- flesh out proctitle move justification
- add issue reference in return_fixup move patch
- remove explicit Cc:

Richard Guy Briggs (4):
  audit: audit_context pid unused, context enum comment fix
  audit: explicitly check audit_context->context enum value
  audit: free audit_proctitle only on task exit
  audit: move audit_return_fixup before the filters

 kernel/audit.h   |  2 +-
 kernel/auditsc.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.27.0

