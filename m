Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74435AD354
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiIEM5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236829AbiIEM53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:57:29 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B3E205D8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:57:28 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220905125717euoutp027248ac07bcd2254342a6b7f8dd347fc7~R_DNufX_L0936709367euoutp02C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 12:57:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220905125717euoutp027248ac07bcd2254342a6b7f8dd347fc7~R_DNufX_L0936709367euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662382637;
        bh=0NOo6f/pWYXuPoQFfjEOXBVE2XC8pCS60UOPZi9RzHU=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=NN+9eXvzx0lqZ+64NZjyuQcp9cbTMwvnURrGMqQAJOLw4mJGZta+4rDN3bpUCMeLV
         1c1uJC0Bwsodqxj30MPpsMMv7aGMcuANdoOtdk7VtJduK6Ejo8JGZNEad5/Wimjl9F
         3/o1M2L9YH+PblB1DjmCavRP82rbafXmBnnxAYN4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220905125712eucas1p27c789651a573fe2b0f6774b0a5c7889f~R_DI2eCzV1056610566eucas1p2j;
        Mon,  5 Sep 2022 12:57:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1D.2C.19378.722F5136; Mon,  5
        Sep 2022 13:57:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220905125711eucas1p12e53a64104034b1a8dca6ada0a79cf94~R_DIcHdgG1238212382eucas1p1v;
        Mon,  5 Sep 2022 12:57:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220905125711eusmtrp20c331e84f5a49de8bce1b5aa4250139d~R_DIbOf650766107661eusmtrp2u;
        Mon,  5 Sep 2022 12:57:11 +0000 (GMT)
X-AuditID: cbfec7f5-a35ff70000014bb2-e1-6315f2279068
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 15.CB.10862.722F5136; Mon,  5
        Sep 2022 13:57:11 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220905125711eusmtip19aba6d939273cea0e9076ccec1896a95~R_DILN56f3006530065eusmtip1b;
        Mon,  5 Sep 2022 12:57:11 +0000 (GMT)
Received: from [106.110.32.100] (106.110.32.100) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 5 Sep 2022 13:57:10 +0100
Message-ID: <67726654-2c13-2c41-c002-30dc99db8497@samsung.com>
Date:   Mon, 5 Sep 2022 14:57:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v12 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Content-Language: en-US
To:     Mike Snitzer <snitzer@redhat.com>
CC:     <agk@redhat.com>, <snitzer@kernel.org>, <axboe@kernel.dk>,
        <damien.lemoal@opensource.wdc.com>, <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>, <bvanassche@acm.org>,
        <pankydev8@gmail.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        <gost.dev@samsung.com>, <jaegeuk@kernel.org>,
        <matias.bjorling@wdc.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <YxJwd7xcZRdznsYz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.100]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djP87rqn0STDbattbRYf+oYs8Xqu/1s
        FtM+/GS2+H32PLNFa/s3Jou972azWqxcfZTJ4sn6WcwWf7vuAcVuaVtc3jWHzWL+sqfsFhPa
        vjJbrLn5lMXixC1pi7aNXxkdBDwuX/H22DnrLrvH5bOlHptWdbJ5bF5S77H7ZgObx87W+6we
        7/ddZfP4vEnOo/1AN1MAVxSXTUpqTmZZapG+XQJXxpEnKxkL1vJV3Nhwnb2BcRV3FyMnh4SA
        icSb93vZuxi5OIQEVjBK9FxcxAbhfGGU+DZrLSuE85lR4ta1uUwwLSvXvGGBSCxnlDjweSUz
        XFXvgbNQzi5GiYfrp7GCtPAK2EmcebkYqJ2Dg0VARaL3pCREWFDi5MwnLCC2qECkxJrdZ9lB
        bGGBbImlfcfBbGYBcYlbT+aDtYoIqErcmuYCET7ELHHhRjZImE1AS6KxE6yaE8h833OaCaJE
        U6J1+2+oKfIS29/OYYa4X0liwrz7bBB2rcTaY2fA3pcQeMQpcWV9KyNEwkVi7co/UEXCEq+O
        b2GHsGUk/u+cDw2IaomnN34zQzS3MEr071zPBnKQhIC1RN+ZHIgaR4n9C84zQ4T5JG68FYS4
        h09i0rbpzBMYVWchBcQsJA/PQvLCLCQvLGBkWcUonlpanJueWmycl1quV5yYW1yal66XnJ+7
        iRGYBk//O/51B+OKVx/1DjEycTAeYpTgYFYS4U3ZIZIsxJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nDc5c0OikEB6YklqdmpqQWoRTJaJg1Oqgalsziu3+lPvtAqrbp5f8SKMU+I5U3vIfd8odrXH
        bOKX+HN7t5w58ILZamXZJBXbG97X9AyPbDEwPKZjG7WwzkhA/at00YOGt/ed5gsmWMyQXDhX
        9rnggoBqt4uylZ1Nt+zd5h2YFx/W8aw2vW3WziZBTfHLnc/q+xiVSswr5d6kRkyP1Qr2CvFZ
        um/vzgdMNkUHI64LvtNNt/BQfv1i9WEWmRPsH+aUe3VXmO1WCOdcveTCX9lHG6PvLEu7Zajw
        Wk6w1tZub+rTo9OyOZb+eJ/yNsV5nkHu1faJjg/kmiWMO3heXPr0N/6x7qFy1RfuhicXHD1x
        8fitKfYrt219UX5bl/P0huqy6pyjK+e9rldiKc5INNRiLipOBACZzGsn8gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsVy+t/xu7rqn0STDY5MlLJYf+oYs8Xqu/1s
        FtM+/GS2+H32PLNFa/s3Jou972azWqxcfZTJ4sn6WcwWf7vuAcVuaVtc3jWHzWL+sqfsFhPa
        vjJbrLn5lMXixC1pi7aNXxkdBDwuX/H22DnrLrvH5bOlHptWdbJ5bF5S77H7ZgObx87W+6we
        7/ddZfP4vEnOo/1AN1MAV5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6d
        TUpqTmZZapG+XYJexpEnKxkL1vJV3Nhwnb2BcRV3FyMnh4SAicTKNW9YQGwhgaWMEpN+Z0PE
        ZSQ+XfnIDmELS/y51sXWxcgFVPORUeLd00usEM4uRok9e+6yglTxCthJnHm5mKmLkYODRUBF
        ovekJERYUOLkzCdgC0QFIiUeLmtiArGFBbIllvYdB1vALCAucevJfLBWEQFViVvTXEDGMwsc
        YpZY1buZCWLXP0aJE+vmM4MUsQloSTR2gvVyApnve04zQczRlGjd/htqprzE9rdzmCEeUJKY
        MO8+G4RdK/Hq/m7GCYyis5CcNwvJGbOQjJqFZNQCRpZVjCKppcW56bnFRnrFibnFpXnpesn5
        uZsYgclj27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRHelB0iyUK8KYmVValF+fFFpTmpxYcYTYFB
        NJFZSjQ5H5i+8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamIQC
        /od7nHUxdV+YvTZi47Z1XRVHtuy92nU+i5vh5z/269ei7XcsW61yTHyTyI2Li45GzKhQYcoJ
        3fVm8hOXL2YO+3ZEPThscE+mVv5d8b6t2TI/VB5c+XVIuHv66qtHtdvv5bbKyLjoMufXek4x
        XHrjsn3KYrODRUfUfx1VvP5B5OXpKf8qEsTtXsetZ7tU+TJ6gU3Ix+x3m7j+7z3NFdMb8P7G
        joyjje9lv1ez79h47nyhxF2jDbGc/zK6LPovpteZfT/KusxZuWSbiR8Pb5RAsvhaMUZFU34r
        o1TxRT9Pz5hv2qQh2LayVTplps2944v+ufVrTf6c8Oz15VxN+QX7d62InpP7wlty6lP3LfVK
        LMUZiYZazEXFiQDE0KUFpwMAAA==
