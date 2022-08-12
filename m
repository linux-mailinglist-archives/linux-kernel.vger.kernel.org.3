Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FBF590C82
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbiHLHZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiHLHZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:25:54 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6072B20BC2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 00:25:49 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220812072544euoutp02151d69146211b17b1f70bff707f9edd3~KiC4jc1Xe1472314723euoutp02G
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:25:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220812072544euoutp02151d69146211b17b1f70bff707f9edd3~KiC4jc1Xe1472314723euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660289144;
        bh=PZsQf3iDA8wIHZWw0fJKxNZcUxFzh+Qp6mRoTJ+47pI=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=Y/4OGgfG/jqYWaBfYVs5GRFvI+enYczKqWf8HXw0YzFa4OxxjjELbIAfm7vZTs1dw
         LhMdjiuDvzvTlLvV6n3YYG90xpCqX/zq1whZnnNF8o0Irze+n0mhKH/kjBAWDNTICM
         OIIUOgONTldx+RHLKpXZpL+C2IoheJbKQtucSpC8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220812072543eucas1p16de268e8d20b6b6596d02826ca4663b2~KiC4K812m0990809908eucas1p1H;
        Fri, 12 Aug 2022 07:25:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BF.F7.09664.77006F26; Fri, 12
        Aug 2022 08:25:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220812072543eucas1p17481ebc371248a10ba678ac2367bca7a~KiC30R8Ur1207412074eucas1p1H;
        Fri, 12 Aug 2022 07:25:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220812072543eusmtrp1732435be62682777d2e3252a58702ae4~KiC3zahY00802508025eusmtrp12;
        Fri, 12 Aug 2022 07:25:43 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-6e-62f600779d02
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3B.80.09095.77006F26; Fri, 12
        Aug 2022 08:25:43 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220812072543eusmtip2f234d39b26ca1f6cc254757c34376da3~KiC3nN_KP0089400894eusmtip2p;
        Fri, 12 Aug 2022 07:25:43 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.18) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 12 Aug 2022 08:25:26 +0100
Message-ID: <b250d97d-d0f2-0f89-dc02-a1bf54f8e43f@samsung.com>
Date:   Fri, 12 Aug 2022 09:25:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v10 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <snitzer@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
        <agk@redhat.com>
