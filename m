Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6422C538537
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242196AbiE3PrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242597AbiE3PrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:47:08 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E172221BBC
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 08:00:03 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220530145956euoutp02096cc771a9da5b11191b06ae7b024d14~z6gUwR5rY0936609366euoutp02-
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:59:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220530145956euoutp02096cc771a9da5b11191b06ae7b024d14~z6gUwR5rY0936609366euoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653922796;
        bh=a4jTP20Hv9ifoTwI0jRhyc3pKwRt67MyWvQ+usouMtc=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=Y8tBTw0U7YFpbu+feP2bJjV+nt1/yobRo9F1zECRMlhMS68wz/6Ku/DTu8rvbJ/Y4
         1tKV+lXORiW58J3+4Sj+nlPIebdyulVICcvwL9x0PDbBFaB7Tds3wuxhrMH63yPi9K
         uzwG2F+nRhGuHxoqUYgqGUhtL9ES4uTyEFF0PxmU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220530145955eucas1p236047dbf7b203dfd021695a4210bc98f~z6gUaE-Zb3015430154eucas1p2z;
        Mon, 30 May 2022 14:59:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4A.33.09580.BEBD4926; Mon, 30
        May 2022 15:59:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220530145955eucas1p1049c4bad5ed3bc5e611d761e4bbaa71a~z6gT9Vg6J0702807028eucas1p1O;
        Mon, 30 May 2022 14:59:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220530145955eusmtrp2bb2f618b4a5e74c299c509890def680d~z6gT8iigM3210732107eusmtrp2H;
        Mon, 30 May 2022 14:59:55 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-7e-6294dbebbb2a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 42.9E.09095.BEBD4926; Mon, 30
        May 2022 15:59:55 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220530145955eusmtip22fe4b311280fd4e0cf570b215bcb3bd4~z6gT0ilnG1461214612eusmtip2E;
        Mon, 30 May 2022 14:59:55 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.241) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 30 May 2022 15:59:53 +0100
Message-ID: <876dabfd-04ba-a1cb-2cab-e7032fea0c17@samsung.com>
Date:   Mon, 30 May 2022 16:59:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.9.1
Subject: Re: [PATCH v6 8/8] dm: ensure only power of 2 zone sizes are
 allowed
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <axboe@kernel.dk>, <snitzer@redhat.com>,
        <Johannes.Thumshirn@wdc.com>, <hch@lst.de>, <hare@suse.de>
