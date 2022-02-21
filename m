Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599064BED14
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 23:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbiBUWRn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Feb 2022 17:17:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiBUWRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:17:39 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD0C922BEE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 14:17:13 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-cZWv-X8dPMKKcsDI4bGfIw-1; Mon, 21 Feb 2022 17:17:09 -0500
X-MC-Unique: cZWv-X8dPMKKcsDI4bGfIw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 561D01091DA1;
        Mon, 21 Feb 2022 22:17:08 +0000 (UTC)
Received: from x1.com (unknown [10.22.16.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75C7A5DB96;
        Mon, 21 Feb 2022 22:17:03 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH V2 00/11] rtla: Improved tracing support
Date:   Mon, 21 Feb 2022 23:16:45 +0100
Message-Id: <cover.1645481500.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

This set introduces some tracing facilities to rtla tools:

- Add the possibility to change the tracing_thresh to osnoise,
allowing a fine tune of OS noise detection.

- Add the auto-tracing feature (-a threshold us), which aims
helping the first approach to a problem by setting common
tracing features with a single parameter.

- Add -e/--event option, allowing osnoise and timerlat to
enable additional trace events via (possible multiple)
-e sys:event options.

- Add the --filter option to filter the previous -e event.

- Add the --trigger option to allow the usage of tracing
trigger of the previously set -e event. If the trigger
is hist: one, rtla automatically saves the hist file
associated with the -e event.

Depends on "rtla: Some RTLA fixes for 5.17":
   https://lore.kernel.org/lkml/cover.1645206561.git.bristot@kernel.org/

Changes from V1:
 - Add -e to osnoise/timerlat hist
 - Add --trigger
 - Add --filter
 - Add support to save hist file
 - Function name refactoring

Daniel Bristot de Oliveira (11):
  rtla/osnoise: Add support to adjust the tracing_thresh
  rtla/osnoise: Add an option to set the threshold
  rtla/osnoise: Add the automatic trace option
  rtla/timerlat: Add the automatic trace option
  rtla/trace: Add trace events helpers
  rtla: Add -e/--event support
  rtla/trace: Add trace event trigger helpers
  rtla: Add --trigger support
  rtla/trace: Add trace event filter helpers
  rtla: Add --filter support
  rtla/trace: Save event histogram output to a file

 Documentation/tools/rtla/common_options.rst   |  19 +
 .../tools/rtla/common_osnoise_options.rst     |  10 +
 .../tools/rtla/common_timerlat_options.rst    |   7 +
 tools/tracing/rtla/src/osnoise.c              |  83 +++++
 tools/tracing/rtla/src/osnoise.h              |   8 +
 tools/tracing/rtla/src/osnoise_hist.c         |  87 ++++-
 tools/tracing/rtla/src/osnoise_top.c          |  83 ++++-
 tools/tracing/rtla/src/timerlat_hist.c        |  78 ++++-
 tools/tracing/rtla/src/timerlat_top.c         |  73 +++-
 tools/tracing/rtla/src/trace.c                | 326 ++++++++++++++++++
 tools/tracing/rtla/src/trace.h                |  22 ++
 11 files changed, 782 insertions(+), 14 deletions(-)

-- 
2.34.1

