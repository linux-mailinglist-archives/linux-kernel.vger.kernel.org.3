Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AEA497821
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241370AbiAXEZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiAXEZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:25:14 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F5EC06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 20:25:12 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id l16so15195428pjl.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 20:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=ZlU1YtCb74/PtHVtb3Wm72htYLoYfou/n0ndVPahqMo=;
        b=cFh9wd8QHdgybiAXNs5slP4x0Jd1PdRGLD4dFpNPhVZBV0CDFFj8KJKSRCfdYxUxq1
         j1VlZmQLmzmReho992xqVu6bqpAwSbZ+On5mQbYskbRcijkmmCiIrXYebbAr5OYNQmbC
         Z1WSvhfe9RxLxBiLdG1pcZoBGAemQAbETj262+B80QyvhV4ZL1d9zq9ay+bbpC6EoLAt
         B6lxi2KiXjwGl0xXikwDudX5jc8kq0H1pyFRd4nlQHqjrqNci/b5tshRCTQR7gWov38o
         IiAPBjPrz64oOtzBxGHJBn5o/GuAPT5feQTgeP+6wJZwNTgkfPVjsZzyPRX5gYF54iNB
         ZB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=ZlU1YtCb74/PtHVtb3Wm72htYLoYfou/n0ndVPahqMo=;
        b=BKlLNcGMutgBg/sKZ2vCaUlkLcxwZzhaJRgwQU8AoN1OCpO26nOzVkM6zcHRVEncdx
         K6c5BNA4h4qt33uQlkm2qW/ZUKj3e1OFZ8rP+wkfxNGY62T3WOEN6YzcFkqOFFtvykOB
         DmbCpJ6e5lPWAZzf9+zSRXnePS7edA4UaRo31+GFQw8JJU3mY6zCLs5XSmRC2bwWIJjj
         NoES9zpgJKfn2EjCKn7gHT/oCL2YhFBiFMxfDaLOn/cfaB2cgUTDxG7U/VBP7R9uLe4k
         8kH5vfKj68TH11KGvgGyyqYAQbSScRvQ7ME4fH7tJHfakGRlKpAcB5FOJ4HAkV/SjO1+
         JzjQ==
X-Gm-Message-State: AOAM533nGQ+ROv/YsKUWFJ+wBlIoqjZyNfQi8UG2XPbIcdlgwrNArp0r
        VnM6S8AqDkg7xOyPy25uA3w=
X-Google-Smtp-Source: ABdhPJyoCy0ihQOCnsJ3kzsjLAsnG6piJqPMecFfqiT5oxhTHa0FoC1T8tIURomLQKFoRg2hzg3rMA==
X-Received: by 2002:a17:902:c40d:b0:14a:96a4:1044 with SMTP id k13-20020a170902c40d00b0014a96a41044mr13150581plk.50.1642998312280;
        Sun, 23 Jan 2022 20:25:12 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id lt17sm11265936pjb.41.2022.01.23.20.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 20:25:11 -0800 (PST)
Date:   Mon, 24 Jan 2022 17:25:06 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] staging: pi433: add debugfs interface
Message-ID: <20220124042506.GA7662@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye06GfUzwzQBvfLy@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When troubleshooting RF applications, one of the most common approaches 
is to ensure that both sides of the communication path are using the 
same configuration such as bit rate, frequency deviation, encryption key,
sync words and so on.

The existing driver implementation doesn't allow the user to see which 
values have been configured onto the uC which makes trobleshooting more 
painful than it needs to be.

This patchset adds debugfs interface to this driver and exposes a 
read-only access to uC reg values to address that problem.

Patch dependency:

This series depend on these patches as they change the same set of files:

- https://lore.kernel.org/lkml/20220108212728.GA7784@mail.google.com/
- https://lore.kernel.org/lkml/20220114221643.GA7843@mail.google.com/ 
- https://lore.kernel.org/lkml/20220118230312.GA4826@mail.google.com/

Changelog:

v2: remove redudant references to dentry pointers in the code and perform 
     debugsfs_lookup instead. Req: Greg k-h  
v1: https://lore.kernel.org/lkml/20220123073855.GA79453@mail.google.com/

Paulo Miguel Almeida (2):
  staging: pi433: add missing register contants
  staging: pi433: add debugfs interface

 drivers/staging/pi433/pi433_if.c       | 80 ++++++++++++++++++++++++++
 drivers/staging/pi433/rf69.c           |  2 +-
 drivers/staging/pi433/rf69.h           |  1 +
 drivers/staging/pi433/rf69_registers.h |  2 +
 4 files changed, 84 insertions(+), 1 deletion(-)

-- 
2.25.4

