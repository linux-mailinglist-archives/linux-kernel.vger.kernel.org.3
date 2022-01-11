Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA6948A5BE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 03:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346512AbiAKClU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 21:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244189AbiAKClS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:41:18 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4FEC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:41:17 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id h14so26016886ybe.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Joo9XLyJawJ6b/Q5BJnek831dd87+0Z5xXvI19cdHEY=;
        b=aEjdZx+6H9Q+x0zf1NZDTj42BcCcW6i61XkDl35hnkRAXRv60Zocyk2Uf3QX0FbxoI
         4pcgIg/K9oD8nXI0pOeF11OIzdUQIcNp//EGswVTMkHojv84bEmO/m+47o3JlKCzfe1N
         KtwWGE1s12/h27ESyEpD5ggPD8g54pawqyoIIgSZu9HWIT+RJ5WSn2TBAm7gSPDyrf2b
         vF7TNHSRE0aZ5KOxZCaMZ2oHSAbtFrnDXHjNn14w4cHkt3jLHEDeALtI6+Y3Z0vvi0xf
         ym9mCzRX+Oz5lRP+Ul2XQMIM5J71cGKn7utkdRwxzaFzKOre5sZQMyYyvUyyY1TwzvuJ
         Yz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Joo9XLyJawJ6b/Q5BJnek831dd87+0Z5xXvI19cdHEY=;
        b=Xfu114/SELQdYfVc4mHRB3uUp3siy+PAZZGusyWLf65SfF2LndHfjwLrZoWkw/DzAg
         3UVGLghaDTuDkHpWckP8kFzj7qyfpfHnk7nDy4XHLNTHxLbTlabicwaVRQT0fjmszwiy
         zs7q3PvbNj13P/w73cf1MoDdV0VHx2TkraMrm7GhXwVstkUxnYh7OJHwLs5XGClpOCuL
         7BsNTplHS/ppdc391l5+xlxx2+kRmUvkIrMSzWZjklqq2a8T/L7xOqV0DZJbBJBwiLZL
         wM77Cr6RRJSAtjvcKzN4IcOcZtCoElTi43YutHhq+yhG8mnSVAZ/9k02JpmmmNcBeYR3
         w3Cw==
X-Gm-Message-State: AOAM530CKacldppkpsWQcORp8QOsUQeI+s0bB7dLGEraOvLxybPsS6Sw
        8nmc8taysj2kCdDm2pwGZ5eE7CYMxQ64NH+gphk=
X-Google-Smtp-Source: ABdhPJzk9WV/PZBhoZGB4Wd+7zIapd1Up7SMw5WM3H+E0sBOsCGyvhOEjbg/3ZzRDhzzryhD3GF+YWSOFpvHEltDW04=
X-Received: by 2002:a25:4cc5:: with SMTP id z188mr3350416yba.248.1641868876831;
 Mon, 10 Jan 2022 18:41:16 -0800 (PST)
MIME-Version: 1.0
From:   cruise k <cruise4k@gmail.com>
Date:   Tue, 11 Jan 2022 10:41:06 +0800
Message-ID: <CAKcFiNDwEUw+sLxfdFgYsrX7WrqtgbhvNi_ncZx040VFgF-cfQ@mail.gmail.com>
Subject: INFO: task hung in devtmpfs_submit_req
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Syzkaller found the following issue:

HEAD commit: 75acfdb Linux 5.16-rc8
git tree: upstream
console output: https://pastebin.com/raw/gwHBn2EB
kernel config: https://pastebin.com/raw/XsnKfdRt

And hope the report log can help you.

INFO: task kworker/6:4:13959 blocked for more than 145 seconds.
      Not tainted 5.16.0-rc8+ #10
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/6:4     state:D stack:26944 pid:13959 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __schedule+0xcd9/0x2550
 schedule+0xd2/0x260
 schedule_timeout+0x5e5/0x890
 wait_for_completion+0x17b/0x280
 devtmpfs_submit_req+0xa8/0x100
 devtmpfs_delete_node+0xe1/0x150
 device_del+0xadf/0xe80
 usb_disconnect+0x4a4/0x8c0
 hub_event+0x199c/0x4090
 process_one_work+0x9df/0x16a0
 worker_thread+0x90/0xe20
 kthread+0x405/0x4f0
 ret_from_fork+0x1f/0x30
 </TASK>
