Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CD94BCF96
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbiBTPt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:49:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbiBTPt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:49:26 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9D0532D0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:49:04 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a23so26936904eju.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dARIPsQFLgerpwn1kQ2g+irfqGZDCER4zOvKgssyNuo=;
        b=fFzb5I+Xrzyb7TNUivKHhlRdkvfeCmNWBLCRAGxwGGTi4Hlc2FRsX0syDEtgC2GkDY
         NOIXYpBQZiY/9N+FiDnO4cwrSx5FLXjkzvuKEByuGT3fa7kfg6wpiZhckWom4veyzVlu
         7iXKZBQW3FIkDPCCwx3XSqEtsqSzglp8VPA+SGxVFq4z5peIwd+4W5DUfOkwWQaFguGo
         iGen3s0GReq9iMuH1OOYBQ2kWmzWRDalj8Hw+ZWj4eP9NiAjxFlNXksl9/jX7gn6KCQH
         ljF6/AFu8u5bpMoO1rW1fOadtp8JvVXsPg999ucvYZH+Kx9Djv3M7qhxVmDlkPTJPZfC
         4p3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dARIPsQFLgerpwn1kQ2g+irfqGZDCER4zOvKgssyNuo=;
        b=rTxpdFe18FDmKsKEmRp3Qc7N8KwZv3ZPcGj2XoX9+FExVvAKhVk+To32Ty3yrjCk2s
         Bfhf0Q2fo7h5KKUsmGmQYB//kbTFB2H20Gq8r9IWZDx1Usg+WWnbhB8/eFmpKWtCt4GO
         A5ruqjIlAorydRV3fBHHebXmnPCT21xMVgQqU+iaxRrO9gDi3C+d7FXjWyOx7RQXgpQn
         shve/Jb7siiWHwtLHE5+67leqb/c7QZyD3nLttZsvObg2Xm73lWRUmOEJ6Vic2F/Zlpi
         xYrSCj8/lALPyofU1YFVmMuyjAq7w6gpc212gAKdT0GYKu8lEF1QdxLtLcXcciJ7Yu8a
         cxNQ==
X-Gm-Message-State: AOAM530M8aZDSfQc0TZj1GZqNScZF+vTLoqNNOL5F5Cs0oq6DXNoSSkr
        xpQ1RX4R7mtxGDvm/TsHJYg=
X-Google-Smtp-Source: ABdhPJzOfIaCWcddsfGqtsIX6dBfFI29GRWro4vBxYgh/w8mpHKlXKl8UazYmXPZQtv+xJRoQ6poEw==
X-Received: by 2002:a17:907:1dc4:b0:6ce:f3a8:49b7 with SMTP id og4-20020a1709071dc400b006cef3a849b7mr12425908ejc.121.1645372143489;
        Sun, 20 Feb 2022 07:49:03 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id ew6sm4178979ejc.217.2022.02.20.07.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:49:03 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: clean up rtw_rf.c
Date:   Sun, 20 Feb 2022 16:48:44 +0100
Message-Id: <20220220154847.7521-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
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

This set removes 5 GHz frequencies from the channel-frequency map in
rtw_rf.c and simplifies the rtw_ch2freq() function.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (3):
  staging: r8188eu: remove 5 GHz channels from ch_freq_map
  staging: r8188eu: refactor rtw_ch2freq()
  staging: r8188eu: clean up rtw_rf.c

 drivers/staging/r8188eu/core/rtw_rf.c | 61 +++++++--------------------
 1 file changed, 16 insertions(+), 45 deletions(-)

-- 
2.35.1

