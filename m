Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81415467E7B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353649AbhLCT5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:57:24 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:39779 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242274AbhLCT5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:57:23 -0500
Received: by mail-ot1-f52.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso4710547ots.6;
        Fri, 03 Dec 2021 11:53:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IzwaVxFXQ/xekG4IJ5xJaE8yrs9liJNMHjXb9KDbmH4=;
        b=ZfUyyN78BddfhSrQTYJjxtdJllc+Bc0ZBT4WjVaf4/YkVBXkFXQARgr7gxLT865b+9
         aOX/i1vGTptkpB8mXGqr51TcviIEZV0Fc+7ML6xbBg0gM5Yx2yVRbuoYYjPkRre48yvY
         lLNKfwgYpP6KDoZrHEZ8YpatjNw+ZXYa8QTiApnHwZMGkYyaUir9CTWQupFXAm5Ff+IQ
         3uAwvcv2TGh1bKlAC6Ttw1dEesWnUgGS8GRvpr48Vtnld/X2ZzBpdcMTEF+/oZhQG+TX
         9JRi81dku8isaFlieX3MunSeiU3AST4KKezJWQvGhOg9RiA9AX1YlId8yzbh7c3h1J4q
         bSHw==
X-Gm-Message-State: AOAM532qwQjdYgH7RfEFOMIBUAzV672yV+qBtaVE6MfEfj238Q/19BeU
        2xllXVY0nBL1TrSMR5Rr7pbyM0cGcCodyWEUCMNwtNCREKI=
X-Google-Smtp-Source: ABdhPJwXbVpqZ3Y56BBEujpfDJ/7vvzwoTAtkHcAENGQR2Ce5+pn7G3Snz25bvHFnmJe0PrVgGKV6TvleDISCjoSsGk=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr17983542otf.198.1638561238982;
 Fri, 03 Dec 2021 11:53:58 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Dec 2021 20:53:48 +0100
Message-ID: <CAJZ5v0jkFod+DDdMFft31aHT1BXtip631LGznrryna9cBf5HHA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.16-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.16-rc4

with top-most commit 404c91218703d58c8f442aa01e4ae558f14c0e20

 Merge branch 'powercap'

on top of commit d58071a8a76d779eedab38033ae4c821c30295a5

 Linux 5.16-rc3

to receive power management fixes for 5.16-rc4.

These fix a CPU hot-add issue in the cpufreq core, fix a comment
in the cpufreq core code and update its documentation, and
disable the DTPM (Dynamic Thermal Power Management) code for the
time being to prevent it from causing issues to appear.

Specifics:

 - Disable DTPM for this cycle to prevent it from causing issues
   to appear on otherwise functional systems (Daniel Lezcano).

 - Fix cpufreq sysfs interface failure related to physical CPU
   hot-add (Xiongfeng Wang).

 - Fix comment in cpufreq core and update its documentation (Tang
   Yizhou).

Thanks!


---------------

Daniel Lezcano (1):
      powercap/drivers/dtpm: Disable DTPM at boot time

Rafael J. Wysocki (1):
      powercap: DTPM: Drop unused local variable from init_dtpm()

Tang Yizhou (2):
      cpufreq: Fix a comment in cpufreq_policy_free
      cpufreq: docs: Update core.rst

Xiongfeng Wang (1):
      cpufreq: Fix get_cpu_device() failure in add_cpu_dev_symlink()

---------------

 Documentation/cpu-freq/core.rst |  6 +++---
 drivers/cpufreq/cpufreq.c       | 14 +++++++-------
 drivers/powercap/dtpm.c         |  5 -----
 3 files changed, 10 insertions(+), 15 deletions(-)