CC:     <linux-block@vger.kernel.org>, <Johannes.Thumshirn@wdc.com>,
        <bvanassche@acm.org>, <matias.bjorling@wdc.com>, <hare@suse.de>,
        <gost.dev@samsung.com>, <linux-nvme@lists.infradead.org>,
        <jaegeuk@kernel.org>, <pankydev8@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dm-devel@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Joel Granados <j.granados@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <9cc04d5e-dfa5-6d48-b9e1-60d319ab2299@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.18]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djP87rlDN+SDLrfmVusP3WM2WL13X42
        i2kffjJb/D57ntmitf0bk8Xed7NZLfYsmsRksXL1USaLJ+tnMVv87boHlLilbXF51xw2i/nL
        nrJbTGj7ymyx5uZTFosTt6QdBDwuX/H22DnrLrvH5bOlHptWdbJ5bF5S77H7ZgObx87W+6we
        7/ddBQqdrvb4vEnOo/1AN1MAdxSXTUpqTmZZapG+XQJXxo8dr1gLvnNX3GxawNLAeJSzi5GD
        Q0LAROLuLd4uRi4OIYEVjBJ79i1n7WLkBHK+MEr8nSEDkfjMKLHyxVRGkARIw4HeR+wQieWM
        Ei2vz7DDVe2a/pENwtnFKPHo8FOwFl4BO4n2eVfA5rIIqEo8+HOMHSIuKHFy5hMWEFtUIFJi
        ze6z7CA3CQtkS0zssAEJMwuIS9x6Mp8JZKaIQAOjxPT9W8AcZoEfTBJbPk1jAmlgE9CSaOwE
        m8kp4Cbx8/c8dohmTYnW7b+hbHmJ7W/nMEO8oCSxsO0OG4RdK7H2GMQHEgLPOCVOPPnFBJFw
        kVjyaio7hC0s8er4FihbRuL05B4WCLta4umN38wQzS2MEv0717NBQtVaou9MDkSNI9CTt6DC
        fBI33gpC3MMnMWnbdOYJjKqzkIJiFpKfZyF5YRaSFxYwsqxiFE8tLc5NTy02zEst1ytOzC0u
        zUvXS87P3cQITIin/x3/tINx7quPeocYmTgYDzFKcDArifCWLfqcJMSbklhZlVqUH19UmpNa
        fIhRmoNFSZw3OXNDopBAemJJanZqakFqEUyWiYNTqoGpvOpm8e+UI9v2O63Ri2X+I748fvVu
        lVmalm3+Z7Jj5xy/FZLjuG5j4z2+ZY/8u60ZT1YzLRH8fO7iaVb2xIfVr1L8RCd2XPjy8e2/
        bW0VJh2hKpW+czyDbdLbDUNn3vJ0SAl3+Xc6KWJTS5LE/+ZNwe9+6fg+/H/Ned8F37VhYpbr
        V2jcXqy+/aPHF5lPf7VK1rxdbGBksfVbO7euyGr++cqb+v/0cmXWfBEPYS85+67blPnIm6TV
        G6OfZAplzXWNfHe878Xy9CszJ0sdt3j4NsUxdNbXe9u2tZ1fvXXF6e/H7ld0/k9dq2frpnbh
        3mqRA+byMkaGW//vXG/dbTc5p757Q+2x9ms+MWLOuj6/lViKMxINtZiLihMBUIqufPcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsVy+t/xe7rlDN+SDI4ekrFYf+oYs8Xqu/1s
        FtM+/GS2+H32PLNFa/s3Jou972azWuxZNInJYuXqo0wWT9bPYrb423UPKHFL2+LyrjlsFvOX
        PWW3mND2ldlizc2nLBYnbkk7CHhcvuLtsXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j52t91k9
        3u+7ChQ6Xe3xeZOcR/uBbqYA7ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNT
        JX07m5TUnMyy1CJ9uwS9jB87XrEWfOeuuNm0gKWB8ShnFyMnh4SAicSB3kfsXYxcHEICSxkl
        bp5qY4ZIyEh8uvKRHcIWlvhzrYsNougjo8S8c3+YIJxdjBKbrs1hBKniFbCTaJ93hRXEZhFQ
        lXjw5xg7RFxQ4uTMJywgtqhApMTDZU1AzRwcwgLZEhM7bEDCzALiEreezAebKSLQwCgxff8W
        MIdZ4AeTxJZP06C2/WGUmPWmmxWkm01AS6KxE2wBp4CbxM/f89ghJmlKtG7/DWXLS2x/Owfq
        HSWJhW132CDsWolX93czTmAUnYXkvllIDpmFZNQsJKMWMLKsYhRJLS3OTc8tNtQrTswtLs1L
        10vOz93ECEwl24793LyDcd6rj3qHGJk4GA8xSnAwK4nwli36nCTEm5JYWZValB9fVJqTWnyI
        0RQYSBOZpUST84HJLK8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1Oq
        genY+6sHhEIdPS26ZuXbf7WWaWCJYtdg9w7bMPnPzc2dW3KnB3/iv7Egaa7vfvbEQkuVsCjf
        PVP1dLTPzNp7X9++YU7cvSnnbf2Zdl43Xnfjnn95vsLqM/uvvdkYdaPpoe0Vz2n7HlTuPmMU
        LDelOrPt2nHV5e/Pf1WLSjn994bIjt3+T+5r/ttzbOuzoHMxJYbs+Rplt5T2fNe9tT7q28S+
        Gxv8P8hViBZlbfsibNq4X8Di0TZDsdspK/+WqnR2Ti3ffdpqZZ8O47rYU/cU4uOn8WjUPm+/
        yqipdOo2R2yM1QGPrW6/Xq7SZhFL6Z3p6LrM4veJo4n7N0c+yPq8ZUfP0lhBi7+dDZOniXY9
        LIxSYinOSDTUYi4qTgQARMUMOK4DAAA=
X-CMS-MailID: 20220812072543eucas1p17481ebc371248a10ba678ac2367bca7a
X-Msg-Generator: CA
X-RootMTR: 20220811143058eucas1p247291685ffff7a75186947fd30b5c13f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143058eucas1p247291685ffff7a75186947fd30b5c13f
References: <20220811143043.126029-1-p.raghav@samsung.com>
        <CGME20220811143058eucas1p247291685ffff7a75186947fd30b5c13f@eucas1p2.samsung.com>
        <20220811143043.126029-14-p.raghav@samsung.com>
        <9cc04d5e-dfa5-6d48-b9e1-60d319ab2299@opensource.wdc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien,

>> |--------------|---|--------------|---|
>> 0             3M  4M             7M  8M
>>
>> The area between target's zone capacity and zone size will be emulated
>> in the target.
>> The read IOs that fall in the emulated gap area will return 0 filled
>> bio and all the other IOs in that area will result in an error.
>> If a read IO span across the emulated area boundary, then the IOs are
>> split across them. All other IO operations that span across the emulated
>> area boundary will result in an error.
>>
>> The target can be easily created as follows:
>> dmsetup create <label> --table '0 <size_sects> po2zone /dev/nvme<id>'
>>
>> Note that the target does not support partial mapping of the underlying
>> device.
>>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
>> Suggested-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Joel Granados <j.granados@samsung.com>
> 
> You changed this patch. So it needs review again. Please do not carry previous
> review tags in that case.
> The changes were non-functional such as changing multiplication to
shifts and rephrasing error messages.

While I agree with your comment not to carry forward review tags if the
patch has changed, I thought it might be too much to ask a reviewer to
re-review for non-functional changes such as these. But I will request
Joel to do a quick re-review.

Thanks.
