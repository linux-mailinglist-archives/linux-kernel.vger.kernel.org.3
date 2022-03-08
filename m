Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8043A4D22FA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348213AbiCHU5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiCHU5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:57:32 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7347A5004A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:56:35 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so3262377pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1sHi12oEm3E/t24MftHPPCsXxHeW61kYnNhOf+LhGIw=;
        b=NBNukXaJNcFM/m+tUQZ44Qy4Lwop0t+AdSS8pIf0xIrsXiUXfd/lK2cJstpEhpOBSr
         ekpVb2aPAbopDU+K1F96kCw8Nw0CzFHh9d0aP0IKx1D+3yvpQBaTIIlkECBZ9eLJHWg2
         bb/n3kddV3AhUsjjeq9NtFBXA4teBqD7NkCi7ts3L3IE459WTSETgWgUED+2XfZBWVPO
         NAKS/JttaKZ20Y5zCqcWDCWD7h06/y5stkanP+2g5gSoARtJklGSsPfGqIhiOlyGnkjA
         C2Qw1gYDbtdY2XW1st8WIIzcTPUkMVhFo3RVDNblxL+I3INAnuFsICxqZriS5JG7Rpt5
         Vbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1sHi12oEm3E/t24MftHPPCsXxHeW61kYnNhOf+LhGIw=;
        b=bKgmRKWKtgXeKlff2x5y7ZZuUSX7XPiSah23Y4O4eSZiYvB/sggTaP3rYwDIA4u0a9
         H82rvfumpa1e4b8Ps+D3zbB4CVtbe2mXlvxMxIdtezZuz+g8bGhQHfpUoP21THvo87Nj
         4AhwR61VP6BuFp5aPWn2HxjYnvea/ZsqCHuBPQ+xSBrUBpAwmmotVBKrZ6xPhl3NwFs1
         N6yia0Jfh6D10FjhoH8Cetyk4ub5oOsavjtSMZMbuJwnVxbeF4yU31jr8cNwra+7qfzl
         zX9shUUk2YtTr3y6WPTYSIMY+UVmvMiI88S58IGtbVNK7sKxPqVfp/5bH3h6CnkMxM5E
         7CJw==
X-Gm-Message-State: AOAM5337lHyCXrYpH+62SafTT6muZKtjUiZ+Wv0OoXI99J7qyk2LfauL
        gcNVuNZOQqKLNFw8hSztzE0=
X-Google-Smtp-Source: ABdhPJy8Nqf48NfshCenKmm4eTMb8NfChK4bTOYYuiGTSDoXdFluZEwAeZkSo6QOFCZ4vRL6Lc7Aiw==
X-Received: by 2002:a17:902:f712:b0:149:d41a:baa8 with SMTP id h18-20020a170902f71200b00149d41abaa8mr19248230plo.115.1646772995019;
        Tue, 08 Mar 2022 12:56:35 -0800 (PST)
Received: from localhost.localdomain ([103.85.9.4])
        by smtp.gmail.com with ESMTPSA id u10-20020a056a00124a00b004f741eb11d0sm1252661pfi.149.2022.03.08.12.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:56:34 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: call _cancel_timer_ex from _rtw_free_recv_priv
Date:   Wed,  9 Mar 2022 02:25:09 +0530
Message-Id: <20220308205510.48431-2-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220308205510.48431-1-makvihas@gmail.com>
References: <20220308205510.48431-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _rtw_init_recv_priv() initializes precvpriv->signal_stat_timer and
sets it's timeout interval to 1000 ms. But _rtw_free_recv_priv()
doesn't cancel the timer and we need to explicitly call
_cancel_timer_ex() after we call _rtw_free_recv_priv() to cancel the
timer.
Call _cancel_timer_ex() from inside _rtw_free_recv_priv() as every init
function needs a matching free function.


Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index d77d98351..61308eb39 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -103,6 +103,7 @@ void _rtw_free_recv_priv(struct recv_priv *precvpriv)
 	vfree(precvpriv->pallocated_frame_buf);
 
 	rtl8188eu_free_recv_priv(padapter);
+	_cancel_timer_ex(&precvpriv->signal_stat_timer);
 }
 
 struct recv_frame *_rtw_alloc_recvframe(struct __queue *pfree_recv_queue)
-- 
2.30.2

