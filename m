Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC9E4DBD06
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 03:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358422AbiCQCdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 22:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354709AbiCQCdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:33:16 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A6E1FA59
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 19:31:59 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KJrcy5kKLz1GCND;
        Thu, 17 Mar 2022 10:26:58 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 10:31:57 +0800
Subject: Re: [PATCH -next] ubifs: rename_whiteout: correct old_dir size
 computing
To:     Richard Weinberger <richard@nod.at>
CC:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yukuai3 <yukuai3@huawei.com>,
        chengzhihao1 <chengzhihao1@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20220215040736.2839939-1-libaokun1@huawei.com>
 <dc55e8b3-7d22-6024-374d-4ed126e18c42@huawei.com>
 <157336576.152785.1647468012272.JavaMail.zimbra@nod.at>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <a4f8bfff-26ee-95f8-db3c-91ca860a32bd@huawei.com>
Date:   Thu, 17 Mar 2022 10:31:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <157336576.152785.1647468012272.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/3/17 6:00, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----
>> Von: "libaokun" <libaokun1@huawei.com>
>> An: "richard" <richard@nod.at>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel"
>> <linux-kernel@vger.kernel.org>
>> CC: "yukuai3" <yukuai3@huawei.com>, "chengzhihao1" <chengzhihao1@huawei.com>, "libaokun" <libaokun1@huawei.com>
>> Gesendet: Donnerstag, 10. März 2022 09:32:57
>> Betreff: Re: [PATCH -next] ubifs: rename_whiteout: correct old_dir size computing
>> A gentle ping, sorry for the noise.
> I have to say sorry for the day.
> Thanks for your patience with me.
>   
Please don't feel bad about it.
Glad to hear from you! Thanks for your kindly reply！
>> 在 2022/2/15 12:07, Baokun Li 写道:
>>> When renaming the whiteout file, the old whiteout file is not deleted.
>>> Therefore, we add the old dentry size to the old dir like XFS.
>>> Otherwise, an error may be reported due to `fscki->calc_sz != fscki->size`
>>> in check_indes.
>>>
>>> Fixes: 9e0a1fff8db56ea ("ubifs: Implement RENAME_WHITEOUT")
>>> Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>> ---
>>>    fs/ubifs/dir.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
>>> index ae082a0be2a3..86151889548e 100644
>>> --- a/fs/ubifs/dir.c
>>> +++ b/fs/ubifs/dir.c
>>> @@ -1402,6 +1402,9 @@ static int do_rename(struct inode *old_dir, struct dentry
>>> *old_dentry,
>>>    			iput(whiteout);
>>>    			goto out_release;
>>>    		}
>>> +
>>> +		/* Add the old_dentry size to the old_dir size. */
>>> +		old_sz -= CALC_DENT_SIZE(fname_len(&old_nm));
> So you basically reset old_sz back to 0?
Yes, reset old_sz to 0 here.
Since the old file remains in old_dir after whiteout_rename,
nothing has changed, we just add new_sz to the new folder.

Here, old_sz is the value to be subtracted from old_dir->i_size,
which is initialized to `CALC_DENT_SIZE(fname_len(&old_nm));` .
In RENAME_WHITEOUT, because the old file is not deleted,
we need to subtract old_dent_size from old_sz after RENAME_WHITEOUT is 
complete, that is, set old_sz to 0.

we can easily reproduce this problem with the following script：
  ```C
// test_ubifs_whiteout.c
  #include <stdlib.h>
  #include <unistd.h>
  #include <fcntl.h>
  #include <sys/syscall.h>
  #include <linux/fs.h>

  int main(int argc, char *argv[])
  {
      system("touch /root/temp/file");
      syscall(SYS_renameat2, AT_FDCWD, "/root/temp/file", AT_FDCWD, 
"/root/temp/target", RENAME_WHITEOUT);
      return 0;
  }
  ```

```shell
#!/bin/bash
set -e
# ubifs_whiteout_reproducer.sh

TMP=/root/temp
umount $TMP 2>/dev/null || true
mkdir -p $TMP

modprobe -r ubifs 2>/dev/null || true
for i in $(seq 0 1)
do
     ubidetach -p /dev/mtd$i 2>/dev/null || true
done
modprobe -r ubi 2>/dev/null || true
modprobe -r nandsim 2>/dev/null || true
modprobe nandsim id_bytes="0xec,0xa1,0x00,0x15"
modprobe ubi mtd="0,512"
ubimkvol -N vol_a -m -n 0 /dev/ubi0
modprobe ubifs
mount -t ubifs /dev/ubi0_0 $TMP

./test_ubifs_whiteout
umount /dev/ubi0_0
echo 1 > /sys/kernel/debug/ubifs/chk_fs
mount -t ubifs /dev/ubi0_0 $TMP
```
> Thanks,
> //richard
> .

-- 
With Best Regards,
Baokun Li

