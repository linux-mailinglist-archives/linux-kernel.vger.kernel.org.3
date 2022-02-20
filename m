Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DB04BD123
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 20:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244742AbiBTTxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 14:53:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiBTTx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:53:29 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB5B32EEE
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 11:53:08 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u18so25233408edt.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 11:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sbg/+DLQOR79p6+0YNOkKyiycWb1remk9bmGUAMrS88=;
        b=nB6eDpubZekSnWEMZoKwxePhhcG9rMs3SAxMmF3ISlJI75CHUF/6uf0lLL/mWsDYHk
         YVmGREQa6Estabu/cdARskm3SK33BooecldvQ06A/ebqwMwB/RwJm8twzp8Y0aVkhpvb
         s/scUze/CUwY+bioMTTDdBdSfiDCkV4kNf9bS/sLkhIRtZBa3/K8NXWoY97Hwu3z/8cQ
         JMoRTGmNltL3W9eP/eUmrHV0FGNGUdx61xJCSbKNcRkr5Iq8auzltT28nzL1voYRC7b1
         mk/QqcYBuaH/Ker7sD9BlHUSNAODxKavJukcuQHOzKdu484saLd7rDJwG7y3PAYO0ovI
         ta1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sbg/+DLQOR79p6+0YNOkKyiycWb1remk9bmGUAMrS88=;
        b=xKG9CMAe1quX5fAAkps0ruShfHdi2yU3akWDKhGOw0irak7evGyAJTWJ5EI96QxECZ
         06VnYTY6ZuvRH5MrhMRMiT0+hU9rUkvEO9Fi0viWeF6xQA7uvOlnsQ3s9QMIBSWhEfLq
         xqvVsSfpnUxmyehqpKkIxgv5LFZPxlJ51iEsu6UTzXcejdrFqnS0x81sf9U04vs5DUCZ
         wMOTqdsQSsbLyTWFHoHSPqVzO+OBTIXOy7KqbEEUjP3KsYNOzlF/Lk1qzVDbAzhbnUIN
         0e94WZBE5E9tDF+HnT4wSTamIip0PVMMEg4g9aOjfbXEZW6IrnP7YMhrB/0duxIXew22
         iAdA==
X-Gm-Message-State: AOAM530XM2jZuLpHbmZmAV8h2VXbCJX8HEmGVspvTWk9SPRYs0y+fqq+
        uwMP0ZvbR41J3Mz17LhY9yo=
X-Google-Smtp-Source: ABdhPJzFMIej0zmTKKZnEBObUvSWAGC3nQXLGbfIW7RfGr27tjZJrKBSJicYHuowtwePhpk8M+zQUg==
X-Received: by 2002:a05:6402:c10:b0:40f:33cd:a39 with SMTP id co16-20020a0564020c1000b0040f33cd0a39mr18100681edb.234.1645386786554;
        Sun, 20 Feb 2022 11:53:06 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id l6sm4354376ejz.189.2022.02.20.11.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 11:53:05 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/2] staging: r8188eu: clean up rtw_security
Date:   Sun, 20 Feb 2022 20:52:52 +0100
Message-Id: <20220220195254.11759-1-straube.linux@gmail.com>
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

This set removes unused macros and aes tables from rtw_security.h and
rtw_security.c.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (2):
  staging: r8188eu: remove unused macros from rtw_security.h
  staging: r8188eu: remove unused aes tables from rtw_security.c

 drivers/staging/r8188eu/core/rtw_security.c   | 174 ------------------
 .../staging/r8188eu/include/rtw_security.h    | 112 -----------
 2 files changed, 286 deletions(-)

-- 
2.35.1

