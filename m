Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077BD584DDA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbiG2JJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiG2JJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:09:23 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F00985F86
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:09:20 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220729090918euoutp020f220198867c69b94ce36ab321a6e6d7~GQbUcFz493062230622euoutp02c
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 09:09:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220729090918euoutp020f220198867c69b94ce36ab321a6e6d7~GQbUcFz493062230622euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659085758;
        bh=xUi/aumvkNNWLDf9OglW0aUO63Tnf9nSRETunbF1Zr0=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=FukMvNoJtks6GY6PBjOf5vVvRLF1AuGvjwRKU30hoaL7PGLjZv/yqU6VrJvg9xiJT
         fclInjWUpeB2J+6geSmubKrALvwSkmwXz7oruVQtypA45umdF/KLsH3jKAwdtUSLup
         JN0dRhWDilX0COnDstyIL1HumalKSbzdwwGp7eN4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220729090918eucas1p2789e2f8c650aa31e0ecec8f1d2aff3d6~GQbUD7Cv72990229902eucas1p2D;
        Fri, 29 Jul 2022 09:09:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A5.C1.09580.EB3A3E26; Fri, 29
        Jul 2022 10:09:18 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220729090918eucas1p1782d5db2070d20502d6534c7a7e37a22~GQbTtKK9o1900119001eucas1p1P;
        Fri, 29 Jul 2022 09:09:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220729090918eusmtrp2cb36704469666cfa1381c86a8c45a6b0~GQbTsOxOd2132221322eusmtrp2O;
        Fri, 29 Jul 2022 09:09:18 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-0c-62e3a3be7352
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A2.5E.09038.DB3A3E26; Fri, 29
        Jul 2022 10:09:17 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220729090917eusmtip125a6d45cf8e112df70fc03b445c79919~GQbTh_gX13212032120eusmtip1G;
        Fri, 29 Jul 2022 09:09:17 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.8) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 29 Jul 2022 10:09:15 +0100
Message-ID: <f577e147-c692-97b1-3262-2684649b5eae@samsung.com>
Date:   Fri, 29 Jul 2022 11:09:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v8 02/11] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        <damien.lemoal@opensource.wdc.com>, <hch@lst.de>,
        <axboe@kernel.dk>, <snitzer@kernel.org>,
        <Johannes.Thumshirn@wdc.com>