CC:     <dsterba@suse.com>, <dm-devel@redhat.com>,
        <jiangbo.365@bytedance.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <jaegeuk@kernel.org>, <gost.dev@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <3c04e29f-2c99-c350-bc87-0c0633b4d19d@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.241]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7djPc7qvb09JMvjeq2ex+m4/m8Xvs+eZ
        Lfa+m81qceFHI5PFnkWTmCxWrj7KZPFk/Sxmi54DH1gs/nbdY7LYe0vb4vKuOWwW85c9Zbdo
        2/iV0YHX49+JNWwel8+Wemxa1cnmsXlJvcfumw1sHjtb77N6vN93lc1j/ZarLB6bT1d7fN4k
        59F+oJspgDuKyyYlNSezLLVI3y6BK2Pz9ansBZPYK36du8jYwHiatYuRk0NCwETizJIX7F2M
        XBxCAisYJZ59P8MM4XxhlJj3fBEjhPOZUeL3n7UsMC1nPy6ASixnlOjd/R4sAVZ17HQARGI3
        o8TnKZPYQBK8AnYS97dsA7NZBFQldnQ9YoSIC0qcnPkErFlUIEJiZesbMFtYwF/i+O27TCA2
        s4C4xK0n85lAhooIzAO66cd/MIdZ4D6jxO3nF4A6ODjYBLQkGjvZQRo4BdwknvZNY4Fo1pRo
        3f6bHcKWl9j+dg4zxAvKEosvXGOEsGslTm25BTZTQuAap0Tf8kPsIDMlBFwkzm6ogagRlnh1
        fAs7hC0j8X/nfCYIu1ri6Y3fzBC9LYwS/TvXs0H0Wkv0ncmBqHGU+Nl4jRkizCdx460gxDl8
        EpO2TWeewKg6CykoZiF5eRaSD2Yh+WABI8sqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2M
        wMR3+t/xrzsYV7z6qHeIkYmD8RCjBAezkghvQ/LEJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
        yZkbEoUE0hNLUrNTUwtSi2CyTBycUg1M3OKXuXf91Q8I+Lhdle3yu+0qJ68sMAi6y7G6k03q
        j2pGy+lojs4DH0on39/GX/6sZ7eNlVt68Lo8pdVeaybfNHcru6q7tEbmtctevRNXrvBw1E+W
        L38fPrU7ePJE8e7tflWO/Tduma1v5J1UzPv1/vkzt3/nu8/uzL7Q1rLr3oyLiUwz4k+WZknV
        5ug37rCqMthsaXp8T221R8RH0TMN89vL9icwuff8K5pjuuaz3qTTaZ+0/fg/3Em7uGNWXOnH
        6Is/LT/4PgrgSFCX79m75qtX5zSfM7N/dfzTY/ebPdeaacH/y83Tzun/K2fRkuGIfShttPrX
        LjWDM98MZ6/9++/VDF7BxlDnBZPY89NOKbEUZyQaajEXFScCAJGrxfHrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42I5/e/4Pd3Xt6ckGSzqF7BYfbefzeL32fPM
        FnvfzWa1uPCjkcliz6JJTBYrVx9lsniyfhazRc+BDywWf7vuMVnsvaVtcXnXHDaL+cueslu0
        bfzK6MDr8e/EGjaPy2dLPTat6mTz2Lyk3mP3zQY2j52t91k93u+7yuaxfstVFo/Np6s9Pm+S
        82g/0M0UwB2lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqk
        b5egl7H5+lT2gknsFb/OXWRsYDzN2sXIySEhYCJx9uMCRhBbSGApo8Trx0IQcRmJT1c+skPY
        whJ/rnWxQdR8ZJRY8LKii5ELyN7NKDHt1U+wBK+AncT9LdvAbBYBVYkdXY8YIeKCEidnPmEB
        sUUFIiQ+LZsAtlhYwFdi+s5zYDazgLjErSfzmUCGigjMY5SY9+M/mMMscJ9R4vbzCywQq98w
        SZxeHtLFyMHBJqAl0dgJdh2ngJvE075pLBCDNCVat/9mh7DlJba/ncMM8YGyxOIL1xgh7FqJ
        z3+fMU5gFJ2F5L5ZSO6YhWTULCSjFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAhMFtuO
        /dy8g3Heq496hxiZOBgPMUpwMCuJ8DYkT0wS4k1JrKxKLcqPLyrNSS0+xGgKDKSJzFKiyfnA
        dJVXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cCkZz5FWk2zd++6
        q9Erp+devu/y6+yDnNObr2+5Xut48sOTm5yuW5gWZQlKOm/N+l727ozWxSWy+9psgoorthbt
        kn3nvPPf6yc/Fz2KmqMV3G31vmYuS+qP7Q943tQuKDjHlXnoQrdv9OPb569VckTnlZ4p7DT8
        9cFrTpCLxQL3Lk717VFme/ZFXza3fWW35ir/27DaBz1njfa8WBIafPLdF9etXM2LIpatnDg7
        hHHPZmezGuV+mwO3fu77a9/5ss0qp8bq2ol/GWJlGr0sN3J0eJlXMpsZyka9dD9TmitUEugx
        tbbJWcXwTe+OO3vvx/c6+scbiddYzPz5WzB0jpnH+X6lFNNVtXW7J9QEda1WYinOSDTUYi4q
        TgQAb04t7Z8DAAA=
X-CMS-MailID: 20220530145955eucas1p1049c4bad5ed3bc5e611d761e4bbaa71a
X-Msg-Generator: CA
X-RootMTR: 20220525155008eucas1p2c843cc9098f2920e961f80ffaf535789
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220525155008eucas1p2c843cc9098f2920e961f80ffaf535789
References: <20220525154957.393656-1-p.raghav@samsung.com>
        <CGME20220525155008eucas1p2c843cc9098f2920e961f80ffaf535789@eucas1p2.samsung.com>
        <20220525154957.393656-9-p.raghav@samsung.com>
        <9703ca4c-33cf-cb3a-b46b-6b0e5537cfd6@opensource.wdc.com>
        <0bb57f61-9a33-0273-4b89-2cdf042e56dd@samsung.com>
        <3c04e29f-2c99-c350-bc87-0c0633b4d19d@opensource.wdc.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 10:25, Damien Le Moal wrote:
>> This series is targeting the first phase where we have stop gap patches
>> and add support to the block and nvme layer and in the next phase we
>> will add a dm linear like target for npo2 zone sizes which can be used
>> by all the filesystems. This patch makes sure that we can't use npo2
>> zoned devices without the proper support that will be added in the next
>> phase in the DM.
> 
> Personally, I do not want to see a kernel version where zone support is broken
> for some devices. So I definitely prefer everything in one go or nothing.
> 
Ok. I will make sure the DM target is a part of the next series along
with the zonefs patch.

Meanwhile, could you review the patches for the block, nvme and null blk
that is already a part of this series? I have made the changes in those
patches as you requested in previous revisions.

Thanks,
Pankaj
