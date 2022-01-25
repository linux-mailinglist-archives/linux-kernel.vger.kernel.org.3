Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083A549BDE8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiAYVeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiAYVeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:34:16 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C447BC06173B;
        Tue, 25 Jan 2022 13:34:15 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id w8so12731808qkw.8;
        Tue, 25 Jan 2022 13:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=JOQ3PmaJtbdtPUYBzN8lYyLwqfEwyWGHTqG8SXs6IXQ=;
        b=DLJtQB/iPbudM4U5QdnFTufb8Ay0mLqmLcSVPxmc8P4p1gEtaJ3bvEx3FZmixDmyHF
         03V4e0Z1BRn8noHW/vGg3uurht3vEnpwnxqQ7PrgKZO1YWOfsFKTB66vM829GeKyWqJw
         4ON1cEHGSIqbJ0x5IjCNI9aQr+Ickgpp64iXjee09+YjZe44jJlFRwlY1uhlLj/t2vs1
         D7NzK4h+/rwbpDQ5rJ1Fi4JdbHBgVXTHjywfRsw2k0GgC9mbefixvwlliCNETQBRqjtI
         K2xD6FdmnbyJDmyvPfb+O2lwAm1FoE4b0BAbv9l5IAhi8F20h5lasjHSkCNajCc2KwUm
         CiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=JOQ3PmaJtbdtPUYBzN8lYyLwqfEwyWGHTqG8SXs6IXQ=;
        b=HATUK3x3CjTkjMUACxuqhOQBb2Vs9N0x5Mm0u5YMjU+Qy5c3AlQWUvTpZGX2AqIXdH
         5NViHIqycNlmSvs9hZHJBNIp3ZQcjQ0VuT1kvwBro2N9LnonP+F67wk+R4jETsFeX3+a
         41GkBuEfzy60byN8/P3uwfk9HmS2/cqpZghzqt6LK4jKqXRwRNupydta2+CJX4p5xFQs
         YMa4pcRQnEOkSjRwCeaMRpd8aBc2eVu15GVOQYXa2UqPlht1pTrSF8sDrJHMOFBdlF/g
         33fXbTA5VzKG9W0Kk+60AM31dKUqUybDcnd61/jezYTtEpBh1L85Fnca6mR3X8P6700o
         pjqA==
X-Gm-Message-State: AOAM532QaaX8t4uogOZaoDumPwuS7ticFzn416mCwHA1dBq9G77HWSIU
        zreT56OyGVwl6t22GeOX62k=
X-Google-Smtp-Source: ABdhPJw/2YXrKi+2Ss6HpuhQYRNalRDThCcOA5ft3LnqcnRjQoz65yWuuVC0x1Wotv6N8VP9xTKe5w==
X-Received: by 2002:a37:996:: with SMTP id 144mr8982462qkj.247.1643146455014;
        Tue, 25 Jan 2022 13:34:15 -0800 (PST)
Received: from [10.139.255.254] ([89.187.171.240])
        by smtp.gmail.com with ESMTPSA id h21sm9484295qth.16.2022.01.25.13.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 13:34:14 -0800 (PST)
Message-ID: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
Date:   Tue, 25 Jan 2022 16:34:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Demi Marie Obenour <demiobenour@gmail.com>
Subject: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Cc:     Demi Marie Obenour <demiobenour@gmail.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which SELinux
always allows too.  Furthermore, a failed FIOCLEX could result in a file
descriptor being leaked to a process that should not have access to it.

Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
---
 security/selinux/hooks.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5b6895e4fc29..8f3b2f15c1f3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3728,6 +3728,11 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 		error = file_has_perm(cred, file, FILE__GETATTR);
 		break;
 
+	/* must always succeed */
+	case FIOCLEX:
+	case FIONCLEX:
+		break;
+
 	case FS_IOC_SETFLAGS:
 	case FS_IOC_SETVERSION:
 		error = file_has_perm(cred, file, FILE__SETATTR);
-- 
Sincerely,
Demi Marie Obenour

