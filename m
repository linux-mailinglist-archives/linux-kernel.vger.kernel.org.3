Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A7952D718
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbiESPM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbiESPMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:12:23 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4CDC9EF9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:12:21 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p74so2455126iod.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jdEQHGju4mFfX3gcNSc2YY06HbqmiG/LBfB3okg7Tsk=;
        b=H+M1vvEAY1HUdr4mwKwcMiZ9S4s708i3vBZhoklK8wI4WLWY6GLH5gliSHOpi8GtIm
         QKBY2Kz7DdhAuBOPge1WiowgUkZUDguhSWtucGNZsLC7/wW4F8iixeFzeTQNrBHb8QDR
         +6j+dhbnZViGrQDs8V8P86J4n6AMcabcxvyM4UO97+9SOf11WmwCM8igCdbrdzl6oX9/
         PfvRMpGTvB/E4H9zUxR3qONIQT6jEpwnjugDYY9gfAuSvqZGos+TrTRSezIQrhONjb2o
         76T47GF2ky6ivm//VKPNTw71OP3ttSwYYDkPF2f4JrIgoewx8epSxvsuhvLziiC+PTfP
         e8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jdEQHGju4mFfX3gcNSc2YY06HbqmiG/LBfB3okg7Tsk=;
        b=JRzwJxm0TIczYflki92NrITEs7wLZ1qtgQpy3qW1Psvnp5ZkQs3jIxfIW/G7kpP4+B
         PmIjb9M8PI9k2POgjSBrDOadYA/PhCKzZ6JDxshDAbK2kQLAvJWwtIebew+z95l86Bl0
         wgoMSCnUR6n8UxfcFq9xSmpX473jPLfdDVgTkuij6iqzNSvI2xY3zS951bnmZitfSIDn
         8KuJ8jeuQ88K6G2FMUNZkRlo3CiGKb6XZjSyMzis6bEoEOvLs4EcuxLzN0OBQn5/90hH
         e/xjsbywjVVA43oypFC/TMLyW7rwjlqx495EXzm8MOo30MdjW1ZN4ykf8/jVYRVfp9GR
         6aYg==
X-Gm-Message-State: AOAM531tBPjcyYljpkPIUoUcQR1orBa0Klll+gCStacSW55COTB2dUmf
        4mRxpwSStYW5aQdSnxdT4IlOpg==
X-Google-Smtp-Source: ABdhPJz1AblWlFZFDd4U5+4gFWSoBUgTKLkMZvJTK94tEM0oRQkmEZCPGkhVzClVPww1qaEpg0h0Ig==
X-Received: by 2002:a05:6638:52e:b0:32a:e022:5a9e with SMTP id j14-20020a056638052e00b0032ae0225a9emr3070588jar.60.1652973140943;
        Thu, 19 May 2022 08:12:20 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id g6-20020a025b06000000b0032e271a558csm683887jab.168.2022.05.19.08.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 08:12:20 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/7] net: ipa: a mix of patches
Date:   Thu, 19 May 2022 10:12:10 -0500
Message-Id: <20220519151217.654890-1-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes a mix of things things that are generally
minor.  The first four are sort of unrelated fixes, and summarizing
them here wouldn't be that helpful.

The last three together make it so only the "configuration data" we
need after initialization is saved for later use.  Most such data is
used only during driver initialization.  But endpoint configuration
is needed later, so the last patch saves a copy of that.  Eventually
we'll want to support reconfiguring endpoints at runtime as well,
and this will facilitate that.

					-Alex

Alex Elder (7):
  net: ipa: drop an unneeded transaction reference
  net: ipa: rename a GSI error code
  net: ipa: ignore endianness if there is no header
  net: ipa: open-code ether_setup()
  net: ipa: move endpoint configuration data definitions
  net: ipa: rename a few endpoint config data types
  net: ipa: save a copy of endpoint default config

 drivers/net/ipa/gsi.c          | 16 ++-----
 drivers/net/ipa/gsi_reg.h      |  2 +-
 drivers/net/ipa/ipa_data.h     | 70 ++-------------------------
 drivers/net/ipa/ipa_endpoint.c | 86 +++++++++++++++++-----------------
 drivers/net/ipa/ipa_endpoint.h | 66 +++++++++++++++++++++++++-
 drivers/net/ipa/ipa_modem.c    | 13 +++--
 6 files changed, 128 insertions(+), 125 deletions(-)

-- 
2.32.0

