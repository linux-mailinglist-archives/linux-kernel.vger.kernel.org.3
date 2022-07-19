Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA47F57A8BD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239669AbiGSVCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiGSVCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:02:15 -0400
X-Greylist: delayed 163 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Jul 2022 14:02:13 PDT
Received: from cmx-mtlrgo002.bell.net (mta-mtl-002.bell.net [209.71.208.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E28E34F1B2;
        Tue, 19 Jul 2022 14:02:13 -0700 (PDT)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [142.181.186.4]
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 62D6EBC60007B342
X-CM-Envelope: MS4xfPDKSqTeFgeIo8sbqKxR534z6yt384bsV8dXD9yb2d5RklzIIvS0QtRMICXbTr3KmV3474YlZmZ3fHkVEFb0DRCVSxQmSjtNIuq0erVxKynvy+EfI/yw
 YqR9kLNggq2GhFioaZUdba4iV2qRynrMnWXQfs9134YiR45T9nPbNh5p+nwI30D7K5YIiFH2xCqUrKWlgfiV8IX5xfuorlvo9/qNZUDRjMmoUj8WVEzIZzM9
 Ga+LfnxMDAhEpeolnuhn0fir7UXznKCsppsyQ1EkpkwlXoRjVPMuK3yUUMPGHdET4cx3jRrImRycVC1zZkPD7FOhMs8Cg3PyiRCj89NQHrwKrmiBXPpjisAG
 UeUOhPSq
X-CM-Analysis: v=2.4 cv=FMx4e8ks c=1 sm=1 tr=0 ts=62d71b28
 a=HvfK566jdESv8vPwpMqobg==:117 a=HvfK566jdESv8vPwpMqobg==:17
 a=IkcTkHD0fZMA:10 a=2e59O1INAAAA:8 a=FBHGMhGWAAAA:8 a=GJOq0uU_-oSRmziDgnsA:9
 a=QEXdDO2ut3YA:10 a=qinn3d7XxS3vONFlH6pt:22 a=9gvnlMMaQFpL9xblJ6ne:22
Received: from [192.168.2.49] (142.181.186.4) by cmx-mtlrgo002.bell.net (5.8.807) (authenticated as dave.anglin@bell.net)
        id 62D6EBC60007B342; Tue, 19 Jul 2022 16:59:20 -0400
Message-ID: <7d53692b-6ac8-e1bd-4d0d-7e97aa01b18d@bell.net>
Date:   Tue, 19 Jul 2022 16:59:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365
 dentry_free+0x100/0x128
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>, Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20220709090756.2384-1-hdanton@sina.com>
 <20220715133300.1297-1-hdanton@sina.com>
 <cff76e00-3561-4069-f5c7-26d3de4da3c4@gmx.de>
 <20220717113634.1552-1-hdanton@sina.com>
 <0aa365ca-a9f0-8d15-b515-adb8823f5d28@gmx.de>
From:   John David Anglin <dave.anglin@bell.net>
In-Reply-To: <0aa365ca-a9f0-8d15-b515-adb8823f5d28@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

I hit this warning with the patch below building ghc on mx3210:

mx3210 login: ------------[ cut here ]------------
WARNING: CPU: 2 PID: 32654 at fs/dcache.c:365 dentry_free+0xfc/0x108
Modules linked in: binfmt_misc ext2 ext4 crc16 mbcache jbd2 ipmi_watchdog sg ipmi_si ipmi_poweroff ipmi_devintf ipmi_msghandler fuse nfsd 
ip_tables x_tables ipv6 autofs4 xfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c 
crc32c_generic raid1 raid0 multipath linear md_mod sd_mod t10_pi ses enclosure scsi_transport_sas crc64_rocksoft crc64 uas usb_storage sr_mod 
cdrom ohci_pci sym53c8xx pata_cmd64x ehci_pci ohci_hcd libata scsi_transport_spi ehci_hcd tg3 scsi_mod usbcore scsi_common usb_common
CPU: 2 PID: 32654 Comm: cc1 Not tainted 5.18.12+ #2
Hardware name: 9000/800/rp3440

      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
PSW: 00001000000001000110100000001111 Not tainted
r00-03  000000000804680f 00000040ce7fc880 00000000404f2b74 00000040ce7fc920
r04-07  0000000040be4940 000000410f6cd630 00000001413e4068 000000410f6cd688
r08-11  0000000040fd2e60 0000000040bc5020 0000000040c2c940 00000000000800e0
r12-15  0000000040c2c940 0000000000000001 0000000040c2c940 000000410f6cd688
r16-19  00000001f9fe105d 00000040ce7fc1f8 000000000000002f 000000000a0c1000
r20-23  000000000800000f 000000000800000f 000000410f6cd639 000000000800000f
r24-27  0000000000000000 0000000000000385 000000410f6cd630 0000000040be4940
r28-31  0000000041104530 00000040ce7fc8f0 00000040ce7fc9a0 0000000000000000
sr00-03  0000000000a03800 0000000000000000 0000000000000000 0000000000a03800
sr04-07  0000000000000000 0000000000000000 0000000000000000 0000000000000000

IASQ: 0000000000000000 0000000000000000 IAOQ: 00000000404f18bc 00000000404f18c0
  IIR: 03ffe01f    ISR: 0000000010350000  IOR: 00000239ff3fc928
  CPU:        2   CR30: 00000040cadd1380 CR31: ffffffffffffffff
  ORIG_R28: 00000040ce7fcb70
  IAOQ[0]: dentry_free+0xfc/0x108
  IAOQ[1]: dentry_free+0x100/0x108
  RP(r2): __dentry_kill+0x2bc/0x338
Backtrace:
  [<00000000404f2b74>] __dentry_kill+0x2bc/0x338
  [<00000000404f37b8>] dentry_kill+0xb0/0x318
  [<00000000404f3d08>] dput+0x2e8/0x328
  [<00000000404dd7dc>] step_into+0x344/0x390
  [<00000000404dda4c>] walk_component+0xa4/0x310
  [<00000000404df234>] link_path_walk.part.0+0x2ec/0x4b0
  [<00000000404e0000>] path_openat+0xe8/0x348
  [<00000000404e2c58>] do_filp_open+0x98/0x178
  [<00000000404babe8>] do_sys_openat2+0x148/0x288
  [<00000000404bb41c>] compat_sys_openat+0x54/0x98
  [<0000000040203e30>] syscall_exit+0x0/0x10

---[ end trace 0000000000000000 ]---
watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [cc1:32657]

Regards,
Dave

On 2022-07-19 12:32 p.m., Helge Deller wrote:
> Hello Hillf,
>
> On 7/17/22 13:36, Hillf Danton wrote:
>> On Sun, 17 Jul 2022 11:42:48 +0200
>>> I used WARN_ON() instead of BUG_ON().
>>> With that, both triggered, first the first one, then the second one.
>>> Full log is here:
>>> http://dellerweb.de/testcases/minicom.dcache.crash.6-warn
>> Given the first BUG_ON triggered, and dentry at the moment is supposed to
>> not be alias, see if it is still in lookup with d_lock held. That is the
>> step before de-unioning d_alias with d_in_lookup_hash.
>>
>> On the other hand if only the second one triggered, we should track
>> DCACHE_DENTRY_KILLED instead in assumption that killed dentry was
>> used again after releasing d_lock surrounding the firt one.
> The machine has now been up for 2 days without any issues, while it had pretty
> much the same load as when it was crashing earlier.
> So, in summary I'd assume that your patch below fixes the issue.
>
> I'm now rebooting the machine with a new kernel, where I just changed
> 	if (unlikely(d_in_lookup(dentry)))
> to
> 	if (WARN_ON_ONCE(d_in_lookup(dentry)))
> in order to see if this really triggered.
>
> Anyway, I think your patch is good so far.
> Would that be the final patch, or should I test some others?
>
> Thanks!
> Helge
>
>> --- a/fs/dcache.c
>> +++ b/fs/dcache.c
>> @@ -605,8 +605,12 @@ static void __dentry_kill(struct dentry
>>   		spin_unlock(&parent->d_lock);
>>   	if (dentry->d_inode)
>>   		dentry_unlink_inode(dentry);
>> -	else
>> +	else {
>> +		if (unlikely(d_in_lookup(dentry))) {
>> +			__d_lookup_done(dentry);
>> +		}
>>   		spin_unlock(&dentry->d_lock);
>> +	}
>>   	this_cpu_dec(nr_dentry);
>>   	if (dentry->d_op && dentry->d_op->d_release)
>>   		dentry->d_op->d_release(dentry);


-- 
John David Anglin  dave.anglin@bell.net

