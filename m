Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292DF50F09D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244479AbiDZGJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244492AbiDZGJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:09:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E543B3E0;
        Mon, 25 Apr 2022 23:05:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so1632779pjf.0;
        Mon, 25 Apr 2022 23:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sveTZihqbtASgG45RmpuX6/+/JP5p6aKyndPd2dvzrk=;
        b=lipHBQT5QDm2zvtDEj95wCCFW/LVcbOVRDa8bm+NF6/vTb7U8h0po5u7vP+FbjaLNb
         fSTO2akyIrAAU8seVxDglthX8/vS5bpBc6P4WZuAYV+MF1yYKdZRBqOo5kUNOBk0scTW
         Ss6dHjTc2sBC6wJCqMH4LW+P2UM/axZTqo+B7ZepZCiB4rHLj8OBu5jABzC/iajaUTZq
         L/oXhaTfwOQ0GAdNpPrgsQV3/J53iatnJgTTEGTGILDdAFvdIjW3FV6VAqh0jVvx0KXm
         qngpJAbXWrP6bbpk0pTsRTBbEEJf36j6CqL1WbXl4YwfEl4cRiGkUE6XwJBJ4jEnSyP5
         VtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sveTZihqbtASgG45RmpuX6/+/JP5p6aKyndPd2dvzrk=;
        b=Q5uILKPElSlZ036s/CozqIt7PaR0uODTnsqUEptASul2pSt7toBIs4K6NhzJql6MR5
         qkBM9hRdDx31X4o0mOmrWUinKp2l4MVS4wQ7geMX3kR4gloFsul2Tu3jeat6NNpJ68ZE
         DSY3+AEA+Csvd1v1/2GAR8qA5CwW3eiuhDlJInoQIrbFiA/JkdsjQWZIfKhqs7M6D2KX
         XkkKiIsuV0B1DVSUPJ0B7XalyjYgBfU0wINQHl9B7y+ZBLDFhSquidZ7JTSo5XbcACXt
         i0JB3n6wT+TtOzkCVnuGvlrmMPwWOGYAGkgZ7GG14OADSFwxNJfdDl2sCUzpxK2d+4AV
         odsw==
X-Gm-Message-State: AOAM533Y0mifInTiRP9AGMli8aDxaakJbSA4iWKDafoNJNXqUi9fH91v
        SJ54C2AePDQTP4MpgLu7jiqEXhg8p6Mh5w==
X-Google-Smtp-Source: ABdhPJx5QtIfmQP8yirGnkQjosr/AQEnKycMr6tP8xcGosUgyInpFNgrJ6eAZwfUGz99HIWGjVHWkw==
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id s7-20020a170902988700b001516e1c7082mr21292705plp.162.1650953157585;
        Mon, 25 Apr 2022 23:05:57 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id k13-20020a056a00134d00b0050a5867dd73sm13969135pfu.157.2022.04.25.23.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 23:05:57 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2 0/3] rpmsg: virtio: fix posseble double free
Date:   Tue, 26 Apr 2022 14:05:33 +0800
Message-Id: <20220426060536.15594-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
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

There are double free in rpmsg_probe() and rpmsg_virtio_add_ctrl_dev().
In addition, rpmsg_virtio_del_ctrl_dev() didn't use correct function
to free the object.

v2:
Use a cover letter to integrate the three patches.
Add comments in rpmsg_probe() and rpmsg_virtio_add_ctrl_dev().


Hangyu Hua (2):
  rpmsg: virtio: fix possible double free in rpmsg_probe()
  rpmsg: virtio: fix possible double free in rpmsg_virtio_add_ctrl_dev()
Arnaud Pouliquen (1):
  rpmsg: virtio: Fix the unregistration of the device rpmsg_ctrl

 drivers/rpmsg/virtio_rpmsg_bus.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.25.1

