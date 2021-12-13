Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D898473783
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243638AbhLMWdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243593AbhLMWdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:33:38 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44158C0613F8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:33:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so13409568pjj.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fn4qb4VpnpL9cHIDHm8PVw/axI2OCAjJYGYPjq+lmCU=;
        b=MGrKvzUiWWYOkeqn57fgoFY4N5BmaLdmwhcqxBB90I1icKBQeZyY42PsaYvBVzBQsg
         tF8YXsB1j3coRnNIxTN4s15iw2HqBBo0iuLUCNWl1r1Zco1OV2jna5iOFQUFTtvXXUn/
         YPxigWjO9EcNwOHY7xZRDDyrvZ7i3me+Mi/lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fn4qb4VpnpL9cHIDHm8PVw/axI2OCAjJYGYPjq+lmCU=;
        b=Y5nm8OJBu/9UTLD1ie/2cey5TRg2kxndLcT3NeWUCvxaUG2UquTBakpBq2H5cGuyhv
         w0n9OuRc3ZSYpjbhKVaokNk+/eZFXW7kzF0SM2V+FHXL4mGbtSaZdCevJLLhjNwPML1H
         xf63enzdxWXpaC0F+sbq+xhbM+qlRwmjA4/bREV5otcYEbHTPcp1aLpg6QuZWUlTW54H
         AmtmfNIV1dBds1H5AN5agrAl2Rc7In3WuEe2Q9FLeTrHdf4txevjcT6E6lfkiClXorsb
         WxpsUNFNBHgz+WxR0TcVFXeBlDfwNR9CgozSUU/kWmVnkYmItrFo+YkRKaL2j/cQiuzh
         Mn7w==
X-Gm-Message-State: AOAM532VhEJuDnzalBh1l5Eh8ttmqutUFfDRu+cks5cvNVRucJjHtXIP
        3wnUzUqwn6J6S6VCmhMazVzoutzp/pcv4w==
X-Google-Smtp-Source: ABdhPJzmw78A+daFoOvnev4exAfarxyzvjBiG71x9KHt11gUHMBmgFvCAzgFQCBRvUvUx2gTZtsohg==
X-Received: by 2002:a17:90b:1d91:: with SMTP id pf17mr1170087pjb.230.1639434817765;
        Mon, 13 Dec 2021 14:33:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f19sm13254844pfv.76.2021.12.13.14.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:33:36 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/17] media: omap3isp: Use struct_group() for memcpy() region
Date:   Mon, 13 Dec 2021 14:33:18 -0800
Message-Id: <20211213223331.135412-5-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211213223331.135412-1-keescook@chromium.org>
References: <20211213223331.135412-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4159; h=from:subject; bh=N8+9iw8eqkBRgOadkosB8PfBprAVHbU1wOrwAnD7q94=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBht8o3kQlqNDs1/r/+sQ/zvIpk0El6fooUUdbkO+q+ oXwrSJ6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbfKNwAKCRCJcvTf3G3AJjCYD/ 9D3jU3IhaQXXacX0dcrEEz/l+hhTkwbzBkFV5oKBBTe8yn0EIeHoBoSplsiNSK7qMppTkqrTig0R6J So7n62bKE0Rp01Yo0T8XbnFxh1O/On3ETblixOtcx0AoPmyLEGDAKptWWcPn4vQrAhuZlxh2+Phq/G nKaKc04HShNAM6qECpbU9xrjp7jf5mcvDpiF80qEKlsNXNfINehdfkXML10YaYhed8AkzTD/Uc+TU4 IEQd5yU6Y87oXemlhbD8+nB6d7Hxu6aDVda10ZAE0x+8r4xzIRdlDa+TuLw5owVQIIVbSW7ku8gDC9 M8T9iajSZ/wwOuqGMLEH0a0OfFAjbCf9Mvg7hZhdY5T7scV4oV0f6vRp9QgBj6U8ShPil5wbQ14PrK bn16CwTKbPVK3gGbNzK/HiS16n4Pw4Ny4no6eYWWk+ZM7xzM3jFEJXpWjCxt5Q6Vy98McS5d40xjSB Z/+FskVG7cZ47Tbxw/tZi2MJP8J+PzT6L931KE89GwQfVdtVndIB6P2t3j/agm54RecP2kkl3NRsSr LKgy8SeQqNKnkcbQppLx3x83TNYsXD/yurpKpv1jOBR89F9SIpkSR8hoozE/1+V2fLxDCPIMtTU7JY MRD8GGSP5Leltli1d5SEEQiuzU7VdpVNBUnbSt4+JntubgShWwQNM8AC4vqg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields. Wrap the target region
in struct_group(). This additionally fixes a theoretical misalignment
of the copy (since the size of "buf" changes between 64-bit and 32-bit,
but this is likely never built for 64-bit).

