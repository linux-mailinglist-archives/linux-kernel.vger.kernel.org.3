Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7770A48B943
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 22:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbiAKVUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 16:20:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:32285 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231816AbiAKVUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 16:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641936042; x=1673472042;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version;
  bh=jqyGOe6Gae8wCI20XWEnjACFe3TDrjOPtMZH2fetrxU=;
  b=SHiv+K7OiR1cksp3INKrnF8tu+PI/lLLS+/Q2s0aZ/GgHs5cn0uoCPUc
   IYjO9151TN+fMNr3MT/zfd7P/vB623dugehC8Gq4z9EkDiRmxXW25RHlh
   AarTCtDUMLSMonsqglTnXe6xzhkEY7NTe2NZklM5pd/QVWFYurj5iP0QE
   DcYzlb8kol4P86wJidU2K389Ye+5rWVN6JjZ9NdIO3C7giBMo4wel/FQW
   OLLKFITzmxNLaEvSh/VO1uW9SUZA/XhUoHh4sJG2maczWEzH/L5m9IOoZ
   PPSIrQjtSsIiFnbyHFx+RI5DkAzTL2xPgvok8sXbBbbZFTfuORU+feIj9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243541653"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208,223";a="243541653"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 13:20:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208,223";a="528895008"
Received: from dchandr2-mobl.amr.corp.intel.com ([10.212.157.65])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 13:20:42 -0800
Message-ID: <3d677ec215006f2b4d08f1bd32c040e88d53ebde.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: ISST: do not hold lock
 punit_misc_dev_lock when register misc
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Liwei Song <liwei.song@windriver.com>,
        HansdeGoede <hdegoede@redhat.com>,
        MarkGross <markgross@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 11 Jan 2022 13:20:41 -0800
In-Reply-To: <20220111103122.32362-1-liwei.song@windriver.com>
References: <20220111103122.32362-1-liwei.song@windriver.com>
Content-Type: multipart/mixed; boundary="=-U6VPt1w4FtC2Ibwd43To"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-U6VPt1w4FtC2Ibwd43To
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Song,

Please check the attached and see if you can reproduce this.

Thanks,
Srinivas

