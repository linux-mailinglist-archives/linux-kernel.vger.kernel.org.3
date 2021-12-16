Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EF7476B50
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhLPIBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:01:39 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:43121 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbhLPIBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:01:37 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20211216080135epoutp020923c9bc4dc32beaf377cc01a2c4de1e~BLW9c3-iT2948729487epoutp02b
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 08:01:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20211216080135epoutp020923c9bc4dc32beaf377cc01a2c4de1e~BLW9c3-iT2948729487epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639641695;
        bh=5y97tgp0fDZSDibO/cpPtQ0gF2gqCgfXcUTjEGwvhLY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=M+3K10ItUFfE4OeyoKl+ZD5jspr+EqLR2VD/25q3sM/SmgXAyPuPYS+DKmfFheR46
         wkbB6WEAYZnqQfXlOWWVh2k1bNOJqBZKCfYKbJkLVzvtKisAnziHPXtZFfytDFKXvb
         WK+HklbNLaZPbYZr7hmBQ1llSTbFYwkK/TRSCghA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20211216080135epcas1p36d26bac9cb607de76bb5a900a6bbe27d~BLW88tvrT2252222522epcas1p3p;
        Thu, 16 Dec 2021 08:01:35 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.237]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JF4Ly1qRkz4x9Pp; Thu, 16 Dec
        2021 08:01:30 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.8A.64085.462FAB16; Thu, 16 Dec 2021 17:01:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211216080129epcas1p1508dc29e0f2ba4ff03df45837efbc8b5~BLW3_JjlB3003130031epcas1p12;
        Thu, 16 Dec 2021 08:01:29 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211216080129epsmtrp298a7b24c10fcb310f9fe5c1467a776d3~BLW3602EF3077230772epsmtrp2Q;
        Thu, 16 Dec 2021 08:01:29 +0000 (GMT)
X-AuditID: b6c32a35-9c3ff7000000fa55-6d-61baf2649d3e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.17.08738.952FAB16; Thu, 16 Dec 2021 17:01:29 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211216080129epsmtip11e4fca1ae3e474b1fff6359234dc1d7b~BLW3m91V00741907419epsmtip1a;
        Thu, 16 Dec 2021 08:01:29 +0000 (GMT)
