Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00CC58C814
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiHHMEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbiHHMEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:04:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FFA11C31
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:04:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v5so4700318wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 05:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=plnBWnVwXrE1lhxE5G1pC4DscYe+Aj6YcHEs3iVl5BA=;
        b=epYC1saHxJBZkzzYKEtkae0XhMlNW/aWmXjFTyiuajUGHOH5oE9VpqewtvXMmYrwDc
         c5G/p1xe/P8EEWbdZskA+FHo8Kaa++JVnNXFCGX9Wy55OFhsMY7TUrbHjsqmUUQP8SsR
         sTZY8/VGmYPF0gdgFJ764riXGAF3p07Tzsl3h1BuhNftk6f/uxadx+f0pYYOGMOrATAy
         AJbLK7x7XVArGMd/zShHShyCsWn6zWFdH8IzFSU2XzVWd3gDcBPhBIvy71rdXG0iAemb
         Za3i72QIWN6qOUej/CDseah49peD6HxU5YolNjt4rigpRLU3BIKcP5Kh+fIxb+JxNba1
         hJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=plnBWnVwXrE1lhxE5G1pC4DscYe+Aj6YcHEs3iVl5BA=;
        b=WfBChUQDGQxuE5hqDTL/CPeqitc0yyR3mGJJY3aAjCj4kQ9SejJs6t6IKg+SiyxOih
         ztb60oovSV1LrWZybWv6HRCZVQvfgLSYQbfITVCuj3ge65wS2nopzZ1o0JL3J+hzpY7X
         x8AxWJzlY9DXqv6B/HGzyg7c3ZbPnGgkwSpaT8WyZJ+HtH8MrNg2aD5Qd6Tn/+4OFxU/
         UMSiPnATeoC5YNT5W0/7lQlBeG2hA5uVASL2qy5m9r8uOOAOlc1i6Mu5IS13E8RCpWbW
         mM4/i/QRp+l4CtefSBtxoGbsNtZGpqAsUWElPbbnhp6+Yi5ByOvvHasxWeaAWe8FvJEt
         iikA==
X-Gm-Message-State: ACgBeo36Md6TWeLK7na2AAOKtH5wfVzFTwsi934UoeKOPAnnrKQkcBZO
        go1P33kdzQy+LtlTmJtFl17qcQ==
X-Google-Smtp-Source: AA6agR7JaoQKnBjEQaAhj5ksmilu1aeqBCtfchOYfNpkZrsQ+WH1he17WrY84Qy6dqTkGUPd+Jp11w==
X-Received: by 2002:a05:600c:1e8a:b0:3a3:20fc:a651 with SMTP id be10-20020a05600c1e8a00b003a320fca651mr12632810wmb.39.1659960273119;
        Mon, 08 Aug 2022 05:04:33 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xh0y3vuv1059rd6h4r.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:cd22:c517:e143:e53b])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c19ca00b003a31fd05e0fsm35293317wmq.2.2022.08.08.05.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:04:32 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v2 0/2] iio: temperature: mlx90632: Add supply regulator
Date:   Mon,  8 Aug 2022 14:04:10 +0200
Message-Id: <20220808120410.1543050-1-cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add supply regulator to the sensor as initial update before proper power
management is presented. This will reduce the diff for the following
patches.

Changes in v2:

 - Regulator voltage was removed as per comments from Jonathan Cameron
   and Lars-Peter Clausen
 - Style handling for the error reporting of the regulator DT binding
   was adjusted
 - NEW: Delay function was created and grouped together with call from
   the reset command, to ensure consistency and reduce the amount of
   code.

Crt Mori (2):
  iio: temperature: mlx90632 Add supply regulator to sensor
  dt-bindings: iio: mlx90632 Add supply regulator documentation

 .../iio/temperature/melexis,mlx90632.yaml     |  4 ++
 drivers/iio/temperature/mlx90632.c            | 63 +++++++++++++++++--
 2 files changed, 62 insertions(+), 5 deletions(-)

-- 
2.34.1