CC:     <matias.bjorling@wdc.com>, <gost.dev@samsung.com>,
        <linux-kernel@vger.kernel.org>, <hare@suse.de>,
        <linux-block@vger.kernel.org>, <pankydev8@gmail.com>,
        <jaegeuk@kernel.org>, <dm-devel@redhat.com>,
        <linux-nvme@lists.infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <514f85ce-84fc-1186-7169-a29d7118e8cc@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.8]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7djP87r7Fj9OMlj7Sdxi9d1+NotpH34y
        W/w+e57ZYu+72awWexZNYrJYufook8WT9bOYLf523WOy2HtL2+LyrjlsFvOXPWW3mND2ldni
        xoSnjBZrbj5lsThxS9qB3+PyFW+PnbPusntcPlvqsWlVJ5vH5iX1HrtvNrB57Gy9z+rxft9V
        oNDpao/Pm+Q82g90MwVwR3HZpKTmZJalFunbJXBl3Jq/k61gAVvFw3trWRsY21m7GDk5JARM
        JG7POwBkc3EICaxglPi+/DuU84VR4mjXTCjnM6PEm3f9jDAt2z9sZoNILGeUOLz2GRNc1eOZ
        S9hBqoQEdjJKPPxoBmLzCthJXGq9zwJiswioSsz/tJsZIi4ocXLmE7C4qECkxJrdZ8F6hQXi
        JX4cX8QGYjMLiEvcejIfbIGIwFJGiX+3L4KtZhaYwSRx/PIqIIeDg01AS6KxE6yZU8Ba4sPW
        HnaIZk2J1u2/oWx5ie1v5zBDvKAo0f99AxuEXSux9tgZdpCZEgL3OCWmztnFDpFwkejceRvq
        Z2GJV8e3QMVlJP7vBLkIxK6WeHrjNzNEcwujRP/O9WAHSQBd0XcmB6LGUWLB6+eMEGE+iRtv
        BSHu4ZOYtG068wRG1VlIYTELyc+zkLwwC8kLCxhZVjGKp5YW56anFhvnpZbrFSfmFpfmpesl
        5+duYgSmwtP/jn/dwbji1Ue9Q4xMHIyHGCU4mJVEeAUCHicJ8aYkVlalFuXHF5XmpBYfYpTm
        YFES503O3JAoJJCeWJKanZpakFoEk2Xi4JRqYHKLv6Y5b35ef7vnhYPf/XtDKtZKp91VWiG8
        YuYMs50n/zipScx5d8XjgrHyDb44mZevvhVn3F6dUy/mpXmrWT3iTjKjm13ykpbaa3dbXpoc
        YX68///WPOeEz+ZrS6Ri3/xwF+OQt5291zKqTuhE14Rvl/6YlX5V79ywhYnnuTsb77GgoEM3
        C7Xe1li5Zhgn+CQerzqdXFS617/yceoGEfvuKzvN3y3UNl0T1Vxw81DEwX8Flswr5qfd9fp7
        te7HrRT7t/svZ8pWXLHY0rLAXzPb4nb8kgYmp3OVcxjXfrv0UNZtz+kOo7aXk27wRm2PdOBL
        f1gcK5pcPydjZdq+pbtv+Pwz72wsyjxhIa3mrMRSnJFoqMVcVJwIANbigGD0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsVy+t/xu7p7Fz9OMvhxx9pi9d1+NotpH34y
        W/w+e57ZYu+72awWexZNYrJYufook8WT9bOYLf523WOy2HtL2+LyrjlsFvOXPWW3mND2ldni
        xoSnjBZrbj5lsThxS9qB3+PyFW+PnbPusntcPlvqsWlVJ5vH5iX1HrtvNrB57Gy9z+rxft9V
        oNDpao/Pm+Q82g90MwVwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZ
        pKTmZJalFunbJehl3Jq/k61gAVvFw3trWRsY21m7GDk5JARMJLZ/2MzWxcjFISSwlFHi1so7
        jBAJGYlPVz6yQ9jCEn+udUEVfWSUWLWulRnC2cko8fDJLSaQKl4BO4lLrfdZQGwWAVWJ+Z92
        M0PEBSVOznwCFhcViJR4uKwJrF5YIF7ix/FFbCA2s4C4xK0n85lAhoqAnDFn5hNGEIdZYAaT
        xPHLq6B2X2OSePpkDdDlHBxsAloSjZ1g93EKWEt82NrDDjFJU6J1+28oW15i+9s5zBA/KEr0
        f9/ABmHXSry6v5txAqPoLCQHzkJyyCwko2YhGbWAkWUVo0hqaXFuem6xkV5xYm5xaV66XnJ+
        7iZGYArZduznlh2MK1991DvEyMTBeIhRgoNZSYRXIOBxkhBvSmJlVWpRfnxRaU5q8SFGU2Ao
        TWSWEk3OByaxvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGJqb/
        Zt1HuU4vLZG9u8NX7GFqi4HoEw3DJblmc5JSz+YtZS9v1dg46Xba7u/3uHa0zS10EUg4f/9k
        RLAA+62wO2xVczqaJblPJ9+o3bW3Z6c2n7SQ5abefPcnhmstpht+eMe7vn/fxD/THov4R9Wn
        LCzrOuf6YqlM0F5/PoV4xrmsdwKmbV6+yPvJ7D2LVJw5+l6zrzjtLi2tenwDq0SatfZeVw3x
        n5Grjs7TeNTyT/e9TUvf/xeBxw7sqJCLv+E+W4z5YX51lOGCHxI5u04HbXc5uDW/Un9J/OSb
        E/m7fJ4/eppR0ZXt+/PqAuZJb400yuXazopMys7pV7PdF7fTkidF7lq+/7m5leGvVGZGKLEU
        ZyQaajEXFScCALp70FGqAwAA
X-CMS-MailID: 20220729090918eucas1p1782d5db2070d20502d6534c7a7e37a22
X-Msg-Generator: CA
X-RootMTR: 20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9
References: <20220727162245.209794-1-p.raghav@samsung.com>
        <CGME20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9@eucas1p2.samsung.com>
        <20220727162245.209794-3-p.raghav@samsung.com>
        <7984b969-9025-6b31-2645-da08daeefafb@acm.org>
        <eed7d9ee-fd7f-e57c-598e-909dbb0d2380@samsung.com>
        <514f85ce-84fc-1186-7169-a29d7118e8cc@acm.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-28 15:29, Bart Van Assche wrote:

>> But I am fine with going back to bdev_is_zone_start if you and Damien
>> feel strongly otherwise.
> The "zone start LBA" terminology occurs in ZBC-1, ZBC-2 and ZNS but
> "zone aligned" not. I prefer "zone start" because it is clear,
> unambiguous and because it has the same meaning as in the corresponding
> standards documents. I propose to proceed as follows for checking
> whether a number of LBAs is a multiple of the zone length:
> * Either use bdev_is_zone_start() directly.
> * Or introduce a synonym for bdev_is_zone_start() with an appropriate
> name, e.g. bdev_is_zone_len_multiple().
> 
Thanks for the clarification Bart. I will go with bdev_is_zone_start()
as it is also a commonly used terminology.
> Thanks,
> 
> Bart.
