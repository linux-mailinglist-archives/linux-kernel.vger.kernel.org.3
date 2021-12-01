Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFA14656C9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345203AbhLAUB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352804AbhLAUAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:00:45 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF005C061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 11:57:23 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id t6so32365529qkg.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 11:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=14/d54RDwtk2CS4Rg9GfJZQeZjQOY7xNprxxaiC/1sg=;
        b=FluJK/6UKzOKO2u83VqJVT/4msePMUkQmwg1ZW8sNYvK2vMMIgaQst6jaEJTfK8mVJ
         OenDAYZcp5YLGYz8nEetPLO46NGZPhtfKTVr+DN8DKkagYvcaoG8gSlNWcK7moWsVjy5
         d8CGd76HCCye34xHHmH6mI/+hxoiSsFLv/eN224FT6oc1E3qtnGiTk+Na5MN9aPkOnEd
         OzWxItqMDEMhazc768MQZkGu9jVoC6qiAGD392415xvhy906HkSPmBGlQMnNZ95TRQBG
         6eM0xXCkZeLcfXGMBuJnAnGU5QPFnYYCRkfDaXFkEXtV1ArYmpBgeGi469clFYNsj61w
         XNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition;
        bh=14/d54RDwtk2CS4Rg9GfJZQeZjQOY7xNprxxaiC/1sg=;
        b=2AuR6cJmbPWHw1lzfbjkmT0VRfAQUn0QSqI4OLcpm3pOT4Olhw7QhrhZhnZfSY0K7/
         QfdjS8/IfjkhtQF/XLG8l7ZjwYDMHgpp4PFdhEssrxaVoq8ZLzYAINqRDUks1esZ2WAi
         TbGa+fzMCIUah7+Nkzs2ATTbu4PUk06DQmO2GGdrUSc0mLWxpC5hz919xly0ESRlNwWf
         DIqT1ot3las23g2oNxg2cAo+c4So7jpWRmfD/+SggowsAzYWVsDefXsGKr5Kq3XrIHHb
         li6FI9JNG9ULyzF1K2qfOMdA0/uOxFHyCFJaZe5wFHYTwIJei3m4i2TSEk9tAkaUzgrj
         3mgA==
X-Gm-Message-State: AOAM532oWvfbyztn5PxHpW8J5wuEYqecSinImxYNv0X1HkoVDb6vgXxa
        GpGFiPKTg1mW9d3vfFpKrg==
X-Google-Smtp-Source: ABdhPJyIfOBJzQ32apoNdOttA2rEZpjta9mVqjWnYNVbmuEQoWnTy1yENSbVdbpUw4TMGYTncwgqCA==
X-Received: by 2002:a05:620a:1253:: with SMTP id a19mr8370585qkl.293.1638388642757;
        Wed, 01 Dec 2021 11:57:22 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id h22sm363184qkk.14.2021.12.01.11.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 11:57:22 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:b0fd:aad1:1fcc:32a6])
        by serve.minyard.net (Postfix) with ESMTPSA id A66B81800B9;
        Wed,  1 Dec 2021 19:57:21 +0000 (UTC)
Date:   Wed, 1 Dec 2021 13:57:20 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 5.16
Message-ID: <20211201195720.GJ15676@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5833291ab6de9c3e2374336b51c814e515e8f3a5:

  Merge tag 'pci-v5.16-fixes-1' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci (2021-11-11 15:10:18 -0800)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.16-2

for you to fetch changes up to c03a487a83fddbca1ef6cb5b97a69cd3e390e233:

  ipmi:ipmb: Fix unknown command response (2021-11-25 21:17:55 -0600)

----------------------------------------------------------------
Fix issues with IPMI

Some changes that went in 5.16 that had issues.  When working on the
design a piece was redesigned and things got missed.  And the message
type was not being initialized when it was allocated, resulting in some
crashes.

In addition, the IPMI driver has had a shutdown issue where it could
still have an item in a system workqueue after it had been shutdown.
Move to a private workqueue to avoid that problem.

----------------------------------------------------------------
Corey Minyard (2):
      ipmi: fix IPMI_SMI_MSG_TYPE_IPMB_DIRECT response length checking
      ipmi:ipmb: Fix unknown command response

Ioanna Alifieraki (1):
      ipmi: Move remove_work to dedicated workqueue

Jakub Kicinski (1):
      ipmi: fix oob access due to uninit smi_msg type

Wei Yongjun (1):
      ipmi: msghandler: Make symbol 'remove_work_wq' static

 drivers/char/ipmi/ipmi_msghandler.c | 41 +++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

