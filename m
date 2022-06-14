Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D38D54BE8A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiFOAD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiFOADz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:03:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DF8186CF;
        Tue, 14 Jun 2022 17:03:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so227657wms.5;
        Tue, 14 Jun 2022 17:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xRGhX1G1JiDmmsUwG6ZMtfqSCm+v9on5hrKocMWvgE=;
        b=Uy+w2DJZyhIqOcHta1SYjcM+SjaXRF4/pYuetf7JhRv3KJKgS0MBn0EpYY/ed3ptxr
         SCwf57bAMDY8ZkqkDb/+Sn5cv6R5aPC27Beptil9R4V3MeFP0+v1T4/4T3UL2G701CXB
         BWGUXdIHzCfL9uBoUbFTmZDGneJ9TeXBm+fTSKooZZokOZWeRZvCdlY8Ie27PPNYUY2t
         aD1UyDRceoYt/eWOyHNMAIyWGi6YlrjXAqK2KGlFTn4KiGXjSr/2KsrBvIAmPIarUvmm
         wpoBThxQXXoySO8gMQ9w3cxWTNZCxE5xv7ZjBR3a1VGFN7vlH5xVnY5Z0bXGpOMecPbQ
         FUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xRGhX1G1JiDmmsUwG6ZMtfqSCm+v9on5hrKocMWvgE=;
        b=bFEUkVGMaBa4yMWVow2p4GXzGnL5V++twkS0WJC7tT2ss6f0B/ky0c4Lkzza1tiOwg
         UFLyiTR5vLKEra0Aruatbk2tM255x9yDWG5VRYLBvEzMad5O6hQolnGTVS56XtPx7vkW
         jTkPy6u1i8AokIUEyDq40E1igU6YbpyQFyGsbxBhRzgqb8SX1lpBSnj87bnOzI19tz90
         fesZJ3FtubPCkcTcbVMM7sh/cnOKoBTqwLBt9h7u/SIIfcWnd76GtwhxWj4E8wWSTW1+
         BrdOpfMgrRdk2E0uXOwkU7i8fCNvF/v75s6YltxKNJd/ixixGU2Cy9sF9J79+fKOeEba
         i1YA==
X-Gm-Message-State: AOAM530LLOribAcoie+yu9Gl8M0CFqd96yLE53o6OBSPaPz8VvXZjl1/
        1kvMsu7VI7bRYqGdzvrd31Y=
X-Google-Smtp-Source: ABdhPJwAh18CRP2MSxURbOqVtBqj1KuvTxrbncFvt329FduIB/QBh4H2mUPqgozUAM2+J6bN2SyoQQ==
X-Received: by 2002:a7b:c1d4:0:b0:39c:4176:6a16 with SMTP id a20-20020a7bc1d4000000b0039c41766a16mr6831431wmj.8.1655251432058;
        Tue, 14 Jun 2022 17:03:52 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id l7-20020a05600c4f0700b00397342e3830sm5546821wmq.0.2022.06.14.17.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 17:03:51 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v4 0/4] PM / devfreq: Various Fixes to cpufreq based passive governor
Date:   Wed, 15 Jun 2022 01:09:46 +0200
Message-Id: <20220614230950.426-1-ansuelsmth@gmail.com>
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

v4:
- Fix error with dev_err_probe
- Move cpu_parent_data deletion to dedicated function
- Drop PM / devfreq: Fix kernel panic with cpu based scaling
 to passive gov (merged)
v3:
- Fix compilation error for list_for_each_entry_safe (i'm stupid -.-''')
v2:
- Fix wrong list_for_each_entry reported by Dan Carpenter

Christian 'Ansuel' Marangi (4):
  PM / devfreq: Fix cpufreq passive unregister erroring on PROBE_DEFER
  PM / devfreq: Fix kernel warning with cpufreq passive register fail
  PM / devfreq: Rework freq_table to be local to devfreq struct
  PM / devfreq: Mute warning on governor PROBE_DEFER

 drivers/devfreq/devfreq.c          | 76 +++++++++++++++---------------
 drivers/devfreq/governor_passive.c | 54 ++++++++++-----------
 include/linux/devfreq.h            |  4 ++
 3 files changed, 65 insertions(+), 69 deletions(-)

-- 
2.36.1

