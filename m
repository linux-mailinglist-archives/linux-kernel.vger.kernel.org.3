Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F035A4849B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiADVJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:09:29 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35812 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiADVJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:09:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 2FAAC1F43DE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641330567;
        bh=S9/BYZv6PF/gittsjCjf6Ha+s2qRbnqJMTXw19zodsE=;
        h=Date:From:To:Cc:Subject:From;
        b=VlLXUvcijE8ot99aTIGJvj3yIPDf48f9CB5DQLS09WTm+98nYwVtQZ5JBxe/IzSlC
         4ZVCFpa1hASJFuRYiiUYyWgoXjZE5ZJQAoNinGYqYQNQSZF55Aj9B5bWcxFbR0kgRn
         m5dDs6NngW9biq7l4l1G1gp5xOiNRcQJH3B3dNz0H6G1SiEyJ1nySqJnjfPoc2v0My
         6bLyk2TRNmejgVZ6QubIz/JuP2767HkYLLKgX5e64W+AYJB+PXE0qnY+fHWkhugH5Q
         b5Zzqchjp8zaRbR1PqpnWY9uFRqQ4FkiYEIzwKGsVxLzaz9QdeR7TykbrrKSjaY/9a
         6PXTb7d6J5J6Q==
Date:   Wed, 5 Jan 2022 02:09:20 +0500
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     usama.anjum@collabora.com
Subject: [PATCH] iio: frequency: admv1013: remove the always true condition
Message-ID: <YdS3gJYtECMaDDjA@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unsigned int variable is always greater than or equal to zero. Make the
if condition simple.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/iio/frequency/admv1013.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index 6cdeb50143af..3f3c478e9baa 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -348,7 +348,7 @@ static int admv1013_update_mixer_vgate(struct admv1013_state *st)
 
 	vcm = regulator_get_voltage(st->reg);
 
-	if (vcm >= 0 && vcm < 1800000)
+	if (vcm < 1800000)
 		mixer_vgate = (2389 * vcm / 1000000 + 8100) / 100;
 	else if (vcm > 1800000 && vcm < 2600000)
 		mixer_vgate = (2375 * vcm / 1000000 + 125) / 100;
-- 
2.30.2

