Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B9F481C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 14:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239699AbhL3NqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 08:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbhL3NqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 08:46:00 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E950C061574;
        Thu, 30 Dec 2021 05:46:00 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n14-20020a7bcbce000000b00332f4abf43fso7962222wmi.0;
        Thu, 30 Dec 2021 05:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nrSWP5T7g/6Hd2Mwif6iAnRqHbuh0AXAUD99jJuYV8=;
        b=QOKn4DPLbDQCeqgwYjCebkywo1hkdJFJbdL70xP8l8aFPPufYrIedF5pN5qjirz2HP
         WRt6N86lkVsQBxccR7usmq/A/qu4pe/1+/PyUlzXQva/h2e6CPPs+j7qX3mBcbyG9mh9
         NI3cV7owIubZm+mAoTNqyIIL8nTZ7gwMuewzhNRQj0C8zHpx7q9lv5m7BzNRPfPygVdU
         BN0zj0qcfZ775mNY+MKiDz18KVcSYu+PEh+dILz0ZzVZJ3621P9PfPlY7oS7cg1XYQta
         jJRbxv6JjJLeVrs0cdjXKKx9ZfcbBXy5FjC+1K6VwbRRCOr9GjaZax0NF22xB3kbE9tY
         ImLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nrSWP5T7g/6Hd2Mwif6iAnRqHbuh0AXAUD99jJuYV8=;
        b=l4FPl2xmp1GgGwLwRmIfvx1fPyN25AleFhy8LdCAj//CNbhkOnyfqjdiFP5VZNRvOL
         8man4avR0F24kFbKadUQhFxqbJRQxM8idFMdC32b39rDCPmOFtznsLOVVpip/nvpLBei
         47vqeDMrWfJa2ule1JBu+twE8t6+hUhc5xGdPkn7HBN+z+lFWgZuXWCRgbpDp+tu4CIa
         7PokvirAtkc0UD6Jkzzk+XnonWSAwv8L6epjZcag1uPwvtgXemIce+Z/yYPnGrQ3aVoV
         OKOezhdbqMV/uX2Ilt/EV6IQenZZ9KR4Um1AMBpis7HnCv9GQY2phVYOJoKGBPh9fFAX
         mTfA==
X-Gm-Message-State: AOAM5308LzaZzs0Ra+VgYeChMR3WzPn52oknw9+deMbyjk0BdKgdA5RS
        Hf6gpJ6Gi0VJvB3AACQOE7M=
X-Google-Smtp-Source: ABdhPJxrmn7Q+cEPjWO+mscNaLzrNCKtccUzYI+KO/u0EWRycxr6EDGdfPC22v1/O+iAzAgHMEcJ5w==
X-Received: by 2002:a1c:7f57:: with SMTP id a84mr7480295wmd.115.1640871958712;
        Thu, 30 Dec 2021 05:45:58 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n12sm17371136wmq.30.2021.12.30.05.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 05:45:58 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lib: remove redundant assignment to variable ret
Date:   Thu, 30 Dec 2021 13:45:57 +0000
Message-Id: <20211230134557.83633-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable ret is being assigned a value that is never read. If the
for-loop is entered then ret is immediately re-assigned a new
value. If the for-loop is not executed ret is never read. The
assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 lib/asn1_encoder.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
index 27bbe891714f..0fd3c454a468 100644
--- a/lib/asn1_encoder.c
+++ b/lib/asn1_encoder.c
@@ -164,8 +164,6 @@ asn1_encode_oid(unsigned char *data, const unsigned char *end_data,
 
 	data_len -= 3;
 
-	ret = 0;
-
 	for (i = 2; i < oid_len; i++) {
 		ret = asn1_encode_oid_digit(&d, &data_len, oid[i]);
 		if (ret < 0)
-- 
2.33.1

