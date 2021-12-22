Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0C247CCD0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 07:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242676AbhLVGHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 01:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242656AbhLVGHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 01:07:50 -0500
X-Greylist: delayed 455 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Dec 2021 22:07:50 PST
Received: from mail1.kuutio.org (mail1.kuutio.org [IPv6:2001:41d0:701:1000::88b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A393EC061574;
        Tue, 21 Dec 2021 22:07:50 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 72F361FE04;
        Wed, 22 Dec 2021 07:00:12 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received; s=dkim; t=1640152811; x=1642744812; bh=7goCQ
        RK56252j1Vuv1LAm+D12SpIRIPvTknwjB0fb40=; b=L3xSOpPzd7ix3OoZfvwCi
        gXtJGAbgoazxwmCSvxK1/Oin4x+jnk8kWsFwaW3mhdw8S8PIo8IkOzKnn//M4Rcr
        2CthnBBWnInVo70dX58yWUHMzEryYEoYYWWkm8ZBarUQlJGQmI6Vj7yoLK5nta8G
        OGJPw89G3Too2ep31gxpG4t4nUNQT9yTwZsY4BKki8BivsW07fzS2lchdl2w0CTT
        GIv2IUc07DtNSVbRnJwVWQJySUJtN+wtunO8x+gnvmIi64PQSnt8n8CRfYHLe/E/
        ktMU2NlpKEsqmPsXOpkw4Y7yiv+nzB39Zt52WmdCZTAJehpKvgS519GffWelrUFO
        Zd49upDVPO1003WMQuyP0kd/fkNnhFxf2ghZdZShL28knj53JTdWTDU6sOURRjga
        C3L06fi9VVdKEir9VXQJuC80Y8VfjiSic3kdZmIch1S6ZAWi8JaUrvYL37JrAfHl
        HYilXsYTrvqhv5PYj1xq0VIoVaUNeB1fjHRtrHlFntqRL0kI9LFV0Igk9wPpIkz6
        YNucU6s4gLLJ/TTb0UraLFRlqA8ZDSZWzol39ZviKaq5jwCbwb+g/oCABrlr+fov
        rNKJGNV9LMHVhljzMfLFrx0B/gy5LQ4oDvHxm27IudtiluYuixq7pRUlvhkKj2NR
        O+3NLU8itizNzb/pPTXvE4=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id PJZ97WVEY7Kj; Wed, 22 Dec 2021 07:00:11 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id D50001FDDB;
        Wed, 22 Dec 2021 07:00:10 +0100 (CET)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH 2/2] spi: ar934x: fix transfer and word delays
Date:   Wed, 22 Dec 2021 07:59:58 +0200
Message-Id: <20211222055958.1383233-3-oskari@lemmela.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222055958.1383233-1-oskari@lemmela.net>
References: <20211222055958.1383233-1-oskari@lemmela.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing delay between transferred messages and words.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 drivers/spi/spi-ar934x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-ar934x.c b/drivers/spi/spi-ar934x.c
index a2cf37aca234..ec7250c4c810 100644
--- a/drivers/spi/spi-ar934x.c
+++ b/drivers/spi/spi-ar934x.c
@@ -142,8 +142,10 @@ static int ar934x_spi_transfer_one_message(struct spi_controller *master,
 					reg >>= 8;
 				}
 			}
+			spi_delay_exec(&t->word_delay, t);
 		}
 		m->actual_length += t->len;
+		spi_transfer_delay_exec(t);
 	}
 
 msg_done:
-- 
2.25.1

