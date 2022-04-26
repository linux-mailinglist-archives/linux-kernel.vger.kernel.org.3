Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F49150FE66
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350681AbiDZNNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350684AbiDZNNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:13:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BDF3BFAF;
        Tue, 26 Apr 2022 06:10:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j15so12159488wrb.2;
        Tue, 26 Apr 2022 06:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6GOK8GOxXZjvCSWzpBpj5pKZ6Fq3fZcQydXRFhVyOtw=;
        b=mGxUFcSaBFGsCVExojhT7A540W1WOiCl4vceovmyDaNamYZ7gYsZxRuUON05MLN8f6
         cXiLpQ1uZwSj804vGUbUmEeJpcPKoc34agS4/HO+Hs5drDJaU2HhV0DZartzpuqawVeE
         7M62D9eUSEM3jh9Q118e95VpQ7D+CeXXCt8P0yxSYEhzbIL8lUPaizr9268qscrccgas
         XOXrezVsitALJ67ra5pR3tZMxhT1hI2fdrBk69/PLjvCJkHj4706tsngiwLHKcauAC07
         tboo/cy2vTcj4gqq0EltbeX3PFnVv2CSzs5daImV/8jlsiFMf8tludYB3LUcVRlRx+3e
         HvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6GOK8GOxXZjvCSWzpBpj5pKZ6Fq3fZcQydXRFhVyOtw=;
        b=iMrvlvwjtTbcTZqIGact6lRW08r3/MxlR8WJd3Hh0a43D50ssQRmrrqQgmn43i+shg
         ongH7wYJLDYpD0m+SL9+s99677bE5EdFkHV/gUP1ZuCJaR1Cy7Rcojg6jcG+l/fc+KmP
         t+VvdFeCGnJxflAZnLWCNrPP34ZNg+UpjzK0q/8/tLuHBGiw0srFqg9Mm7O1MRR5bCoT
         ccIzh/Gsx/zm4Rrfc69zLy+yXASt9XKLV0DhAfsTn0wj+dD29GVv/4Wp8CjWYVcjEQ48
         k1uRZVq2JjwgA0QZSVfc0xseT60SkBcW0RGXmvuld1DincN9oGRz3JltoRkdIJ4MX8pr
         hTQw==
X-Gm-Message-State: AOAM531scPaS7OibXdR4KK7GV0tMJ+yd/iVetctkcOczObFECNWkS/Qv
        wreGrZqP7VoX0TjDybvjLO4=
X-Google-Smtp-Source: ABdhPJxkDJylNOaYYHkPyUlYZ9T2/Zn+9hpCgk1NWN0UYJ1It5pVUFOpyduFn52DBNw8FEwZaS7aeg==
X-Received: by 2002:a5d:6dab:0:b0:20a:8684:cbc1 with SMTP id u11-20020a5d6dab000000b0020a8684cbc1mr18216057wrs.482.1650978625869;
        Tue, 26 Apr 2022 06:10:25 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id e9-20020a056000178900b0020a9f995a3csm12057830wrg.24.2022.04.26.06.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:10:25 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/power turbostat: replace strncmp with single character compare
Date:   Tue, 26 Apr 2022 14:10:24 +0100
Message-Id: <20220426131024.1519440-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using strncmp for a single character comparison is overly complicated,
just use a simpler single character comparison instead. Also stops
static analyzers (such as cppcheck) from complaining about strncmp on
non-null terminated strings.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ede31a4287a0..e6779f599a8e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2976,7 +2976,7 @@ int get_thread_siblings(struct cpu_topology *thiscpu)
 				}
 			}
 		}
-	} while (!strncmp(&character, ",", 1));
+	} while (character == ',');
 	fclose(filep);
 
 	return CPU_COUNT_S(size, thiscpu->put_ids);
-- 
2.35.1

