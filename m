Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE79573A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbiGMPyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiGMPyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:54:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9AA26130
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:54:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id fd6so14657149edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ni0BZBOFnZlbLlyP3bZ+inMTCHkl9G9i0+j1BNStb2k=;
        b=W/geH3sqmqfcZSQapGue4T5Vl3bSxlitOo5H83sKvuVa9xPX9OsZCVQAUCsxN9EeT/
         +NW6mCjb3CsnImyXFxgGQhwC60JUh/1wZ/UEF9v8y4T+p1rcS/2WKmxQk0lsFT5Wy+jj
         IYBTveTXDxRdivnauMn9LxmYlEafWYslNL2l8g//LEvpB9QtEhR8xKoINgP0WEOU5sKR
         WJT8Z27itU7J0Gix8/oyeMbN8Nlhno96JkIs/SLcAy3xHZLe+IdbOsUuxLw5N37DPtX6
         lsDQvB8V+5H9DgKCub6cK+zUcuRptrBvtw49tNdVOQq50Yib5K+DkTFZUWuUStuX+1oG
         mOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ni0BZBOFnZlbLlyP3bZ+inMTCHkl9G9i0+j1BNStb2k=;
        b=XN6p1VTjT3y2ugS6tg3lJ0gn+TJg00PrKVN7h15IrFLUK5zGp5/7XbLVB9taLAbCue
         hL5s+v0NAlaknnZ86g546gTb/unQ+e1gAw82w6UcoqZRM3ETnvLH8l+NGsBvd4m0ALma
         UDxeFV1b8QvpmaOcDbXW/zNiEKTtx9bKE57ROJL1VWnOzy85TAVdI/uhr+XgV0SegPMF
         l9xVrwkZ2xxG+orzp6hHOXE62N2KDH3DOm/lulsIZgFIUEzZaMBKAuCWfXfOQPwbrOQg
         EYVquItBn5tgPvesRccCRDLtIysPOGCASpxkPaz5ifpz5QAaqesjl8+c2Sv71Ln/byJb
         aaLA==
X-Gm-Message-State: AJIora9aLKp7YbNgAtL1Bg//5e2Fo0whQcNB/DtiCDHXEsGOFHkmLVIG
        IiPd+1Sd/0s3KF3TP6RSmxlWEg8lTSY=
X-Google-Smtp-Source: AGRyM1txgEPpLdPtuWiGHHn3NE3EaCr9RV/3uDuMLbQZji2Zagm1CM7yDQnoV8iToH3dOOJfIhAv8Q==
X-Received: by 2002:a05:6402:3486:b0:43a:9b82:6d8a with SMTP id v6-20020a056402348600b0043a9b826d8amr6086454edc.23.1657727656361;
        Wed, 13 Jul 2022 08:54:16 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id n2-20020a17090695c200b0072b21cab5a5sm5073688ejy.133.2022.07.13.08.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 08:54:16 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 0/2] ucount: Fix and improve atomic_long_inc_below
Date:   Wed, 13 Jul 2022 17:54:03 +0200
Message-Id: <20220713155405.80663-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
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

The series fixes wrong argument type and improves atomic_long_inc_below
by using atomic_long_try_cmpxchg instead of atomic_long_cmpxchg.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>

Uros Bizjak (2):
  ucount: Fix atomic_long_inc_below argument type
  ucount: Use atomic_long_try_cmpxchg in atomic_long_inc_below

 kernel/ucount.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

-- 
2.35.3

