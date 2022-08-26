Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FC15A2C18
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244406AbiHZQPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiHZQP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:15:29 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690DFA2869;
        Fri, 26 Aug 2022 09:15:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CC0055C05D4;
        Fri, 26 Aug 2022 12:15:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 26 Aug 2022 12:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustymabe.com;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1661530523; x=1661616923; bh=2X
        pK+MsnzSh3YxXW1jI/LTxDkomrIwNcVnN1BvA8HKs=; b=Gj24PpiaInCrHO2Nnr
        N0ZxqlcfGR/NP5Y/qiNNXxXfLMRqUOW6g7jamo3g/rYlojpljy+Ex+mcELoLsZzp
        O8aH9cvZb7gjcJVT/xkd3qqUVrR5B3Xpwl2fRZ9+X/juAr2NwbJHVCwuWTKBo0hF
        v18Q/BSt4j3IFbB8j4cEyJxZcnD8YBLnW1fmoMAO0lzNQZ1ldoUYDNmlLPaXvaZX
        rgyFcT1HiXH9zV6MG11hMvSAqgwCDoaDrg6OZxnP+qRSXY75x8oQECUyu43mZ1Jk
        8YSgrM632qckjMk2ILGmEva+Xf76UO+U6o/wqkT+zEkTJLDLhERBEDO1445XIAou
        3S1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1661530523; x=1661616923; bh=2XpK+MsnzSh3Y
        xXW1jI/LTxDkomrIwNcVnN1BvA8HKs=; b=izAHRUFD+UxY2v8i3Dd8fOenj5Cm+
        09JhWOvl8mDXLayVo/3AV3iNV0iEagOskknCOHySaElCvU4bU86Pg1qiJKN0a9nH
        pYjl/f9ROvAt0X1xYZGeG/URaA9QwHVBg6cNDP9cdBzhTEyJJHSRoFuedDCfgJw8
        Ug8OKuJUmTWV1GnSFDm3IzsxuYiBKIVK+9cQF5kEtAyVXwwrJXdEQVYn3skuiEj2
        CrrX7vBbY8Fs/cc7gLvLONZasHiq44X/CbHHvCGZW9iUbzZzKAvjNnHJwxNKe7Sy
        ra5iVzkECgGjOazs9a9835NbfdmuVafEf/wjyA2LH1Y/DDmYbz4l7YnrA==
X-ME-Sender: <xms:m_EIYy1zNyu8r-LJrp1O1RCtivWzyzwRjQtFJ65LtQFlsIjXpc6T_A>
    <xme:m_EIY1GUiLOLUrtX1ly6Glgj6KUFB1KxVi8uS1mGXXUFBCl9EojB8lCNoaQJHiK1P
    u8jdbP3ChgN4E3UKBk>
X-ME-Received: <xmr:m_EIY65EdBYZLFzvUR0nqm1_zoSkLJKZdvj8WXLojIR8zVxRmxqZOArIB6_9PMp2C8sr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejhedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevhffutgfgsehtjeertddtfeejnecuhfhrohhmpeffuhhsthih
    ucforggsvgcuoeguuhhsthihseguuhhsthihmhgrsggvrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeuhfevheeltddtveegiedvfeffteeghefgfeevjeffgfdtfeevtdeivdduveeu
    ueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhrvgguhhgrthdrtghomhdpghhith
    hhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepughushhthiesughushhthihmrggsvgdrtghomh
X-ME-Proxy: <xmx:m_EIYz3-gH4uCMdEGDa5GjXhE9-gRCtXBD-gdSRccCE83yAGNdWsgg>
    <xmx:m_EIY1HS1kNZVz030Qv9pmiRvIy4K1EjT26RwSjq1tua4WNH0MUOlA>
    <xmx:m_EIY8_u_oT7-tB01CcEjdjKzXDyZbJjp6jBqIJKzxh-3V7y4BH3qg>
    <xmx:m_EIY6R40ZwCfgf1-QrQqbACoyzUy5bGWXwR0qkdK6hL5pI-tLjQEA>
Feedback-ID: i13394474:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Aug 2022 12:15:22 -0400 (EDT)
Message-ID: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
Date:   Fri, 26 Aug 2022 12:15:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hch@lst.de
From:   Dusty Mabe <dusty@dustymabe.com>
Subject: regression caused by block: freeze the queue earlier in del_gendisk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey All,

I think I've found a regression introduced by:

a09b314 o block: freeze the queue earlier in del_gendisk

In Fedora CoreOS we have tests that set up RAID1 on the /boot/ and /root/ partitions
and then subsequently removes one of the disks to simulate a failure. Sometime recently
this test started timing out occasionally. Looking a bit closer it appears instances are
getting stuck during reboot with a bunch of looping messages:

```
[   17.978854] block device autoloading is deprecated and will be removed.
[   17.982555] block device autoloading is deprecated and will be removed.
[   17.985537] block device autoloading is deprecated and will be removed.
[   17.987546] block device autoloading is deprecated and will be removed.
[   17.989540] block device autoloading is deprecated and will be removed.
[   17.991547] block device autoloading is deprecated and will be removed.
[   17.993555] block device autoloading is deprecated and will be removed.
[   17.995539] block device autoloading is deprecated and will be removed.
[   17.997577] block device autoloading is deprecated and will be removed.
[   17.999544] block device autoloading is deprecated and will be removed.
[   22.979465] blkdev_get_no_open: 1666 callbacks suppressed
...
...
...
[  618.221270] blkdev_get_no_open: 1664 callbacks suppressed
[  618.221273] block device autoloading is deprecated and will be removed.
[  618.224274] block device autoloading is deprecated and will be removed.
[  618.227267] block device autoloading is deprecated and will be removed.
[  618.229274] block device autoloading is deprecated and will be removed.
[  618.231277] block device autoloading is deprecated and will be removed.
[  618.233277] block device autoloading is deprecated and will be removed.
[  618.235282] block device autoloading is deprecated and will be removed.
[  618.237370] block device autoloading is deprecated and will be removed.
[  618.239356] block device autoloading is deprecated and will be removed.
[  618.241290] block device autoloading is deprecated and will be removed.
```

Using the Fedora kernels I narrowed it down to being introduced between 
`kernel-5.19.0-0.rc3.27.fc37` (good) and `kernel-5.19.0-0.rc4.33.fc37` (bad).

I then did a bisect and found:

```
$ git bisect bad
a09b314005f3a0956ebf56e01b3b80339df577cc is the first bad commit
commit a09b314005f3a0956ebf56e01b3b80339df577cc
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Jun 14 09:48:27 2022 +0200

    block: freeze the queue earlier in del_gendisk
    
    Freeze the queue earlier in del_gendisk so that the state does not
    change while we remove debugfs and sysfs files.
    
    Ming mentioned that being able to observer request in debugfs might
    be useful while the queue is being frozen in del_gendisk, which is
    made possible by this change.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Link: https://lore.kernel.org/r/20220614074827.458955-5-hch@lst.de
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

 block/genhd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
```

Reverting this commit on top of latest git master (4c612826b) gave me successful results.

Any ideas on what could be amiss here? Luckily the patch is tiny so hopefully it might
be obvious.

More details (including logs) in the following locations:

- https://bugzilla.redhat.com/show_bug.cgi?id=2121791
- https://github.com/coreos/fedora-coreos-tracker/issues/1282


Thanks!
Dusty

