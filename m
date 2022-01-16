Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963AE48F9F5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 01:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiAPARe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 19:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiAPARd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 19:17:33 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84666C061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:17:33 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id q25so550907pfl.8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=i5Ou1yz0idejycfR7awkotrdd+23zegzIC5dA163t+g=;
        b=C5xIzSsYHtbu7OniZp8jIhBTCOP4jfnCYmsCECiOhVGiIQa6rlPxtG9GDijeCLsVc1
         zm2HHKyH99R8KmUFDrIWgBFT5R0DIN20reWU510G6ZE+xVkawmTAbz/mUQrBY0PTRIdb
         ItIuDYKGzuypBSvLhtZAnxNbGy8JEwRfMBHcshnREOWzPsWz7NV8dYV/D/kemuyW7g7K
         KLLOKMvHPDAMM2we0BGAADrswgS9YTTXnwzGJ15vq7LMlnoca8OKukPvrfwKlhHBXUa9
         IdhzZHgUyiwVsiYO8fhwhU0KhZ8c6s66F13uTF28GP9KXRk0GTFHFAlracR3/NbGK/hf
         LzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=i5Ou1yz0idejycfR7awkotrdd+23zegzIC5dA163t+g=;
        b=uacItHF4uRkOaLworYEXqdh8bzss7lHmQKUjCkRPett9+FLeeoW38okv4+L77Gx0W9
         w9xCLq61NMQwJDKzYWsZEXndnaiZDjJ92COrjdGPl5QZHl6yGAuh7YQmTennOI0q0Ylm
         afEj4ZafUQiFOZLYOtt5NLaI5XAER5UNuYPjUaJrJsqSS7d+WtJ1DtawmhiBgrvYV05Q
         giyV502tv1BIurTQ/b73dcm4gyPjtbyp42Xm1/osKHNBrAQ99zT/p8OB0e+LNYUrCkeA
         hnUIAt4dwPpPyya4kI/VV4wLRqXSrqVzhf4Q3WNfqIW2rsjMNMUk4OPLX62jr/nCSpkS
         k3zA==
X-Gm-Message-State: AOAM5315MNmIwsGqQwRJZFcqrAfI4YCmr8eQdY1JjsILTDZKuoISkYVO
        NlInXl2XAMBMZEC9BF1KVq0//lVWnlzQsIBI
X-Google-Smtp-Source: ABdhPJx1T/5+V8yBIGbZNJi6n1OOAef69v3TsxufKcksJI4HtJurA1JQMvyO9xEzoTjOOQoDjeMUzg==
X-Received: by 2002:a63:3c07:: with SMTP id j7mr13313957pga.60.1642292252870;
        Sat, 15 Jan 2022 16:17:32 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id r26sm7661951pgu.65.2022.01.15.16.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 16:17:32 -0800 (PST)
Date:   Sun, 16 Jan 2022 13:17:26 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: pi433: validate min/max bit rate settings
Message-ID: <20220116001726.GA22699@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RF69 chip supports different bit rate settings depending on which frequency
modulation is used. Failing to correctly validate bit rate can lead to a 
silently failure and cause packets not to be read/sent.

This series changes the order in which the rf69 chip is configured and adds
max bit rate validation.

This series depend on these patches as they change the same set of files:

- https://lore.kernel.org/lkml/20220108212728.GA7784@mail.google.com/
- https://lore.kernel.org/lkml/20220114221643.GA7843@mail.google.com/

Paulo Miguel Almeida (3):
  staging: pi433: fix validation for min bit rate supported by the
    device
  staging: pi433: change order in which driver config the rf69 chip
  staging: pi433: validate max bit_rate based on modulation used

 drivers/staging/pi433/pi433_if.c |  8 ++++----
 drivers/staging/pi433/rf69.c     | 14 +++++++++++---
 2 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.25.4

