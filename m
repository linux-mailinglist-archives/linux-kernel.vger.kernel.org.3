Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CE5534970
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245675AbiEZDqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245127AbiEZDqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:46:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19B7BDA2D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 20:46:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y85-20020a253258000000b0064eaa00a2cbso618362yby.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 20:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pOuhR3Pzar7ge+NX8TBbznCApuMPK+u8nzqtMow3X3w=;
        b=pFtuCq9Ahm+dC/wB/XGsvhVcvqEGv0ncYhOV7eYSKXtiZRQTf/H8Bo6BSHNlckk8MZ
         giClqLGO+gDIF6i9lvSpvUtkDlZs5eNq9Dtl8PTSv97NS10j31WS74RsTNgADrb8S6jI
         cWb7d6f+XSRsn3wRfzLEYt2TGsYEQe8TojWOEk2+XvPI15TrI2TS+fR0ukC42HFlU0pK
         ga1fLXslxACOE+ZDusSSawGhpuwQIN5Uj+U/usag7iGRoMUVgBOUcwZAo41fWFoop1vb
         ZnAf8UMo/ym1VQYCqIRxI+ir1nzmyZ0KrDK6SoopJw8pKQA5RViJ5A+Lqr6wkBNDN/um
         YFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pOuhR3Pzar7ge+NX8TBbznCApuMPK+u8nzqtMow3X3w=;
        b=ij1m33I/zGz2CW+zw/nvwJfFKJC+QcqJb9xR8f05Ca7UBXKhZRT7R/yo/N0h29SWOf
         h9eol17vQtGYdh+l1unfnw0JBvmqJysBSh93M7aH5GKgRGgQRL1dMbwhwBhR9G+4krdr
         C47BWDZCahZUCVwtXk3Z0Kz6KkUEvpNeMNYjSrBo1NOdi8NCYEc5zP92erxpSLQ0aURZ
         Y5/GRmKrLg3LvIPyzpagDPRZrSbdfm7XALP7Sv+2tmiA7x5o5GS7TNYmlHT4JwykW3ly
         YuzAZCKmj65eLsMge5xRIZig+gQNM40GcM65mDandIUcgkoB8msG16Tc/KQ0A+RlDiDh
         v9NQ==
X-Gm-Message-State: AOAM531H5PWo0BMu+4y0gFxTsFeUEHABkMgRZAx4uqC1n1mG2yR8uPKX
        uUZPOfvM53MlI7kOuiJBIHZB/thcLVzK6/U=
X-Google-Smtp-Source: ABdhPJwW5TFihKc5fHoOWh+k/wmtfXHJI7LiYEd2CbsQpL9OfsK+Uu/vuEzg0N01VUgI0MphYYCU7YgT/GtskfQ=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:cbc9:88bf:e847:ab95])
 (user=saravanak job=sendgmr) by 2002:a25:501:0:b0:657:c41:3734 with SMTP id
 1-20020a250501000000b006570c413734mr968289ybf.279.1653536773756; Wed, 25 May
 2022 20:46:13 -0700 (PDT)
Date:   Wed, 25 May 2022 20:46:07 -0700
Message-Id: <20220526034609.480766-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v1 0/2] Fix issues with deferred_probe_timeout being non-zero
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting deferred_probe_timeout to a non-zero default used to cause
issues with NFS rootfs. But the fix for that is causing other problem.
So revert the fix and set the default deferred_probe_timeout back to
zero.

Most of the Cc list if from commit 35a672363ab3. Please let me know if
you want to be removed from future patches related to
deferred_probe_timeout and NFS rootfs issues.

-Saravana

Saravana Kannan (2):
  driver core: Fix wait_for_device_probe() & deferred_probe_timeout
    interaction
  driver core: Set default deferred_probe_timeout back to 0.

 drivers/base/dd.c | 10 ----------
 1 file changed, 10 deletions(-)

-- 
2.36.1.124.g0e6072fb45-goog

