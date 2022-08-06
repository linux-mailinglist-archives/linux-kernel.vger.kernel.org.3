Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A042858B67D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 17:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiHFPbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 11:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiHFPat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 11:30:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540B555A2;
        Sat,  6 Aug 2022 08:30:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so3980089pjm.3;
        Sat, 06 Aug 2022 08:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=+8arIIWrqLYF/o3BEvXU2VnFDak7xMmBm9io4/J2ydI=;
        b=Ei+DYk+axtzU+BsRniNAiMAkkb0ZXgiTjBI8VqSG611UFdINc+MlQhnEVtNYjJlQdb
         OkNRP+jjyfPpd0XIn62pU7JMG+1INaX0sXfoQKbu0d5g9AETw4/vlba29Yd34j/f9aIK
         GnFVNucw1/Gz6D6FojjYQRM4RBmiTZWqR70nMmmeYmnmLOzm3qIxwTeBlEb58zw3rMF8
         9v94OiE7CAxqaScpZKQs6KKMX8N+hoxrc9I7UsSbxtEJ6NhXwCud+c/MPok6PIqTDuKa
         ntwENK78I8HVUOoNjJ1Y91XKP6F2BCwr5Zz/7enZto6IPJ7Xk8SBJ+p3GVnHGpsuxwMr
         HOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=+8arIIWrqLYF/o3BEvXU2VnFDak7xMmBm9io4/J2ydI=;
        b=gKZLNw7YpD5yeUasHq8BGvKdx45rdToGugVnnJosV1LKvoe9VYvj6Z1CW5YhiI+ZR5
         2KewuoFEaaRvLb4XA2fWPQBByeZesYuyIbuQgHBGAuuo3bszykfojw5vjXc/5Ugj3JJN
         eGCbQ3scE3kfiNx2rbst7cTx7FIv+GbqDHBLmmBh9idCMnMJ3mEz0Fv4QuVEd9+o9ek2
         /mEZCXXlWCj+GbqxzG/+KNYtRs9Zcz2kNCbdUiReIZ0kP3jj5BGXPCjeAREdY252tSnB
         7jMXT1lbioe6QEYNOTtsYaQ2dXEKngfMSAF5pf14B46X+f5O04d8NJ8StRWhe5Ryeme3
         Rxsw==
X-Gm-Message-State: ACgBeo0o/olTXSER7Laigr58myOG6gHmPi8bsXXfdspaDooaShilSCDp
        K74A0dIdap/hMTh7k4nhfdo=
X-Google-Smtp-Source: AA6agR7NIZM93vzbTHouHPWJnZ0SIrIbtXc1bim8cgHbTimcvtQtks17T5gmw59L6J2OUwMSeVcfYQ==
X-Received: by 2002:a17:90b:17c5:b0:1f4:f55d:24f3 with SMTP id me5-20020a17090b17c500b001f4f55d24f3mr12870531pjb.109.1659799848776;
        Sat, 06 Aug 2022 08:30:48 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id ds23-20020a17090b08d700b001f3162e4e55sm4867886pjb.35.2022.08.06.08.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 08:30:48 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/1] loop: introduce LO_FLAGS_NO_DEALLOC
Date:   Sat,  6 Aug 2022 23:30:21 +0800
Message-Id: <20220806153022.83748-1-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Hi,

This patch gives userspace ability to prevent underlying file of loop
device to be sparse. Currently, if loop device is 'trimmed'
(BLKDISCARD), then underlying file will always become sparse and disk
space freed. This behaviour is good for thin provisioning but not good
for preallocated disk images. This patch introduces LO_FLAGS_NO_DEALLOC
flag, which will write zeroes to underlying file instead of punching
holes when BLKDISCARD is requested. Thus reducing file fragmentation of
preallocated disk images and improve performance.

I will also submit patches to util-linux to provide userspace support if
this patch is merged.

Changes in V1->V2:
Renamed NODEALLOC to NO_DEALLOC, to avoid confusion between NO_DEALLOC
and NODE_ALLOC. Suggested by Jens Axboe.

Best Regards,
Zhang Boyang 


