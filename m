Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BC34BF94E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiBVN3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiBVN3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:29:09 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0EF939EF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:28:44 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E25AF4004D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645536522;
        bh=syQJnDJvIk7oDut501097JANOAQimJJ8XX+nOUPJjUo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=SpwWIDK079KsZengzmEv7Z0tWqAsfgDccqZg/evf9Aep7QIQA6kKGZJ9qo9IMKUyL
         ceIhsXdXVYbxsIvN28bBnyZQXkvvIYOmRSYWVZEwYWHQ5ipWWv2Tjpx1ecsjQHu2mi
         VYexBbTwFXCi0Lz07FCHf3Ad2dHa/GjqWPOfODFikl7DHKj3y4OPkOQpFNxsdg2vqE
         98wf7OMaNV26+zIxuFIzlICNTdIK0SW1ko7zuseztlVf2l265XqAOOYM/x5nu+gtkk
         sFjnZBZdDw9OkkF2izQCFkTRRd4RnuzfC9MS/01Mmz1GgCfP0mGxo8xqZDnBDHnp25
         dUHc22fReuncA==
Received: by mail-ed1-f72.google.com with SMTP id r9-20020a05640251c900b00412d54ea618so6220854edd.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:28:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=syQJnDJvIk7oDut501097JANOAQimJJ8XX+nOUPJjUo=;
        b=BrrcG8RermHVqHKhEHghmXehVOPsUxvU+eugboSIe9TNiwSRw/NbJMYhS+WUTsmcKH
         bsPqRyb8A8F+DGtBzz9mffAunBGe4JgECFos7updwQKyScarZ/SZ9X8j7MB1Dn2Fh5ms
         lwvnBohIriXeCCttw8ykpTvNJjhyTJiVAKomdHW9HygsLQIY5YnYBsJ2vfTamjNmSW/X
         aPsAlkOySF5IdG2juf1gn+bDXm0Fr9ya7p3c1Ki5l+xXahsE7yryLMBBcUJJIGZkmKbX
         JI45w3TiTff3RGwES/v6p8o9FcXQY/ptjUq+jyN4m57Pc7MlmRyddSLCdDUqXI0m8+9Q
         o7DA==
X-Gm-Message-State: AOAM533J8Rg7aeNtlvqN1HmrLrBW7KGjLZjad4wF+uAE/I/s2z1enJNG
        jM45YANGxo9mbVzFakKFNmYwGiOcBBiwdcZuFNhErf5QAG1nYbpkkxAO7g7Kz6wmdZVTu5wJe01
        cpJoTxHT9vGCcZVvEtBx31URqb0Ge8OrmcFZpp8OxCQ==
X-Received: by 2002:a17:906:d935:b0:6cc:fcfc:c286 with SMTP id rn21-20020a170906d93500b006ccfcfcc286mr19267967ejb.423.1645536520192;
        Tue, 22 Feb 2022 05:28:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzyrFfwlMx3wyhaWOiWMYUuCZ2Sd0V6lJlo9wHP9II92B5eFvZo3+bHsg4+GgnT5+leTtK+fA==
X-Received: by 2002:a17:906:d935:b0:6cc:fcfc:c286 with SMTP id rn21-20020a170906d93500b006ccfcfcc286mr19267945ejb.423.1645536520030;
        Tue, 22 Feb 2022 05:28:40 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id c5sm10029875edk.43.2022.02.22.05.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:28:39 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [RFT PATCH 0/3] Fix kfree() of const memory on setting driver_override
Date:   Tue, 22 Feb 2022 14:27:04 +0100
Message-Id: <20220222132707.266883-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Drivers still seem to use driver_override incorrectly. Perhaps my old
patch makes sense now?
https://lore.kernel.org/all/1550484960-2392-3-git-send-email-krzk@kernel.org/

Not tested - please review and test (e.g. by writing to dirver_override
sysfs entry with KASAN enabled).

Dependencies
============
Patches are independent.

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  clk: imx: scu: fix kfree() of const memory on setting driver_override
  slimbus: qcom-ngd: fix kfree() of const memory on setting
    driver_override
  rpmsg: fix kfree() of const memory on setting driver_override

 drivers/clk/imx/clk-scu.c       |  6 +++++-
 drivers/rpmsg/rpmsg_internal.h  | 12 ++++++++++--
 drivers/rpmsg/rpmsg_ns.c        | 13 +++++++++++--
 drivers/slimbus/qcom-ngd-ctrl.c |  9 ++++++++-
 4 files changed, 34 insertions(+), 6 deletions(-)

-- 
2.32.0

