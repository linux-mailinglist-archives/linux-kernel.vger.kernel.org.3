Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A854B536A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355188AbiBNOdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:33:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355177AbiBNOdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:33:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1A214BFC6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644849216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oIIRJ21BwIfvNwz0gmLQtZq6j5ywHb6my37zjrdYjEk=;
        b=JdmyYN8NJiao2XNqO7tz8Akr1LZ8XEQX82ZxalSDsC0D+z4gF4zSNia9dfqlqP6KvY4ilG
        tF/yL5D208SfgAQzI+YEGZXhHkKmLSV+s/AIJmuOeidg/Kn1zn8Btw5CB66kbyyYEQMR59
        lZpmxRnQPC+dTfZoHgTQdA0JVXw001s=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-f4tA5gRtN5mHVZMeanHJmg-1; Mon, 14 Feb 2022 09:33:35 -0500
X-MC-Unique: f4tA5gRtN5mHVZMeanHJmg-1
Received: by mail-oo1-f70.google.com with SMTP id g8-20020a4aa708000000b002e8efc514a6so10733701oom.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oIIRJ21BwIfvNwz0gmLQtZq6j5ywHb6my37zjrdYjEk=;
        b=AD/P0VuRgD4ZH7MA+JjhKdaUHlC9XMWuPmYe83cPMDvDE8aq5vHwl0JgLYDerOTvJs
         TBT5C5TMnuPZwYkZ+i0P0MdzJ1iOcTFhZTUbFNm32dNKrlvaOt7gxVP060bhZ6uaiQDV
         kN3ThA8XJa/ozImImAQ9VgYkOB1LKAJfIK45Cy/IM/s7Bg7DReAY6gG2hts/qAxhwfKD
         ZDmGvXG8P4CTFghWjzL1Ifm/RKoonGcf02L1FTI035GwPz/Exn94CgRcnQ9M6LHra86C
         ntWY30HXQRa0LrycAYo5LKuwX8DiVLdZ8tPzlY8b9JaeociVQg9oxno/gAnZLIkKh1Q2
         8Hxw==
X-Gm-Message-State: AOAM531wfMNgVQN1Eq7aGIqZ3CLrGk3anLmDAArapCKek+CeoWCMW7O1
        j23UBjXPMONHIGd6lGwDcGjlYfpv6paD6nx756Fv0dfxGswIYxTa4gpBlt0Vs0BCJlKfN1Lqe38
        bOUJwQaYSewrR+i5rXWuU9nqd
X-Received: by 2002:a05:6870:c095:: with SMTP id c21mr2067589oad.245.1644849215018;
        Mon, 14 Feb 2022 06:33:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdVQ5IR9sHLZgVPu2QVTSPw4yaT3G8ufJi3cdC6V7G9uaFDWwCWmnk8z6rfOM7YD50C4dtNQ==
X-Received: by 2002:a05:6870:c095:: with SMTP id c21mr2067577oad.245.1644849214794;
        Mon, 14 Feb 2022 06:33:34 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id z4sm12449303ota.7.2022.02.14.06.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 06:33:34 -0800 (PST)
From:   trix@redhat.com
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, kuba@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, jacob.e.keller@intel.com
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ice: check the return of ice_ptp_gettimex64
Date:   Mon, 14 Feb 2022 06:33:27 -0800
Message-Id: <20220214143327.2884183-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this issue
time64.h:69:50: warning: The left operand of '+'
  is a garbage value
  set_normalized_timespec64(&ts_delta, lhs.tv_sec + rhs.tv_sec,
                                       ~~~~~~~~~~ ^
In ice_ptp_adjtime_nonatomic(), the timespec64 variable 'now'
is set by ice_ptp_gettimex64().  This function can fail
with -EBUSY, so 'now' can have a gargbage value.
So check the return.

Fixes: 06c16d89d2cb ("ice: register 1588 PTP clock device object for E810 devices")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index ae291d442539..000c39d163a2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1533,9 +1533,12 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 static int ice_ptp_adjtime_nonatomic(struct ptp_clock_info *info, s64 delta)
 {
 	struct timespec64 now, then;
+	int ret;
 
 	then = ns_to_timespec64(delta);
-	ice_ptp_gettimex64(info, &now, NULL);
+	ret = ice_ptp_gettimex64(info, &now, NULL);
+	if (ret)
+		return ret;
 	now = timespec64_add(now, then);
 
 	return ice_ptp_settime64(info, (const struct timespec64 *)&now);
-- 
2.26.3

