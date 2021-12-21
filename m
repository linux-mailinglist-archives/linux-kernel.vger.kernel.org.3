Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B5547C76A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241769AbhLUTUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbhLUTUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:20:42 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C7BC061574;
        Tue, 21 Dec 2021 11:20:42 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 80F221F42C82
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1640114439; bh=5HlfVhipWFs2W1k7528IgRRoCTk0yWR3iwopOn1wo+c=;
        h=Date:From:To:Cc:Subject:From;
        b=ehHxAsLx/S3nY1+gV41HuiPGFjdGXi3bzC40wvoLCwOlbeKi7L0ARTchZXIW+UB4P
         +FNYjJX2fIGjufeBiENKWPtffq7iadL3oU+dyK8qMUW4wcP2kG4/ng8T4HwBNtCKrc
         ESL/xbE2MnBnSZnSBE/v6wOOxWxj7pqfbvKkgh7/xRiMe6deZP9UB9O1Y0pCi4vGDE
         1PlkVk2Dxfi+xBRjZ4US+uEbY7jQaRvAFItFtEQvaIB7vUnBzZWalKeIBws/6IPzJ6
         Zr3LTITRoM382vdpBdrVOesaQW0AH/EbsLOb35NSnlVfk61A0LdrepdezamysM+PdV
         RQV0RcyBNs8jw==
Date:   Wed, 22 Dec 2021 00:20:32 +0500
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Mihail Chindris <mihail.chindris@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] drivers:iio:dac make expression evaluation 64-bit
Message-ID: <YcIpAKV7Cmi0o7PU@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two 32-bit values are being evaluated using 32-bit arithmetic and then
passed to s64 type. It is wrong. Expression should be evaluated using
64-bit arithmetic and then passed.

Fixes: 8f2b54824b ("drivers:iio:dac: Add AD3552R driver support")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/iio/dac/ad3552r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index 97f13c0b9631..b03d3c7cd4c4 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -770,7 +770,7 @@ static void ad3552r_calc_gain_and_offset(struct ad3552r_desc *dac, s32 ch)
 	dac->ch_data[ch].scale_dec = DIV_ROUND_CLOSEST((s64)rem * 1000000,
 							65536);
 
-	dac->ch_data[ch].offset_int = div_s64_rem(v_min * 65536, span, &rem);
+	dac->ch_data[ch].offset_int = div_s64_rem(v_min * 65536L, span, &rem);
 	tmp = (s64)rem * 1000000;
 	dac->ch_data[ch].offset_dec = div_s64(tmp, span);
 }
-- 
2.30.2