Subject: Re: [PATCH v2] extcon: fix extcon_get_extcon_dev() error handling
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b4d0c326-3122-c5f9-f376-b122f263d92c@samsung.com>
Date:   Thu, 16 Dec 2021 17:24:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211216075233.GD1978@kadam>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmnm7Kp12JBv82sFsca3vCbvH633QW
        i+bF69ks3hyfzmTRtXoni8XWW9IWl3fNYbOYvaSfxeJz7xFGi0XLWpktniw8w2Rxu3EFm8Xp
        3SUWPw+dZ3Lg89jwaDWrx6ZVnWwe804Geuyfu4bd4+PTWywe7/ddZfPY+b2B3aNvyypGj8+b
        5AI4o7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BO
        V1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBboFSfmFpfmpevlpZZYGRoYGJkC
        FSZkZ9y8LFhwgrPiePsHpgbGi+xdjJwcEgImEpNnNTN3MXJxCAnsYJRYsO8BG4TziVHi0bLP
        LCBVQgKfGSV2nRSE6bj/5x87RNEuRolVPz8zQTjvGSV+b9oHNldYwEuia/YhNhBbREBH4nLn
        D7AOZoHrzBJ953czgSTYBLQk9r+4AVbEL6AocfXHY0YQm1fATmL7oxlgq1kEVCU2LZwKVi8q
        ECZxclsLVI2gxMmZT8BqOIHmLN4zD2wOs4C4xK0n85kgbHmJ7W/ngD0nIfCEQ2LJteusED+4
        SJz/dYkFwhaWeHV8CzQ0pCQ+v9vLBtGwjFHi1+ROJghnPaPEy1mdzBBVxhL7l04GSnAArdCU
        WL9LHyKsKLHz91xGiM18Eu++9rCClEgI8Ep0tAlBlChLXH5wlwnClpRY3N7JNoFRaRaSf2Yh
        +WEWkh9mISxbwMiyilEstaA4Nz212LDAEB7dyfm5mxjB6VrLdAfjxLcf9A4xMnEwHmKU4GBW
        EuF9ErErUYg3JbGyKrUoP76oNCe1+BCjKTCEJzJLiSbnAzNGXkm8oYmlgYmZkbGJhaGZoZI4
        7wv/6YlCAumJJanZqakFqUUwfUwcnFINTIZGEX67N83N5074LJY56xV7jN/MuvUVWTpvPMM6
        dZK+1qjnTmoI2K3zKnTlo/yec1NmqPDZ/5tWX3wm5R3n4zZuUYdW03k8/w52/FQwyzfsn6sy
        1/nyPiOvmgzv3yZz3GclnYlV2dd90ZrjqfuZrdP2cMuvs7AR/Khe+8r/qlhs7luT6/UShf9S
        Dutd9py0YjKTisHn3v+VVV7q5qr7Zsz7+D1mkqz97OPTdoRFT5epvR+Q6TfHdIP5z+UfWuPM
        d2w9vr7nRy//xRdzSj4qir81ebfv71qmEiPVc2nC3xYlemfVTrDkOHZabevKX1+cHh8Xznht
        zP53pkB7O1PMdtkQ1/e1/5bFOWnruKf9UmIpzkg01GIuKk4EAPpaEXdgBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWy7bCSnG7kp12JBr/ea1gca3vCbvH633QW
        i+bF69ks3hyfzmTRtXoni8XWW9IWl3fNYbOYvaSfxeJz7xFGi0XLWpktniw8w2Rxu3EFm8Xp
        3SUWPw+dZ3Lg89jwaDWrx6ZVnWwe804Geuyfu4bd4+PTWywe7/ddZfPY+b2B3aNvyypGj8+b
        5AI4o7hsUlJzMstSi/TtErgybl4WLDjBWXG8/QNTA+NF9i5GTg4JAROJ+3/+AdlcHEICOxgl
        Jv+9CZWQlJh28ShzFyMHkC0scfhwMUTNW0aJBYefgtUIC3hJdM0+xAZiiwjoSFzu/AE2iFng
        NrNE07EnzBAdFxklzt+fA1bFJqAlsf/FDTCbX0BR4uqPx4wgNq+AncT2RzNYQGwWAVWJTQun
        MoHYogJhEjuXPGaCqBGUODnzCVgNJ9CcxXvmgc1hFlCX+DPvEjOELS5x68l8JghbXmL72znM
        ExiFZyFpn4WkZRaSlllIWhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOWy2t
        HYx7Vn3QO8TIxMF4iFGCg1lJhPdJxK5EId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmk
        J5akZqemFqQWwWSZODilGpgaJu1eVLLUdN81Hs/U9ntaab7aH5nu75gUzPy5v2J3IPfq1Edb
        VWOT8rwzMl0Pq7f6pIdoXv9/mmf7XKNDmZYxvDLlNq9vZZ+Ykvvz2wxPVq2el6/PzFVIu7/v
        lGHpbufW67vX8rRemnBxyrWCs8u2HWcsZsq7L+vrvjh1g4mXwOpF9p/d7p2dYHeY6/9zAYWp
        km/MVr283d///NYsMbO3aVN05TrfSrmaMmQ8MbYK2puw7FGcjvmJJRr3hKwduictesg5vWB6
        u6iF8sorj82cJwVyvZ4r28fIeGGn0BXrpD/q687EfQyaeK2xeXKscMPs0rm/Q/kvHFmcwmp9
        /DJLyka2vYonY2e5dcz5ovBaiaU4I9FQi7moOBEA5WfrWkoDAAA=
X-CMS-MailID: 20211216080129epcas1p1508dc29e0f2ba4ff03df45837efbc8b5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211123084357epcas1p14833147710153f9606f14941ac8b0d96
References: <CGME20211123084357epcas1p14833147710153f9606f14941ac8b0d96@epcas1p1.samsung.com>
        <20211123083925.GA3277@kili>
        <562b12ff-e395-c818-787e-7fd6ee6d53fb@samsung.com>
        <20211216075233.GD1978@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 4:52 PM, Dan Carpenter wrote:
> On Thu, Dec 16, 2021 at 03:39:46PM +0900, Chanwoo Choi wrote:
>> Hi Dan,
>>
>> First of all,  sorry for late reply.
>>
>> There is one issue. About this issue, I already discussed on patch[1]
>> [1] https://lore.kernel.org/lkml/5BEB63C3.1020504@samsung.com/ 
>>
>> extcon_get_extcon_dev() is used for anywhere except for probe step.
>> But EPROBE_DEFER is only used on probe step.
>>
>> So that it is not clear to return EPROBE_DEFER from extcon_get_extcon_dev()
>> because extcon_get_extcon_dev() never know either call it on probe function
>> or not.
> 
> Currently extcon_get_extcon_dev() is only called from probe so it's not
> an issue.

Even if extcon_get_extcon_dev() is used on probe until now,
it is possible to use on anywhere as I commented.

It is difficult to agree this approach without any other solution.

Basically, the subsystem core never know either probe time or not.
It means that this issue should be handled in each device driver.


> 
> It's impossible to know what future programmers will want, but I feel
> like this change probably makes it easier for them.




-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
