Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C51C4872A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346201AbiAGFaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346159AbiAGF35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:29:57 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B14C061212;
        Thu,  6 Jan 2022 21:29:56 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y18so5832067iob.8;
        Thu, 06 Jan 2022 21:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e63T25IY0LrfOuX+XUbFrW7daTp0yjRBy27VA81f73c=;
        b=lrazqIvRI7nkcOWlxTYZ9i/W0BZLR+6pq9AkUgro+ggvyCEnHKGma1fZ9YSYg9sLXs
         t7BZGjrvTexU9tKlOt269njn3U2ieCQjxn3V0E4N2eAeb9iyPqe2sWWyYgK0Nfuor0Kj
         7o8gVKi/QiHWa/zkHJSlpIbe+W1LFcV611bn1lba/8aTTOeI83SnxuUYqeOkhgc6fxis
         r+O2Hwht/mRN4l4ezOOBpeBeIejoXY9HrP/Tk+J5BH7NbzBXo4W18iiRxzUKlMX/9Qdf
         Q+RYhwObXjtRB9E85C74C9P6wIQKJ1j6GGz/BxLvSV3lqWyMnulc0/m7dOnhr0Pm/FNa
         maLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e63T25IY0LrfOuX+XUbFrW7daTp0yjRBy27VA81f73c=;
        b=Mqm6EbmStNMXdkMk9RzSFods51rhCLUAKI5/c2DHfz0Kq4HYr0dM+JkBJVgT/kFjQr
         VmQUU/IOPZDm1rIs+8jQBh6ZQmBf30bdGPo7zN4wkS7Yt+Go9Yu2h3McN2WF7N5IXWng
         mRKpKcj6xjgp5+FFdMMWlShanmhAsR0JT0qNZX81fHjcerylrjCNYDi8GM0lkFBJrQty
         NIKCsn5ypCEeO7nrf/AXaIK2/1DjyQ1L+bZ0Zxcvfqi6z1pIXhwNmcPAJ79sy+g1xBp1
         o1fuqggJujhq7hHy0FqPsGsaKKRF/B5x69Fn9FzZc3IpBIsSdKuwwIp0F2D/vKuwSxLE
         Kh+g==
X-Gm-Message-State: AOAM530Sd9PVazlcvFScEYtIAMgmygSRZ/8t3f2uqme4lzS2fmaHS/ZB
        5Iv89noM+XfoDSbvUVRVZ3w=
X-Google-Smtp-Source: ABdhPJzCJ4a/OeMh5+Vd7ifGWNtNlzms8nsxPhCodTm0c6KSDOhbHpofTWUlQSognE0poa4IEhOEPg==
X-Received: by 2002:a05:6638:2505:: with SMTP id v5mr31095831jat.250.1641533396065;
        Thu, 06 Jan 2022 21:29:56 -0800 (PST)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id c18sm1843446iod.18.2022.01.06.21.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 21:29:55 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, daniel.vetter@ffwll.ch,
        seanpaul@chromium.org, robdclark@gmail.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     quic_saipraka@quicinc.com, will@kernel.org,
        catalin.marinas@arm.com, quic_psodagud@quicinc.com, maz@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com
Subject: [PATCH v11 05/19] dyndbg: add desc, dev fields to event record
Date:   Thu,  6 Jan 2022 22:29:28 -0700
Message-Id: <20220107052942.1349447-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107052942.1349447-1-jim.cromie@gmail.com>
References: <20220107052942.1349447-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit:HEAD~1 added pr_debug(), dev_dbg() params to the new events,
but didn't actually capture the params.  Do that now; add the other
TP_* parts: __fields, fast-assign, and printk elements for the
desccriptor and device params.

The message capture part is copied from printk:console, it gets the
whole message, including dyndbg's prefixing: the dev_name() etc, the
optional module:function:line decorations, and the trailing newline
(which is trimmed).

dyndbg->trace-events must be enabled on both sides:

  in tracefs:	echo 1 > /sys/kernel/tracing/events/dyndbg/enable
  in dyndbg:	echo module drm +T > /proc/dynamic_debug/control

This is good; it gives 2 orthogonal cuts at trace traffic, dyndbg can
enable callsites indvidually, tracefs can (in principle) filter and
trigger on the incoming event stream.

ATM, TP_print adds "__entry->desc->{modname,function}", which is
redundant with +Tmf enabled callsites.

RFC

Perhaps the whole decorations/prefix should be excluded from the event
capture ?  Vincent's skip-past-KERN_DEBUG trick could be extended to
skip part or all of the prefix, and leave the "decorating" of events
solely to TP_printk.  Whats the right separation of concerns ?

NB: __entry->desc is a pointer into kernel .data, a pretty stable
reference, at least while the kernel is running.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/trace/events/dyndbg.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/dyndbg.h b/include/trace/events/dyndbg.h
index 82620b10e968..2ac296cb451c 100644
--- a/include/trace/events/dyndbg.h
+++ b/include/trace/events/dyndbg.h
@@ -14,10 +14,12 @@ TRACE_EVENT(prdbg,
 	TP_ARGS(desc, text, len),
 
 	TP_STRUCT__entry(
+		__field(const struct _ddebug *, desc)
 		__dynamic_array(char, msg, len + 1)
 	),
 
 	TP_fast_assign(
+		__entry->desc = desc;
 		/*
 		 * Each trace entry is printed in a new line.
 		 * If the msg finishes with '\n', cut it off
@@ -30,8 +32,8 @@ TRACE_EVENT(prdbg,
 		__get_str(msg)[len] = 0;
 	),
 
-	TP_printk("%s", __get_str(msg))
-
+	TP_printk("%s.%s %s", __entry->desc->modname,
+		  __entry->desc->function, __get_str(msg))
 );
 
 /* capture dev_dbg() callsite descriptor, device, and message */
@@ -42,10 +44,14 @@ TRACE_EVENT(devdbg,
 	TP_ARGS(desc, dev, text, len),
 
 	TP_STRUCT__entry(
+		__field(const struct _ddebug *, desc)
+		__field(const struct device *, dev)
 		__dynamic_array(char, msg, len + 1)
 	),
 
 	TP_fast_assign(
+		__entry->desc = desc;
+		__entry->dev = (struct device *) dev;
 		/*
 		 * Each trace entry is printed in a new line.
 		 * If the msg finishes with '\n', cut it off
@@ -58,7 +64,8 @@ TRACE_EVENT(devdbg,
 		__get_str(msg)[len] = 0;
 	),
 
-	TP_printk("%s", __get_str(msg))
+	TP_printk("%s.%s %s", __entry->desc->modname,
+		  __entry->desc->function, __get_str(msg))
 );
 
 #endif /* _TRACE_DYNDBG_H */
-- 
2.33.1

