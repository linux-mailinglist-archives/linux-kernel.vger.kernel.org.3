Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6220484822
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbiADSzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiADSzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:55:06 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AB9C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:55:06 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id j185so60699399oif.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 10:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5XKm0n4ayuVG4m+jalkj2tNajAo4twgq+I+w5oh7RxY=;
        b=Fu89EdgnfAIMK0sAI4kboDyPMVi969c18wxuNtTWZoVYoCPjOw2HW1xYiwEQvomjwQ
         WDsm8isFzlCI6E103j7WfjlFzAfFEaNXWTh9R2mg4e236PBZb+h62+3plBHOgDFjWYvD
         +xQ6Hx0jqFuuJu+tSTI2Iv6n6I2W4tlYbPXusq/wgkFKhnPPMw0XsjkhA3J9d62XWeKK
         LBxKIjSOe86/i1ST5xNWmxOQjleV29QQ0FowcQYTwAikpB2FO1XfsyXoWrPfzgkK5e43
         s3PvZgn3UPIIihkNaH3Ahq/NnxLi95iYSUCMGpsgLjWQ59j2qwF5s2PtIyVqo+n8Vz+k
         N2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5XKm0n4ayuVG4m+jalkj2tNajAo4twgq+I+w5oh7RxY=;
        b=oJh0cDUYBvkCEk0GQ2vgj7VxoWU6wpsdzjUlrz3BrryiEZY8OfFf1vMntOAfpIU8Ea
         L7dBbN4XF3bhdGbHnqI6HK8jEcevwXhOT4X4ALU9qiSFDMIC63qpjH5JtPm/I2eLsuqG
         gC06EZ86/cEDJu78HrH42a5EKVAn/870V3TOOHJI2y3/cDutag+83KG4Z4GQi19iI2su
         kJ8/Q4SOvLYSaZeAHVIyAcNG7CyFueU1rqQw9/sgTffOdTVb376GzkjTMzpnxH0cjgPu
         tl0o7BhA9wrOzizttS81QvRuzyAVX6PquuKCGIW7OtQWeBTqAsKoDMYnvexTYVGXGP5e
         1FiQ==
X-Gm-Message-State: AOAM530Z9YvP7bL0adHmULwiGKsUWXKkidn4ZLOhTDT0ZiQYMK/lAFrF
        gdfz2/M2P+6xkBTLln+9OHg=
X-Google-Smtp-Source: ABdhPJzCEi789hB3uVsy7XMKNSwg+v8VPg3L6qJb1IeUCDTBoiFwpO1RKaRXO23IE4NCbSi4i4Lswg==
X-Received: by 2002:aca:100f:: with SMTP id 15mr36180260oiq.145.1641322505457;
        Tue, 04 Jan 2022 10:55:05 -0800 (PST)
Received: from [192.168.0.92] (cpe-70-94-157-206.satx.res.rr.com. [70.94.157.206])
        by smtp.gmail.com with ESMTPSA id f13sm8152413ots.76.2022.01.04.10.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 10:55:05 -0800 (PST)
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
Subject: mdadm regression tests fail
Cc:     "Douglas R. Reno" <renodr2002@gmail.com>,
        Pierre Labastie <pierre.labastie@neuf.fr>
Message-ID: <c4c17b11-16f4-ef70-5897-02f923907963@gmail.com>
Date:   Tue, 4 Jan 2022 12:55:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to document the mdadm-4.2 installation procedures for our book,
https://www.linuxfromscratch.org/blfs/view/svn/postlfs/mdadm.html

For testing, I am doing a simple:

   make
   sudo ./test --keep-going --logdir=test-logs --save-logs

But I get failures for about half the tests.

Digging in a bit I just ran:

  sudo ./test --tests=00raid0 --logdir=test-logs

This is the first test that fails.  With some hacking, it appears that the first 
portion of this test that fails is:

   mdadm -CR $md0 -e0.90 -l0 -n4 $dev0 $dev1 $dev2 $dev3

This resolves to

   mdadm -CR /dev/md0 -e0.90 -l0 -n4 /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3

There is not a lot of error output in the test, so I manually ran:

   dd if=/dev/zero of=/tmp/mdtest0 count=20000 bs=1K
   losetup /dev/loop0 /tmp/mdtest0

For /dev/loop[0123]

Then I ran

   mdadm -CR /dev/md0 -e0.90 -l0 -n4 /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3
   mdadm: 0.90 metadata does not support layouts for RAID0

My question is whether the regression tests in the tarball are valid for mdadm-4.2?

   -- Bruce Dubbs
      linuxfromscratch.org

Note: The kernel is version 5.15.12.
