Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC09E4BB7C1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiBRLJ4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Feb 2022 06:09:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbiBRLJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:09:52 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC99F2B4050
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:09:36 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-nd3EsSwbMXCqZ4U4EXKMfA-1; Fri, 18 Feb 2022 06:09:29 -0500
X-MC-Unique: nd3EsSwbMXCqZ4U4EXKMfA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54C042F47;
        Fri, 18 Feb 2022 11:09:28 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6ABB22B4B5;
        Fri, 18 Feb 2022 11:09:26 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Some rtla features
Date:   Fri, 18 Feb 2022 12:09:12 +0100
Message-Id: <cover.1645182327.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set introduces some tracing facilities to rtla tools.

It adds the possibility to change the tracing_thresh to osnoise,
allowing a fine tune of OS noise detection.

It also adds the auto tracing feature (-a threshold us), which aims
helping the first approach to a problem by setting common tracing
features with a single parameter.

Finally, it also allow osnoise top and timerlat top to enable additional
trace events via (possible multiple) -e sys:event options.


Daniel Bristot de Oliveira (7):
  rtla/osnoise: Add support to adjust the tracing_thresh
  rtla/osnoise: Add an option to set the threshold
  rtla/osnoise: Add the automatic trace option
  rtla/timerlat: Add the automatic trace option
  rtla/trace: Add trace events helpers
  rtla/osnoise: Add -e/--event option
  rtla/timerlat: Add -e/--event option

 .../tools/rtla/common_osnoise_options.rst     |  10 ++
 .../tools/rtla/common_timerlat_options.rst    |   7 ++
 tools/tracing/rtla/src/osnoise.c              |  83 ++++++++++++++
 tools/tracing/rtla/src/osnoise.h              |   8 ++
 tools/tracing/rtla/src/osnoise_hist.c         |  35 +++++-
 tools/tracing/rtla/src/osnoise_top.c          |  58 +++++++++-
 tools/tracing/rtla/src/timerlat_hist.c        |  24 +++-
 tools/tracing/rtla/src/timerlat_top.c         |  50 ++++++++-
 tools/tracing/rtla/src/trace.c                | 105 ++++++++++++++++++
 tools/tracing/rtla/src/trace.h                |  15 +++
 10 files changed, 382 insertions(+), 13 deletions(-)

-- 
2.34.1

