Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AF84AF89C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbiBIRi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiBIRi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:38:56 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D54C0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:38:59 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id y23so3182641oia.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 09:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=GpHtH5ckgS1E5v9uYapUFRK8rOzVMinhmnQifd9QHgM=;
        b=bBg/zIU0D0rHjsq8WSReJtHW9BObQRcFgTPP9QYw+4L5a2HdZonygJyIHz3YB3eqhC
         VZ5UJO3hPpa36+XDFQsbyW4GB4bNFK6hw27Vk61TTI2B+mrg+HS0kZUm+5osWVZQIERO
         eewIM6t4GnCvsJWSaFL2M8wXYwSykGtirZ9cL/2jgZugT1pznmXLZcpbpeiml+wDnlF6
         pi65sjIwdJyYO7Kx/MIuxKHbz6IPCu2lZCvXLqpiYg72cBKw4wRuhFMguUOiWYC+ZQRG
         7v7Vz/gjfPzQ4F2g7yIyyKrkq/09lTl66SxTrgJAyf0vgKl1a1O6NlNoZ0lsuuxBY2JQ
         rXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GpHtH5ckgS1E5v9uYapUFRK8rOzVMinhmnQifd9QHgM=;
        b=bVrSlFHGOjJ7DxiUoKJU1/qbPr25wuYbVxgtpQtRUQ4XXMlwHgZ5YUKYr23+UlqqgU
         Oy0NMXSCUFbK51+hxw/5qYXfzA3AQhiXp51Ddjrl60vYIeWTmeNIZu2Hx21wmFoFZhLh
         K06hmPyuyJC5cwnUe6ZSdFOxdJwznoYwJA+O/rauHA4QnB/HxQQr7NqGqXWXOmC75z+f
         36PGNEqXudLJBGHEr1YOPkelIHdWG0wHIkLihU+hWqKnSzHD0pF/WMpUX5xbX68rqdGs
         RnnErArwoXiM53FBh6RHN2H+KJ2KE6nd1fhFrJW5N/C8gep7lvoLVR2avKXzXBd+Tx/a
         Y6Ww==
X-Gm-Message-State: AOAM530SSaqgNtKSai5LH0Aju0/yoWkdgn7uYEMElm0TAMH0IcUi76UD
        VblvRxEgzdtSQ7N+ZKLZ2ymUtgQlGuQ=
X-Google-Smtp-Source: ABdhPJxOZbvqUeNlbqDrWyH5wctuANDd+DECGLzhJEEjyoDv8a6Ohu5ENs77QdHp6jfawG/zuRVSgw==
X-Received: by 2002:a05:6808:1b13:: with SMTP id bx19mr1434137oib.284.1644428338767;
        Wed, 09 Feb 2022 09:38:58 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id t31sm7514969oaa.9.2022.02.09.09.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 09:38:58 -0800 (PST)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CFC3C400FE; Wed,  9 Feb 2022 14:38:54 -0300 (-03)
Date:   Wed, 9 Feb 2022 14:38:54 -0300
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] tools headers UAPI: Sync linux/perf_event.h with the
 kernel sources
Message-ID: <YgP8LnuwTKQDF9/B@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI, carrying this in my tree:

---

To pick the trivial change in:

  ddecd22878601a60 ("perf: uapi: Document perf_event_attr::sig_data truncation on 32 bit architectures")

Just adds a comment.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'
  diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h

Cc: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 1b65042ab1db8df4..82858b697c05a1d2 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -465,6 +465,8 @@ struct perf_event_attr {
 	/*
 	 * User provided data if sigtrap=1, passed back to user via
 	 * siginfo_t::si_perf_data, e.g. to permit user to identify the event.
+	 * Note, siginfo_t::si_perf_data is long-sized, and sig_data will be
+	 * truncated accordingly on 32 bit architectures.
 	 */
 	__u64	sig_data;
 };
-- 
2.34.1

