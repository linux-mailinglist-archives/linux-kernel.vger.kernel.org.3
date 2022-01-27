Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C9F49EECD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbiA0XYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiA0XYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:24:07 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BD9C061714;
        Thu, 27 Jan 2022 15:24:07 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e8so7629104wrc.0;
        Thu, 27 Jan 2022 15:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=H6M7U4X4ObpILj87GAfcv8PfNUT14ZVVu9S9xFT6cdY=;
        b=TyqToe8bOPqQTEtEliueH42hNUKLulPoqVmr9pRWjikwvmHHYzbUNr9hm2sY6SF53W
         k1KKW+LHskYP2wDrx4et+x+Q/ydHGLB/Uk9u/vBB5/UUSaKYmKbqBjl8G7B8kHvxMiyw
         zjVrGce8K9mQCOB6cCnNgmHcGPq2ggmAkdca6hgLh9BhaD9s2y/GlJBNMZatqRcF/4WW
         XMK1StvK3RHVzWpFR6kvHmd+X2Hia4UV0gWx74hDxPre5qza2gwYYqQpRZ488nNtnpZB
         BS3LB7E40KkCWdvxUfUfFJSNSzj+4V3LFaFZ/cWyk0Mn8nOVcO0UrWpnT+XCjsDRZNy7
         0RnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=H6M7U4X4ObpILj87GAfcv8PfNUT14ZVVu9S9xFT6cdY=;
        b=JqB1UYqVobcLoLVJ3S+nThMMJGroUP/b6x7Q1OOsef5LqKrAry6CcFOJH5VNbTur4j
         KNxcyPM/fS8dmqIp723uUruDG0VwSH+h/LuPGhQ5iXQ13fxWsouZYEi4w70y2cp/V9yM
         ksxJw0+BIw6yNkczL/knUyMAfrvU7aHs4VTcI4P9qqBbafmf2e7ejnzTLrvCZUIF5yZ7
         Maz8qJbdL8F9kzZ44qEdFFj3sTDkGGkBGlJNK0FTuEUZShV2ckIqexwNOao1fB/N+cFI
         Zxt+9wTs8RxhWCuv6honTvtsrBdGgOfgEBO92wj4b8ywgDjXDGX5DQ5jKVcvi2YtYWlf
         whLg==
X-Gm-Message-State: AOAM530zKeDPYLElJaQSRG03sUIJOy/VUCQjEw74up6RvZGBJWZoSKE9
        nFpWdn5qfVqlgRM9EtdWE/JLFQ6Jnfk=
X-Google-Smtp-Source: ABdhPJwVf2hDJWcwBCmWSG/P+cGWMdiWXv7BnOe2OwexDibrQSEyAMNN1d+vIUrXcqwSvSTi/+HGHg==
X-Received: by 2002:adf:fb0e:: with SMTP id c14mr4734834wrr.586.1643325845666;
        Thu, 27 Jan 2022 15:24:05 -0800 (PST)
Received: from debian (host-2-98-43-34.as13285.net. [2.98.43.34])
        by smtp.gmail.com with ESMTPSA id l39sm552449wms.24.2022.01.27.15.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 15:24:05 -0800 (PST)
Date:   Thu, 27 Jan 2022 23:24:03 +0000
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org
Subject: Regression with 5021d709b31b ("tty: serial: Use fifo in 8250 console
 driver")
Message-ID: <YfMpk7DM9zA7NfmI@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wander,

Not sure if this has been reported before but since last few weeks I am
seeing a problem with the rpi4 serial port on my test setup. The initial
boot message will be completely garbled as you can see at:
https://lava.qa.codethink.co.uk/scheduler/job/543#L380.
The last good boot was https://lava.qa.codethink.co.uk/scheduler/job/540#L390.

The bisect log:

# bad: [455e73a07f6e288b0061dfcf4fcf54fa9fe06458] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
# good: [7e7b69654724c72bd3219b71f58937845dca0b2b] Merge tag 'dma-mapping-5.17' of git://git.infradead.org/users/hch/dma-mapping
git bisect start '455e73a07f6e288b0061dfcf4fcf54fa9fe06458' '7e7b69654724c72bd3219b71f58937845dca0b2b'
# bad: [342465f5337f7bd5b8bd3b6f939ac12b620cbb43] Merge tag 'tty-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect bad 342465f5337f7bd5b8bd3b6f939ac12b620cbb43
# good: [6dc69d3d0d18d587ab9d809fe060ba4417cf0279] Merge tag 'driver-core-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
git bisect good 6dc69d3d0d18d587ab9d809fe060ba4417cf0279
# good: [e269f7acdc53623769da31135f60afeb3a65eaff] staging: r8188eu: remove the private ioctl "wps_assoc_req_ie"
git bisect good e269f7acdc53623769da31135f60afeb3a65eaff
# bad: [ad234e2bac274a43c9fa540bde8cd9f0c627b71f] tty: serial: meson: Drop the legacy compatible strings and clock code
git bisect bad ad234e2bac274a43c9fa540bde8cd9f0c627b71f
# good: [c66453ce8af8bac78a72ba4e21fd9a86720127d7] tty: fix kernel-doc in n_tty.c
git bisect good c66453ce8af8bac78a72ba4e21fd9a86720127d7
# good: [0882b473b084df31288003b3bee974aabac9dcf9] tty: serial: samsung: Enable console as module
git bisect good 0882b473b084df31288003b3bee974aabac9dcf9
# bad: [b4a29b94804c4774f22555651296b838df6ec0e4] serial: 8250: Move Alpha-specific quirk out of the core
git bisect bad b4a29b94804c4774f22555651296b838df6ec0e4
# good: [e822b4973f49015e1c6f63b91c8641ed9bfaf229] tty/ldsem: Fix syntax errors in comments
git bisect good e822b4973f49015e1c6f63b91c8641ed9bfaf229
# good: [fb09d0ac07725b442b32dbf53f0ab0bea54804e9] tty: Fix the keyboard led light display problem
git bisect good fb09d0ac07725b442b32dbf53f0ab0bea54804e9
# bad: [5021d709b31b8a14317998a33cbc78be0de9ab30] tty: serial: Use fifo in 8250 console driver
git bisect bad 5021d709b31b8a14317998a33cbc78be0de9ab30
# good: [adbfddc757aec1ed54ccb35c4a7ca9170df827e0] docs/driver-api: Replace a comma in the n_gsm.rst with a double colon
git bisect good adbfddc757aec1ed54ccb35c4a7ca9170df827e0
# first bad commit: [5021d709b31b8a14317998a33cbc78be0de9ab30] tty: serial: Use fifo in 8250 console driver

And, indeed reverting 5021d709b31b ("tty: serial: Use fifo in 8250 console
driver") on top of 23a46422c561 ("Merge tag 'net-5.17-rc2' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net") fixes the problem
for me.

This is seen on every boot and I will be happy to test any patch.


--
Regards
Sudip
