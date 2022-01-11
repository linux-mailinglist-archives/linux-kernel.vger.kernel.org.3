Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FCE48ACE0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbiAKLoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:44:54 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16701 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238804AbiAKLox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:44:53 -0500
Received: from kwepemi500001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JY80W5sD9zVfjR;
        Tue, 11 Jan 2022 19:41:15 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi500001.china.huawei.com (7.221.188.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 19:44:50 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 19:44:50 +0800
Subject: Re: [PATCH v6 12/15] ubi: fastmap: Add all fastmap pebs into
 'ai->fastmap' when fm->used_blocks>=2
To:     Richard Weinberger <richard@nod.at>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        mcoquelin stm32 <mcoquelin.stm32@gmail.com>,
        "kirill shutemov" <kirill.shutemov@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com>
 <20211227032246.2886878-13-chengzhihao1@huawei.com>
 <361758697.248157.1641857025490.JavaMail.zimbra@nod.at>
 <6f7df7ba-9557-58a3-7978-e5d14a72f234@huawei.com>
 <244238061.248369.1641886066066.JavaMail.zimbra@nod.at>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <420c7567-8926-2e8b-4da0-a9bfc8379642@huawei.com>
Date:   Tue, 11 Jan 2022 19:44:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <244238061.248369.1641886066066.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,
> In ubi_wl_init() there is another corner case documented:
>                          /*
>                           * The fastmap update code might not find a free PEB for
>                           * writing the fastmap anchor to and then reuses the
>                           * current fastmap anchor PEB. When this PEB gets erased
>                           * and a power cut happens before it is written again we
>                           * must make sure that the fastmap attach code doesn't
>                           * find any outdated fastmap anchors, hence we erase the
>                           * outdated fastmap anchor PEBs synchronously here.
>                           */
>                          if (aeb->vol_id == UBI_FM_SB_VOLUME_ID)
>                                  sync = true;
> 
> So ubi_wl_init() makes sure that all old fastmap anchors get erased before UBI
> starts to operate. With your change this is no longer satisfied
I seem to understand the another case. But I'm still confused that why 
outdated fastmap PEBs cannot be erased. When UBI comes to this point, it 
means UBI is attached by **full scanning mode**, scan_fast() returns two 
values:
   UBI_NO_FASTMAP: scan all pebs from pnum UBI_FM_MAX_START, ai is 
assigned with scan_ai, at last, all fastmap pebs are added into 
'ai->fastmap'
   UBI_BAD_FASTMAP: scan all pebs from pnum 0, all fastmap pebs are 
added into 'ai->fastmap'
