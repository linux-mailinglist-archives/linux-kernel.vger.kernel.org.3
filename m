Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DC647D368
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245595AbhLVOMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbhLVOMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:12:00 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C5EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 06:11:59 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 69so2376867qkd.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 06:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=thDdHAXO4Fu5Yivc3/wFyA8Rxn+/3gkNfZ5obxoRWYU=;
        b=aSRzk8PsYg5OEqACaRj37BdmaZNDEfamridrJ7FSCCY7BxmTM9TgzpPOphGmkiQEZX
         o4ClgE9aHorWdoN2vE0O9K7qSPHrm0WQaDGYrUQ0GpUAq+x2hOZCdbYArY8LZ7G4ekMg
         eXE5rF6eQmeDXcFpN932T0lM+b0U87n6hQmhR8PoQMoz2PEkj2PWnWBUB8gVzatM1mFm
         9spez2okTmbE2WlgzCYuMIWXuAtF8DkUjKyyRE0JYWTPTSy9W4gpgyWGEmC7x6EvKxkH
         DOsz8KJLHy4+pOh1D8r95EinWHn/wSfrBzcu0QhYB/RF4ng9uHZo5l43xwvnYLyfzecL
         CR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition;
        bh=thDdHAXO4Fu5Yivc3/wFyA8Rxn+/3gkNfZ5obxoRWYU=;
        b=wOyoEmsztxaKOCG7hG+HdTzR+vVchJIjul85iWm+jwYbdsnLRyVHrnXNZ/sWuEFhFw
         JHtRblyhMQHdamjbjjCPHoWje7optRYEg7dTj2OEjQc8SlSSLdBEWSwmp10P2XLbDxx4
         a4miGjkpDyOFKWGXr1ZVWdCm8DB2EefUzFngHJbcbrklC1SLudVJZ4LSR2hDOre1nyEk
         zZray4/RV5GBGiixop2LeAErl9629EJI95Y904iZOr8BfwD+W7GwFMH188S1Y4oVYqyR
         uxKZMETDEL5ssS9X0wjbDxu/iu+uhyHlkUjZKQQAiRdW+4QAw3GntkX5Pb9NAo9FDIN1
         jKWA==
X-Gm-Message-State: AOAM531wecsfwce44FpIVOysVUBjNzM/x2ZeSedf2a5Dg1ZYKMM3BaDg
        Z306UftfQTOmVc0xj90CdTxStxbQUA==
X-Google-Smtp-Source: ABdhPJxw3IroCNT/flsfagqPGSgGaYVU1sdDdIIcq759rwx2qtItxf4EbHEyQc+sIFrmvmoc/TXJbg==
X-Received: by 2002:a05:620a:1a01:: with SMTP id bk1mr2017307qkb.539.1640182318098;
        Wed, 22 Dec 2021 06:11:58 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id bj32sm1812363qkb.75.2021.12.22.06.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 06:11:57 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:a994:7eee:8e73:4087])
        by serve.minyard.net (Postfix) with ESMTPSA id DAA19180013;
        Wed, 22 Dec 2021 14:11:56 +0000 (UTC)
Date:   Wed, 22 Dec 2021 08:11:55 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 5.16 (3)
Message-ID: <20211222141155.GV14936@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 12119cfa1052d512a92524e90ebee85029a918f8:

  Merge tag 'vfio-v5.16-rc4' of git://github.com/awilliam/linux-vfio (2021-12-03 12:27:08 -0800)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.16-3

for you to fetch changes up to ffb76a86f8096a8206be03b14adda6092e18e275:

  ipmi: Fix UAF when uninstall ipmi_si and ipmi_msghandler module (2021-12-21 08:04:42 -0600)

----------------------------------------------------------------
Fix some IPMI crashes

Some crash fixes have come in dealing with various error handling
issues.  They have sat in next for 5 days or more without issue, and
they are fairly critical.

-corey
