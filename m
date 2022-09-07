Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4DF5B044E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiIGMv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiIGMvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:51:33 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CA780F4A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 05:51:28 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bj14so6972033wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 05:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7KvsrxzdRu/1ZCcF3FvQUHupf11TCZFlO9FQE3i8fVg=;
        b=byTk1PERy1xg8uduZ/vlGwafyPhLGvoY7pXynSWyML06wLvc6XPLmaRqEC2aMIwacV
         tUoup1Y1MKEfke2ZQCnVfXA7ynGh9tD6fmFJ2NeosScvDVyofRNGWL1q9VsTZpKi3MZM
         G0rbog7IRrNI2AYyjOephBJ52e1JOLDh+X2Uw7hRy8ac1WLy7tCU0d4TsHTg4GNkSTRE
         e9yTAgfQzSAllIDau9CnUscSa9dC0nCASyLiFgKN8CFAVW2l5NjyXTK6x47MJJDU5nKt
         +POxsjxxGx9AL/Jl81pq1OyBQD7x4jYpWTvIlhJ9wvr/iv7LMLfbVlVMpy4KjJFiFJiA
         MS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7KvsrxzdRu/1ZCcF3FvQUHupf11TCZFlO9FQE3i8fVg=;
        b=kyTqQR0hsDPGooorK0Ra7ItWXktIsnC+hu4Ff2hcp8UDasLxUnZQgbK7zciJM+6fp3
         ID9wY6h3nsH6ySm1WyOn3wA5xVTyXbqjiB+Cdwtn/6NBLQKrGEbsC6ke9aeB54z1SbNe
         HPPuQp47GAv8SyoFAkPUbAqc4Vb/mobmjFe4K+D5c57UToRYSqXkWvGyGZ/v3nUy9m6e
         ZQqurtS7+V8VUEhIzF7N5ahk6izdT2pga839w2wLcN4eM/dTKevYCKEwagGiCVBDBQIb
         2+/JbMy1tl8vr/iE8pLs8UeTy0LRw9At8ZvcigCEgO2eWUUuuSOGq9hx9LIU2yxwzkIh
         ymgA==
X-Gm-Message-State: ACgBeo3Vz52ib+jx5MdrziINBjdxR6hGdr8woiG+r/i1gmIgHRq+ebUq
        cCYUxET50ghiHde5e9yWOi/X1A==
X-Google-Smtp-Source: AA6agR59YwUbyyqlrFljRm41GE4qM9ZwcVQYqqOyOqKMX0/S32LliZKD5iDf+UMvGzsxfRdrxJHjKg==
X-Received: by 2002:a5d:47ce:0:b0:228:5769:489e with SMTP id o14-20020a5d47ce000000b002285769489emr1946894wrc.188.1662555086828;
        Wed, 07 Sep 2022 05:51:26 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm11480001wrc.41.2022.09.07.05.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 05:51:26 -0700 (PDT)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     edumazet@google.com, netdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        jasowang@redhat.com, mst@redhat.com, pabeni@redhat.com,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org
Cc:     yan@daynix.com, yuri.benditovich@daynix.com
Subject: [PATCH v3 2/6] uapi/linux/if_tun.h: Added new offload types for USO4/6.
Date:   Wed,  7 Sep 2022 15:50:44 +0300
Message-Id: <20220907125048.396126-3-andrew@daynix.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220907125048.396126-1-andrew@daynix.com>
References: <20220907125048.396126-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added 2 additional offlloads for USO(IPv4 & IPv6).
Separate offloads are required for Windows VM guests,
g.e. Windows may set USO rx only for IPv4.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 include/uapi/linux/if_tun.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 2ec07de1d73b..65b58fbec335 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -88,6 +88,8 @@
 #define TUN_F_TSO6	0x04	/* I can handle TSO for IPv6 packets */
 #define TUN_F_TSO_ECN	0x08	/* I can handle TSO with ECN bits. */
 #define TUN_F_UFO	0x10	/* I can handle UFO packets */
+#define TUN_F_USO4	0x20	/* I can handle USO for IPv4 packets */
+#define TUN_F_USO6	0x40	/* I can handle USO for IPv6 packets */
 
 /* Protocol info prepended to the packets (when IFF_NO_PI is not set) */
 #define TUN_PKT_STRIP	0x0001
-- 
2.37.2

