Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDE158362D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 03:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbiG1BMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 21:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiG1BMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 21:12:00 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7901512628;
        Wed, 27 Jul 2022 18:11:59 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c139so633497pfc.2;
        Wed, 27 Jul 2022 18:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujYPF0y3oFZZMdYY8+ib0+t+2yFUQfMg4yTIIJFKcg0=;
        b=Z8gvV24s76gdJ7QhQCkUbk8/ADQXP/8LL74cpScGPdwx94UliOfobmbH33PQKGbGei
         NlQtaRhNy/+1upkfKEadsEtc9iBqQuqB/Vqhkc51DCrWancHqyPr9/mwVrTAz2HcehET
         +7nKr12ElNK219UI48yDwTZbvHoh8oNABy0578ef53T9jQnn40HZIFwaDgI69CW/xkm8
         A0meEwJZIoGC9c1o/BfNIwubvkXWKxKVIR53wO/as8aEiJzPkDcnjCGExqkU7EZoNyBF
         bAUDqPcTNFUw+hjjckBkneJOqGsndgUm8SyA/1+PdcThyhxZXUe0jJGYODsVW5TlRkUM
         PX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujYPF0y3oFZZMdYY8+ib0+t+2yFUQfMg4yTIIJFKcg0=;
        b=0ESyfgnYGC4VZDBsgqfIihC0UhU6Byj7HPQUG0e+lEPZL16RKp1i8oknkYyzI2DHe/
         O7CxcjgEm5MbgTUCVvsPptJs8GHTXyNfbpvm+mGc7pp8l6y4JUON2oFnjP9yZFlbexXa
         vs18g2IvIVlkbSKM/9dwcnTaDADsvuQbPWz9kqb1jq8lz0IFgxtqxVlODnsH6bq4jLNV
         6i4v8UHEt5kwSmsYiyUUsw7AfMlXrJ0Egx/spMqL5p8hW2bTZ2ghKneuUVulVYE/o5y4
         a9ssPy9LG4fbwZmcz+56ZKgv+LYz9I+dF460+EdTotzWc+othD2sKan5sH+tIabLC/pG
         ushg==
X-Gm-Message-State: AJIora/4d58bX3P4odEtEcEcnJDSlRSht0djiBRD0pukbDU3IdVfcX2N
        A82eRh8rh1m5+/T8WskSzWoAmbQdHMpKcQ==
X-Google-Smtp-Source: AGRyM1sFj8hWCt9crl8FHg9a9CNojhkr9VWpLtqVvMeKHzWiOS9x6DxdKx93K+xpfyz/sUXA5Qlz4Q==
X-Received: by 2002:a05:6a00:148d:b0:52b:946:67d2 with SMTP id v13-20020a056a00148d00b0052b094667d2mr24082747pfu.31.1658970718401;
        Wed, 27 Jul 2022 18:11:58 -0700 (PDT)
Received: from localhost.localdomain (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id x194-20020a6286cb000000b0052ad49292f0sm14526215pfd.48.2022.07.27.18.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 18:11:57 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v4 0/2] iio: humidity: hdc100x: add manufacturer and device ID check
Date:   Thu, 28 Jul 2022 00:34:15 +0000
Message-Id: <20220728003417.3083353-1-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch series, we move the callback from probe to probe_new, and add
manufacturer and device ID check for hdc100x driver.

LINK: [v1] https://lore.kernel.org/all/20220722172035.44977-1-potin.lai.pt@gmail.com/
LINK: [v2] https://lore.kernel.org/all/20220727064415.940690-1-potin.lai.pt@gmail.com/
LINK: [v3] https://lore.kernel.org/all/20220727164133.973930-1-potin.lai.pt@gmail.com/

changes v1 --> v2:
- fix typo in commit message
- change to use probe_new
- use device_get_match_data instead of i2c_of_match_device

changes v2 --> v3:
- move probe_new part into a separate patch
- remove unsed variable
- remove redundant checking of matched data

changes v3 --> v4:
- move ID support checking to probe()
- add hdc100x_chip_data pointer into hdc100x_data for accessing in future

Potin Lai (2):
  iio: humidity: hdc100x: switch to probe_new callback
  iio: humidity: hdc100x: add manufacturer and device ID check

 drivers/iio/humidity/hdc100x.c | 74 +++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 14 deletions(-)

-- 
2.31.1

