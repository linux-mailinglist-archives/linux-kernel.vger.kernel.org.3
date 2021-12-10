Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D68447093F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245542AbhLJSuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbhLJSuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:50:16 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0399C061746;
        Fri, 10 Dec 2021 10:46:40 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z6so9210960pfe.7;
        Fri, 10 Dec 2021 10:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Dz+OquvZUJo0GA0GX6QGULnhdgKSzj2CeViGnWAWXRQ=;
        b=PFyBSc6UDl8M1kgqSkVWlFCSLXFWLYqd194Yoe6oxbifSNwZ9x7YWKYH2Ir3vL3oiz
         hvnlD4ntAmP9S7gei0HveDQkG4u6FlBE1YP+hhnVbj6xeSpHK/0TU1NGgKgHfl5Efn8b
         c1e6lvxIN07L1YgfUxncaoA0VMz+GIdDT/HiZmbXvuiPti4V1ax+22xY1qn3iu64h5Ep
         GpsuSAmz7o4kx9NxwZmv7ObEVKqx7KPYQOK5cT/MuqgBh0gdU7UJu88brIDBDlD1t3tn
         /6rq/SIqXFpXE7WdHDfnFPoFL74c47Pf2lxlMfzUW2QlcGlraKOrOaRWaulOiaHTMN3F
         1ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dz+OquvZUJo0GA0GX6QGULnhdgKSzj2CeViGnWAWXRQ=;
        b=HEx5fxoW/NaXjxGOTkBlL8D40NCY+k/6k+Jr/QkrPLcg/XzwnleuEgq+t9DzVT2DQL
         KaSFr9D10mDcTy/vQ/EZ0IGTnwFudEd4msvv5h4ITKuYxXihKJP3fS61iUsG4na67Xyg
         7GK9vYQ25RbU8RtLHpqJKP6GUUY4srnx7GExzMF39FPZhmT0CnbZALvOG0RFxb7gDUj8
         s9n2MgwmmDMqXyPDcZ6shQVwLORuFU+cfexzPlsfK7HJTlr/ATGsbw3+KZa9niFvqqPs
         8cnY4HWZc1/dEYmGhvaK3etV/i8nPwoWB3HHKBfN/i0zRPkJBBy/+8MbqUG9ZJ/T1QEN
         rfOA==
X-Gm-Message-State: AOAM530OMta5DF7aXqVmf2b2fv6uORomWritMmoPyBSFdlS+OtBr6+6Y
        NsquGLoSCWdXp8+Y7CdZ6gY=
X-Google-Smtp-Source: ABdhPJxnpNEuElnGEflFQNStQArB0tzYSwC+HeXoDjwwD2MdSXaKQbkR4VHm+kgWae2Dulxqu93Alg==
X-Received: by 2002:a05:6a00:234e:b0:4ae:2e0d:cc68 with SMTP id j14-20020a056a00234e00b004ae2e0dcc68mr19653053pfj.60.1639162000256;
        Fri, 10 Dec 2021 10:46:40 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id w6sm4320334pfu.172.2021.12.10.10.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 10:46:39 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     Christoph Hellwig <hch@lst.de>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), linux-kernel@vger.kernel.org (open list),
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v2 0/1] of: unittest: fix warning on PowerPC frame size warning
Date:   Fri, 10 Dec 2021 13:46:34 -0500
Message-Id: <20211210184636.7273-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -- Fix memory leak (Florian).

v1 -- Original.

Jim Quinlan (1):
  of: unittest: fix warning on PowerPC frame size warning

 drivers/of/unittest.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)


base-commit: c741e49150dbb0c0aebe234389f4aa8b47958fa8
-- 
2.17.1

