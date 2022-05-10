Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5B4520EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbiEJHkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240151AbiEJHSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:18:53 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDDE2992C3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:14:54 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i11so7052664ybq.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zH66pFJDkZ1HOEqqc9deO5rWvxbXbeVm/jZJlJAb3ZM=;
        b=JI4/46W0SmXlBajA2jdSbBcKv7/qUwhqfEmwodozi+lypUYA2YzKdfX9DWTbHj4asI
         0qXmTNLaDI0ts7jBR8p31VIZ4P+QlI5ADOOZUp4LxfNjHKlbSxcYaVJrDxlxVIj5VCce
         6eLEzzSD2pFV6tHP1vwXo4Z25D3Jt80zpaFLKc4kS651rVShFgEcjR86J7akwE4OJ5+B
         ZNKeeFBxoxf2feeiG4EmHTMs+vZbL2sQ7O0rRJAODEV3Dy2GEPM/fmRHfooQ6ursn3rr
         CNJdDmDk+bLvfo4r/fjSovnWcyLi0VTUCMriYdgCR/mXEqM+hTcyOpZtHSHkfwwn2+Xc
         dycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zH66pFJDkZ1HOEqqc9deO5rWvxbXbeVm/jZJlJAb3ZM=;
        b=VuOnfok/zASUphWk1gbrO0O815x9JSqGYstoBf6D+tZ7TfTR3Il49hobKbzGB6tOC3
         e8JulMNW57Ed/GJWV1G06RIJZSMiG5oFHrOVBK22UeKOrjIY9tk6KjYSbg/dC1OsjFCl
         FmAU+IBRJKEWMZ+CuhFEMIiv4jpitZ+nZ3v0AHPfTfgpvpZ+YAYsBhGw8fYC84iWK8PI
         0rRNEsG4ZQe00J/xQ5CKnZWuwIv3eeuLfQ8p5WnyIeFTOv2fqdf2OhvTFowtKvqhwFZy
         8ksBCyggsg4Vx85JW5EwygSM/U+gtNpHuXG3aLXwzj6TZQJjkpivqyI6PGfHRlcdpB70
         Seqg==
X-Gm-Message-State: AOAM530S4WUGv6lFfOYvvw8RqUPclgC9sSgc7Sc86eUBXhKFYZ9knv5z
        QjxJulCs/HhNPj0j8UjRH0p1LjZ28tlibhRN+bzJjPb68nM=
X-Google-Smtp-Source: ABdhPJxqyluTn+dW0xXkCrs3+GYZ2zj6BUVtG6u3JBwCFG5zbNS9Yt3xWMJnzBk1tEDiNK0zcNZ1N64E47elnnWvF3U=
X-Received: by 2002:a05:6902:124d:b0:649:2a55:18a with SMTP id
 t13-20020a056902124d00b006492a55018amr16766765ybu.155.1652166893685; Tue, 10
 May 2022 00:14:53 -0700 (PDT)
MIME-Version: 1.0
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Tue, 10 May 2022 15:14:42 +0800
Message-ID: <CAFcO6XNpj6e+OGba30usr_miODhbhmqk7vh3ymU+NLoe2HBqFA@mail.gmail.com>
Subject: A slab-out-of-bounds Write when invoke udf_write_fi via ioctl
To:     jack@suse.com
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, if mounts a malicious udf image,  there is a slab out of bounds
write  bug when a user invokes udf_write_fi via ioctl.
I have reproduced it in the latest kernel.

##smaple analyse
the function call chains:
do_sys_open
    --->do_sys_openat2
       --->do_filp_open
          --->path_openat
              --->open_last_lookups
                 --->lookup_open
                     --->udf_add_nondir
                        --->udf_add_entry

