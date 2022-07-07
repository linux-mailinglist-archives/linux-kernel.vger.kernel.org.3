Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1023956AE70
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbiGGWaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbiGGWaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:30:21 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279E665D5C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:30:21 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b125so14488428qkg.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jw3Qfmu3T45z99OSd3EsU15JM25LaoYd7yNmPKrKK88=;
        b=FOhnmRXS9NL3bEpaOsXAMBkVjpcC47K+YkIorSegkPqV3955JYCXCak9zQs5A4WKBL
         MKFvHRj8NOI81W0zQ8iBeej32OqEeHxhKrliYNuYXJErIEe8W4OpZVNwcZVepivnJ8oW
         tHFJOH5VoDsjhrdxuwxrqTte+9BSf+j1eeyJN8smjaaAek8+9hfTTRHMgsYC/mYr+OYx
         W64vCy3SWfDiTyJfPzYyDd6E566Ykd3h2Aca/pnbUXWmgArSyGQF+Vq7/dwwJUKcwzYa
         9jPKN6sCihez2/4c0MToyT6GegTJker5VEg3mFx5l4z4i0rvUQzfgNmd2NiGxGim42Hx
         F7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jw3Qfmu3T45z99OSd3EsU15JM25LaoYd7yNmPKrKK88=;
        b=xEyI+g0rY+aBGUec/0TgcNsQuWct/HRxK+UAqgWQCEuY5eSPF4cD0dEXx+q4IpfseS
         WMm15sYFeJtWBngbRS3bK/NgHHW6bc48UyQHQCmES53PIt1m8cPtAPNMfcm2OkeRHL5/
         ZDrpny7bRG+hEteFMHJ5DuG88DLmQLm0kb/O+lwyOhUgX6F/9q6IQnidSsvIDOWpl3iK
         GLJw1dGD6j7aUcrAR8zHuAVmP3rzmWzdzkxxiE4BRgllCkL8z/Zu1g/2Qr5LYFesB3qG
         Qi86NKWDki0ZGTDPx1WCURvrB5Zi6t+DBef6qVzYk13Ftp6KiGmpni9F1VIJZjgTLVRx
         0XdA==
X-Gm-Message-State: AJIora8SvNaXdNkHZkVGnQr3YXTvvoCDYHSBArWsNejOkSHx61L5SOsz
        EmDfHoDOUo5mk1GBHey5YHnGz8VWbx6OXw==
X-Google-Smtp-Source: AGRyM1vC9fck9sm08lNxiiaZUV/ztwt7EeO4Xjib0s96dqs+u8o5jSybOIYnTBs3S4UVcRrGf5FF/w==
X-Received: by 2002:a37:ac0f:0:b0:6b4:72de:2432 with SMTP id e15-20020a37ac0f000000b006b472de2432mr166511qkm.699.1657233020300;
        Thu, 07 Jul 2022 15:30:20 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id e22-20020ac84b56000000b0031e9bd3586esm1527747qts.79.2022.07.07.15.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:30:19 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Fred Eckert <Frede@cmslaser.com>
Subject: [PATCH v2 0/2] iio: Implement and utilize register structures for ISA drivers
Date:   Thu,  7 Jul 2022 13:21:23 -0400
Message-Id: <cover.1657213745.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - Rename 'ad' member to 'ssr_ad' to indicate access to Software Strobe
   Register as well; relevant comments updated
 - Dereference DAC channel address via array subscripts in the
   stx104_write_raw() function in order to match rest of code
 - Replace struct cio_dac_reg with direct u16 pointer to the DAC
   address; this greatly simplifies the cio-dac patch

The STX104 and CIO-DAC drivers were updated to use I/O memory accessor
calls such as ioread8()/iowrite8() in previous patch series [1]. This
patch series is a continuation of the effort to improve the code
readability and reduce magic numbers by implementing and utilizing named
register data structures.

[1] https://lore.kernel.org/all/cover.1652201921.git.william.gray@linaro.org/

William Breathitt Gray (2):
  iio: adc: stx104: Implement and utilize register structures
  iio: dac: cio-dac: Cleanup indexing for DAC writes

 drivers/iio/adc/stx104.c  | 74 ++++++++++++++++++++++++++-------------
 drivers/iio/dac/cio-dac.c | 10 +++---
 2 files changed, 55 insertions(+), 29 deletions(-)


base-commit: 338222d8e1121bcb78a86fb39982eddcc367a5bc
-- 
2.36.1

