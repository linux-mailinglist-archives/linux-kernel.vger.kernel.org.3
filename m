Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA06D4DD7F4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbiCRKfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiCRKfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:35:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87308255A0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647599672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=I0SeAJoKlMFlPQaiYQbOksz1DlSlCXtZSo9ZW+YXDyc=;
        b=S79qtRVwC3E9YczsomP3yAWHBrC5M+xoFCNf8VHwjG1L/N5iivfQHACYOchEFCTbLmI6sk
        owMCluK6GWgI+PN9dA2pNxHm5ydcUj17r0u+8NCU0Umb7CdH3f2FLz3HxZJ9ue62yF1PdB
        axypdNlvmVdiQiSb7xmuuK4nxZ+zHfk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-owfTbjfKMOu0xdtfql1tmw-1; Fri, 18 Mar 2022 06:34:29 -0400
X-MC-Unique: owfTbjfKMOu0xdtfql1tmw-1
Received: by mail-pj1-f71.google.com with SMTP id ob7-20020a17090b390700b001c692ec6de4so2456765pjb.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I0SeAJoKlMFlPQaiYQbOksz1DlSlCXtZSo9ZW+YXDyc=;
        b=cfDGE/OFxp7KjCxmopf+o6S1EhjGk+G83uLAdLJshj8OO39u2YasIYDLA+JbSVN+/T
         CvvHuDiXCA5Z/teiNMS/u8KmVXgFz2hPPFDAIXZRrYrBKNX7+OL7UmW8wyTENSajbHpG
         WUIAzl78HFkEEKTcMSeOgf3DmmfkVAFiQESbJDgK2q72GqF31pHsczmULSLAoIH6lAaI
         gB6a5YDUHHXMnVTRqrxlfvmdIHR37tuSVEs/bZ4GP7Y+ZVvw3StJol+xeW5/Go5lw9EN
         sffqS31kfC/zO8OxehB7S2/hPdhng/uZmSlJpqbnFPcTzkhxMQ6XvaV4mBmi4o6Oe0On
         81Aw==
X-Gm-Message-State: AOAM531Vtqx1aPOPJvwyrXPG2PsWHhidrgc7ctRiUltNukX/zy4ygboH
        Lb3JBF9O4aVaGOVzNZ/z2ujI5JOBVzQj9pxFAGIwGT7mL4W7oxwComcGAjOhcdLOVtxVEXFssA/
        BYy3/ueS9uCb45UHKqddZqNaN
X-Received: by 2002:a17:902:ab10:b0:153:b520:dbbe with SMTP id ik16-20020a170902ab1000b00153b520dbbemr9101384plb.55.1647599668108;
        Fri, 18 Mar 2022 03:34:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxq2E7lA6GIq04muhHDq/uvZNiBh61dHzMtMN7l2+AjLeU44C6BHkUhd4xQqMPmuKGlo4mfig==
X-Received: by 2002:a17:902:ab10:b0:153:b520:dbbe with SMTP id ik16-20020a170902ab1000b00153b520dbbemr9101364plb.55.1647599667809;
        Fri, 18 Mar 2022 03:34:27 -0700 (PDT)
Received: from localhost ([240e:3a1:2e5:800:f995:6136:f760:a3d0])
        by smtp.gmail.com with ESMTPSA id s6-20020a056a0008c600b004f667b8a6b6sm9773079pfu.193.2022.03.18.03.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 03:34:27 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Milan Broz <gmazyland@gmail.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org
Subject: [RFC 0/4] Support kdump with LUKS encryption by reusing LUKS master key
Date:   Fri, 18 Mar 2022 18:34:19 +0800
Message-Id: <20220318103423.286410-1-coxu@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With kdump enabled, when kernel crashes, the system could boot into the
kdump kernel and dump the memory image i.e. /proc/vmcore to a specified
target. Currently, when dumping vmcore to a LUKS encrypted device, there
are two problems,
 - for some machines, the user may don't have a chance enter the password
   to decrypt the device after kernel crashes and kdump initrd is loaded
 - LUKS2 by default use the memory-hard Argon2 key derivation function
   which is quite memory-consuming compared to the limited memory reserved
   for kdump. Take Fedora example, by default, only 256M is reserved for
   systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
   to be reserved for kdump.
 
Besides the users (at least for Fedora) usually expect kdump to work out
of the box i.e. no manual password input is needed. And it doesn't make
sense to derivate the master key again in kdump kernel which seems to be
redundant work.

Based on Milan's feedback [1] on Kairui's ideas to support kdump with
LUKS encryption, this patch set addresses the above issues by
 1) first saving the LUKS master key to kexec when opening the encrypted
    device 
 2) then saving the master key to the reserved memory for kdump when 
    loading kdump kernel image.

So the LUKS master key never leaves the kernel space and once the key has
been saved to the reserved memory for kdump, it would be wiped 
immediately. If there is no security concern with this approach or any
other concern, I will drop the following assumptions made for this RFC
version in v1,
 - only x86 is supported
 - there is only one LUKS device for the system

to extend the support to other architectures including POWER, ARM and
s390x and address the case of multiple LUKS devices. Any feedback will be 
appreciated, thanks!

For a proof of concept, I've patched cryptsetup [2] in a quick-and-dirty
way to support a new option "--kdump-kernel-master-key"
and hacked systemd [3]. It works for Fedora 34.

[1] https://yhbt.net/lore/all/e5abd089-3398-fdb4-7991-0019be434b79@gmail.com/
[2] https://gitlab.com/coxu/cryptsetup/-/commit/ee54bb15445da0bc3f9155a7227a9799da4dac20
[3] https://github.com/coiby/systemd/tree/reuse_kdump_master_key

Coiby Xu (4):
  kexec, dm-crypt: receive LUKS master key from dm-crypt and pass it to
    kdump
  kdump, x86: pass the LUKS master key to kdump kernel using a kernel
    command line parameter luksmasterkey
  crash_dump: retrieve LUKS master key in kdump kernel
  dm-crypt: reuse LUKS master key in kdump kernel

 arch/x86/include/asm/crash.h      |  1 +
 arch/x86/kernel/crash.c           | 42 ++++++++++++++++++-
 arch/x86/kernel/kexec-bzimage64.c |  7 ++++
 drivers/md/dm-crypt.c             | 26 +++++++++---
 include/linux/crash_dump.h        |  4 ++
 include/linux/kexec.h             |  7 ++++
 kernel/crash_dump.c               | 69 +++++++++++++++++++++++++++++++
 kernel/kexec_core.c               | 66 +++++++++++++++++++++++++++++
 8 files changed, 215 insertions(+), 7 deletions(-)

-- 
2.34.1