There would traverse to get a `fi` in the function udf_add_entry.
```
if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {   [1]
         block = dinfo->i_location.logicalBlockNum;
         fi = (struct fileIdentDesc *)
           (dinfo->i_data + fibh->soffset -
             udf_ext0_offset(dir) +
              dinfo->i_lenEAttr);
             [2]
} else {
          block = eloc.logicalBlockNum +
              ((elen - 1) >>
            dir->i_sb->s_blocksize_bits);
            fi = (struct fileIdentDesc *)
                 (fibh->sbh->b_data + fibh->soffset);
}
```
[1] if dinfo->i_alloc_type is ICBTAG_FLAG_AD_IN_ICB, [2] it  would
calculate an offset as `fi`,
through the debugger, the `fi` is as below:
```
 p/x *(struct fileIdentDesc*)fi
$24 = {
  descTag = {
    tagIdent = 0x2f70,
    descVersion = 0xea55,
    tagChecksum = 0xcd,
    reserved = 0x66,
    tagSerialNum = 0x511f,
    descCRC = 0x5a9c,
    descCRCLength = 0x5142,
    tagLocation = 0x373ce06a
  },
  fileVersionNum = 0x3139,
  fileCharacteristics = 0xf6,
  lengthFileIdent = 0x7e,
  icb = {
    extLength = 0x6059792,
    extLocation = {
      logicalBlockNum = 0x73886466,
      partitionReferenceNum = 0x7cc6
    },
    impUse = {0x3c, 0xcc, 0x4a, 0xed, 0xdc, 0xfb}
  },
  lengthOfImpUse = 0x1a6a,
  impUse = 0xffff888019ca716a
}
```
These data are wrong and all data are part of  udf image mounted.
Then next it would invoke function udf_write_fi to write fileident into `fi`.
```
if (fileident) {
      if (adinicb || (offset + lfi < 0)) {
          memcpy(udf_get_fi_ident(sfi), fileident, lfi);   [3]
} else if (offset >= 0) {
          memcpy(fibh->ebh->b_data + offset, fileident, lfi);
} else {
          memcpy(udf_get_fi_ident(sfi), fileident, -offset);
          memcpy(fibh->ebh->b_data, fileident - offset,
                  lfi + offset);
       }
}
```
The fileident was controlled by user. `sfi` is `fi`, the memcpy
function is called to copy the data, so an out-of-bounds write occurs

