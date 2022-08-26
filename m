Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FD05A1D95
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 02:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiHZAIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 20:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243000AbiHZAIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 20:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8E7C888E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 17:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661472491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hdzMOeIUQobXozAoBo+0gU24p6eUcuhYf3lPGxm6UuE=;
        b=cbS30Nct+PcjmSUNNYl0efTN02WEn3Uj9cyjbMVtK0KIfwjSICmSfVTqCxErWrlvKbJ0rX
        /2Ebeisx2J0StlmkEH8uMmRxG2+hJrnlUKCDRRiFEHb/wTqamUxOaKj8UOzP+jbRfsu+SG
        HtgAtftbe/ig+ACgNrKZZmEmTtwDuNk=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-137-qQfeAS0ENAy7Myc8Mf13Ig-1; Thu, 25 Aug 2022 20:08:09 -0400
X-MC-Unique: qQfeAS0ENAy7Myc8Mf13Ig-1
Received: by mail-io1-f72.google.com with SMTP id v14-20020a6b5b0e000000b0067bc967a6c0so30318ioh.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 17:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=hdzMOeIUQobXozAoBo+0gU24p6eUcuhYf3lPGxm6UuE=;
        b=lgl5L+PneRdAkM2QaHaLeXAQjDjpK65OBHhiAsLOV+8tlXDZDf+ky84DRMjYxMk3bs
         qKhHQFzDDTxR5xeWLad+adzrZnnyKTb2RuxNg8dkaXKx/KeEeiGlJcgO+HkJjHN61irn
         J4y36xi8tsdHQ1SHl7l0CJynD97mBY/DRuXukfehGprzEDFbqmJzjViQHSfg4sNIZKQ6
         Wy6PyXLG2Gg/wwK4fiodSnszuY+lu89vpNI4g4qEa9JqViwIGB6AyY3/zSxV4fVETJN2
         ebJADmA4bbF/eGQd7waPxM6TeHb7NkUrKtBqZmolEmrxTIOrfaNfLU25AHhm+Lqk2aQi
         SLDQ==
X-Gm-Message-State: ACgBeo1vMfaw8+lzEMekDe+FMKw1qpFHHLJHSAv87ZLZwwteLr5v5Fd/
        q98D3QG1sDgdVotFml9I9H2MnfCxxMdsY8fczCxN9S3xzUebCa4dwy+0JaVxQZVQsjpZPe8Sgr8
        DytCr/qvqZ+F4i9XwIsDl7Hwo
X-Received: by 2002:a05:6638:248c:b0:349:fddf:b80c with SMTP id x12-20020a056638248c00b00349fddfb80cmr2976476jat.261.1661472489144;
        Thu, 25 Aug 2022 17:08:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7ipYtHVVpEtusLYEDloHY4DKd6rUFDwJESB2zw/7x6ZSRdqLCMTAAE/E8tx/dwxcID0l2k4g==
X-Received: by 2002:a05:6638:248c:b0:349:fddf:b80c with SMTP id x12-20020a056638248c00b00349fddfb80cmr2976462jat.261.1661472488897;
        Thu, 25 Aug 2022 17:08:08 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id v6-20020a6bac06000000b00688dd369c7esm295480ioe.55.2022.08.25.17.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 17:08:08 -0700 (PDT)
Date:   Thu, 25 Aug 2022 18:08:07 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Laba, SlawomirX" <slawomirx.laba@intel.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: BUG: Virtual machine fails to start on 6.0-rc2
Message-ID: <20220825180807.020471c8.alex.williamson@redhat.com>
In-Reply-To: <DM6PR11MB3113DF6EC61D0AB73F3A2FE387729@DM6PR11MB3113.namprd11.prod.outlook.com>
References: <DM6PR11MB3113DF6EC61D0AB73F3A2FE387729@DM6PR11MB3113.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 23:42:47 +0000
"Laba, SlawomirX" <slawomirx.laba@intel.com> wrote:

> We were testing the changes for our VF devices and noticed an issue
> when starting VMs with passthrough VFs. We then moved back to
> mainline kernel and reproduced the issue on 6.0-rc2
> 
> We noticed that the startup of the KVM hangs.
> 
> Steps to reproduce:
> Create a VF from the PF interface.
> Configure VM XML with the VF PCI.
> Start the KVM.
> 
> To isolate the issue we moved back to kernel 5.19 and it was working
> fine.
> 
> Working tag v5.19
> Tested failing commit 4c612826bec1

Does this resolve the issue?

https://lore.kernel.org/all/166015037385.760108.16881097713975517242.stgit@omen/

This is currently in Andrew's mm-hotfixes-unstable branch and we're
waiting for it to be merged to mainline.  Thanks,

Alex
 
