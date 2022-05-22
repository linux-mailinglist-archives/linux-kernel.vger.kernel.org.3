Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517FC53035C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 15:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346031AbiEVNgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 09:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiEVNgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 09:36:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD8A5393CB
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 06:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653226596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sRfgkbZUw9keTkZ0zkljUOBSogAEUpAMFk3Mu9RLlPk=;
        b=dcdImN9Uny9ymtCABu0vBXhMEkTJBqLALhux9i0L3269qBbwyC4dnWU+x36vLxkW1z44fn
        7KzYvwODA4r1XdHMudVUDNgaiIiEVCQxV3anoSGck7k3zX2nh/PI1zfkF8cJdWp995ST8H
        RXrFI7fy1wUImaYeJGLnsaYAR7lU9YE=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-k7JA3Qt-Mc6150FyYnVRJg-1; Sun, 22 May 2022 09:36:35 -0400
X-MC-Unique: k7JA3Qt-Mc6150FyYnVRJg-1
Received: by mail-oo1-f71.google.com with SMTP id 188-20020a4a11c5000000b0040e4e4ced2dso4585437ooc.23
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 06:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRfgkbZUw9keTkZ0zkljUOBSogAEUpAMFk3Mu9RLlPk=;
        b=lryvwyq9S46AkWreSly6O0vARdSksm5v3+2dzbfB8ZBrdXieOyoEtPQF+5ZEqdrhwq
         L4H6yrr7bK8g1zg5ioz7+I1twTW0GdeErWmOKVRaKSstPfodGsiG+FTo0WAd+5DWjxGx
         AF6k4EWkrs5v8E9zunrvlEYhiY/WFS5g3BOtv87M4L4sM0jegRd2aEhwBBiBMM4yuLEl
         GDkQEzWAXXBkzSOQjNTTwgrV/cOWEzYBNK9ln1uUYkFqXu5oLUMADkK+iUqI89gJf7fe
         TnEDz91rm4CO5h+Tf+iYHRH6tRGO1IIMu9FpXJaj/4YmEBU3Zp/oW4wblWGIThitl8rO
         VfNw==
X-Gm-Message-State: AOAM5317A8QU9l75mJO3lpqnY0bGaf4zP4Uc/NqQpYdgZbaCvpvbSMTP
        vspqlqFszLgrbyo/sGRAKXSXatnOw9EJBh2Ed/A2ayxpdrYbbsgFemTlsyZh8zlXydhMDKsUIuT
        uABpQH8grhSVl93NLBME8txSV
X-Received: by 2002:a05:6808:23cb:b0:32a:dafa:8b67 with SMTP id bq11-20020a05680823cb00b0032adafa8b67mr10113587oib.260.1653226594505;
        Sun, 22 May 2022 06:36:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJya0gvC0UkPlQHu026fa55oVG25Q0cqbir/dnmDBnKSfLmsJhfUA5Dcf+neKjS4jMZ2L5bEtw==
X-Received: by 2002:a05:6808:23cb:b0:32a:dafa:8b67 with SMTP id bq11-20020a05680823cb00b0032adafa8b67mr10113580oib.260.1653226594340;
        Sun, 22 May 2022 06:36:34 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i45-20020a9d172d000000b00606ae457129sm3071219ota.26.2022.05.22.06.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 06:36:33 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, hanyihao@vivo.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] net: fddi: skfp: smt: Remove extra parameters to vararg macro
Date:   Sun, 22 May 2022 09:36:27 -0400
Message-Id: <20220522133627.4085200-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck reports
[drivers/net/fddi/skfp/smt.c:750]: (warning) printf format string requires 0 parameters but 2 are given.

DB_SBAN is a vararg macro, like DB_ESSN.  Remove the extra args and the nl.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/fddi/skfp/smt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/fddi/skfp/smt.c b/drivers/net/fddi/skfp/smt.c
index 72c31f0013ad..dd15af4e98c2 100644
--- a/drivers/net/fddi/skfp/smt.c
+++ b/drivers/net/fddi/skfp/smt.c
@@ -747,7 +747,7 @@ void smt_received_pack(struct s_smc *smc, SMbuf *mb, int fs)
 #endif
 
 #ifdef	SBA
-		DB_SBAN(2,"SBA: RAF frame received\n",0,0) ;
+		DB_SBAN(2, "SBA: RAF frame received") ;
 		sba_raf_received_pack(smc,sm,fs) ;
 #endif
 		break ;
-- 
2.27.0

