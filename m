Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665A34E6BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357265AbiCYB2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiCYB2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:28:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7B338B5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 18:26:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso6842053pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 18:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=kDqEP6aDD5Du5ulkc6a/EOpkikoDcUeEzxuVegbRcCk=;
        b=QprjuaUFa5wDLToDY98ugPszdIAFMohzq9ShkuRFlIu/NHlmG3ykb/5ZrfInVVboqv
         UO6a9yDnyCN1q0V8N18QkINnKC6LYaycevHjY32d6jWY0rQNVfGs4OnIakKIHS7pwvKU
         h5UnOfvt5FVDBqEmLb1Fz5FBQPYd0Bijm5LJfMA5ZmGAutZrTCyV9I6oiPDuHVgBPJYO
         6wT0VXghRFSoAUAbxAKRN/OLATyhml+becMUssY9fsvRHyX62FkM9eCCEP+JbeQ7EF5E
         zbpAd/qNRudrDmrP/uuI5YetXGjLjNDmTLXQ6TPulyCs03N+5PnVN3/XefryoY8V0MOj
         /eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kDqEP6aDD5Du5ulkc6a/EOpkikoDcUeEzxuVegbRcCk=;
        b=NFZP4YduLVll/hR2nf5FibC+qVw/VycZKxsMZyP9beZINzewtK5bTFJi8nr04JdC+W
         PBkdOV6O9zIavZ81iEEL08QfYes2zJfW4AAswQHGBqjxuNbqzpQibL0XFRUhJkPCHVNt
         EaLQmUfqLZpT0e+P0QUhXb0x2pz7cJlUPcTXOKfMWnHYvRs4RxQ00bYvL6SvVkr4k21i
         f9ABEx161tm/lOd5dElTuUkyKkEftY9A9w9YGcS3CKKOS8+JP6gKS/fQdgyd6pUgwzQT
         e1TCYn4mt72CPQM6wIECz6WjQEWE39xE+fHoPn/dW+g/+fh+AOXRWTP6sX5dnQEp3mWP
         HrsQ==
X-Gm-Message-State: AOAM530adwdJz5OZ/4bRpgkwRaY9fbgrtDUjFl+U9WwnXlwKIhCWwa5c
        9m5CtadyAYqp6sGysRHQ4aE=
X-Google-Smtp-Source: ABdhPJwJLaq8/68FSVdqmJO7a0AlbtMyAZLZYwIaDMGIeklUM4fs5J/4FsXM7DGaENKF0r1QQlXDrA==
X-Received: by 2002:a17:902:9008:b0:14f:b1f9:5271 with SMTP id a8-20020a170902900800b0014fb1f95271mr8768102plp.86.1648171589319;
        Thu, 24 Mar 2022 18:26:29 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:56a:d674:140:d261:4ff3:2835])
        by smtp.gmail.com with ESMTPSA id oj16-20020a17090b4d9000b001c709bca712sm11729204pjb.29.2022.03.24.18.26.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Mar 2022 18:26:28 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, lucas_tsai@richtek.com,
        linux-kernel@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH 0/2] Fix rt4831 regulator active_discharge and bypass
Date:   Fri, 25 Mar 2022 09:26:15 +0800
Message-Id: <1648171577-9663-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch series is to fix rt4831 regulator set/get active_discharge and bypass

ChiYuan Huang (2):
  regulator: rt4831: Add bypass mask to fix set_bypass API work
  regulator: rt4831: Add active_discharge_on to fix discharge API

 drivers/regulator/rt4831-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.7.4

