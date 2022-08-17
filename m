Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2486596A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiHQHgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiHQHgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:36:05 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3C975CE7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:36:01 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220817073600euoutp02a9cd53b6a4d2273ccad02337f2f94963~MEaRyFQBC2984629846euoutp02v
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:36:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220817073600euoutp02a9cd53b6a4d2273ccad02337f2f94963~MEaRyFQBC2984629846euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660721760;
        bh=RCMJ/sBC9tRTXd5pStdmRFTSefL5k27JvB4kPRdUH58=;
        h=Date:From:Subject:To:CC:In-Reply-To:References:From;
        b=r4gVqv9MD3OAeG9yYzdlUE/Wnb2htUqFYdXNhDxC16+Wlhsum3Y2NMe1jxQ3rFEBw
         TOiA7Np5wlu+od7A4viyIE/EbQ/zLEplNpocmqDrXvEhE07kJtqzDGXd9hrqm6k8M4
         JT0fzDV0uvgmMweIUtV4Ri1A7RTwTfzUT0pzorOE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220817073600eucas1p235b8d8108a94d0d3fee28d981b5825d6~MEaRYmfyH0043600436eucas1p2N;
        Wed, 17 Aug 2022 07:36:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DD.5A.10067.06A9CF26; Wed, 17
        Aug 2022 08:36:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220817073559eucas1p2ab394166a038bb1a465409ed7abc2997~MEaQ5hExr3079230792eucas1p2b;
        Wed, 17 Aug 2022 07:35:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220817073559eusmtrp265c2a4659f1be7f3820043f28e2691bb~MEaQ4lPP60351603516eusmtrp2Z;
        Wed, 17 Aug 2022 07:35:59 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-fc-62fc9a6037df
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 91.E2.09038.F5A9CF26; Wed, 17
        Aug 2022 08:35:59 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220817073559eusmtip2c9a7b2c77dfe9a6e218cc17fbe32b2c6~MEaQljAYK2156721567eusmtip2p;
        Wed, 17 Aug 2022 07:35:59 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.74) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 17 Aug 2022 08:35:56 +0100
Message-ID: <ab3ef674-c453-5b38-80b5-f41dcfed62bb@samsung.com>
Date:   Wed, 17 Aug 2022 09:35:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
From:   Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v11 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <axboe@kernel.dk>, <snitzer@kernel.org>, <hch@lst.de>,
        <agk@redhat.com>
CC:     <pankydev8@gmail.com>, <gost.dev@samsung.com>,
        <matias.bjorling@wdc.com>, <hare@suse.de>, <bvanassche@acm.org>,
        <linux-kernel@vger.kernel.org>, <dm-devel@redhat.com>,
        <linux-nvme@lists.infradead.org>, <jaegeuk@kernel.org>,
        <Johannes.Thumshirn@wdc.com>, <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Content-Language: en-US
