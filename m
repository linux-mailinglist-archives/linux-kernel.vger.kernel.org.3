Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C477589787
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbiHDFtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238969AbiHDFt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:49:28 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2669161137
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 22:49:15 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220804054907epoutp0313f2fd234376f350bf6f2a492a4f8498~IDkPwC6Ka2599625996epoutp03m
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 05:49:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220804054907epoutp0313f2fd234376f350bf6f2a492a4f8498~IDkPwC6Ka2599625996epoutp03m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659592147;
        bh=eEByWWlr1hq3Oo9gT1G5MAyMMOkHgVV4ti9vWCBEiA4=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=vL1kii8eIhTC5lqkWqbrCYDGv1FwaEuYUGuj2dx0L+4lONaVnx6Glc2L4eFBK6kbs
         yUs3ikhWQRhFm4pyAsk7iv26fZkyuyidIxyfADkYyXLYcnv45dEw2WUcj8UQJt81Oi
         EZ9E8YXhafzl+FG7ep0eXVWKAsFVYQt9sP6Oabgs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220804054907epcas2p2848db7c14ee034955cb98b3a05929ef4~IDkPVsuuJ0802008020epcas2p2n;
        Thu,  4 Aug 2022 05:49:07 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.70]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LyyTZ5f9Mz4x9Q5; Thu,  4 Aug
        2022 05:49:06 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-8f-62eb5dd2a3cc
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.BB.09642.2DD5BE26; Thu,  4 Aug 2022 14:49:06 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v6 3/6] scsi: ufs: wb: Add explicit flush sysfs
 attribute
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <28b41877-2697-6bbb-066d-ee0f6e330565@acm.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220804054906epcms2p1f3b7f3dc8be225a96933121e77c6648f@epcms2p1>
Date:   Thu, 04 Aug 2022 14:49:06 +0900
X-CMS-MailID: 20220804054906epcms2p1f3b7f3dc8be225a96933121e77c6648f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmqe6l2NdJBhev61qcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2laLLqxjcni8q45bBbd13ewWSw//o/JYunWm4wO3B6Xr3h7
        LN7zksljwqIDjB4tJ/ezeHxf38Hm8fHpLRaPvi2rGD0+b5LzaD/QzRTAGZVtk5GamJJapJCa
        l5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0rJJCWWJOKVAoILG4WEnf
        zqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO2Pzhhb2gpkcFUe7
        pjM2MF5h62Lk4JAQMJG4uEusi5GLQ0hgB6PEpeXnmEHivAKCEn93CHcxcnIICwRJbFyzmxnE
        FhJQkji3ZhYjSImwgIHErV5zkDCbgJ7EzyUz2EBsEYFGFon/G9JAbAkBXokZ7U9ZIGxpie3L
        tzKC2JwC1hJXd71gg4hrSPxY1ssMYYtK3Fz9lh3Gfn9sPiOELSLReu8sVI2gxIOfu6HikhKH
        Dn2F+iRfYsOBQIhwjcTb5QegSvQlrnVsBDuBV8BXYumy9awgNouAqsSep99YIWpcJC70/gY7
        h1lAXmL72zngQGAW0JRYv0sfYrqyxJFbLDBPNWz8zY7OZhbgk+g4/BcuvmPeEyaIVjWJRU1G
        EGEZia+H57NPYFSahQjkWUjWzkJYu4CReRWjWGpBcW56arFRgTE8WpPzczcxglOslvsOxhlv
        P+gdYmTiYDzEKMHBrCTCu8LydZIQb0piZVVqUX58UWlOavEhRlOghycyS4km5wOTfF5JvKGJ
        pYGJmZmhuZGpgbmSOK9XyoZEIYH0xJLU7NTUgtQimD4mDk6pBiYXr+c/hAwP+z3YFsGxTv39
        Yy6vr99exv0z0p12bNufhCnzq0W0dzo0zN6yyF1LVevgBunymoPGR37dqZyhwB49Nbtm7h/J
        opA3ykuYJ/5a+DOJ9Xvx0sx/PnX2WhbTD5zSU7lmsFzhmZqE35177lFSXaeVXnSmX6xVaG3t
        3V1y7GGQ3nTf7f80E0PcjRI9PGzlJALibML3tP90zIowODFD/mCRTc4z1X3sd0Lvnd0d995h
        T+TtSWV8on9XtfmHqwmXzfyvIlN3j6u04/6Ph2fWn7oo6zr9WKJjotMTtZQlvOtE9xULXjDt
        rbVyvpjE8OtAp+l8Y5ELbU09bMLPLuodfKaxcVZ1x/IpfjrnWpVYijMSDbWYi4oTAfOz8no6
        BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce
References: <28b41877-2697-6bbb-066d-ee0f6e330565@acm.org>
        <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
        <20220802080740epcms2p3893fd9cfb765d4addbbfe58c68cf5af3@epcms2p3>
        <CGME20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p1>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 8/2/22 01:07, Jinyoung CHOI wrote:
>> +What:		/sys/bus/platform/drivers/ufshcd/*/wb_buf_flush_en
>> +What:		/sys/bus/platform/devices/*.ufs/wb_buf_flush_en
>> +Date:		July 2022
>> +Contact:	Jinyoung Choi <j-young.choi@samsung.com>
>> +Description:	This entry shows the status of WriteBooster buffer flushing
>
>Can we rename this attribute into something that has a word order that 
>is grammatically correct, e.g. enable_wb_buf_flush?
>

OK, I will replace it.
Instead, When the list is printed through "ls",
it may be difficult to check because the prefix is different.

>> +		and it can be used to allow or disallow the flushing.
>> +		If the flushing is allowed, the device executes the flush
>> +		operation when the command queue is empty.
>
>The attribute has "enabled" in its name while the above text uses the 
>verb "allowed". Consider changing "allowed" into "enabled". Please also 
>change "If the flushing" into "If flushing".
>
>Thanks,
>
>Bart

OK, I will apply next patch.

Warm Regards,
Jinyoung.
