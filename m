Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E1E4F50AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1842960AbiDFBff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390678AbiDENmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:42:55 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE3527B1F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:43:35 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q142so9154717pgq.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 05:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pFy1qZhdMdbp63fvqatp60F+TUWmD+XE3qD2we3Q3/E=;
        b=ICHmkjwoT02evQPvLG67fwtfT+/HO34QaDa64NIblo3dX6mBddVU4pztRQ3PiNWgV8
         Q0atQj4u8oNo9+UKieBwV9ZSUi0gX8g6YmUUkG7ROH5NlrwVNyJUy05Ht6G+QDTCaeyG
         Mv1OIFqk98ytWz415A3HlO64EKjnlwpok1u+MnoORc3QBmzBC4YJTJ5NIokC0Q0f3LUX
         7IqjjjiDnbWIhf0fAe1OZR1bG6XlOr3YwqYmO5nDUKhnpyec1xesRMYWb7wyDJ8ABL/u
         NMsJKvTA5/JDa4gpiHwmq8dVoyh7mO1SIZaipTf6SJlAqGh/cHjXNFPmpUQCsL/U//Yu
         YOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pFy1qZhdMdbp63fvqatp60F+TUWmD+XE3qD2we3Q3/E=;
        b=trFrTzYpBkLKaG9sAHAA5w6tuk+lVxqgsK+vq4jxTgSh4BT3075gcojYV33Aq9eF5S
         G2vc6/kkBC5qvlZZ8kfY7X5TVXRXs5KNGiys49vVz84SHOB0bPpBLuNJ0CVHH1OrJKCc
         GjI5Qun6pNzOCGnkGF1cjF3LUmwAGkUuEs1cKhsAC7S+kiwtkgkUJVt//MlSKoaOdAWn
         E8ms32WcuTx+AtwuGQUiRR1+hxF/V5cXIsS5qCO2v8EKUN3iba424QGLVlqx+ilrqRsj
         SlQLq9FDQKoyWJHhOUesNq/UD4dKm0dwaX8n7v+Lbu6y+5ub3MhSf7oMKupyKtQzQWm2
         R7dA==
X-Gm-Message-State: AOAM531YYSpUimag/tN3Z440gzX2mEErJc7N12TT9aorbN4eogDwZt98
        XarAk4Z82pgV8AviCvu9Nts=
X-Google-Smtp-Source: ABdhPJyDfpN+1H4PfHUqp+rp8XEL538Oc78MuEILvTB/wjQSaNjaqZgkugyg7zTaw6Hwc9tuD+WpFA==
X-Received: by 2002:a63:3756:0:b0:398:4086:16 with SMTP id g22-20020a633756000000b0039840860016mr2741728pgn.55.1649162615312;
        Tue, 05 Apr 2022 05:43:35 -0700 (PDT)
Received: from vihas.localhost.com ([103.85.9.59])
        by smtp.gmail.com with ESMTPSA id nl17-20020a17090b385100b001c70883f6ccsm2760014pjb.36.2022.04.05.05.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 05:43:34 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: some refactoring and cleanup
Date:   Tue,  5 Apr 2022 18:12:37 +0530
Message-Id: <20220405124239.3372-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop some redundant checks and cleanup the unused functions.

Vihas Makwana (3):
  staging: r8188eu: drop redundant if check in IS_MCAST
  staging: r8188eu: drop redundant if check in check_fwstate
  staging: r8188eu: simplify rtw_inc_and_chk_continual_urb_error

 drivers/staging/r8188eu/include/rtw_mlme.h | 43 +---------------------
 drivers/staging/r8188eu/include/usb_ops.h  |  7 +---
 drivers/staging/r8188eu/include/wifi.h     |  5 +--
 3 files changed, 3 insertions(+), 52 deletions(-)

-- 
2.30.2

