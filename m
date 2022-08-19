Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1101959A601
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351090AbiHSTIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351067AbiHSTIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:08:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A98665BE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:08:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e19so4275568pju.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=8WuC3QVNj7mN+gJ3LjT4Cfvi0Qq7SJaLcYxLIkVCB2I=;
        b=boS2jioIR3XnzDYWXFCfhb+LllONe6VH67/GSUWbCeUb9ROSFmyoCi45qHQ2uqfNFl
         RkA7XlSJ4KoJmpr4d2cA3unGM72tJfyemOnWja22v9H5rVKNv/DJZlaK0Fdszjhid6Bk
         LpclbcGGjJO2xvS3oxWcpYdSSIbUg4TWAQCmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=8WuC3QVNj7mN+gJ3LjT4Cfvi0Qq7SJaLcYxLIkVCB2I=;
        b=goDoceWCyxuFvUNe+uYy6Ru94489MzSJR0FiZCaCOchl+q9j+D+KrmY/9Ll6145N91
         sDptB0qs6kHDv69rznryPRW+MR/HqmdUMe5S3sDDPheYa77br7FQ+L04FkySJ9RQGJ5L
         70IDP8d/j7hZraPhaohlFYV6eXGn6uzL83bmQPQS02KLcKvcK8pt4K3K852jtdGl3gfB
         nUoxd7fGX+YVS62cjtl24I3jHbtw07CHnnl/V1+wyofcKro0ZDh7DnCbSFDg8PrLYamJ
         rpyUFWVTcylhLc3XpaaO1nqUlhfKDuUrq2pfhAeOgdIf6Yh5yr+qdRaLzA8SQskvJpb4
         PqEw==
X-Gm-Message-State: ACgBeo0ZgsyBzZIgdWpN0nsScG680k9QsmwmqOuy0Mn1kHOXZoKkkztz
        Bn4awPdmks9i4BU9Qnz6C7FhnQjcXtVuXA==
X-Google-Smtp-Source: AA6agR7dsTtzR9jI8fPkHbcLyi9Kp1fhBb4YYG+GJpFhKXDSjZ84k8gw9vAMssGvEBMGyjOPq9p2/w==
X-Received: by 2002:a17:902:7242:b0:171:398d:9e66 with SMTP id c2-20020a170902724200b00171398d9e66mr8963930pll.19.1660936095903;
        Fri, 19 Aug 2022 12:08:15 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id b14-20020a170903228e00b00172a567d910sm3499775plh.289.2022.08.19.12.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:08:15 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 0/4] platform/chrome: cros_ec_typec: Altmode fixes
Date:   Fri, 19 Aug 2022 19:08:01 +0000
Message-Id: <20220819190807.1275937-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a short series of minor fixes and changes to prepare the
ChromeOS Type-C driver to better support alternate mode drivers.

Prashant Malani (4):
  platform/chrome: cros_ec_typec: Add bit offset for DP VDO
  platform/chrome: cros_ec_typec: Correct alt mode index
  platform/chrome: cros_ec_typec: Stash port driver info
  platform/chrome: cros_ec_typec: Use Type-C driver data

 drivers/platform/chrome/cros_ec_typec.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.37.1.595.g718a3a8f04-goog

