Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F545449D9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242319AbiFILTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbiFILTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:19:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582E734BAB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:19:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r123-20020a1c2b81000000b0039c1439c33cso12421979wmr.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqMs3a5YintB0gVdU2B3xyiVVe9JXV55Eno0UBh+s+0=;
        b=v7+74RRAbyju487rK4ntR27tiHtCsewTc/zp5hlgHR3kJcOJnCNRWY5VFBd9G/K6Wz
         D1TjizVKFmdemSS28zrviDlHkf4azNLJjsrHE9wOsKtrneN11Qpca/bFltFZLSzBMMrm
         TREmJFHSjwRwbFSQfpKIFI7SjddVQOWjpMWFe9pBsZWVQbg+kGWFDyGGghEotOKt2P4Y
         SAYviRvOAWEZddl5Cha1N4GCPKN372GcbKgCiau2Ai2A80QfwJdgR2OdD93STz3DwgH+
         NGDocMYB/8afYFTP3XQJms6YL4ADQfQ1digdSdAYi/wPbZ/G6OZjETxOM+iaS33aXteF
         osHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PqMs3a5YintB0gVdU2B3xyiVVe9JXV55Eno0UBh+s+0=;
        b=b6gu7M0X5XDEKPMpqIcOkLv81bL3T/1oYoOaJSWsUTC+tUHmdurn7aHG2ynOx2oDmC
         iyjBzaxwHqDgL1b5YXG4MV5348hRqRKUMNRUKmRkGnXCpdfjN3vIZJ7nRd7gut/GSg6F
         znTsi1MzwQ9aVotaZIOXzRFz0yPrI+k5F7KOHA0FSP2XcaN28d6g5vIYzEE6dOOlvpOG
         pVU+aE8tvi8dy2J4pxTH6gwAsdWrrJjGbzzjpMSUAofNdAZYp1fJpsE6DYVO0SQqo986
         QaHgVxlfaAX4POrCI+S5jxAnPVXg7k7IjVm2fy/FiPfX9NwQU7W5aVGlVJBp8ktKCgSf
         AT9A==
X-Gm-Message-State: AOAM532vlmrKSC9Xv17JCXYTnzevFoyNPg9gh1thEBTSkfXjvrHpgew+
        XBXDENF+7AZ1H8r2pOt4YEXRbA==
X-Google-Smtp-Source: ABdhPJxeAaHpJ6zWscdJmwG7nQ9B4mr0a9rMgXVUoFV3ix4rZgEznulAJ6Mf1aChGhdcn90NgSZDvg==
X-Received: by 2002:a05:600c:3386:b0:39c:5b81:af9e with SMTP id o6-20020a05600c338600b0039c5b81af9emr2826341wmp.2.1654773549938;
        Thu, 09 Jun 2022 04:19:09 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id o22-20020a1c7516000000b003942a244ed1sm26477850wmc.22.2022.06.09.04.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:19:09 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] ASoC: codecs: qualcomm move gain to S8_TLV
Date:   Thu,  9 Jun 2022 12:18:59 +0100
Message-Id: <20220609111901.318047-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all the digital and IIR gains form using SX_TLV to S8_TLV,
these gains are actually 8 bit gains with 7th signed bit and
ranges from -84dB to +40dB

Tested on DB410c with Headset playback

Thanks,
Srini

Srinivas Kandagatla (2):
  ASoC: codecs: msm8916-wcd-digital: move gains from SX_TLV to S8_TLV
  ASoC: codecs: wcd9335: move gains from SX_TLV to S8_TLV

 sound/soc/codecs/msm8916-wcd-digital.c | 46 +++++++--------
 sound/soc/codecs/wcd9335.c             | 81 ++++++++++++--------------
 2 files changed, 59 insertions(+), 68 deletions(-)

-- 
2.25.1

