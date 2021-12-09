Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3A346E814
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbhLIMKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237094AbhLIMKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:10:33 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFC1C061353
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 04:06:59 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso3881347wmr.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 04:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QMAxu6THltYWLchCw9nsHQsbKoxrZaVufwyt4Anj+Rw=;
        b=pvhVgdgJNkG2YC0mg7aQCaNoBF3wZYpj3ZrcvXlKvxJoKmff8WgVu2Yf1/LtYgXn71
         a1yDRI7nj+91hDcEfm86joqMzl677CEun0CRUsVP8hnh2P+5cVrWQNnfViUQWWoM6usz
         wsGGFNq8+RGppBNPRJTMj6RYmHKXwMr8HtnebW6LaeYUCOIkAaS0/61jOMdGRVtQmBev
         a3jajhfjp6Gel54ZqjzziUsgSTMp2tV/YzZyIZy8fwzKM4cs8m2TNljEK9yvsrNhGqa9
         BCJr5kmrJD/tch13KtUUnsrRoecuKzGZySsVtLmjr8i92PFeLzURK8t+vT2C1ZM2ekuM
         XkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QMAxu6THltYWLchCw9nsHQsbKoxrZaVufwyt4Anj+Rw=;
        b=wizNAMnX5mEZUXAkruvc9YZoFlgqoDLFSBuGJgiTWjAf7FJGrD43QI0yoBM1v/wE7S
         BUzJQ6txp2aLGCT4MSNrxDlq+r3kMg8iiVlWSF0IN3PPgep0F342dNRl768cQtf16kGu
         4hO2w5a4RhlQWXW0cHaTsto5ywaSZSW5O7PwErkQGZNhH2MmF0h8E9ECxg8xoFasl+fP
         QBZyuMCvIvqZRNn34US4g6OVfqayHFUpmTYlAYQnlnd71Ky8yYlg9VivTfl/UXOOJMVb
         mrgRnzvGZbGmC8mEyBpv80QvJlAb15eL5VKPI8msqfWW+D+TnzrIvIj6zzYNUlCi/0xl
         HwcQ==
X-Gm-Message-State: AOAM531GM6R3TmNeAz9pWlLJat2n9G2uxHrLQM+oGX75Zel8N1PRBQ6K
        NXmj1ZryJd6aIkxdUs+EtrxMuA==
X-Google-Smtp-Source: ABdhPJz4cOkVVHWdVQ/CEluKwx9VmaZDIJ/8mfQwZiNQ/fbsKfXNlqPrlMxig83e8304dt+agA5vSA==
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr6612045wmc.39.1639051618381;
        Thu, 09 Dec 2021 04:06:58 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id 4sm7513289wrz.90.2021.12.09.04.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 04:06:58 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        jeyr@codeaurora.org, bkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/8] misc: fastrpc: add remote process attributes
Date:   Thu,  9 Dec 2021 12:06:20 +0000
Message-Id: <20211209120626.26373-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211209120626.26373-1-srinivas.kandagatla@linaro.org>
References: <20211209120626.26373-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeya R <jeyr@codeaurora.org>

Add fastrpc remote process attributes. These attributes are passed as
part of process create ioctl request.

Signed-off-by: Jeya R <jeyr@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/uapi/misc/fastrpc.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index 0a89f95463f6..b74407d19ed5 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -14,6 +14,23 @@
 #define FASTRPC_IOCTL_MUNMAP		_IOWR('R', 7, struct fastrpc_req_munmap)
 #define FASTRPC_IOCTL_INIT_ATTACH_SNS	_IO('R', 8)
 
+enum fastrpc_proc_attr {
+	/* Macro for Debug attr */
+	FASTRPC_MODE_DEBUG		= (1 << 0),
+	/* Macro for Ptrace */
+	FASTRPC_MODE_PTRACE		= (1 << 1),
+	/* Macro for CRC Check */
+	FASTRPC_MODE_CRC		= (1 << 2),
+	/* Macro for Unsigned PD */
+	FASTRPC_MODE_UNSIGNED_MODULE	= (1 << 3),
+	/* Macro for Adaptive QoS */
+	FASTRPC_MODE_ADAPTIVE_QOS	= (1 << 4),
+	/* Macro for System Process */
+	FASTRPC_MODE_SYSTEM_PROCESS	= (1 << 5),
+	/* Macro for Prvileged Process */
+	FASTRPC_MODE_PRIVILEGED		= (1 << 6),
+};
+
 struct fastrpc_invoke_args {
 	__u64 ptr;
 	__u64 length;
-- 
2.21.0