> [root@localhost sl]# uname -r
> 6.0.0-rc2-00159-g4c612826bec1
> [root@localhost sl]# echo 1 >
> /sys/class/net/ens785f3/device/sriov_numvfs [root@localhost sl]#
> virsh start rhel_9_0_first ^C
> [root@localhost sl]# virsh list --all
>  Id   Name             State
> -------------------------------
>  1    rhel_9_0_first   paused	
> 
> Dmesg:
> [  +0.042400] iavf: Intel(R) Ethernet Adaptive Virtual Function
> Network Driver [  +0.000004] Copyright (c) 2013 - 2018 Intel
> Corporation. [  +0.000309] iavf 0000:18:19.0: enabling device (0000
> -> 0002) [  +0.073471] iavf 0000:18:19.0: Invalid MAC address
> 00:00:00:00:00:00, using random [  +0.000674] iavf 0000:18:19.0:
> Multiqueue Enabled: Queue pair count = 16 [  +0.000466] iavf
> 0000:18:19.0: MAC address: 5a:0c:b5:f7:4f:0b [  +0.000003] iavf
> 0000:18:19.0: GRO is enabled [  +0.005941] iavf 0000:18:19.0
> ens785f3v0: renamed from eth0 [  +0.179174] IPv6:
> ADDRCONF(NETDEV_CHANGE): ens785f3v0: link becomes ready [  +0.000040]
> iavf 0000:18:19.0 ens785f3v0: NIC Link is Up Speed is 25 Gbps Full
> Duplex [ +26.408503] bridge: filtering via arp/ip/ip6tables is no
> longer available by default. Update your scripts to load br_netfilter
> if you need this. [  +0.399621] VFIO - User Level meta-driver
> version: 0.3 [  +0.151579] iavf 0000:18:19.0: Remove device [
> +0.292158] ice 0000:18:00.3 ens785f3: Setting MAC 52:54:00:9f:ea:de
> on VF 0. VF driver will be reinitialized [  +0.083676] ice
> 0000:18:00.3: Clearing port VLAN on VF 0 [  +0.155905] tun: Universal
> TUN/TAP device driver, 1.6 [  +0.000976] virbr0: port 1(vnet0)
> entered blocking state [  +0.000017] virbr0: port 1(vnet0) entered
> disabled state [  +0.000052] device vnet0 entered promiscuous mode [
> +0.000244] virbr0: port 1(vnet0) entered blocking state [  +0.000003]
> virbr0: port 1(vnet0) entered listening state [  +2.019924] virbr0:
> port 1(vnet0) entered learning state [  +2.047997] virbr0: port
> 1(vnet0) entered forwarding state [  +0.000018] virbr0: topology
> change detected, propagating [Aug25 19:12] INFO: task khugepaged:507
> blocked for more than 122 seconds. [  +0.000016]       Tainted: G
>    W I        6.0.0-rc2-00159-g4c612826bec1 #1 [  +0.000010] "echo 0
> > /proc/sys/kernel/hung_task_timeout_secs" disables this message. [
> > +0.000010] task:khugepaged      state:D stack:    0 pid:  507 ppid:
> >     2 flags:0x00004000 [  +0.000004] Call Trace:
> [  +0.000001]  <TASK>
> [  +0.000003]  __schedule+0x1bc/0x550
> [  +0.000006]  ? osq_unlock+0xf/0x90
> [  +0.000005]  schedule+0x5d/0xd0
> [  +0.000002]  rwsem_down_write_slowpath+0x2c9/0x5e0
> [  +0.000004]  ? find_vma+0x64/0x70
> [  +0.000004]  collapse_huge_page+0x1f8/0x8a0
> [  +0.000004]  ? _raw_spin_unlock+0x14/0x30
> [  +0.000002]  ? preempt_count_add+0x70/0xa0
> [  +0.000005]  ? _raw_spin_lock_irqsave+0x21/0x30
> [  +0.000001]  ? lock_timer_base+0x61/0x80
> [  +0.000005]  khugepaged_scan_pmd+0x33d/0x7b0
> [  +0.000003]  khugepaged_scan_mm_slot+0x155/0x440
> [  +0.000003]  khugepaged+0x189/0x3e0
> [  +0.000002]  ? preempt_count_add+0x70/0xa0
> [  +0.000002]  ? _raw_spin_unlock_irqrestore+0x1e/0x40
> [  +0.000002]  ? khugepaged_scan_mm_slot+0x440/0x440
> [  +0.000001]  kthread+0xf0/0x120
> [  +0.000003]  ? kthread_complete_and_exit+0x20/0x20
> [  +0.000003]  ret_from_fork+0x1f/0x30
> [  +0.000006]  </TASK>
> 
> On the working version there is a line that enables the interface for
> the VF which is missing on non-working one: [  +0.911730] vfio-pci
> 0000:18:19.0: enabling device (0000 -> 0002)
> 

