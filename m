Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09971549B06
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244466AbiFMSDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244032AbiFMSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:02:20 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849D8CE4;
        Mon, 13 Jun 2022 06:45:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o8so7216222wro.3;
        Mon, 13 Jun 2022 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqt6o5xeA7H2Z1sbf12TbkTBeucsVcaM2qYUUouRmsE=;
        b=nS9MOmChlPbvpzLEPXlBOJ9l5totUFJHG+Rb7e/yt17MKC539uvdcUKKT+akKIaQMy
         da9YJJ2RrGTR/FsX3jGTUxHgzV1h/hIb305oQC38lU16BOPknTF51+/tm1MWj62vIowR
         8H7iUnn6Vsopad+WQDoK7JA8MXva+YVmVWRjXpBlOW1zZ93GdFN3hpWwVCYzYuct1d6+
         6ZEpssKwvRVe79wXh7ZyZ+bEoh0A9+VlLP3plXij6I7SaqN2wUNXze1eoav/KBrS+UEQ
         LzIxVzxU8wxwF4LbHN2EdCsCcE52dW5ti69bRxVTTktlzl+gsZU4N28hYqJzHMvqK8ix
         opEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqt6o5xeA7H2Z1sbf12TbkTBeucsVcaM2qYUUouRmsE=;
        b=j5611nlTnygxbaj4QdE728aNWkKZwpiUsVbjws7d/WNTpYQHaqf8M7fLh697iXU9tX
         uAfJ8AAsUouXC9/8Yh7GyVrxlkauZQ3/VOCtSjYuRppLIsHnvvnIFKLhpSzdiAy/HE25
         pGAm8Ww+QuPVoUFwpWYPHopzspReMQB9TRyuZ/I0HUp7Tmc5j/fM9OxvQc2K8Xl5Uhpz
         EGfXVMxNgI6qhZBk3YApiFKp6TXLM/h7bI6Lt1v5jQokWGZLPX0td7o5MfPg7AqOKtVi
         5yj8D6p+yqcBAPLHYGB9O8xuYUmcuC0AuAIfeVUG+smVMXKGh5o930xYcDmLHhUUghmm
         lV8A==
X-Gm-Message-State: AOAM5311u/TppQkg4aqJWcgm7kCTsbwmuD1mniygEmY7eoesaJo6RXp6
        YLBezIJ5O0s5AMNmALYAQCc=
X-Google-Smtp-Source: ABdhPJx8Zhg/1/+HyFqPEsxzGt+S2hzJPy+bosUdcRdorVNuXH9/fl9Gvu8Yx9FJrQtB2xcnxBaAQA==
X-Received: by 2002:a5d:584d:0:b0:216:a2a9:5f2c with SMTP id i13-20020a5d584d000000b00216a2a95f2cmr47600441wrf.184.1655127910879;
        Mon, 13 Jun 2022 06:45:10 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id i1-20020a5d5221000000b002103aebe8absm8647510wra.93.2022.06.13.06.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 06:45:10 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 0/5] PM / devfreq: Various Fixes to cpufreq based passive governor
Date:   Mon, 13 Jun 2022 15:42:08 +0200
Message-Id: <20220613134213.8904-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
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

While developing a krait cache scaling devfreq driver I encounter tons
of panics and errors with using the new cpufreq passive governor
functions. While the krait cache scaling is still WIP and required some
testing I would like to push all the fixes to make the new
implementation wroking since currently with a the governor
PROBE_DEFERRing all sort of things happen from kernel panic from invalid
address access to freq_table getting corrupted.

With the following fixes my WIP driver works correctly without any
warning/problems. 

v2:
- Fix wrong list_for_each_entry reported by Dan Carpenter

Christian 'Ansuel' Marangi (5):
  PM / devfreq: Fix cpufreq passive unregister erroring on PROBE_DEFER
  PM / devfreq: Fix kernel warning with cpufreq passive register fail
  PM / devfreq: Fix kernel panic with cpu based scaling to passive gov
  PM / devfreq: Rework freq_table to be local to devfreq struct
  PM / devfreq: Mute warning on governor PROBE_DEFER

 drivers/devfreq/devfreq.c          | 75 ++++++++++++++----------------
 drivers/devfreq/governor_passive.c | 39 ++++++----------
 include/linux/devfreq.h            |  4 ++
 3 files changed, 53 insertions(+), 65 deletions(-)

-- 
2.36.1

