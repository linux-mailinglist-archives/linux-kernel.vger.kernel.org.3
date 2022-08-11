Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5942058FB88
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 13:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiHKLlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 07:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiHKLlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 07:41:00 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6762F676;
        Thu, 11 Aug 2022 04:40:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso5078413pjq.4;
        Thu, 11 Aug 2022 04:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=rrKiQb1S5z5z7w7sHDKunQOaYoO4M9deebwCXQZj6+g=;
        b=WUXTx6aiiigWnOLElXjeMxJt6cpNGAcT60S6AMd0sOnQE/LRD2sa+DYWnLRectgdFr
         +QWLep5lri0TIxZVSHtDanE2WzEcdgIMEoiWomyO48e32VTaRmDg9PNxRD+SWgj7GHyq
         KNL11sSHGoy96stdYtffOJrI/rXq50UdJfvgkV9UfdGC2S4LyT1bdyqqQw3+C5SySRVL
         4bfkfnrId+Q31r5w9ztfufFEBehApQ2VbrLBe9KOtMc3Eqvl4gAhswZ3heaspCzzYL04
         gd+CJhyHcBnHQOenh5vNy1u44Zd+WK2miUXh41mV3dwNxLri1w6tSx5d7wLt7IArBIPI
         HqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rrKiQb1S5z5z7w7sHDKunQOaYoO4M9deebwCXQZj6+g=;
        b=uW12CXbHhFM6Wu/JRwTee9ZZtintInCEZTroDR5/6SGW+nPXeFWJ4w2xmHEZQOHffD
         EZoAo7HmilKT93uSbIknnUlA3BcXFhbOtZHGzV3g+2ef6G9VCqLIG9ypFqLQABOcGlkm
         9MIa9AboQIbk7lBM77Pkq1XH+4BUZHVayg+ms7sUOunf/uUETI2vWQY9rnfLrbEwWPnm
         uY3wj43nfETUe2dhkQD/Pm7aVU3GqyffPBIpawv2iOtUzHhLShmH5QRSOS6tEzX34Oy1
         clT9s6NngB9wHODNAjBPZOmnvZ6Uk1IqY9dh+W9pUuMcs37Ozg9dnZ4QpDjSRl10cjqS
         mLuw==
X-Gm-Message-State: ACgBeo3ZVekYYseLbra7B36n1AayeE2zjYtiVa9LR4DOWDbetLZdWtBD
        1A4sKg+cvUYOtH68O08E2Q4=
X-Google-Smtp-Source: AA6agR4r+rxguUVdJkATS56TZ0Alm4LhjoktsY6mYyg84IJzExQYkU79C2ZSvPeQnPusFulpZ0qxcw==
X-Received: by 2002:a17:90b:1bc6:b0:1f5:313a:de4b with SMTP id oa6-20020a17090b1bc600b001f5313ade4bmr8446198pjb.4.1660218057861;
        Thu, 11 Aug 2022 04:40:57 -0700 (PDT)
