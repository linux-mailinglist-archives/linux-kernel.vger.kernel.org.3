Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA814E5F08
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348368AbiCXHBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244643AbiCXHA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:00:59 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DF153A6C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:59:25 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220324065921epoutp02ed26e69bd9e19f46bd5bcd9952d416af~fPulyEFtU1428414284epoutp02Z
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:59:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220324065921epoutp02ed26e69bd9e19f46bd5bcd9952d416af~fPulyEFtU1428414284epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648105161;
        bh=95OQZnrTneCPsp9i8C5Lny3QhxwLFEspWNR3e8e8ZVU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=HagKM6WrTTuwwPyZVkXRcNFWLF5hTixc7QfWwMTkQYAo0oduCMrUCmQT2dagESDFc
         Zzp1OYsipq1jdqk2IrfHqrHWhHMupWdLJCBGqW0CRbPMunyVZNn6EClimhrEHHiQTX
         nULRcNJwJp8fHsgtLjbCgCGGlzss0KHWPV+Xt0Ug=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220324065920epcas1p39792ec7e377ccdb4b370be9bbfeabf6e~fPulS71bP0539605396epcas1p3i;
        Thu, 24 Mar 2022 06:59:20 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.249]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KPGKz4LG9z4x9Q5; Thu, 24 Mar
        2022 06:59:19 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.2B.28648.7C61C326; Thu, 24 Mar 2022 15:59:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220324065919epcas1p4c79da5f6ec4fa0311409ca24a38785d8~fPukM222e2260522605epcas1p4m;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220324065919epsmtrp119bc2f245fb329c59bc753673a59aeb7~fPukMDP2S2225322253epsmtrp1N;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
X-AuditID: b6c32a39-ff1ff70000006fe8-89-623c16c79c3f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.AD.03370.7C61C326; Thu, 24 Mar 2022 15:59:19 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.100.104]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220324065919epsmtip2346e3a1312333e5561c4704fa10f56b6~fPukDaeDs3187231872epsmtip2a;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ytk.lee@samsung.com, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH 0/8] memblock: introduce memsize showing reserved memory
Date:   Thu, 24 Mar 2022 16:01:50 +0900
Message-Id: <20220324070158.22969-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7bCmvu5xMZskg02tShZz1q9hs+jePJPR
        ovf9KyaLy7vmsFncW/Of1eLI+u1MFrMb+xgtHq/nduDw2DnrLrvHplWdbB6bPk1i9zgx4zeL
        R9+WVYweZxYcYff4vEkugD0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEv
        MTfVVsnFJ0DXLTMH6CglhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFZgV5xYm5x
        aV66Xl5qiZWhgYGRKVBhQnbGjc+LWQv2CVTMPrCdrYGxnaeLkZNDQsBE4tH962xdjFwcQgI7
        GCVebTjCCOF8YpTY8nYRO4TzmVFixsSp7DAtcy+ehGrZxSjx/skNVgjnB6PEz69bWEGq2AS0
        Jd4vmARmiwjYSXybfQCsiFmgi1HiwYeDLF2MHBzCAh4Sj/u1QGpYBFQlTr47xgRi8wrYSixc
        u40JYpu8xOoNB5hBeiUEjrFLfPuzkx2kV0LARWLtfQ2IGmGJV8e3QF0nJfGyvw3KzpZ4evII
        M0R5jkTDBlkI017i/SULEJNZQFNi/S59iGJFiZ2/5zKC2MwCfBLvvvawQlTzSnS0CUGUqEm0
        PPvKCmHLSPz99wzK9pD4d3g5M4gtJBAr0dC9nn0Co+wshAULGBlXMYqlFhTnpqcWGxaYwqMo
        OT93EyM4lWlZ7mCc/vaD3iFGJg7GQ4wSHMxKIrz3L1snCfGmJFZWpRblxxeV5qQWH2I0BQbW
        RGYp0eR8YDLNK4k3NLE0MDEzMrEwtjQ2UxLnXTXtdKKQQHpiSWp2ampBahFMHxMHp1QD0wpT
        7gqD9Y5z+VTnBAu2J4oevTVDQe+97/J5hy1Y7PdOY9MO+rZ4gn1J2NWHmz06lAIfnZmvXaPL
        pC/MzR7+2YD/pWI9E8tKTcXnCg/uye321Kp4dPznHqf8x89mPrmkwWd18LbsxirXR+c0xFta
        poenRwgdXXulaR77X5XKmgC14PJfFf0/BXlZziakpDlINF3mWMh2NTT63sOH4vnP1vKWRJ8+
        FNHX+WnTr/2lD70upL2OmPz19+XFFVfLDe6bri+5JcpidPH1K9t4j42TOlouv5lv8NMsxmLy
        jk/p/1xMXnhtOe91Qzhv75f3oU+nNs7jnCyTGMNmemy3WeN0oXaJ/kV6+q98tu28dze4WYml
        OCPRUIu5qDgRAJriUxHuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42LZdlhJXve4mE2SwYcnfBZz1q9hs+jePJPR
        ovf9KyaLy7vmsFncW/Of1eLI+u1MFrMb+xgtHq/nduDw2DnrLrvHplWdbB6bPk1i9zgx4zeL
        R9+WVYweZxYcYff4vEkugD2KyyYlNSezLLVI3y6BK+PG58WsBfsEKmYf2M7WwNjO08XIySEh
        YCIx9+JJti5GLg4hgR2MEm3vbjJDJGQk3px/ytLFyAFkC0scPlwMUfONUaJ53yp2kBo2AW2J
        9wsmsYLYIgJOEhuurGYBKWIWmMAosXLZJ7BmYQEPicf9WiA1LAKqEiffHWMCsXkFbCUWrt3G
        BLFLXmL1hgPMExh5FjAyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA4wLa0djHtW
        fdA7xMjEwXiIUYKDWUmE9/5l6yQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRm
        p6YWpBbBZJk4OKUamM5uZz7//92xgLYN5xTtim4oPhQVfsv5yJ6rZZrp+yRfoY/pN84tSLR9
        tkWGLb+v7tpLBc4Z1rUHljLI3r204IftzyDukpe7BR/Y7M7OCIqqnLqE65+b+qHtMtYzT7Zf
        VmyWmrWq6gDPscNeG1juiLG7HtyrWHFeKTiU7bh2pvpZvdjXnmve/50uVeQZsnLLXJ6NoTMD
        2E8lci/7fMc929xwx8P0K2fnuLz0PB240E+nOsDoz+pSiedORortp4ui77ztTM3NC7EtqHVY
        18zCm33RdedJ9oNsulVseY3zGa737f0b9jtA3uwIh8Wams91Ssys1kyOnI8XL645FDJHK/3a
        8Ys/DfSCPOUK5TU3KLEUZyQaajEXFScCABX7qnmfAgAA