X-CMS-MailID: 20220905125711eucas1p12e53a64104034b1a8dca6ada0a79cf94
X-Msg-Generator: CA
X-RootMTR: 20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de
References: <20220823121859.163903-1-p.raghav@samsung.com>
        <CGME20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de@eucas1p1.samsung.com>
        <20220823121859.163903-14-p.raghav@samsung.com>
        <YxJttvB2Z5I58SQ5@redhat.com> <YxJwd7xcZRdznsYz@redhat.com>
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> 1) why is a partial mapping of the underlying device disallowed?
>> 2) why is it assumed all IO is read-only? (talk to me and others like
>>    we don't know the inherent limitations of this class of zoned hw)
>>
>> On a code level:
>> 1) are you certain you're properly failing all writes?
>>    - are writes allowed to the "zone capacity area" but _not_
>>      allowed to the "emulated zone area"? (if yes, _please document_). 
>> 2) yes, you absolutely need to implement the .status target_type hook
>>    (for both STATUS and TABLE).
>> 3) really not loving the nested return (of DM_MAPIO_SUBMITTED or
>>    DM_MAPIO_REMAPPED) from methods called from dm_po2z_map().  Would
>>    prefer to not have to do a depth-first search to see where and when
>>    dm_po2z_map() returns a DM_MAPIO_XXX unless there is a solid
>>    justification for it.  To me it just obfuscates the DM interface a
>>    bit too much. 
>>
>> Otherwise, pretty clean code and nothing weird going on.
>>
>> I look forward to seeing your next (final?) revision of this patchset.
> 
> Thinking further.. I'm left confused about just what the heck this
> target is assuming.
> 
> E.g.: feels like its exposing a readonly end of the zone is very
> bi-polar... yet no hint to upper layer it shouldn't write to that
> read-only end (the "emulated zone").. but there has to be some zoned
> magic assumed?  And I'm just naive?
> 

You are absolutely right about "zoned magic". Applications that use a zoned
block device are aware of the zone capacity and zone size. BLKREPORTZONE
ioctl is typically used to get the zone information from a zoned block device.

This target adjusts the zone report so that zone size and zone capacity are
modified correctly (see dm_po2z_report_zones() and
dm_po2z_report_zones_cb() functions).
