Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D32F4708A3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245308AbhLJS3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245107AbhLJS3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:29:51 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F107C0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 10:26:16 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id a23so4148345pgm.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 10:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=5ZWHsHrPXRi2wsn383Uu/1pd+rYDunvKkawYraa0NUU=;
        b=z0fHip/MZwxDe4vHYomeTzwFJb3U1F6jmwmgr3rsirUf0tChAE9PzrAEZsHbsKImCf
         xS6IWdNUa3EYz58mawdCaReNw+O8oHfgl9j2dl29xc3YGvOtK99laelFIU5V9aoAVDhE
         meb/xRVCcR+yg9zzngV5tDxT2SbF1K+GThAZNbbtCkoY61bZN+rChuSGCAPN5BwME6Jm
         4WroOOpahZaNSNUxLyRsCFD/sOE+9GdNsXOc8mpZ0N+uoP+NELn+gQjbL45l7EVOQZfx
         YSZ6oHZW49PgergROwi7NGAYk8kNMMqaBiW4jKiDwnVQqrdPWjCG5Vj+XjZ6IJSIKEaN
         d07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=5ZWHsHrPXRi2wsn383Uu/1pd+rYDunvKkawYraa0NUU=;
        b=63y13Oz/TCMyhcaJPh/JJp3r3LjiWQ+50ZMh+01ol/hjll+J/9+wMPgc1kDHrpGgxJ
         NkOlfufDvnTp6SYxUHMQ4kzsETRbFkLNKTOTdm21t2CTWyJHjQKZlEFWDV7xCIseEAwP
         ObTtlO8rtn2Pmn7KFkuoK1t/gOVbjOTybC1BAL8DFH10N8NOldOf8yi4EOwCYZiAnXEY
         oy+eoGhRfl11JimLFhABiuJ1FLFOIP8WB4NJLM+iq46GufHdkCoNy156ZZDweTVMue8M
         fzGE950brme7CKujXq2kblyF8KflDiIKgpUUDN+XW8ZZsnNIS/F01OpxadsLwJwcM6Y7
         tU5w==
X-Gm-Message-State: AOAM530JcNb21vVkhjQr0edcgJGM8V1XDdApWHvAUsp4x6dPNrDC3kyh
        Vx/+Aj9Cr1IV14D2oQAoFmuDoQkAHdz6sg==
X-Google-Smtp-Source: ABdhPJwSJasp5TOKzYWPb4Na+8MBZ6lVt9UPw0kNn5DPvNdYwiUA3S0wvCDRN19sohb737MFHivkIA==
X-Received: by 2002:a62:c541:0:b0:4ad:561a:5b6c with SMTP id j62-20020a62c541000000b004ad561a5b6cmr19546309pfg.48.1639160775461;
        Fri, 10 Dec 2021 10:26:15 -0800 (PST)
Received: from [172.20.4.26] ([66.185.175.30])
        by smtp.gmail.com with ESMTPSA id mz7sm13410388pjb.7.2021.12.10.10.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 10:26:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        oleg@redhat.com, linux-block@vger.kernel.org
In-Reply-To: <20211210182058.43417-1-dave@stgolabs.net>
References: <20211210182058.43417-1-dave@stgolabs.net>
Subject: Re: [PATCH] block: fix ioprio_get(IOPRIO_WHO_PGRP) vs setuid(2)
Message-Id: <163916077449.627295.16747606305851596098.b4-ty@kernel.dk>
Date:   Fri, 10 Dec 2021 11:26:14 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 10:20:58 -0800, Davidlohr Bueso wrote:
> do_each_pid_thread(PIDTYPE_PGID) can race with a concurrent
> change_pid(PIDTYPE_PGID) that can move the task from one hlist
> to another while iterating. Serialize ioprio_get to take
> the tasklist_lock in this case, just like it's set counterpart.
> 
> 

Applied, thanks!

[1/1] block: fix ioprio_get(IOPRIO_WHO_PGRP) vs setuid(2)
      commit: e6a59aac8a8713f335a37d762db0dbe80e7f6d38

Best regards,
-- 
Jens Axboe