Received: from [0.0.0.0] (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id g74-20020a62524d000000b0052d40c4c06esm3778024pfb.39.2022.08.11.04.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 04:40:57 -0700 (PDT)
Message-ID: <b7aee1a6-88da-aeff-0f13-8f5ebe893149@gmail.com>
Date:   Thu, 11 Aug 2022 19:40:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Userspace support for LO_FLAGS_NO_DEALLOC (Re: [PATCH V2 0/1] loop:
 introduce LO_FLAGS_NO_DEALLOC)
Content-Language: en-US
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20220806153022.83748-1-zhangboyang.id@gmail.com>
In-Reply-To: <20220806153022.83748-1-zhangboyang.id@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/6 23:30, Zhang Boyang wrote:
> I will also submit patches to util-linux to provide userspace support if
> this patch is merged.

For anyone who want to test the LO_FLAGS_NO_DEALLOC feature, the 
userspace support patch for util-linux is done at 
https://github.com/zhangboyang/util-linux/tree/losetup-nodealloc-202207

Below is an example typescript. In the example, a 10G test file is 
created and used as backing file of /dev/loop0. Then the mkfs.ext4 will 
discard most blocks in /dev/loop0. As you can see in the output of `du' 
and `filefrag', the extents is not freed nor changed location, thus file 
fragmentation is avoided. (The filesystem of backing file is ext4. 
Things are different in XFS or Btrfs, they tend to allocate new extents 
elsewhere when doing FALLOC_FL_ZERO_RANGE.)

Best Regards,
Zhang Boyang


root@debian:~# fallocate -l 10G /data/test
root@debian:~# du -sh /data/test
11G	/data/test
root@debian:~# filefrag -v /data/test
Filesystem type is: ef53
File size of /data/test is 10737418240 (2621440 blocks of 4096 bytes)
  ext:     logical_offset:        physical_offset: length:   expected: 
flags:
    0:        0..   32767:   37715968..  37748735:  32768: 
unwritten
    1:    32768..  524287:   37781504..  38273023: 491520:   37748736: 
unwritten
    2:   524288.. 1015807:   38305792..  38797311: 491520:   38273024: 
unwritten
    3:  1015808.. 1507327:   38830080..  39321599: 491520:   38797312: 
unwritten
    4:  1507328.. 1998847:   39354368..  39845887: 491520:   39321600: 
unwritten
    5:  1998848.. 2490367:   39878656..  40370175: 491520:   39845888: 
unwritten
    6:  2490368.. 2621439:   40402944..  40534015: 131072:   40370176: 
last,unwritten,eof
/data/test: 7 extents found
root@debian:~# ./losetup -f --no-dealloc /data/test
root@debian:~# ./losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE  DIO NO-DEALLOC LOG-SEC
/dev/loop0         0      0         0  0 /data/test   0          1     512
root@debian:~# mkfs.ext4 /dev/loop0
mke2fs 1.46.2 (28-Feb-2021)
Discarding device blocks: done
Creating filesystem with 2621440 4k blocks and 655360 inodes
Filesystem UUID: 4abd9157-6e40-4842-bb33-e6807fc5c231
Superblock backups stored on blocks:
	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done

root@debian:~# ./losetup -d /dev/loop0
root@debian:~# du -sh /data/test
11G	/data/test
root@debian:~# filefrag -v /data/test
Filesystem type is: ef53
File size of /data/test is 10737418240 (2621440 blocks of 4096 bytes)
  ext:     logical_offset:        physical_offset: length:   expected: 
flags:
    0:        0..    1027:   37715968..  37716995:   1028:
    1:     1028..    1042:   37716996..  37717010:     15: 
unwritten
    2:     1043..    1043:   37717011..  37717011:      1:
    3:     1044..    1058:   37717012..  37717026:     15: 
unwritten
    4:     1059..    1059:   37717027..  37717027:      1:
    5:     1060..    9250:   37717028..  37725218:   8191: 
unwritten
    6:     9251..    9256:   37725219..  37725224:      6:
    7:     9257..   32767:   37725225..  37748735:  23511: 
unwritten
    8:    32768..   32770:   37781504..  37781506:      3:   37748736:
    9:    32771..   98303:   37781507..  37847039:  65533: 
unwritten
   10:    98304..   98306:   37847040..  37847042:      3:
   11:    98307..  163839:   37847043..  37912575:  65533: 
unwritten
   12:   163840..  163842:   37912576..  37912578:      3:
   13:   163843..  229375:   37912579..  37978111:  65533: 
unwritten
   14:   229376..  229378:   37978112..  37978114:      3:
   15:   229379..  294911:   37978115..  38043647:  65533: 
unwritten
   16:   294912..  294914:   38043648..  38043650:      3:
   17:   294915..  524287:   38043651..  38273023: 229373: 
unwritten
   18:   524288..  524288:   38305792..  38305792:      1:   38273024:
   19:   524289..  819199:   38305793..  38600703: 294911: 
unwritten
   20:   819200..  819202:   38600704..  38600706:      3:
   21:   819203..  884735:   38600707..  38666239:  65533: 
unwritten
   22:   884736..  884738:   38666240..  38666242:      3:
   23:   884739.. 1015807:   38666243..  38797311: 131069: 
unwritten
   24:  1015808.. 1048575:   38830080..  38862847:  32768:   38797312: 
unwritten
   25:  1048576.. 1048577:   38862848..  38862849:      2:
   26:  1048578.. 1081343:   38862850..  38895615:  32766: 
unwritten
   27:  1081344.. 1081344:   38895616..  38895616:      1:
   28:  1081345.. 1507327:   38895617..  39321599: 425983: 
unwritten
   29:  1507328.. 1572863:   39354368..  39419903:  65536:   39321600: 
unwritten
   30:  1572864.. 1572864:   39419904..  39419904:      1:
   31:  1572865.. 1605631:   39419905..  39452671:  32767: 
unwritten
   32:  1605632.. 1605634:   39452672..  39452674:      3:
   33:  1605635.. 1998847:   39452675..  39845887: 393213: 
unwritten
   34:  1998848.. 2097151:   39878656..  39976959:  98304:   39845888: 
unwritten
   35:  2097152.. 2097152:   39976960..  39976960:      1:
   36:  2097153.. 2097166:   39976961..  39976974:     14: 
unwritten
   37:  2097167.. 2097167:   39976975..  39976975:      1:
   38:  2097168.. 2490367:   39976976..  40370175: 393200: 
unwritten
   39:  2490368.. 2621439:   40402944..  40534015: 131072:   40370176: 
last,unwritten,eof
/data/test: 7 extents found
