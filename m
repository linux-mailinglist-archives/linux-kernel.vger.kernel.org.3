Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B163E4FB970
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345370AbiDKKZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345418AbiDKKZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:25:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D5844761
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:21:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so16318069pjk.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qqzor9pjG1TYg9IdQuC1oJUUk90Bi3aWHzEMNZOgNWI=;
        b=GRj2XJmEuxLk9MuNfXIRBqtrYPZlM3M/2wbiZGetnbNVwtKr5R+ul55qIFUxO1UzCP
         jE8ojn/a/ow7SB0XAeheQ9sZ6q+z1I1U6jdjtDvQJJicUSTu72neFcI92SEe9hcdeIxr
         Y5YVns+azOlep1psaVSX8tU7QuUpWk9OPtY6YWHqFQaE6qJI+ZS8pcvfC2AtBURE4I7R
         7Kz01riZEdAS5QlTP3FTBn2rL5fenLNNT78MzxWHLOEhofgD+JG/pLxjxlZTYR9Mt9nv
         CcDCVrwk187XWOtacwyNGWc1dTkgC1SACn8kjlprh1kKIh5XJaxWlvi2ORjCzO3+vdWP
         srog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qqzor9pjG1TYg9IdQuC1oJUUk90Bi3aWHzEMNZOgNWI=;
        b=hQBa63l7UUY7++h7PH34N/vRIS6PSJyPvu0RsOW4NPSEowa6Lv9MUPDhMgDAxo+80i
         Q4brRiwqkNJmthrxQUoXxCJ5IEepVkTb2sA6V0CFkMBkLJmnAVcCcKvi4h8OTO2re+P3
         Euc3Z8HGgALw9VtWbG8TIhdXW9DW/H0ylb2dwvcFLwqKqTDPyjY5VnJHE79LbyGS3uus
         KYhE1TsIWWPMPfKHzTJO5TvFfACVEuwwoOYAF64hxPNU3VbAAiDczEz6G3Hfr3yg+IW6
         X0ox8+MOqN+/7/Huk6Nw7YEEk9fttJOY7yfW7iKs0SPU4i7HkyAfEG7dhVB3Qc9jCcLF
         CVkQ==
X-Gm-Message-State: AOAM530As1rBJCJiyABof9/cXuwHkPaXYCTgGn6/yQZt3/jizcZ4ymyp
        QPkf57VeSIQcFUL6YoSxpr4=
X-Google-Smtp-Source: ABdhPJwMtswdD8i5LKlqTZJu3XXMLQxkxOHfBS/uTn6eZ686k+5+si56IuMF5pcbwT9b2nvBEdG+KA==
X-Received: by 2002:a17:902:e154:b0:158:71b7:ca8 with SMTP id d20-20020a170902e15400b0015871b70ca8mr1851201pla.21.1649672515341;
        Mon, 11 Apr 2022 03:21:55 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:4376:c658:ae1e:1781])
        by smtp.gmail.com with ESMTPSA id z14-20020a17090a170e00b001cb7e69ee5csm4886318pjd.54.2022.04.11.03.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:21:55 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v2 0/7] drop some unnecessary wrappers
Date:   Mon, 11 Apr 2022 15:51:29 +0530
Message-Id: <20220411102136.14937-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop some unnecessary wrappers and update all the references
accordingly.
Tested on Comfast CF-WU810N RTL8188EUS wireless adapter.

v1 -> v2:
Drop the wrapper functions with underscores prefixed.

Vihas Makwana (7):
  staging: r8188eu: drop unnecessary wrapper _rtw_free_cmd_priv
  staging: r8188eu: drop unnecessary wrapper _rtw_init_cmd_priv
  staging: r8188eu: drop unnecessary wrapper _rtw_init_evt_priv
  staging: r8188eu: drop unnecessary wrapper _rtw_init_mlme_priv
  staging: r8188eu: drop unnecessary wrapper _rtw_free_mlme_priv
  staging: r8188eu: drop unnecessary wrapper _rtw_alloc_network
  staging: r8188eu: drop unnecessary wrapper _rtw_dequeue_cmd

 drivers/staging/r8188eu/core/rtw_cmd.c     | 145 +++++++----------
 drivers/staging/r8188eu/core/rtw_mlme.c    | 179 +++++++++------------
 drivers/staging/r8188eu/include/rtw_mlme.h |   4 +-
 3 files changed, 135 insertions(+), 193 deletions(-)

-- 
2.30.2