On Tue, 2022-01-11 at 18:31 +0800, Liwei Song wrote:
> exist the below call sequences may cause deadlock:
> 
> isst_if_probe()
>    --> isst_if_cdev_register()
>       --> mutex_lock(&punit_misc_dev_lock)
>    --> misc_register()
>       --> mutex_lock(&misc_mtx)
> 
> misc_open()
>    --> mutex_lock(&misc_mtx)
>    --> isst_if_open()
>       --> mutex_lock(&punit_misc_dev_lock)
> 
> to fix this do not hold punit_misc_dev_lock when call misc_register
> since it has misc_mtx lock for sync.
> 
> [  256.104522] ======================================================
> [  256.113783] WARNING: possible circular locking dependency detected
> [  256.120093] 5.16.0-rc6-yocto-standard+ #99 Not tainted
> [  256.125362] ------------------------------------------------------
> [  256.131673] intel-speed-sel/844 is trying to acquire lock:
> [  256.137290] ffffffffc036f0d0 (punit_misc_dev_lock){+.+.}-{3:3},
> at: isst_if_open+0x18/0x90 [isst_if_common]
> [  256.147171]
> [  256.147171] but task is already holding lock:
> [  256.153135] ffffffff8ee7cb50 (misc_mtx){+.+.}-{3:3}, at:
> misc_open+0x2a/0x170
> [  256.160407]
> [  256.160407] which lock already depends on the new lock.
> [  256.160407]
> [  256.168712]
> [  256.168712] the existing dependency chain (in reverse order) is:
> [  256.176327]
> [  256.176327] -> #1 (misc_mtx){+.+.}-{3:3}:
> [  256.181946]        lock_acquire+0x1e6/0x330
> [  256.186265]        __mutex_lock+0x9b/0x9b0
> [  256.190497]        mutex_lock_nested+0x1b/0x20
> [  256.195075]        misc_register+0x32/0x1a0
> [  256.199390]        isst_if_cdev_register+0x65/0x180
> [isst_if_common]
> [  256.205878]        isst_if_probe+0x144/0x16e [isst_if_mmio]
> [  256.209991] hrtimer: interrupt took 10370 ns
> [  256.211582]        local_pci_probe+0x47/0xa0
> [  256.220384]        work_for_cpu_fn+0x17/0x30
> [  256.224790]        process_one_work+0x26a/0x650
> [  256.229456]        worker_thread+0x1dd/0x3b0
> [  256.233861]        kthread+0x191/0x1c0
> [  256.237745]        ret_from_fork+0x1f/0x30
> [  256.241976]
> [  256.241976] -> #0 (punit_misc_dev_lock){+.+.}-{3:3}:
> [  256.248552]        validate_chain+0xbc6/0x1750
> [  256.253131]        __lock_acquire+0x88c/0xc10
> [  256.257618]        lock_acquire+0x1e6/0x330
> [  256.261933]        __mutex_lock+0x9b/0x9b0
> [  256.266165]        mutex_lock_nested+0x1b/0x20
> [  256.270739]        isst_if_open+0x18/0x90 [isst_if_common]
> [  256.276356]        misc_open+0x100/0x170
> [  256.280409]        chrdev_open+0xa5/0x1e0
> [  256.284550]        do_dentry_open+0x23d/0x3c0
> [  256.289039]        vfs_open+0x2f/0x40
> [  256.292836]        path_openat+0x87a/0x940
> [  256.297064]        do_filp_open+0xc5/0x140
> [  256.301295]        do_sys_openat2+0x23d/0x320
> [  256.305782]        do_sys_open+0x59/0x80
> [  256.309836]        __x64_sys_openat+0x20/0x30
> [  256.314324]        do_syscall_64+0x3f/0x90
> [  256.318552]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  256.324259]
> [  256.324259] other info that might help us debug this:
> [  256.324259]
> [  256.332394]  Possible unsafe locking scenario:
> [  256.332394]
> [  256.338444]        CPU0                    CPU1
> [  256.343105]        ----                    ----
> [  256.347768]   lock(misc_mtx);
> [  256.350870]                                lock(punit_misc_dev_loc
> k);
> [  256.357441]                                lock(misc_mtx);
> [  256.363058]   lock(punit_misc_dev_lock);
> [  256.367110]
> [  256.367110]  *** DEADLOCK ***
> [  256.367110]
> [  256.373162] 1 lock held by intel-speed-sel/844:
> [  256.377824]  #0: ffffffff8ee7cb50 (misc_mtx){+.+.}-{3:3}, at:
> misc_open+0x2a/0x170
> [  256.385531]
> [  256.385531] stack backtrace:
> [  256.390021] CPU: 12 PID: 844 Comm: intel-speed-sel Not tainted
> 5.16.0-rc6-yocto-standard+ #99
> [  256.398678] Hardware name: ACCTON MOROCITY/MOROCITY, BIOS
> IDVLCRB1.86B.0021.D09.2111010103 11/01/2021
> [  256.408028] Call Trace:
> [  256.410605]  <TASK>
> [  256.412837]  dump_stack_lvl+0x5b/0x82
> [  256.416635]  dump_stack+0x10/0x12
> [  256.420085]  print_circular_bug.isra.43+0x261/0x2c0
> [  256.425095]  check_noncircular+0x126/0x140
> [  256.429326]  ? __this_cpu_preempt_check+0x13/0x20
> [  256.434167]  validate_chain+0xbc6/0x1750
> [  256.438223]  ? validate_chain+0xbc6/0x1750
> [  256.442451]  ? validate_chain+0x236/0x1750
> [  256.446687]  __lock_acquire+0x88c/0xc10
> [  256.450658]  lock_acquire+0x1e6/0x330
> [  256.454452]  ? isst_if_open+0x18/0x90 [isst_if_common]
> [  256.459726]  ? __mutex_lock+0x79/0x9b0
> [  256.463610]  ? __mutex_lock+0x79/0x9b0
> [  256.467493]  ? isst_if_open+0x18/0x90 [isst_if_common]
> [  256.472764]  ? isst_if_open+0x18/0x90 [isst_if_common]
> [  256.478038]  __mutex_lock+0x9b/0x9b0
> [  256.481748]  ? isst_if_open+0x18/0x90 [isst_if_common]
> [  256.487021]  ? __mutex_lock+0x102/0x9b0
> [  256.490993]  ? __this_cpu_preempt_check+0x13/0x20
> [  256.495837]  mutex_lock_nested+0x1b/0x20
> [  256.499893]  ? mutex_lock_nested+0x1b/0x20
> [  256.504121]  isst_if_open+0x18/0x90 [isst_if_common]
> [  256.509222]  misc_open+0x100/0x170
> [  256.512759]  chrdev_open+0xa5/0x1e0
> [  256.516386]  ? cdev_put.part.1+0x20/0x20
> [  256.520441]  do_dentry_open+0x23d/0x3c0
> [  256.524414]  vfs_open+0x2f/0x40
> [  256.527689]  path_openat+0x87a/0x940
> [  256.531399]  do_filp_open+0xc5/0x140
> [  256.535112]  ? trace_preempt_on+0x28/0xd0
> [  256.539255]  ? alloc_fd+0x152/0x230
> [  256.542880]  ? preempt_count_sub+0x9b/0x100
> [  256.547200]  ? _raw_spin_unlock+0x2c/0x50
> [  256.551348]  do_sys_openat2+0x23d/0x320
> [  256.555320]  ? do_sys_openat2+0x23d/0x320
> [  256.559467]  do_sys_open+0x59/0x80
> [  256.563003]  __x64_sys_openat+0x20/0x30
> [  256.566972]  do_syscall_64+0x3f/0x90
> [  256.570680]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  256.575866] RIP: 0033:0x7f9be4b97c27
> [  256.579576] Code: 25 00 00 41 00 3d 00 00 41 00 74 37 64 8b 04 25
> 18 00 00 00 85 c0 75 5b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00
> 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 85 00 00 00 48 83 c4 68 5d 41 5c
> c3 0f 1f
> [  256.598474] RSP: 002b:00007ffd8fc01b70 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000101
> [  256.606177] RAX: ffffffffffffffda RBX: 00005572f20332b0 RCX:
> 00007f9be4b97c27
> [  256.613443] RDX: 0000000000000000 RSI: 00005572f202936a RDI:
> 00000000ffffff9c
> [  256.620709] RBP: 00005572f202936a R08: 0000000000000008 R09:
> 0000000000000001
> [  256.627974] R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000000000000000
> [  256.635241] R13: 00005572f20332b0 R14: 0000000000000001 R15:
> 0000000000000000
> [  256.642513]  </TASK>
> 
> Signed-off-by: Liwei Song <liwei.song@windriver.com>
> ---
>  drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 6
> +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git
> a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index c9a85eb2e860..bcbc0d508ec4 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -693,10 +693,12 @@ int isst_if_cdev_register(int device_type,
> struct isst_if_cmd_cb *cb)
>  	if (!misc_usage_count) {
>  		int ret;
>  
> +		mutex_unlock(&punit_misc_dev_lock);
>  		misc_device_ret = misc_register(&isst_if_char_driver);
>  		if (misc_device_ret)
> -			goto unlock_exit;
> +			return misc_device_ret;
>  
> +		mutex_lock(&punit_misc_dev_lock);
>  		ret = isst_if_cpu_info_init();
>  		if (ret) {
>  			misc_deregister(&isst_if_char_driver);
> @@ -731,7 +733,9 @@ void isst_if_cdev_unregister(int device_type)
>  	if (device_type == ISST_IF_DEV_MBOX)
>  		isst_delete_hash();
>  	if (!misc_usage_count && !misc_device_ret) {
> +		mutex_unlock(&punit_misc_dev_lock);
>  		misc_deregister(&isst_if_char_driver);
> +		mutex_lock(&punit_misc_dev_lock);
>  		isst_if_cpu_info_exit();
>  	}
>  	mutex_unlock(&punit_misc_dev_lock);

--=-U6VPt1w4FtC2Ibwd43To
Content-Disposition: attachment;
	filename*0=0001-platform-x86-ISST-Fix-possible-circular-locking-depe.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-platform-x86-ISST-Fix-possible-circular-locking-depe.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSBlOTJjOWM0MjlkYmQyNTk3NzhiOTRjNDVjNDcyM2RkYjBkMTY3MGZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2
YWRhQGxpbnV4LmludGVsLmNvbT4KRGF0ZTogVHVlLCAxMSBKYW4gMjAyMiAxMjowNDoyOCAtMDgw
MApTdWJqZWN0OiBbUEFUQ0hdIHBsYXRmb3JtL3g4NjogSVNTVDogRml4IHBvc3NpYmxlIGNpcmN1
bGFyIGxvY2tpbmcgZGVwZW5kZW5jeQogZGV0ZWN0ZWQKCkFzIHJlcG9ydGVkOgoKWyAgMjU2LjEw
NDUyMl0gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09ClsgIDI1Ni4xMTM3ODNdIFdBUk5JTkc6IHBvc3NpYmxlIGNpcmN1bGFyIGxvY2tpbmcgZGVw
ZW5kZW5jeSBkZXRlY3RlZApbICAyNTYuMTIwMDkzXSA1LjE2LjAtcmM2LXlvY3RvLXN0YW5kYXJk
KyAjOTkgTm90IHRhaW50ZWQKWyAgMjU2LjEyNTM2Ml0gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClsgIDI1Ni4xMzE2NzNdIGludGVsLXNwZWVk
LXNlbC84NDQgaXMgdHJ5aW5nIHRvIGFjcXVpcmUgbG9jazoKWyAgMjU2LjEzNzI5MF0gZmZmZmZm
ZmZjMDM2ZjBkMCAocHVuaXRfbWlzY19kZXZfbG9jayl7Ky4rLn0tezM6M30sIGF0OiBpc3N0X2lm
X29wZW4rMHgxOC8weDkwIFtpc3N0X2lmX2NvbW1vbl0KWyAgMjU2LjE0NzE3MV0KWyAgMjU2LjE0
NzE3MV0gYnV0IHRhc2sgaXMgYWxyZWFkeSBob2xkaW5nIGxvY2s6ClsgIDI1Ni4xNTMxMzVdIGZm
ZmZmZmZmOGVlN2NiNTAgKG1pc2NfbXR4KXsrLisufS17MzozfSwgYXQ6IG1pc2Nfb3BlbisweDJh
LzB4MTcwClsgIDI1Ni4xNjA0MDddClsgIDI1Ni4xNjA0MDddIHdoaWNoIGxvY2sgYWxyZWFkeSBk
ZXBlbmRzIG9uIHRoZSBuZXcgbG9jay4KWyAgMjU2LjE2MDQwN10KWyAgMjU2LjE2ODcxMl0KWyAg
MjU2LjE2ODcxMl0gdGhlIGV4aXN0aW5nIGRlcGVuZGVuY3kgY2hhaW4gKGluIHJldmVyc2Ugb3Jk
ZXIpIGlzOgpbICAyNTYuMTc2MzI3XQpbICAyNTYuMTc2MzI3XSAtPiAjMSAobWlzY19tdHgpeysu
Ky59LXszOjN9OgpbICAyNTYuMTgxOTQ2XSAgICAgICAgbG9ja19hY3F1aXJlKzB4MWU2LzB4MzMw
ClsgIDI1Ni4xODYyNjVdICAgICAgICBfX211dGV4X2xvY2srMHg5Yi8weDliMApbICAyNTYuMTkw
NDk3XSAgICAgICAgbXV0ZXhfbG9ja19uZXN0ZWQrMHgxYi8weDIwClsgIDI1Ni4xOTUwNzVdICAg
ICAgICBtaXNjX3JlZ2lzdGVyKzB4MzIvMHgxYTAKWyAgMjU2LjE5OTM5MF0gICAgICAgIGlzc3Rf
aWZfY2Rldl9yZWdpc3RlcisweDY1LzB4MTgwIFtpc3N0X2lmX2NvbW1vbl0KWyAgMjU2LjIwNTg3
OF0gICAgICAgIGlzc3RfaWZfcHJvYmUrMHgxNDQvMHgxNmUgW2lzc3RfaWZfbW1pb10KLi4uClsg
IDI1Ni4yNDE5NzZdClsgIDI1Ni4yNDE5NzZdIC0+ICMwIChwdW5pdF9taXNjX2Rldl9sb2NrKXsr
LisufS17MzozfToKWyAgMjU2LjI0ODU1Ml0gICAgICAgIHZhbGlkYXRlX2NoYWluKzB4YmM2LzB4
MTc1MApbICAyNTYuMjUzMTMxXSAgICAgICAgX19sb2NrX2FjcXVpcmUrMHg4OGMvMHhjMTAKWyAg
MjU2LjI1NzYxOF0gICAgICAgIGxvY2tfYWNxdWlyZSsweDFlNi8weDMzMApbICAyNTYuMjYxOTMz
XSAgICAgICAgX19tdXRleF9sb2NrKzB4OWIvMHg5YjAKWyAgMjU2LjI2NjE2NV0gICAgICAgIG11
dGV4X2xvY2tfbmVzdGVkKzB4MWIvMHgyMApbICAyNTYuMjcwNzM5XSAgICAgICAgaXNzdF9pZl9v
cGVuKzB4MTgvMHg5MCBbaXNzdF9pZl9jb21tb25dClsgIDI1Ni4yNzYzNTZdICAgICAgICBtaXNj
X29wZW4rMHgxMDAvMHgxNzAKWyAgMjU2LjI4MDQwOV0gICAgICAgIGNocmRldl9vcGVuKzB4YTUv
MHgxZTAKLi4uCgpUaGUgY2FsbCBzZXF1ZW5jZSBzdWdnZXN0ZWQgdGhhdCBtaXNjX2RldmljZSAv
ZGV2IGZpbGUgY2FuIGJlIG9wZW5lZApiZWZvcmUgbWlzYyBkZXZpY2UgaXMgeWV0IHRvIGJlIHJl
Z2lzdGVyZWQsIHdoaWNoIGlzIGRvbmUgb25seSBvbmNlLgoKSGVyZSBwdW5pdF9taXNjX2Rldl9s
b2NrIHdhcyB1c2VkIGFzIGNvbW1vbiBsb2NrLCB0byBwcm90ZWN0IHRoZQpyZWdpc3RyYXRpb24g
YnkgSVNTVCBIVyBkcml2ZXJzLCBvbmUgdGltZSBzZXR1cCwgcHJldmVudCBkdXBsaWNhdGUKcmVn
aXN0cnkgb2YgbWlzYyBkZXZpY2UgYW5kIHByZXZlbnQgbG9hZC91bmxvYWQgd2hlbiBkZXZpY2Ug
aXMgb3Blbi4KCldlIGNhbiBzcGxpdCBpbnRvIGxvY2tzOgotIE9uZSB3aGljaCBqdXN0IHByZXZl
bnQgZHVwbGljYXRlIGNhbGwgdG8gbWlzY19yZWdpc3RlcigpIGFuZCBvbmUKdGltZSBzZXR1cC4g
QWxzbyBuZXZlciBjYWxsIGFnYWluIGlmIHRoZSBtaXNjX3JlZ2lzdGVyKCkgZmFpbGVkIG9yCnJl
cXVpcmVkIG9uZSB0aW1lIHNldHVwIGlzIGZhaWxlZC4gVGhpcyBsb2NrIGlzIG5vdCBzaGFyZWQg
d2l0aAphbnkgbWlzYyBkZXZpY2UgY2FsbGJhY2tzLgoKLSBUaGUgb3RoZXIgbG9jayBwcm90ZWN0
cyByZWdpc3RyeSwgbG9hZCBhbmQgdW5sb2FkIG9mIEhXIGRyaXZlcnMuCgpTZXF1ZW5jZSBpbiBp
c3N0X2lmX2NkZXZfcmVnaXN0ZXIoKQotIFJlZ2lzdGVyIGNhbGxiYWNrcyB1bmRlciBwdW5pdF9t
aXNjX2Rldl9vcGVuX2xvY2sKLSBDYWxsIGlzc3RfbWlzY19yZWcoKSB3aGljaCByZWdpc3RlcnMg
bWlzY19kZXZpY2Ugb24gdGhlIGZpcnN0CnJlZ2lzdHJ5IHdoaWNoIGlzIHVuZGVyIHB1bml0X21p
c2NfZGV2X3JlZ19sb2NrLCB3aGljaCBpcyBub3QKc2hhcmVkIHdpdGggY2FsbGJhY2tzLgoKU2Vx
dWVuY2UgaW4gaXNzdF9pZl9jZGV2X3VucmVnaXN0ZXIKSnVzdCBvcHBvc2l0ZSBvZiBpc3N0X2lm
X2NkZXZfcmVnaXN0ZXIKClJlcG9ydGVkLWJ5OiBMaXdlaSBTb25nIDxsaXdlaS5zb25nQHdpbmRy
aXZlci5jb20+ClNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzIFBhbmRydXZhZGEgPHNyaW5pdmFzLnBh
bmRydXZhZGFAbGludXguaW50ZWwuY29tPgotLS0KIC4uLi9pbnRlbC9zcGVlZF9zZWxlY3RfaWYv
aXNzdF9pZl9jb21tb24uYyAgICB8IDk3ICsrKysrKysrKysrKy0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA2MyBpbnNlcnRpb25zKCspLCAzNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9zcGVlZF9zZWxlY3RfaWYvaXNzdF9pZl9jb21tb24uYyBi
L2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3NwZWVkX3NlbGVjdF9pZi9pc3N0X2lmX2NvbW1v
bi5jCmluZGV4IGM5YTg1ZWIyZTg2MC4uZTg0MjRlNzBkODFkIDEwMDY0NAotLS0gYS9kcml2ZXJz
L3BsYXRmb3JtL3g4Ni9pbnRlbC9zcGVlZF9zZWxlY3RfaWYvaXNzdF9pZl9jb21tb24uYworKysg
Yi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9zcGVlZF9zZWxlY3RfaWYvaXNzdF9pZl9jb21t
b24uYwpAQCAtNTk2LDcgKzU5NiwxMCBAQCBzdGF0aWMgbG9uZyBpc3N0X2lmX2RlZl9pb2N0bChz
dHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50IGNtZCwKIAlyZXR1cm4gcmV0OwogfQogCi1z
dGF0aWMgREVGSU5FX01VVEVYKHB1bml0X21pc2NfZGV2X2xvY2spOworLyogTG9jayB0byBwcmV2
ZW50IG1vZHVsZSByZWdpc3RyYXRpb24gd2hlbiBhbHJlYWR5IG9wZW5lZCBieSB1c2VyIHNwYWNl
ICovCitzdGF0aWMgREVGSU5FX01VVEVYKHB1bml0X21pc2NfZGV2X29wZW5fbG9jayk7CisvKiBM
b2NrIHRvIGFsbG93IG9uZSBzaGFyZSBtaXNjIGRldmljZSBmb3IgYWxsIElTU1QgaW50ZXJhY2Ug
Ki8KK3N0YXRpYyBERUZJTkVfTVVURVgocHVuaXRfbWlzY19kZXZfcmVnX2xvY2spOwogc3RhdGlj
IGludCBtaXNjX3VzYWdlX2NvdW50Owogc3RhdGljIGludCBtaXNjX2RldmljZV9yZXQ7CiBzdGF0
aWMgaW50IG1pc2NfZGV2aWNlX29wZW47CkBAIC02MDYsNyArNjA5LDcgQEAgc3RhdGljIGludCBp
c3N0X2lmX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpCiAJaW50
IGksIHJldCA9IDA7CiAKIAkvKiBGYWlsIG9wZW4sIGlmIGEgbW9kdWxlIGlzIGdvaW5nIGF3YXkg
Ki8KLQltdXRleF9sb2NrKCZwdW5pdF9taXNjX2Rldl9sb2NrKTsKKwltdXRleF9sb2NrKCZwdW5p
dF9taXNjX2Rldl9vcGVuX2xvY2spOwogCWZvciAoaSA9IDA7IGkgPCBJU1NUX0lGX0RFVl9NQVg7
ICsraSkgewogCQlzdHJ1Y3QgaXNzdF9pZl9jbWRfY2IgKmNiID0gJnB1bml0X2NhbGxiYWNrc1tp
XTsKIApAQCAtNjI4LDcgKzYzMSw3IEBAIHN0YXRpYyBpbnQgaXNzdF9pZl9vcGVuKHN0cnVjdCBp
bm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKQogCX0gZWxzZSB7CiAJCW1pc2NfZGV2aWNl
X29wZW4rKzsKIAl9Ci0JbXV0ZXhfdW5sb2NrKCZwdW5pdF9taXNjX2Rldl9sb2NrKTsKKwltdXRl
eF91bmxvY2soJnB1bml0X21pc2NfZGV2X29wZW5fbG9jayk7CiAKIAlyZXR1cm4gcmV0OwogfQpA
QCAtNjM3LDcgKzY0MCw3IEBAIHN0YXRpYyBpbnQgaXNzdF9pZl9yZWxhc2Uoc3RydWN0IGlub2Rl
ICppbm9kZSwgc3RydWN0IGZpbGUgKmYpCiB7CiAJaW50IGk7CiAKLQltdXRleF9sb2NrKCZwdW5p
dF9taXNjX2Rldl9sb2NrKTsKKwltdXRleF9sb2NrKCZwdW5pdF9taXNjX2Rldl9vcGVuX2xvY2sp
OwogCW1pc2NfZGV2aWNlX29wZW4tLTsKIAlmb3IgKGkgPSAwOyBpIDwgSVNTVF9JRl9ERVZfTUFY
OyArK2kpIHsKIAkJc3RydWN0IGlzc3RfaWZfY21kX2NiICpjYiA9ICZwdW5pdF9jYWxsYmFja3Nb
aV07CkBAIC02NDUsNyArNjQ4LDcgQEAgc3RhdGljIGludCBpc3N0X2lmX3JlbGFzZShzdHJ1Y3Qg
aW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZikKIAkJaWYgKGNiLT5yZWdpc3RlcmVkKQogCQkJ
bW9kdWxlX3B1dChjYi0+b3duZXIpOwogCX0KLQltdXRleF91bmxvY2soJnB1bml0X21pc2NfZGV2
X2xvY2spOworCW11dGV4X3VubG9jaygmcHVuaXRfbWlzY19kZXZfb3Blbl9sb2NrKTsKIAogCXJl
dHVybiAwOwogfQpAQCAtNjYyLDYgKzY2NSw0MyBAQCBzdGF0aWMgc3RydWN0IG1pc2NkZXZpY2Ug
aXNzdF9pZl9jaGFyX2RyaXZlciA9IHsKIAkuZm9wcwkJPSAmaXNzdF9pZl9jaGFyX2RyaXZlcl9v
cHMsCiB9OwogCitzdGF0aWMgaW50IGlzc3RfbWlzY19yZWcodm9pZCkKK3sKKwltdXRleF9sb2Nr
KCZwdW5pdF9taXNjX2Rldl9yZWdfbG9jayk7CisJaWYgKG1pc2NfZGV2aWNlX3JldCkKKwkJZ290
byB1bmxvY2tfZXhpdDsKKworCWlmICghbWlzY191c2FnZV9jb3VudCkgeworCQltaXNjX2Rldmlj
ZV9yZXQgPSBpc3N0X2lmX2NwdV9pbmZvX2luaXQoKTsKKwkJaWYgKG1pc2NfZGV2aWNlX3JldCkK
KwkJCWdvdG8gdW5sb2NrX2V4aXQ7CisKKwkJbWlzY19kZXZpY2VfcmV0ID0gbWlzY19yZWdpc3Rl
cigmaXNzdF9pZl9jaGFyX2RyaXZlcik7CisJCWlmIChtaXNjX2RldmljZV9yZXQpIHsKKwkJCWlz
c3RfaWZfY3B1X2luZm9fZXhpdCgpOworCQkJZ290byB1bmxvY2tfZXhpdDsKKwkJfQorCX0KKwlt
aXNjX3VzYWdlX2NvdW50Kys7CisKK3VubG9ja19leGl0OgorCW11dGV4X3VubG9jaygmcHVuaXRf
bWlzY19kZXZfcmVnX2xvY2spOworCisJcmV0dXJuIG1pc2NfZGV2aWNlX3JldDsKK30KKworc3Rh
dGljIHZvaWQgaXNzdF9taXNjX3VucmVnKHZvaWQpCit7CisJbXV0ZXhfbG9jaygmcHVuaXRfbWlz
Y19kZXZfcmVnX2xvY2spOworCWlmIChtaXNjX3VzYWdlX2NvdW50KQorCQltaXNjX3VzYWdlX2Nv
dW50LS07CisJaWYgKCFtaXNjX3VzYWdlX2NvdW50ICYmICFtaXNjX2RldmljZV9yZXQpIHsKKwkJ
bWlzY19kZXJlZ2lzdGVyKCZpc3N0X2lmX2NoYXJfZHJpdmVyKTsKKwkJaXNzdF9pZl9jcHVfaW5m
b19leGl0KCk7CisJfQorCW11dGV4X3VubG9jaygmcHVuaXRfbWlzY19kZXZfcmVnX2xvY2spOwor
fQorCiAvKioKICAqIGlzc3RfaWZfY2Rldl9yZWdpc3RlcigpIC0gUmVnaXN0ZXIgY2FsbGJhY2sg
Zm9yIElPQ1RMCiAgKiBAZGV2aWNlX3R5cGU6IFRoZSBkZXZpY2UgdHlwZSB0aGlzIGNhbGxiYWNr
IGhhbmRsaW5nLgpAQCAtNjc5LDM4ICs3MTksMzEgQEAgc3RhdGljIHN0cnVjdCBtaXNjZGV2aWNl
IGlzc3RfaWZfY2hhcl9kcml2ZXIgPSB7CiAgKi8KIGludCBpc3N0X2lmX2NkZXZfcmVnaXN0ZXIo
aW50IGRldmljZV90eXBlLCBzdHJ1Y3QgaXNzdF9pZl9jbWRfY2IgKmNiKQogewotCWlmIChtaXNj
X2RldmljZV9yZXQpCi0JCXJldHVybiBtaXNjX2RldmljZV9yZXQ7CisJaW50IHJldDsKIAogCWlm
IChkZXZpY2VfdHlwZSA+PSBJU1NUX0lGX0RFVl9NQVgpCiAJCXJldHVybiAtRUlOVkFMOwogCi0J
bXV0ZXhfbG9jaygmcHVuaXRfbWlzY19kZXZfbG9jayk7CisJbXV0ZXhfbG9jaygmcHVuaXRfbWlz
Y19kZXZfb3Blbl9sb2NrKTsKKwkvKiBEZXZpY2UgaXMgYWxyZWFkeSBvcGVuLCB3ZSBkb24ndCB3
YW50IHRvIGFkZCBuZXcgY2FsbGJhY2tzICovCiAJaWYgKG1pc2NfZGV2aWNlX29wZW4pIHsKLQkJ
bXV0ZXhfdW5sb2NrKCZwdW5pdF9taXNjX2Rldl9sb2NrKTsKKwkJbXV0ZXhfdW5sb2NrKCZwdW5p
dF9taXNjX2Rldl9vcGVuX2xvY2spOwogCQlyZXR1cm4gLUVBR0FJTjsKIAl9Ci0JaWYgKCFtaXNj
X3VzYWdlX2NvdW50KSB7Ci0JCWludCByZXQ7Ci0KLQkJbWlzY19kZXZpY2VfcmV0ID0gbWlzY19y
ZWdpc3RlcigmaXNzdF9pZl9jaGFyX2RyaXZlcik7Ci0JCWlmIChtaXNjX2RldmljZV9yZXQpCi0J
CQlnb3RvIHVubG9ja19leGl0OwotCi0JCXJldCA9IGlzc3RfaWZfY3B1X2luZm9faW5pdCgpOwot
CQlpZiAocmV0KSB7Ci0JCQltaXNjX2RlcmVnaXN0ZXIoJmlzc3RfaWZfY2hhcl9kcml2ZXIpOwot
CQkJbWlzY19kZXZpY2VfcmV0ID0gcmV0OwotCQkJZ290byB1bmxvY2tfZXhpdDsKLQkJfQotCX0K
IAltZW1jcHkoJnB1bml0X2NhbGxiYWNrc1tkZXZpY2VfdHlwZV0sIGNiLCBzaXplb2YoKmNiKSk7
CiAJcHVuaXRfY2FsbGJhY2tzW2RldmljZV90eXBlXS5yZWdpc3RlcmVkID0gMTsKLQltaXNjX3Vz
YWdlX2NvdW50Kys7Ci11bmxvY2tfZXhpdDoKLQltdXRleF91bmxvY2soJnB1bml0X21pc2NfZGV2
X2xvY2spOworCW11dGV4X3VubG9jaygmcHVuaXRfbWlzY19kZXZfb3Blbl9sb2NrKTsKIAotCXJl
dHVybiBtaXNjX2RldmljZV9yZXQ7CisJcmV0ID0gaXNzdF9taXNjX3JlZygpOworCWlmIChyZXQp
IHsKKwkJLyoKKwkJICogTm8gbmVlZCBvZiBtdXRleCBhcyB0aGUgbWlzYyBkZXZpY2UgcmVnaXN0
ZXIgZmFpbGVkCisJCSAqIGFzIG5vIG9uZSBjYW4gb3BlbiBkZXZpY2UgeWV0LiBIZW5jZSBubyBj
b250ZW50aW9uLgorCQkgKi8KKwkJcHVuaXRfY2FsbGJhY2tzW2RldmljZV90eXBlXS5yZWdpc3Rl
cmVkID0gMDsKKwkJcmV0dXJuIHJldDsKKwl9CisJcmV0dXJuIDA7CiB9CiBFWFBPUlRfU1lNQk9M
X0dQTChpc3N0X2lmX2NkZXZfcmVnaXN0ZXIpOwogCkBAIC03MjUsMTYgKzc1OCwxMiBAQCBFWFBP
UlRfU1lNQk9MX0dQTChpc3N0X2lmX2NkZXZfcmVnaXN0ZXIpOwogICovCiB2b2lkIGlzc3RfaWZf
Y2Rldl91bnJlZ2lzdGVyKGludCBkZXZpY2VfdHlwZSkKIHsKLQltdXRleF9sb2NrKCZwdW5pdF9t
aXNjX2Rldl9sb2NrKTsKLQltaXNjX3VzYWdlX2NvdW50LS07CisJaXNzdF9taXNjX3VucmVnKCk7
CisJbXV0ZXhfbG9jaygmcHVuaXRfbWlzY19kZXZfb3Blbl9sb2NrKTsKIAlwdW5pdF9jYWxsYmFj
a3NbZGV2aWNlX3R5cGVdLnJlZ2lzdGVyZWQgPSAwOwogCWlmIChkZXZpY2VfdHlwZSA9PSBJU1NU
X0lGX0RFVl9NQk9YKQogCQlpc3N0X2RlbGV0ZV9oYXNoKCk7Ci0JaWYgKCFtaXNjX3VzYWdlX2Nv
dW50ICYmICFtaXNjX2RldmljZV9yZXQpIHsKLQkJbWlzY19kZXJlZ2lzdGVyKCZpc3N0X2lmX2No
YXJfZHJpdmVyKTsKLQkJaXNzdF9pZl9jcHVfaW5mb19leGl0KCk7Ci0JfQotCW11dGV4X3VubG9j
aygmcHVuaXRfbWlzY19kZXZfbG9jayk7CisJbXV0ZXhfdW5sb2NrKCZwdW5pdF9taXNjX2Rldl9v
cGVuX2xvY2spOwogfQogRVhQT1JUX1NZTUJPTF9HUEwoaXNzdF9pZl9jZGV2X3VucmVnaXN0ZXIp
OwogCi0tIAoyLjI1LjEKCg==


--=-U6VPt1w4FtC2Ibwd43To--