In-Reply-To: <30790cae-5440-2447-a8b8-52a57fa16fa5@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.74]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7djPc7oJs/4kGSzfy2qx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaL1vZvTBZ7381mtdizaBKTxcrVR5ksnqyfxWzxt+seUOKWtsXlXXPYLOYv
        e8puMaHtK7PFmptPWSxO3JJ2EPC4fMXbY+esu+wel8+Wemxa1cnmsXlJvcfumw1sHjtb77N6
        vN93FSh0utrj8yY5j/YD3UwB3FFcNimpOZllqUX6dglcGcsvHWQvWMZa8brpHmsDYxtLFyMn
        h4SAicSHriY2EFtIYAWjxO9zQl2MXED2F0aJxfsmMUMkPjNKvDwfANOw7uRSNoii5YwSt3sa
        WCAcoKI9M9ezQHTsYpQ4tFkUxOYVsJNoBDq8i5GDg0VAVeJ3vxREWFDi5MwnYOWiApESa3af
        BSthE9CSaOxkBwkLC2RLPDjQzAgyXkSggVHi565vYA6zwAUmiSOT14GdzSwgLnHryXwmkGZO
        ATeJ9Y8rIcKaEq3bf7ND2PIS29/OYYZ4QEni6qkT7BB2rcTaY2eg7EecEvtXVEHYLhJ/f85l
        g7CFJV4d3wJVIyPxfyfIKhC7WuLpjd/MIPdICLQwSvTvXM8GcoOEgLVE35kciBpHiQ3XvrBA
        hPkkbrwVhDiHT2LStunMExhVZyGFxCwkz8xC8sEsJB8sYGRZxSieWlqcm55abJSXWq5XnJhb
        XJqXrpecn7uJEZgKT/87/mUH4/JXH/UOMTJxMB5ilOBgVhLhFXzxI0mINyWxsiq1KD++qDQn
        tfgQozQHi5I4b3LmhkQhgfTEktTs1NSC1CKYLBMHp1QD0+T23ELnj4EnmCV4jiVqLc/azzSl
        +8zthn2dS8omZzlZBF8uTYoT6z7q92s+/+HXfau3Ztv96n+8YLbr0VWx55lmG+i8lGjbeMFq
        b0KWmu5J5QkB6q732KwsJ6tYbm05xRQuvDllkcXpP0vYzx9yyPNQWzxPan/vKRZ5x09qE7zW
        qG/gef5EVdywNLMv5+BH94f2rAU6qzn2MD4LO+W2frt2zFdrP8nNlXvLJhs8SVvFoj5n3TTd
        feU2HhqSjz5vaAje/n7yVdWV7pNdgwpuZ8jskeLNeLe3OE/y0UzFzb1TFVjlJOdevvrWubxF
        //mh00xtDO8EmSVYiiw31LFae/VLxdt/WXFncccebcEqJZbijERDLeai4kQAu9ztj/QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsVy+t/xe7rxs/4kGUyYLGex/tQxZovVd/vZ
        LKZ9+Mls8fvseWaL1vZvTBZ7381mtdizaBKTxcrVR5ksnqyfxWzxt+seUOKWtsXlXXPYLOYv
        e8puMaHtK7PFmptPWSxO3JJ2EPC4fMXbY+esu+wel8+Wemxa1cnmsXlJvcfumw1sHjtb77N6
        vN93FSh0utrj8yY5j/YD3UwB3FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkam
        Svp2NimpOZllqUX6dgl6GcsvHWQvWMZa8brpHmsDYxtLFyMnh4SAicS6k0vZuhi5OIQEljJK
        /FjazQSRkJH4dOUjO4QtLPHnWhdU0UdGiY13Z0M5uxgl9m2ZzwpSxStgJ9EI9EQXIwcHi4Cq
        xO9+KYiwoMTJmU/AtokKREo8XNbEBFLCJqAl0dgJNl9YIFviwYFmRpCRIgINjBI/d31jBEkw
        C5xjknj+NBXEFhL4wyjxaZIPRFxc4taT+WBzOAXcJNY/roQIa0q0bv/NDmHLS2x/O4cZ4n4l
        iaunTkD9Uivx6v5uxgmMorOQXDcLydRZSEbNQjJqASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k
        /NxNjMAksu3Yzy07GFe++qh3iJGJg/EQowQHs5IIr+CLH0lCvCmJlVWpRfnxRaU5qcWHGE2B
        ITSRWUo0OR+YxvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGphC
        7ojOj7ezEWD7tkno7J0nx3oPbdMt0l97eNuiPw2u7znnNv35ZL3s2mPH58EGvBdK/zTzizSK
        LCpcc2u9xpoaSY8Qx2nffm/V19+6X4O3J2lx3iIh5unZs502nd0iuOam/b/U7ylG9xsMRI6F
        XG1VbpE+eTXwwq7iaQKn4tb3/b6VLBE/pce8OFz11rSrHBNYDe4W3lq+4vazas43/v95/urf
        9Dqaznn7Xa9m2Mscvb1HQ48Kz316Rafw0r2vj1XWqn2987Z2X9xfyRmM6lN4F1yTe+MTXXj0
        cQ1TwAOFo3vrmy+xVzgbF4iu2NiSr7jvoIQ055repOfdoRzKutsLm+e517AIOChdTV+ophGv
        xFKckWioxVxUnAgAngpcwasDAAA=
X-CMS-MailID: 20220817073559eucas1p2ab394166a038bb1a465409ed7abc2997
X-Msg-Generator: CA
X-RootMTR: 20220816131551eucas1p218faf35348e78a73aaa87d5477ecdb2e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220816131551eucas1p218faf35348e78a73aaa87d5477ecdb2e
References: <20220816131536.189406-1-p.raghav@samsung.com>
        <CGME20220816131551eucas1p218faf35348e78a73aaa87d5477ecdb2e@eucas1p2.samsung.com>
        <20220816131536.189406-14-p.raghav@samsung.com>
        <30790cae-5440-2447-a8b8-52a57fa16fa5@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien,
>> + */
>> +static bool bio_in_emulated_zone_area(struct dm_po2z_target *dmh,
>> +				      struct bio *bio, int *offset)
> 
> This function name reads like it is a block layer helper. It mat be less
> confucing to keep using the dm_po2z_ prefix for it.
>
Good point. Even though it is a static function in the same file, it could
be confused for a block helper at the caller site.
>> +{
>> +	/*
>> +	 * Read operation on the emulated zone area (between zone capacity
>> +	 * and zone size) will fill the bio with zeroes. Any other operation

>> +
>> +	return DM_MAPIO_KILL;
>> +}
> 
Do you see any more issues apart from the two you pointed out?
