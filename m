Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2085302E9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 14:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344302AbiEVMIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 08:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbiEVMIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 08:08:06 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C738A33A15
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 05:08:04 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bu29so21351611lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:cc
         :content-language:to:content-transfer-encoding;
        bh=nL/dVGmV8SVJ8XY9T2y2Xs22TOu5OlKd3euuTOmb9S4=;
        b=dY9UcXK/oJMSJoYU12izmW/FnAYwMTMLETztr1WWz4D35LIy+rNOSlcLBClNMExUV4
         eHEeIEy+7ymmdgalKmq++LKhP+izXt0PfSl8q2zKMjp4O2exWq2yLZxkn8re8UVRiVIr
         oM5roUeyoU4kPZxOGlwqIyUf+anbiXuarA+i8RhdcGfZKwY2dPikHRkZokh7QyG28yHq
         LThHQM0PsCHxCAZDma4zPtDWmsgClF7dfUUo+G8Ji2OxnkKX9bNhVohFctjMBrviEv5Z
         qSP5tIL2QsZ7m3I/h2+XQ5zdb8bOkcgtVdg9v7G9Jvq7CHfciSKIxASYktFZXeHUzkAr
         uZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:cc:content-language:to:content-transfer-encoding;
        bh=nL/dVGmV8SVJ8XY9T2y2Xs22TOu5OlKd3euuTOmb9S4=;
        b=H0LPJO62Oa+v6wxY/5Udg5BTU4LIKJNHdmv5g0y18pU9A714P5idycUF7vG5NsbEPU
         CFZ72K3qEgKwwHyL9XYpzv/u18kCTjhFeQ1HQfYdzX3v2MhFpGS2oOTKwR61Z2jhQwVG
         tluAU27jt0qJBlv0bEjX50NgJAjttE+CSdYaK7J7wb6QNHUbUUXhwHmcAZGmzwnXgEFc
         1Zc8VeabiYG82nA5Ka0wSswbqtEeagMi/OyRrszCDpPNicT4lhwFe4AkIepUEm7qJAKu
         r8HCjBmZN4MpSPMt+R3S1KrbWCF7lmHoex6dkfC4CIwEjyCpCSmV3AenVdPRCWW0DEJz
         DmiA==
X-Gm-Message-State: AOAM532cgdsJNogwjBDE2YYzdDzAFFDV73FVeHxf8qvL33dnnRBEK+5y
        jjEcngkQ6F2gb42T0bJ+fMbJfQ==
X-Google-Smtp-Source: ABdhPJz4u143hIp4L2y7X/tAAADLwuCPw7Sg31/7fzUEYGRi6yX27/JAVA8CEjTrAmFDQdog8/Yeeg==
X-Received: by 2002:a05:6512:3c84:b0:478:19f2:bc2e with SMTP id h4-20020a0565123c8400b0047819f2bc2emr9440081lfv.324.1653221283073;
        Sun, 22 May 2022 05:08:03 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id u1-20020ac24c21000000b0047255d2118csm1433942lfq.187.2022.05.22.05.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 05:08:02 -0700 (PDT)
Message-ID: <9adfd6ac-1b89-791e-796b-49ada3293985@openvz.org>
Date:   Sun, 22 May 2022 15:08:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH v3] fanotify: fix incorrect fmode_t casts
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes sparce warnings:
fs/notify/fanotify/fanotify_user.c:267:63: sparse:
 warning: restricted fmode_t degrades to integer
fs/notify/fanotify/fanotify_user.c:1351:28: sparse:
 warning: restricted fmode_t degrades to integer

FMODE_NONTIFY have bitwise fmode_t type and requires __force attribute
for any casts.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
v3: split, according to Christoph Hellwig recommendation
---
 fs/notify/fanotify/fanotify_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index a792e21c5309..16d8fc84713a 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -264,7 +264,7 @@ static int create_fd(struct fsnotify_group *group, struct path *path,
 	 * originally opened O_WRONLY.
 	 */
 	new_file = dentry_open(path,
-			       group->fanotify_data.f_flags | FMODE_NONOTIFY,
+			       group->fanotify_data.f_flags | __FMODE_NONOTIFY,
 			       current_cred());
 	if (IS_ERR(new_file)) {
 		/*
@@ -1348,7 +1348,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	    (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID)))
 		return -EINVAL;
 
-	f_flags = O_RDWR | FMODE_NONOTIFY;
+	f_flags = O_RDWR | __FMODE_NONOTIFY;
 	if (flags & FAN_CLOEXEC)
 		f_flags |= O_CLOEXEC;
 	if (flags & FAN_NONBLOCK)
-- 
2.36.1

