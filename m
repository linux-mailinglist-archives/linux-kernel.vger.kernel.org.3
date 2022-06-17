Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3C454FAF3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383227AbiFQQRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383009AbiFQQRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:17:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24D56390
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 09:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655482643;
        bh=aRtRVsI2JJYA+qUK4Y/ri9UxvhPtbnG1cbThjE1hFf8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=grOvUTOo9eCdhtRdlWBT2zjU6WTuHwjfLdHEbFfoW2dXL1fBEYOmighqWwqy4R01D
         7w1aXK+OIX14W2Piycrz7qqnlZV55eqVv7tplQl6QEvOecxF6oG02zywjLWFSEP4LH
         Sf2FzYkmhXXbb09ZYd1l65z6OGOnVJJHEKvsnEmM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.144.127] ([217.61.144.127]) by web-mail.gmx.net
 (3c-app-gmx-bap03.server.lan [172.19.172.73]) (via HTTP); Fri, 17 Jun 2022
 18:17:23 +0200
MIME-Version: 1.0
Message-ID: <trinity-2d26eb5e-6a3f-485a-aed7-134c1e164942-1655482643278@3c-app-gmx-bap03>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: helping with remapping vmem for dma
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 17 Jun 2022 18:17:23 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:NaGm1ixNJFwRHQsXaPteffNzoyyx5RfMlAz1K/3CtJDwCT6zA8aCnfM3W4+CwSdU9RiYG
 EsCfMorKngViGBiMQv4Sw14ryProWVIGehaJ9zy2y3hk3erY2zw2AefbDZYEALykUsQW1ASd9wOG
 CZaoZEqScmz61XByQplSWSQuj9kcKbPyE99fkjnzHWy5YjvGUHuAcion7npUjul+C6gtY7smdpem
 s2osVesgXUj7g3QisdaexDVqh3zqrr5wpo+rAr134QU+v7ak6JwXueZLIvPWCNKmlhXouF5mZMy6
 s8=
X-UI-Out-Filterresults: notjunk:1;V03:K0:VMH9nN8H+h0=:jCyV5ctGx7Y77X/k+z81KD
 kKk4q/V15hhuG5G6VduLSFNY4bTmkZ5NCgS5zp6bxjn4zbMwKkulWkC4cK8yCyS/Mj9WEqYxY
 jRn/2gNxkK5KlSYBoo6fArYbKOgtMixodB2MC8iPczfS9RvZyyln3wLR6vrX7/HuyKHF+x78Q
 VM5tqSty//PjwmQeGVPQcGfgKfkVXkfAytNSNvPmPB5wd0yCuSyZd+eYFuxIGyJe/VEAvvf8o
 n5FXaLsJyF71T4OxVxGry/wHqzzuwE33TVaH7LlxAo2734wzqQ85w/EZsJR41ylpEl6bTdHUP
 aF/G08jhXyr5KDHwtoMBa7ZsMZmfbIkaayAtpjK9Xq4QaAtDPaQNugJfBqTFKJqP32gWm48my
 iKfJZvNr0GGv0pxovM9knU68UjMDp0wB684PTPgMBjWWhbICuSBfRtffaAc8asSos3rvTTH80
 VqsdvRuT4uPluXdpGu6J9Q2vc4cckGLCYujr6J1dRQtBQXX98jerz9atvJBLgXmXkeRMvBepf
 QpWykKie0XpJfRUB6oHjM8JNIhYwFe4/iqHIZl5/g8s56lkiOK3cci/IDkEXGhkfvjPOur7J7
 ME2W/94IgwjItAkwZv0JpW4IiAgpCdVsWs+aCJik5QtBl4fhpSKE2OQ1+pSs2729ayZLhh5Mm
 VrjWy0nrlnGjUPHWgi/mo1IVliR5PNMVL77wzvZ6NJbeuHLT/HYG5myJtutBQxlDBd5+mxr0f
 DdLZzWGk4XD02k1dxrLJssGZmwmRHFDskzd/2R2duyTB+/4ppa8E2Il5IPxg/kxkrNqZbaNsj
 KwBTslm
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15. Juni 2022 15:17:00 MESZ schrieb Christoph Hellwig <hch@lst.de>:
>On Wed, Jun 15, 2022 at 02:15:33PM +0100, Robin Murphy wrote:
>> Put simply, if you want to call dma_map_single() on a buffer, then that
>> buffer needs to be allocated with kmalloc() (or technically alloc_pages=
(),
>> but then dma_map_page() would make more sense when dealing with entire
>> pages.
>
>Yes.  It sounds like the memory here comes from the dma coherent
>allocator, in which case the code need to use the address returned
>by that and not create another mapping.

Hi

traced it to buffer allocated as simple uint8-array [1]:

UINT_8 aucBuffer[sizeof(INIT_HIF_RX_HEADER_T) + sizeof(INIT_EVENT_CMD_RESU=
LT)];

and then called as

nicRxWaitResponse(prAdapter,0,aucBuffer,sizeof(INIT_HIF_RX_HEADER_T) + siz=
eof(INIT_EVENT_CMD_RESULT),/* 4B + 4B */
					&u4RxPktLength)

this calls [2]:

WLAN_STATUS
nicRxWaitResponse(IN P_ADAPTER_T prAdapter,
		  IN UINT_8 ucPortIdx, OUT PUINT_8 pucRspBuffer, IN UINT_32 u4MaxRespBuf=
ferLen, OUT PUINT_32 pu4Length)
{
...
HAL_PORT_RD(prAdapter,ucPortIdx =3D=3D 0 ? MCR_WRDR0 : MCR_WRDR1, u4PktLen=
, pucRspBuffer, u4MaxRespBufferLen);
}


nicRxWaitResponse contains a do-while(true)-loop, but it looks like this i=
s failing on first call (i see my debug before call of HAL_PORT_RD only on=
ce)...

do i need kmalloc before call of nicRxWaitResponse and if yes which flags =
are right here?
https://www.kernel.org/doc/htmldocs/kernel-api/API-kmalloc.html

callstack is like this:

[  126.919569]  __dma_page_dev_to_cpu from kalDevPortRead+0x3a0/0x6b4 [wla=
n_gen2]
[  126.928643]  kalDevPortRead [wlan_gen2] from nicRxWaitResponse+0x4c0/0x=
61c [wlan_gen2]
[  126.939752]  nicRxWaitResponse [wlan_gen2] from wlanImageSectionDownloa=
dStatus.part.0+0xd0/0x26c [wlan_gen2]
[  126.952783]  wlanImageSectionDownloadStatus.part.0 [wlan_gen2] from wla=
nImageSectionDownload+0x168/0x36c [wlan_gen2]
[  126.966511]  wlanImageSectionDownload [wlan_gen2] from wlanAdapterStart=
+0x674/0xf94 [wlan_gen2]
[  126.978367]  wlanAdapterStart [wlan_gen2] from wlanProbe+0x318/0xbe8 [w=
lan_gen2]
[  126.988951]  wlanProbe [wlan_gen2] from HifAhbProbe+0x54/0x88 [wlan_gen=
2]
[  126.998905]  HifAhbProbe [wlan_gen2] from wmt_func_wifi_on+0x4c/0x150

regards Frank

[1] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/med=
iatek/connectivity/wlan/gen2/common/wlan_lib.c#L3046
[2] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/med=
iatek/connectivity/wlan/gen2/nic/nic_rx.c#L3604
