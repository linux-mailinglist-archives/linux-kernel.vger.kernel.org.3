Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1B1481BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 12:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbhL3LcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 06:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhL3LcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 06:32:09 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A220DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 03:32:09 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id f138so22329155qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 03:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xz9wQgVFaOyvwZSGL/SXwsOeqxcneFSh8VrphgAkOqA=;
        b=oLmztMoulnp8cgFl7flECDJjqpl7wy1OssjGEqmxxdhM0dn8QTiy6mBZQxXn5sSgh2
         EPxtFZDcDlwyqpsJFeMfdUYSjUKteu0nIa9RrYdTkoLNUR5tg7TA/5mw2wJ80HrJyvYO
         tcUWlGuuTSWazSSSf+Dr+wpcelJ2tzrzarYv9mS7QJEFrLzoPj8h3CNyrs6ryicbBVkz
         yZ28lMgpLexnN+aBrWfyaHPBJ6M+LhHq2hedYNpMtCEinIdA8+BN/gbyD91q9rnuNgWt
         MdNJXl1im7gvMaKXCDnfiOhuDgiwgzGuVglJqt3mU4WUggix4cCN9CN+h2Pq3ulQozXM
         zCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xz9wQgVFaOyvwZSGL/SXwsOeqxcneFSh8VrphgAkOqA=;
        b=1VlPlaj2eSnoUCyV4sWudBvWhn2mYwULWb4qoQILBUiK/qRSjqTdC6rkeFnnWOX0kT
         0YYFsTroETtJHSCLzOzaSNBJ3HcSTMgLNAtshPab7eJ5Fvz4ag0V/md4c9TI3IhO49fz
         onFOwFYYiEScn2nNAkF43ZmutcR/x/jdm+VVcUMansWW6iBBE0oOVcNCgJwFdF+IwaxP
         +RA3dAPh5kbYKawkpL70GheBnC3edDrUYCLP6+1uZFGhMjbzAsOIbNXFeKfldW8ugeoc
         FAuhH71vBlod2rhBhXIN7vzw/ucybVd8EAH42+n1U0ZJeyQ6f0Tf2g8wfS3ps0oR5KiM
         ICcQ==
X-Gm-Message-State: AOAM532z7bqtALeDdAv4ahGqsCGdILYviWoCFmKhRUalZEEsOGw7LK9D
        L4Lex+idheQdNEx4NRRaHzs=
X-Google-Smtp-Source: ABdhPJwvSVUosC04j83BLB3MFg/6DOg4p/GiNncYIT7N60+th9yGaj2v6JlgxzJRehd+qfqLM2RtTw==
X-Received: by 2002:a05:620a:4305:: with SMTP id u5mr20944784qko.577.1640863928191;
        Thu, 30 Dec 2021 03:32:08 -0800 (PST)
Received: from localhost.localdomain ([181.23.70.139])
        by smtp.gmail.com with ESMTPSA id v5sm20348559qkp.126.2021.12.30.03.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 03:32:07 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gascoar@gmail.com
Subject: [PATCH v2 0/3] staging: vc04_services: avoid the use of typedef for function pointers
Date:   Thu, 30 Dec 2021 08:31:23 -0300
Message-Id: <cover.1640776340.git.gascoar@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set removes some typedefs for function pointers in vc04_services.

v1 -> v2:

- Following Greg suggestion, functions pointers were not renamed making patches
  1 and 2 much smaller.
- Function pointers in vchiq-mmal were not touched as the result is less
  readable than the original.
- In the description of changes in the TODO file, it was specified that there
  are no current 'struct typedefs' left inside vc04_servivces. 
- The name of the particular subsystem of vc04_services was included in the
  title of each commit.

Gaston Gonzalez (3):
  staging: vc04_services: bcm2835-audio: avoid the use of typedef for
    function pointers
  staging: vc04_services: bcm2835-camera: avoid the use of typedef for
    function pointers
  staging: vc04_services: update TODO file

 .../staging/vc04_services/bcm2835-audio/bcm2835.c    | 12 +++---------
 .../staging/vc04_services/bcm2835-camera/controls.c  | 10 ++--------
 drivers/staging/vc04_services/interface/TODO         |  8 ++------
 3 files changed, 7 insertions(+), 23 deletions(-)

-- 
2.34.1

