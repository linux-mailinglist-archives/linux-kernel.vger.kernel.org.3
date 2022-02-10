Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EC54B0A63
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbiBJKQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:16:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbiBJKQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:16:30 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89ADCEF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:16:31 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id k25so14047654ejp.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cqd+nHAtyHPX1TFwEse8byzK8ys5i5RMjcpqTUGLpbY=;
        b=ZzQq1zGYJdLFyrdECQKUokfzSmpV8AqALMPLO487lPqoVwtNE3ikjy6gqgwnwpJ+xU
         dlmywpWlofAFYfYsu6oGnCUuSX/BKLw+aDeW8YK7gZqUfz8So29y1bznaQA4VtrNAZcA
         9yXqneAa99/xv4+GK3e59lboF7swv/mALq4i91wXZqGS4itER6DavxIQG0VjOEYPGavD
         peWfE52Wm4urJbKxbSk+M55S03CC/7ton5MYmIdQa0qFKwuety67toEnOLBCFD8ZdHHA
         Py4jsMsW7Dqi7DJLvhPgOaAfbEksUOqlw2sCAgzSac852Mt888jxrXQwMe5dtjXA1uCz
         VA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cqd+nHAtyHPX1TFwEse8byzK8ys5i5RMjcpqTUGLpbY=;
        b=KW1Wb01+Tox6IIAbYpd2Q3+bDAnfebN60xKEt1ksbUVAWHnQDkHVX5sDZ5WyxNqNX3
         oOwVyRjc/OWWETH3pO3Vv2VZEReoUu9uItyvF8SqcNMIa/wrk7gflMsnJKhvnMbHq7iL
         r2/IErL4nLJ/OKnm/7eylcD97kp28sjrfQmS80JnOz30qMQhbnIVLB+hkOGXkvAgftmX
         JzlkqpfOAZHNkNBFqHn+v+rrfhfL3oar0FLxaodpEvIORSt/o1wUcwJs7l39TUHxX+Lk
         4AVVgd7LXq3do2281Rl+aAo43NZdoFUMVOuclReVgpSkV+oQynvT9CAPVTS2+dGiv+pN
         K7FA==
X-Gm-Message-State: AOAM531R0SpiXXquw58Fpc7jGBQwEVW6dsn8p/VTZnXEOLNcBxVFSCB9
        sMvfFrEatD6vp4/rCQUB/73hktxGL9M=
X-Google-Smtp-Source: ABdhPJw6GGKIy6Xla66jzDmfg+MfJVxsugVCLGL94ScZSCChCbM/0W0cOwAyiwMYiLv6ofnO+/QFcw==
X-Received: by 2002:a17:907:d01:: with SMTP id gn1mr5853708ejc.507.1644488190439;
        Thu, 10 Feb 2022 02:16:30 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id i9sm7994855eda.35.2022.02.10.02.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 02:16:30 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 0/2] staging: r8188eu: clean up ieee80211.h
Date:   Thu, 10 Feb 2022 11:16:21 +0100
Message-Id: <20220210101623.13758-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set removes unused structs and enums from the ieee80211.h header.

v2:
Fixed a typo in the commit message of patch 1/2.
strutures -> structures

Michael Straube (2):
  staging: r8188eu: remove unused structs from ieee80211.h
  staging: r8188eu: remove unused enums from ieee80211.h

 drivers/staging/r8188eu/include/ieee80211.h | 266 --------------------
 1 file changed, 266 deletions(-)

-- 
2.35.1

