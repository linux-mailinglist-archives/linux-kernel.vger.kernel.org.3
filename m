Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486D348592D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 20:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243532AbiAET2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 14:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243475AbiAET20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:28:26 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821D4C061212
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 11:28:26 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id b1so354939ilj.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 11:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=qnPSvaXhWMxjQ74hplnccXSTlLN2N/ubhChG+ptPHa4=;
        b=jyxD1uHRxTRV4QDq1nDmGvyqfJG1PLzoDjLEwIYlT3VUa7zaSGva6Rp2XLIl0AMheQ
         MdPtEyYKcUYJz3C7VE6RGTZn42V2TuumBrslFnXgcght/Q9ECdaapoTupAhoioXRAipq
         +zzlFmMbErr5KzdrW61Mcx2l/o6IkTILvnWMRowxXeFtf9rrafdHiCTo1E9U3TcJGKvv
         9VmwILazCy7g0Tp0y7bf2jvhgVgMhwb7/maMuQxxjPXg3+YyUbICXlTGp35OCgajFk6N
         A2Bywzo15hHzIu4pc7GacaAPjQF4ix91W95klNkv0uMba0MmLsWqMTYzN3q+krGsL/zz
         tOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=qnPSvaXhWMxjQ74hplnccXSTlLN2N/ubhChG+ptPHa4=;
        b=ZxhTd7hEJBTYZaJUcX1srr7u8vt8MapF+SX0s43qvEOkfC/PNic3RLf32T3y+prIte
         k6Y/zUGYai30Cf3Qh91e5vT7ixzZWNgyw6IriTSnE5bDYQgQ//Dw163IjXEXtcTvgj2t
         jtKhObbOkwpGU96pz+lfaIFvroGrEtipKkkARUAz+PVxptlZFAQD4rM9J7AB9Om3d7AY
         2qMnHn7Tlqjf1/3Al10SSsWf5ZkeDTijoBiLrdBMro2MpVEP6L+Sp8zIvNYqP6lYkNXh
         UXJb32Fj9a0DTV8He0ZurAxiUzaYY8Igzzok+ONik1v/PIM1r34aZU1Xq0Y+h2dqNwoK
         vgOA==
X-Gm-Message-State: AOAM531XdKNZ8H21++M8IkfSUOOvh/S69hFP58KD1USbctdMuL8DasC5
        KuXrQeCoJpr27j6Xjg5E0gNedjYsuxv+SA==
X-Google-Smtp-Source: ABdhPJy/IvlhNzu0sViPTQcIz68vdHn2MySBd9y7zXAI/yXlMFQN1L+qOTP4sM4ICSmA7u7RUFEuLQ==
X-Received: by 2002:a05:6e02:1aa3:: with SMTP id l3mr26680283ilv.251.1641410905465;
        Wed, 05 Jan 2022 11:28:25 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x5sm229481iov.32.2022.01.05.11.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 11:28:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jack Wang <jinpu.wang@ionos.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20220104162947.1320936-1-gregkh@linuxfoundation.org>
References: <20220104162947.1320936-1-gregkh@linuxfoundation.org>
Subject: Re: [PATCH] block/rnbd-clt-sysfs: use default_groups in kobj_type
Message-Id: <164141090490.316016.4253885398568107482.b4-ty@kernel.dk>
Date:   Wed, 05 Jan 2022 12:28:24 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 17:29:47 +0100, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the rnbd controller sysfs code to use default_groups field
> which has been the preferred way since aa30f47cf666 ("kobject: Add
> support for default attribute groups to kobj_type") so that we can soon
> get rid of the obsolete default_attrs field.
> 
> [...]

Applied, thanks!

[1/1] block/rnbd-clt-sysfs: use default_groups in kobj_type
      commit: 050f461e28c5d13f327353d660ffad2603ce7ac1

Best regards,
-- 
Jens Axboe


