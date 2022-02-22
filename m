Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6654BF39F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiBVI3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiBVI3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:29:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2CB15678A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:28:58 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id bq11so13719783edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BrVa7cPF9wijuktD07w20oweh+VJHhnda+u1Tia5Q9g=;
        b=FLFhyccSMFOrGRWGIXbKI+zJfnddI8tO6JPCoSiPS3qH4PO05muN4/V4i1GQwFc9bu
         FzlN2qWBP/exaq5IzvSOW/Hf68jIn0/cvqns6cNyXKC9wxSuqp/9cMfDOyMpAEAS+X9j
         G49OaC/4mJqo4/SYkXBQEtYiXoqaRTfll71uZyqGddNMypYSzfGan2wTIzaoVftFoCDi
         RmFnkaBcp2KJNrz2RO6N3kbkAAMWSGWZgMPIyHG+jAUTUrFcXQcCPlYFs5sU72zr7wIZ
         6xEv1Zo/sDY62dMRNgyKmWlRMXoNSlPSaEx0TPiy1xz0gONi4KzNhAJUZqB7tmrwcbbB
         jGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BrVa7cPF9wijuktD07w20oweh+VJHhnda+u1Tia5Q9g=;
        b=2KDjpqc+eq/+EYvvu5yYSrzbeYRvErRt8WMJwlsjiZ7mkVBs0RRhPoj3xQzqABYNzg
         PSezJe4f72ASWjpbXfj91QLvqXIPfPJFDHOicXCfYH3qolYI0uXCQgnGps+Mn4Uiz1/U
         BSGciOrxMcow5WlrY3mUlWliDUbgMXCNCa/j5erzQWsdHQNM9LiRxlCrq0SSuEgM10eN
         l1vmJnyJonXS9D6rUgEH4Uu6+hOwF9jK+ikM9hIsKI3z2ZTBNsWzU/TM5AmPmDNzJjIx
         Y6Czgt/5NiCqoHTLTmhFInhlGz5OfvkhXKobqcECscN0BcVzMU5L890NxV059KLK+NoJ
         m+2Q==
X-Gm-Message-State: AOAM532nsnBL06FbmEzXRsvb+rquMOad/XiyQ8lCGw3hiP5BEwIa7/H/
        xu3IzSltV5XpIzN6wRPEE7w=
X-Google-Smtp-Source: ABdhPJyZCYCb57qQLcloyT6zXAZ1LdCFSUeTKDT8jl8qwZZLjowEnS/zZtXl/OHJQQm1EP2KmYfNzw==
X-Received: by 2002:a05:6402:2790:b0:412:8379:f248 with SMTP id b16-20020a056402279000b004128379f248mr25227566ede.285.1645518536853;
        Tue, 22 Feb 2022 00:28:56 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id v12sm9831926edr.8.2022.02.22.00.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 00:28:56 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 0/3] staging: r8188eu: clean up rtw_rf.c
Date:   Tue, 22 Feb 2022 09:28:44 +0100
Message-Id: <20220222082847.6687-1-straube.linux@gmail.com>
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

v2:
Changed the commit message of patch 1/3.
Added a check to avoid out of bounds array access in patch 2/3.

Michael Straube (3):
  staging: r8188eu: remove 5 GHz channels from ch_freq_map
  staging: r8188eu: refactor rtw_ch2freq()
  staging: r8188eu: clean up rtw_rf.c

 drivers/staging/r8188eu/core/rtw_rf.c | 62 ++++++++-------------------
 1 file changed, 18 insertions(+), 44 deletions(-)

-- 
2.35.1

