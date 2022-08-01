Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF065873CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 00:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbiHAWPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 18:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiHAWPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 18:15:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8CF267
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 15:15:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c22so6410736wmr.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=eb3sWwf5IKoZQzOvkPaaI1IVQ2HjKkCnRKRFnGOH6+c=;
        b=KkS9Qo1VRpPLirdZBp9VDugwC30AD643a3KZCtTbTTDZ2iNVscA62kiy0dD3sT/JA+
         7ktfkcoT8qRyRUqJX6hl51/je061gXw/lQ5tQwM9iGVRFUd0gwFkUT3u8oFIo7TZtLjf
         Hzp820QgI96oq4m8izWoEwEeHz+f1SPSAyggY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=eb3sWwf5IKoZQzOvkPaaI1IVQ2HjKkCnRKRFnGOH6+c=;
        b=qJrFNbdmfmiGBT/faBkKD4/mswlZ+lmc1NzromNwUGaH6PqYq8QLt3Ou2+tu2UXxgm
         P6S0vVaPyMqDvqMDDOwMywB9Sgl7effPaIMzZ2rFjL1rPJC1umRp1JEzW2bWhwGEv2/p
         5fAqXRgXBVIdXn8505QM0wJmxJl9P9PQilmY7STZfReaVdhGZhQuQH9KcQac2uMvbslN
         87Mde5/h4mZDbSJDRrp+IK90Xm/QNHHo2F7NPu0FrWHK35d8eOsMds4/8QFDFnWW5J+8
         LaBrLE4sT8WEsmVzAm4wXDxhbR6d1VrdEm94TdXQ7eYLDlGdCHP2JlsvU/JKliDgWO0n
         iOww==
X-Gm-Message-State: AJIora/ft+BVd4314FiY8621Q2qQkzAdtD+Rk36SJiPBEiKQWJQVIEnx
        idLpk2s4euqqbvaBR4WpR8SwB+FcYilkVMrVlWZphOVLMU8=
X-Google-Smtp-Source: AGRyM1uQtrzzjUTojOce9U1oX4IsLxvEDUtIv9q2DYoehp2Cz8DNp/0ZgjDCAXuc2VNtxvwbNE2CcUP0j7S41z9MIjg=
X-Received: by 2002:a05:600c:3b29:b0:3a3:1fa6:768 with SMTP id
 m41-20020a05600c3b2900b003a31fa60768mr12078307wms.193.1659392110731; Mon, 01
 Aug 2022 15:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <202207301713.q4988FIe-lkp@intel.com> <20220801152612.3064269-1-jrosenth@chromium.org>
In-Reply-To: <20220801152612.3064269-1-jrosenth@chromium.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Mon, 1 Aug 2022 15:14:58 -0700
Message-ID: <CAODwPW-eQ-dYvfCGZ13tOzh4gPdLU9ZoFg9joWpRTX22OXa4Ow@mail.gmail.com>
Subject: Re: [PATCH v5] firmware: google: Implement cbmem in sysfs driver
To:     Jack Rosenthal <jrosenth@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Julius Werner <jwerner@chromium.org>
