Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9A452FF81
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 22:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346172AbiEUUri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 16:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345277AbiEUUrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 16:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43E3F41302
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653166053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q7KKV9nEc1O8xO71RHJAseDwiXENbXZxnjAzbqBmERg=;
        b=HRVf4zVvWcIOoiM32MjsSxlronjRM6snQIzPw0mrLLYWZbcfFfAnBwJ6c8fodmA4CLCEXE
        YTw5yOZyoFW6MRuvHwDAsl9rhdv8AH+zIAzvtVWh7dQuFPmcsNHzKJzzAq/eYXJt95KjhR
        O4tdq8MmUjybZ9Mb1Koyeqs2GGu+xdY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-8lhy7idoM5OcWvWmUphnyA-1; Sat, 21 May 2022 16:47:29 -0400
X-MC-Unique: 8lhy7idoM5OcWvWmUphnyA-1
Received: by mail-ot1-f70.google.com with SMTP id y97-20020a9d22ea000000b0060b0cc66316so180075ota.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q7KKV9nEc1O8xO71RHJAseDwiXENbXZxnjAzbqBmERg=;
        b=YR+sjohXbqUDUaYsSPIAam1DM1m2saVS4NTUozP5sAC/xCaOcf5FzMfC/Y8F2ej9RI
         7lPcq2SmRR82JBpydhON/vzkXjCcT7J0VwzgSDA2BJ/+XrkZpoLKZQ8EYmCZP9sgVFAh
         UA+BqoTeXfgxeXuLLEJbGbNnHaaE0RqmC6HoEsizY0xdg+QyPKkP8IoHRB3yIgaDWJ37
         wtEj0XdLzzJA7SoZZPzkXMqyKq6NeOdVAQGMggLYzo9LNSz0ipmtnZ3qSzSTiVhFHzVB
         SMKpITOuRGaGoFU/5fpo15ob0DR+4Ki11sjFi8JV3ccdE5VGlkrYOUVrHNliNddSo/pm
         NZ4Q==
X-Gm-Message-State: AOAM530Ix+0tK+AEQu1yrC9yTOjtpkzOmDyl2SRjkroXe0yVChT3GuDK
        BKQXPFBIACKHTy2/hD6pnvDeBHi90fesQy8/JOiH2EzuEOl/7SUcUFN1DiyayUqz69U0thKLo6O
        Q/4b8q4/6byujLhMQD8erb86b
X-Received: by 2002:a05:6870:5694:b0:f2:2ad8:a0ae with SMTP id p20-20020a056870569400b000f22ad8a0aemr2596743oao.71.1653166049067;
        Sat, 21 May 2022 13:47:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXZGmjsHsgboy8HLVJI93WiKGJ0RPTYTp8bJj+9c19UnhE7jTtNQ/lroFEhDPgmTztujXLFg==
X-Received: by 2002:a05:6870:5694:b0:f2:2ad8:a0ae with SMTP id p20-20020a056870569400b000f22ad8a0aemr2596738oao.71.1653166048917;
        Sat, 21 May 2022 13:47:28 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d44-20020a056870d2ac00b000f218150563sm1751520oae.10.2022.05.21.13.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 13:47:28 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     toke@toke.dk, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] ath9k: remove setting of 'is_ext' parameter
Date:   Sat, 21 May 2022 16:47:25 -0400
Message-Id: <20220521204725.2539952-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck reports
[drivers/net/wireless/ath/ath9k/dfs.c:93]: (style) Assignment of function parameter has no effect outside the function.

Both the is_ctl and the is_ext parameters are set in the if-else statement.
But only is_ctl is used later, so setting is_ext is not needed and can be removed.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/ath/ath9k/dfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/dfs.c b/drivers/net/wireless/ath/ath9k/dfs.c
index acb9602aa464..47cdfb584eb0 100644
--- a/drivers/net/wireless/ath/ath9k/dfs.c
+++ b/drivers/net/wireless/ath/ath9k/dfs.c
@@ -89,8 +89,6 @@ static int ath9k_get_max_index_ht40(struct ath9k_dfs_fft_40 *fft,
 			int mag_upper = fft_max_magnitude(fft->upper_bins);
 			if (mag_upper > mag_lower)
 				is_ctl = false;
-			else
-				is_ext = false;
 		}
 	}
 	if (is_ctl)
-- 
2.27.0

