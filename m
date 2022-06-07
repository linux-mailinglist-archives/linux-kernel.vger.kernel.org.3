Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF17853F646
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbiFGGjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbiFGGjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:39:01 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D337BAE268
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 23:39:00 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id cv1so11719751qvb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 23:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=SxS3QrHB7bjwl+Cm4ZFUlHa3N2idkpHOMv8U5Xnf73Y=;
        b=SX73mvZOpIRMFB7v6iPMoemXaeivJ5yImf8A4byTZ5zbcnYsFCMSAIOE59s4U3WoFX
         77U0JVlq7NfmaScdPv2qmylx/EV1xhCw02fboJjuCdBnlTTYFnU9uc7eWiOgxwggj9xV
         wCRdMMiMTj/ht+aQb3yMKWmyvDcbb8EjPfpUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SxS3QrHB7bjwl+Cm4ZFUlHa3N2idkpHOMv8U5Xnf73Y=;
        b=AQs3nENQdP7we0ltJmtwisWyq2YZGcct7P31+pD+rNuNJLdOHJb1lLuhjdQyQlwOgF
         m7Niet8zj5DlWY8Wb7H6Bf7t6RnmVBlqfsugvtFZKL4j7LQmM2mSmuoQBmzehumOMuSz
         slghsoxzGg6XRA6m4/MVBEPmKtP2YCfN0QgTDITyxvQX7YH8zfOm8HPkdiKgPZl+JirR
         L2J6Dnkh7uhE+FZBeb8fs0vbVJjNyzktZwCLVB8GcSqZmpvbtoKKE/VEllHQkjCv1WAx
         zaXuRmYmcwSGwAi+D4idX/4qNI7IBoRa4n9utlBgc516rS4hxj6UhXuOueFv5NlA5pCq
         EHUw==
X-Gm-Message-State: AOAM530ctxUMnnHSBlxvZ/gJ7XGnZbUH7GgZukxtOwQVEqtI1mo9mpQM
        M5bqZyuHMy6FdjuBpefKu2yyJlveipxujCu9w3M5pfT/EeUcdQ==
X-Google-Smtp-Source: ABdhPJx5J8gKc6vZqW/KSZ1HuQd73D+1DY7tBrY+ZzsNyJJkaT9fEJDx2+hggWlO86StbprNLLL0wMkZy4QV2Sr1Fzk=
X-Received: by 2002:a05:6214:20c2:b0:464:41b9:f474 with SMTP id
 2-20020a05621420c200b0046441b9f474mr38034891qve.108.1654583939759; Mon, 06
 Jun 2022 23:38:59 -0700 (PDT)
MIME-Version: 1.0
From:   Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date:   Tue, 7 Jun 2022 08:38:34 +0200
Message-ID: <CAK8fFZ6N_7o0mRP5mAuuMc3Z9s=OzNk8NJZ2FAYDeHWATfZC_A@mail.gmail.com>
Subject: ice: Error setting promisc mode on VSI 6 (rc=-17) @ 5.18.x
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm struggling with broken network connectivity at VMs using linux
bridge at host after update of kernel from 5.17.x to 5.18.x @ Dell
R750 server with E810-XXV NICs.

I noticed the kernel reports "Error setting promisc mode" in dmesg.

# dmesg  | grep 'Error setting promisc'
[   24.863557] ice 0000:31:00.0: Error setting promisc mode on VSI 6 (rc=-17)
[   24.878369] ice 0000:31:00.0: Error setting promisc mode on VSI 6 (rc=-17)
[   25.045834] ice 0000:31:00.0: Error setting promisc mode on VSI 6 (rc=-17)
[   25.129840] ice 0000:b1:00.0: Error setting promisc mode on VSI 6 (rc=-17)
[   25.144440] ice 0000:b1:00.0: Error setting promisc mode on VSI 6 (rc=-17)

# lspci -s 0000:31:00.0
31:00.0 Ethernet controller: Intel Corporation Ethernet Controller
E810-XXV for SFP (rev 02)
# lspci -s 0000:b1:00.0
b1:00.0 Ethernet controller: Intel Corporation Ethernet Controller
E810-XXV for SFP (rev 02)

Could it be a 'ice' driver bug?

Best regards,
Jaroslav Pulhart
