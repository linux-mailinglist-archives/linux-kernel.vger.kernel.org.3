Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D5C468664
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 18:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355347AbhLDRH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 12:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbhLDRH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 12:07:56 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD76C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 09:04:31 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id v1so24755534edx.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 09:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+IHFqT+1cIu4d25MxA/33I5hw37sbqf3L8hQmO39cs=;
        b=gdi/hrEsdJa+MtfK1vcA4icU4vcH7+xTuMkSP1+Kea3LWAERjc6zptW/sunycSyp5v
         7GO/CviYc2t+irIBL4f5IVweYDR37BBXHv0XPvKNO3yTVOTfhx3PLAdMKNBU8l/5h01P
         gMrZXiGARkAf9jAbSY4vCAHvvk4TJ3KY/gPhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+IHFqT+1cIu4d25MxA/33I5hw37sbqf3L8hQmO39cs=;
        b=K7oZ+qNKHM8W8vGn9qE9WdjgBa/PWhFAziobEAEpnLmZXW6lLHvUjHiDbw1PwlRdVz
         RKqn/xpkZi7FInZbwxK+3cQTxclVy/SG4Mux13j7ZCQf7FfMwBAMXzRMV2CCCdNw4S45
         B8ccjn5sZlwX+dr51v37YlYG90siOYr/WpezObluobW1dtLpfZHzD+Y8s3EGGZnGw2c9
         6tTJHPAYBWD8GOql4ih7qOaDm/tq9HwBvvacygXL1vOdQPZRCq/Mq2cvsI3guIgdFj9w
         mAlU/PCAcCASdOR/L+GNEoRaWJPodod5BLozxVXeW4cThkp44CcqWZNRe61Vg7nVi9xv
         kePw==
X-Gm-Message-State: AOAM532gpgD4XpiJ4Bn5rAxCJOVvnpiS6xs/oQghni4Y8nbghJiPn1JE
        a2hyBJTY13ZhBapjrJu8bipj4MiMpgGnXyXD
X-Google-Smtp-Source: ABdhPJyBaLTzkYiv34MUn/9NwhHPE8mI5p8SshaXg8+//2kLZp6E33oaeL0tT65qKN+aeMsQ+CQ/pA==
X-Received: by 2002:a05:6402:270d:: with SMTP id y13mr36886564edd.362.1638637469154;
        Sat, 04 Dec 2021 09:04:29 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id mp26sm4089602ejc.61.2021.12.04.09.04.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Dec 2021 09:04:28 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id q3so12712585wru.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 09:04:28 -0800 (PST)
X-Received: by 2002:adf:f8c3:: with SMTP id f3mr30048229wrq.495.1638637467944;
 Sat, 04 Dec 2021 09:04:27 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0hQaF-ANLc4JO=Ub_JMsqLFpZev_gmpb=NPpg=zmqcauA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hQaF-ANLc4JO=Ub_JMsqLFpZev_gmpb=NPpg=zmqcauA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Dec 2021 09:04:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGbtmc+FoUjcgaQRavL=B=rfTmA_VhTtGpmhmk2873cA@mail.gmail.com>
Message-ID: <CAHk-=wiGbtmc+FoUjcgaQRavL=B=rfTmA_VhTtGpmhmk2873cA@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.16-rc3
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 11:38 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  acpi-5.16-rc3

Hmm. This may be unrelated, but I don't think I've seen this before..
On my laptop, I get

  WARNING: CPU: 4 PID: 95940 at kernel/workqueue.c:1441 __queue_work+0x2f9/0x3b0
  Workqueue: kec_query acpi_ec_event_processor
  ..
  Call Trace:
   <TASK>
   queue_work_on+0x20/0x30
   advance_transaction+0x1a1/0x500
   acpi_ec_transaction+0x15c/0x410
   acpi_ec_space_handler+0xd2/0x270
   acpi_ev_address_space_dispatch+0x216/0x2a3
   ? acpi_ec_resume+0x20/0x20
   acpi_ex_access_region+0x1dc/0x255
   ? acpi_os_wait_semaphore+0x48/0x70
   acpi_ex_field_datum_io+0xfd/0x178
   acpi_ex_read_data_from_field+0x12e/0x171
   acpi_ex_resolve_node_to_value+0x1fe/0x281
   acpi_ds_evaluate_name_path+0x75/0xe9
   acpi_ds_exec_end_op+0x8f/0x411
   acpi_ps_parse_loop+0x495/0x5bc
   acpi_ps_parse_aml+0x94/0x2c2
   acpi_ps_execute_method+0x15e/0x193
   acpi_ns_evaluate+0x1c6/0x25d
   acpi_evaluate_object+0x12e/0x226
   acpi_ec_event_processor+0x63/0x90
   process_one_work+0x217/0x3c0

and it seems to be happening at resume time.

This was when running a51e3ac43ddb, so not the very latest git tree,
but recent.

Maybe I've missed a report of this?

               Linus