FWIW, I think this code is totally broken on 64-bit (which appears to
not be a "real" build configuration): it would either always fail (with
an uninitialized data->buf_size) or would cause corruption in userspace
due to the copy_to_user() in the call path against an uninitialized
data->buf value:

omap3isp_stat_request_statistics_time32(...)
    struct omap3isp_stat_data data64;
    ...
    omap3isp_stat_request_statistics(stat, &data64);

int omap3isp_stat_request_statistics(struct ispstat *stat,
                                     struct omap3isp_stat_data *data)
    ...
    buf = isp_stat_buf_get(stat, data);

static struct ispstat_buffer *isp_stat_buf_get(struct ispstat *stat,
                                               struct omap3isp_stat_data *data)
...
    if (buf->buf_size > data->buf_size) {
            ...
            return ERR_PTR(-EINVAL);
    }
    ...
    rval = copy_to_user(data->buf,
                        buf->virt_addr,
                        buf->buf_size);

Regardless, additionally initialize data64 to be zero-filled to avoid
undefined behavior.

Fixes: 378e3f81cb56 ("media: omap3isp: support 64-bit version of omap3isp_stat_data")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/media/platform/omap3isp/ispstat.c |  5 +++--
 include/uapi/linux/omap3isp.h             | 21 +++++++++++++--------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/omap3isp/ispstat.c b/drivers/media/platform/omap3isp/ispstat.c
index 5b9b57f4d9bf..68cf68dbcace 100644
--- a/drivers/media/platform/omap3isp/ispstat.c
+++ b/drivers/media/platform/omap3isp/ispstat.c
@@ -512,7 +512,7 @@ int omap3isp_stat_request_statistics(struct ispstat *stat,
 int omap3isp_stat_request_statistics_time32(struct ispstat *stat,
 					struct omap3isp_stat_data_time32 *data)
 {
-	struct omap3isp_stat_data data64;
+	struct omap3isp_stat_data data64 = { };
 	int ret;
 
 	ret = omap3isp_stat_request_statistics(stat, &data64);
@@ -521,7 +521,8 @@ int omap3isp_stat_request_statistics_time32(struct ispstat *stat,
 
 	data->ts.tv_sec = data64.ts.tv_sec;
 	data->ts.tv_usec = data64.ts.tv_usec;
-	memcpy(&data->buf, &data64.buf, sizeof(*data) - sizeof(data->ts));
+	data->buf = (uintptr_t)data64.buf;
+	memcpy(&data->frame, &data64.frame, sizeof(data->frame));
 
 	return 0;
 }
diff --git a/include/uapi/linux/omap3isp.h b/include/uapi/linux/omap3isp.h
index 87b55755f4ff..d9db7ad43890 100644
--- a/include/uapi/linux/omap3isp.h
+++ b/include/uapi/linux/omap3isp.h
@@ -162,6 +162,7 @@ struct omap3isp_h3a_aewb_config {
  * struct omap3isp_stat_data - Statistic data sent to or received from user
  * @ts: Timestamp of returned framestats.
  * @buf: Pointer to pass to user.
+ * @buf_size: Size of buffer.
  * @frame_number: Frame number of requested stats.
  * @cur_frame: Current frame number being processed.
  * @config_counter: Number of the configuration associated with the data.
@@ -176,10 +177,12 @@ struct omap3isp_stat_data {
 	struct timeval ts;
 #endif
 	void __user *buf;
-	__u32 buf_size;
-	__u16 frame_number;
-	__u16 cur_frame;
-	__u16 config_counter;
+	__struct_group(/* no tag */, frame, /* no attrs */,
+		__u32 buf_size;
+		__u16 frame_number;
+		__u16 cur_frame;
+		__u16 config_counter;
+	);
 };
 
 #ifdef __KERNEL__
@@ -189,10 +192,12 @@ struct omap3isp_stat_data_time32 {
 		__s32	tv_usec;
 	} ts;
 	__u32 buf;
-	__u32 buf_size;
-	__u16 frame_number;
-	__u16 cur_frame;
-	__u16 config_counter;
+	__struct_group(/* no tag */, frame, /* no attrs */,
+		__u32 buf_size;
+		__u16 frame_number;
+		__u16 cur_frame;
+		__u16 config_counter;
+	);
 };
 #endif
 
-- 
2.30.2