##reproduce
CONFIG_KASAN is opened.
[   27.437559][ T4631] loop0: detected capacity change from 0 to 5376
[   27.440865][ T4631] UDF-fs: warning (device loop0): udf_load_vrs:
No anchor found
[   27.441638][ T4631] UDF-fs: Scanning with blocksize 512 failed
[   27.444203][ T4631] UDF-fs: INFO Mounting volume 'LinuxUDF',
timestamp 2020/09/19 18:44 (1000)
[   27.462341][ T4631]
==================================================================
[   27.463081][ T4631] BUG: KASAN: slab-out-of-bounds in
udf_write_fi+0x353/0x1170
[   27.463778][ T4631] Write of size 165 at addr ffff888014fe5c98 by
task udf_write_fi1/4631
[   27.464524][ T4631]
[   27.464736][ T4631] CPU: 0 PID: 4631 Comm: udf_write_fi1 Not
tainted 5.18.0-rc5-00028-ga7391ad35724 #47
[   27.465598][ T4631] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.14.0-2 04/01/2014
[   27.466427][ T4631] Call Trace:
[   27.466721][ T4631]  <TASK>
[   27.466990][ T4631]  dump_stack_lvl+0x11c/0x1b4
[   27.467416][ T4631]  print_address_description.constprop.0.cold+0xeb/0x48f
[   27.468051][ T4631]  ? udf_write_fi+0x353/0x1170
[   27.468481][ T4631]  kasan_report.cold+0xf4/0x1c6
[   27.468914][ T4631]  ? udf_get_fileident+0x271/0x2d0
[   27.469371][ T4631]  ? udf_write_fi+0x353/0x1170
[   27.469801][ T4631]  kasan_check_range+0x13d/0x180
[   27.470246][ T4631]  memcpy+0x39/0x60
[   27.470588][ T4631]  udf_write_fi+0x353/0x1170
[   27.470998][ T4631]  ? udf_new_tag+0x1fd/0x3c0
[   27.471412][ T4631]  udf_add_entry+0x10c7/0x24d0
[   27.471822][ T4631]  ? udf_write_fi+0x1170/0x1170
[   27.472218][ T4631]  ? __mark_inode_dirty+0x76a/0xb00
[   27.472643][ T4631]  ? lock_downgrade+0x810/0x810
[   27.473045][ T4631]  udf_add_nondir+0xf8/0x410
[   27.473424][ T4631]  ? udf_rename+0x1050/0x1050
[   27.473806][ T4631]  ? userns_owner+0x30/0x30
[   27.474177][ T4631]  ? rcu_read_lock_sched_held+0x3a/0xa0
[   27.474628][ T4631]  ? __mark_inode_dirty+0x5f8/0xb00
[   27.475051][ T4631]  ? udf_get_parent+0x1c0/0x1c0
[   27.475455][ T4631]  lookup_open.isra.0+0xec3/0x1760
[   27.475876][ T4631]  ? lock_release+0x890/0x890
[   27.476273][ T4631]  ? path_lookupat+0x6b0/0x6b0
[   27.476670][ T4631]  ? __mnt_want_write+0x184/0x260
[   27.477107][ T4631]  path_openat+0x7d5/0x2360
[   27.477480][ T4631]  ? lookup_open.isra.0+0x1760/0x1760
[   27.477915][ T4631]  ? lockdep_hardirqs_on_prepare+0x430/0x430
[   27.478412][ T4631]  ? lockdep_hardirqs_on_prepare+0x430/0x430
[   27.478901][ T4631]  do_filp_open+0x199/0x3d0
[   27.479271][ T4631]  ? find_held_lock+0x2d/0x110
[   27.479663][ T4631]  ? may_open_dev+0xd0/0xd0
[   27.480036][ T4631]  ? rwlock_bug.part.0+0x90/0x90
[   27.480429][ T4631]  ? _raw_spin_unlock+0x24/0x40
[   27.480825][ T4631]  ? alloc_fd+0x1ef/0x560
[   27.481173][ T4631]  ? getname_flags.part.0+0x89/0x440
[   27.481602][ T4631]  do_sys_openat2+0x11e/0x3f0
[   27.481978][ T4631]  ? build_open_flags+0x490/0x490
[   27.482384][ T4631]  ? lock_downgrade+0x810/0x810
[   27.482777][ T4631]  __x64_sys_openat+0x11b/0x1d0
[   27.483188][ T4631]  ? __ia32_sys_open+0x190/0x190
[   27.483594][ T4631]  ? lockdep_hardirqs_on_prepare+0x22b/0x430
[   27.484177][ T4631]  ? syscall_enter_from_user_mode+0x21/0x80
[   27.484890][ T4631]  ? lockdep_hardirqs_on+0x8b/0x110
[   27.485538][ T4631]  do_syscall_64+0x35/0xb0
[   27.486095][ T4631]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   27.486692][ T4631] RIP: 0033:0x44914d
[   27.487019][ T4631] Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3
0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff 8
[   27.488797][ T4631] RSP: 002b:00007ffc787d2f68 EFLAGS: 00000246
ORIG_RAX: 0000000000000101
[   27.489518][ T4631] RAX: ffffffffffffffda RBX: 0000000000400540
RCX: 000000000044914d
[   27.490179][ T4631] RDX: 0000000000000040 RSI: 0000000020000140
RDI: 0000000000000005
[   27.490825][ T4631] RBP: 00007ffc787d2f80 R08: 0000000020000170
R09: 0000000000000000
[   27.491469][ T4631] R10: 0000000000000000 R11: 0000000000000246
R12: 0000000000404dd0
[   27.492125][ T4631] R13: 0000000000000000 R14: 00000000004c0018
R15: 0000000000400540

If needed a reproduce, I can provided to you.




Regards,
   butt3rflyh4ck.




-- 
Active Defense Lab of Venustech