X-CMS-MailID: 20220324065919epcas1p4c79da5f6ec4fa0311409ca24a38785d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324065919epcas1p4c79da5f6ec4fa0311409ca24a38785d8
References: <CGME20220324065919epcas1p4c79da5f6ec4fa0311409ca24a38785d8@epcas1p4.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of memory regions can be reserved for a specific purpose. They are
usually defined through reserved-memory in device tree. If only size
without address is specified in device tree, the address of the region
will be determined at boot time.

We may find the address of the memory regions through booting log, but
it does not show all. And it could be hard to catch the very beginning
log. The memblock_dump_all shows all memblock status but it does not
show region name and its information is difficult to summarize.

This patch introduce a debugfs node, memblock/memsize, to see reserved
memory easily.

Here's an example

$ cat debugfs/memblock/memsize
0x0f9000000-0x0fb000000 0x02000000 (   32768 KB )   map reusable linux,cma
0x0b1900000-0x0b1b00000 0x00200000 (    2048 KB ) nomap unusable test1
0x0b0200000-0x0b0400000 0x00200000 (    2048 KB )   map unusable test2
 (snipped)

Reserved    :  746924 KB
 .kernel    :  137027 KB
  .text     :   28158 KB
  .rwdata   :    3238 KB
  .rodata   :   13468 KB
  .bss      :   12570 KB
  .etc      :   79593 KB
 .unusable  :  609897 KB
System      : 3447380 KB
 .common    : 3152468 KB
 .reusable  :  294912 KB
Total       : 4194304 KB (  4096.00 MB )

Jaewon Kim (8):
  memblock: introduce memsize showing reserved memory
  memblock: detect hidden memory hole size
  memblock: handle overlapped reserved memory region
  memblock: track memblock changed at early param
  memblock: track kernel size on memsize
  memblock: recognize late free by checking PageReserved
  memblock: print memsize summary information
  memblock: print kernel internal size

 drivers/of/fdt.c             |  10 +
 drivers/of/of_reserved_mem.c |   7 +-
 include/linux/memblock.h     |  21 ++
 include/linux/mm.h           |   3 +
 init/main.c                  |  13 +-
 kernel/dma/contiguous.c      |   9 +-
 mm/Kconfig                   |   7 +
 mm/memblock.c                | 434 ++++++++++++++++++++++++++++++++++-
 mm/page_alloc.c              |  15 +-
 9 files changed, 506 insertions(+), 13 deletions(-)

-- 
2.17.1

