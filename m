Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF27B48E45B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiANGqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiANGqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:46:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED243C061574;
        Thu, 13 Jan 2022 22:46:31 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id ie23-20020a17090b401700b001b38a5318easo13303389pjb.2;
        Thu, 13 Jan 2022 22:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=60RR5RY0BZL0/Lke1Efhyp4YheRzC1dv7rn1c/0ivY0=;
        b=S4hbf+xby5wSt3TcP+HCkU4m/3sA+E3ggOqPLKFj+dIkHGNn5Yb11R80tZwoGU+3ro
         nTapbQ5ju1GFvB0FPaS6n78Ttr1H1xvnZKG0n29fMsqwSz6f+6QbBANC20eXwR8MVvcr
         JmQ4ZmG4L3TcuXu10Q3N7a73TONH6BjPwfpov+Bt1e3rnQG6HdqE+PTiX6ELJSzuccXf
         S0G9maukPD93aSbTE+45mMJULnfffHApeU8wc4U2isv3+xJPtC2PaHQNS7fI/ql+Rsn2
         vZ0Mf+iT6Wm1YoRz7D01iJ0IKByOWXWyiCW6FVZoJYv+YUopFo+7nxh3qwCasfP6q6d4
         92Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=60RR5RY0BZL0/Lke1Efhyp4YheRzC1dv7rn1c/0ivY0=;
        b=zXcDtvWIhVjNr6YauiJbBzwpLoe8FyTKTsUKXAaWLtG6R5ju5KswJwiBT+su0AI74O
         LqIPJFrwRQNu+gM6nSQGNoWsvmGF/rRcJQMqWMMPzkDRPOJ6MspAsd80oKK/+XX/LZfg
         NcOAjq+BwQaR2IN9JloxPLN0MfUbRK/x1gyt6ok7dutkUGkl6J1YexX2d6gRbsNW0547
         T4aVarovL0xnFea8rHyk7Tq3MfRCOFDm40mXE4kavwky9FMLwWg4OJ8YTGgs8XAPrb2X
         40SHoErBEtYlFBcRdBSEqIAgiWw8WMyZNkk7VtU9QTXlCSLehVP5/W5ieZulXHYc+DWr
         9IJA==
X-Gm-Message-State: AOAM531JrXlHqxbqJM5mB38JAbyDBcrH1isXGQkVeJmjbEGQxVyJ40hl
        Gb7X51p1AYXsp5e8gLrvvZG+HwM9cV4=
X-Google-Smtp-Source: ABdhPJwmD+sPDAyu7I2wlipvAonyc4QC+uR0hMvVedvmdoCCRGxWuZXEfSV/ozJ1txzyLwhNNe20FQ==
X-Received: by 2002:a17:902:c64b:b0:14a:6895:949b with SMTP id s11-20020a170902c64b00b0014a6895949bmr8254929pls.147.1642142791431;
        Thu, 13 Jan 2022 22:46:31 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h12sm3752057pfv.214.2022.01.13.22.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 22:46:30 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     sfrench@samba.org
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] cifs: Replace one-element array with flexible-array member
Date:   Fri, 14 Jan 2022 06:46:25 +0000
Message-Id: <20220114064625.765511-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use "flexible array members" for these cases. The older
style of one-element or zero-length arrays should no longer be used.
Reference:
https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 fs/cifs/smb2ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index af5d0830bc8a..5c104b2f308a 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1609,10 +1609,10 @@ struct iqi_vars {
 	struct smb_rqst rqst[3];
 	struct kvec rsp_iov[3];
 	struct kvec open_iov[SMB2_CREATE_IOV_SIZE];
-	struct kvec qi_iov[1];
+	struct kvec qi_iov[];
 	struct kvec io_iov[SMB2_IOCTL_IOV_SIZE];
 	struct kvec si_iov[SMB2_SET_INFO_IOV_SIZE];
-	struct kvec close_iov[1];
+	struct kvec close_iov[];
 };
 
 static int
-- 
2.25.1

