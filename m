Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66470542979
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiFHIdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiFHIct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09FCD3BDF65
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654674787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sNGYKi3MSRgxelnf8gcdJUea13LkpYvVIrd2JFz6gTg=;
        b=VaKO+ZNfdlXcMtbgHVZa/wq5AjmFjcF1jjXijH25rjXrb9Jea0FmeHS9vANT6LLSkWC+oN
        s8LjoMMFSSXcqW6SUJ114707eFZnSR8YYwjqYjrAvPkBUXSZr31euKpwigoUxJfjx2nRJ8
        BYkZtW8S2TUcme3Ev8DByQv1/HLxzFM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-m_9QHWYTMcGvKPKkAQKL5g-1; Wed, 08 Jun 2022 03:53:04 -0400
X-MC-Unique: m_9QHWYTMcGvKPKkAQKL5g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACC3F88743A;
        Wed,  8 Jun 2022 07:52:57 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C71E340D0166;
        Wed,  8 Jun 2022 07:52:56 +0000 (UTC)
Date:   Wed, 8 Jun 2022 15:52:51 +0800
From:   Baoquan He <bhe@redhat.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rob Landley <rob@landley.net>, akpm@linux-foundation.org,
        ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] sh: cast away __iomem to remove sparse warning
Message-ID: <YqBVU9oW6FfGdR9H@MiWiFi-R3L-srv>
References: <20220507013411.74277-1-bhe@redhat.com>
 <YpS0C8tVG2E5jGSV@MiWiFi-R3L-srv>
 <c24579a3-74e4-1dbb-6237-d9e1a01e6e09@landley.net>
 <Yp/3Lq03+UVs9Bpv@MiWiFi-R3L-srv>
 <db5505e5-811e-0572-7614-8443c864b5e6@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db5505e5-811e-0572-7614-8443c864b5e6@physik.fu-berlin.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/22 at 09:05am, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On 6/8/22 03:11, Baoquan He wrote:
> > I guess SuperH arch has been in status of no maintenance, however some
> > generic code change may involve correspondant ARCH change so that we
> > have to touch arch/sh/.
> 
> It is actually actively maintained by Rich Felker but he is often slow to
> respond at the moment. I have already offered Rich my help and maybe we
> can work something out that I can help him with the maintenance.

Thanks, Adrian.

Maybe you can start with being a reviewer by adding yourself into
MAINTAINERS file like below. You need post below change as patch and got
Rich's ACK. Then people will add you to CC when sending patches related
to sh code. Or add yourself as maintainer directly if you have done a
lot of work on maintaining, surely need get other sh maintainers' ACK
too. Personal suggeestion.

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..0e7ce3540eb7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19119,6 +19119,7 @@ F:	drivers/watchdog/sunplus_wdt.c
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
+R:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
 L:	linux-sh@vger.kernel.org
 S:	Maintained
 Q:	http://patchwork.kernel.org/project/linux-sh/list/

