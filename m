Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC154A9CE5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376529AbiBDQYR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Feb 2022 11:24:17 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:23038 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230184AbiBDQYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:24:16 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-ex2SSuqZOQWh513PE2FANw-1; Fri, 04 Feb 2022 11:24:14 -0500
X-MC-Unique: ex2SSuqZOQWh513PE2FANw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EC02100C66D;
        Fri,  4 Feb 2022 16:24:13 +0000 (UTC)
Received: from x1.com (unknown [10.22.33.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 546C57E91E;
        Fri,  4 Feb 2022 16:24:11 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 0/4] Some RTLA fixes
Date:   Fri,  4 Feb 2022 17:24:01 +0100
Message-Id: <cover.1643990447.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first is a change in the Makefile to make rtla use the kernel
version.

The other fixes are in the error path when rtla fails to enable
the tracers. I got some segmentation faults when trying to use rtla
with kernel versions that do not support multiple instances (i.e.,
5.14 and 5.15) and fixed them. I also found some inconsistency in
error messages and also did a cleanup there.

Daniel Bristot de Oliveira (4):
  rtla: Follow kernel version
  rtla/utils: Fix session duration parsing
  rtla/trace: Error message fixup
  rtla/osnoise: Fix segmentation fault when failing to enable -t

 tools/tracing/rtla/Makefile      | 4 +++-
 tools/tracing/rtla/src/osnoise.c | 3 +++
 tools/tracing/rtla/src/trace.c   | 8 ++++----
 tools/tracing/rtla/src/utils.c   | 4 ++--
 4 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.34.1

