Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B97F524399
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344758AbiELDpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbiELDo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:44:59 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB58C9B1B8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:44:57 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220512034451epoutp01476e7a4d99a97329d42ca78e1a514c54~uPrw_1jPE1701217012epoutp01V
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:44:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220512034451epoutp01476e7a4d99a97329d42ca78e1a514c54~uPrw_1jPE1701217012epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652327091;
        bh=GirDdQEslfbySicVoQGet6fAqxxqlgyh1Y0KbsS0OHc=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=dipO9DyK5Y2LnxICuGJXTPAXXgOMfQhlp31I0B7TWf2kEr9KZ864kscO/OlOU57pk
         0HOtdp+YUv+5PGxYP5THCBFwBMlU3M9ZbiJkJRPlCXuvdYvS3MTwENOuaZjTutD9hM
         wXlP8kC0XiEEA0Ql4doCsWEKGmCemrTp0BUfsxyM=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220512034450epcas5p3b74892a315c8163c6065b65e62ce1a08~uPrwRjVv12876328763epcas5p3E;
        Thu, 12 May 2022 03:44:50 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-09-627c82b29056
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.C2.10063.2B28C726; Thu, 12 May 2022 12:44:50 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH modules-next 1/1] kallsyms: enhance %pS/s/b printing
 when KALLSYSMS is disabled
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Kees Cook <keescook@chromium.org>
CC:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.or" <ojeda@kernel.or>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "avimalin@gmail.com" <avimalin@gmail.com>,
        "atomlin@redhat.com" <atomlin@redhat.com>,
        Onkarnath <onkarnath.1@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <202205111513.3AD646936@keescook>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220512034437epcms5p1b384e18e75f0f56ee70f67e62f7ab0ce@epcms5p1>
Date:   Thu, 12 May 2022 09:14:37 +0530
X-CMS-MailID: 20220512034437epcms5p1b384e18e75f0f56ee70f67e62f7ab0ce
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmlu6mppokgxU9WhZz1q9hs+htms5k
        cWT+GlaLBwevs1uc6c61uLxrDptFw+zvrBaPZ81js7gx4SmjxcwvQBUrej6wWvx//JXVYl/H
        AyaL3RsXsVkcv/OUyeLQybmMFo2f7zM6CHrMbrjI4rFz1l12j5Z9t4DEkbesHl+un2f02LSq
        k83jxIzfLB7zTgZ6XOjK9ni/7yqbR9+WVYwe67dcZfH4vEkugDeKyyYlNSezLLVI3y6BK2Nz
        x03Wgtk8Fb2bDjA2ME7l7GLk5JAQMJFYvOIVWxcjF4eQwG5GiUfLtzB3MXJw8AoISvzdIQxS
        IyyQKrFk91sWEFtIQFHiwow1jCAlwgIGEr+2aoCE2QT0JFbt2gNWIiKgKvH9UjMzyEhmga1s
        Etf3nmOF2MUrMaP9KQuELS2xfflWRhCbE6j56PH7UDWiEjdXv2WHsd8fm88IYYtItN47ywxh
        C0o8+LkbKi4jsXpzL9TMaomnr8+B/SIh0MIosW83TJG5xPolq8CG8gr4SjT3LgGLswBdOufC
        czaIGheJ8xcWgw1iFpCX2P52DjgcmAU0Jdbv0ocokZWYemodE0QJn0Tv7ydMMH/tmAdjq0q0
        3NzACvPj548foW7zkGj684gJEs7LGSW+HDjLPIFRYRYiqGch2TwLYfMCRuZVjJKpBcW56anF
        pgWGeanlesWJucWleel6yfm5mxjBaVHLcwfj3Qcf9A4xMnEwHmKU4GBWEuHd31eRJMSbklhZ
        lVqUH19UmpNafIhRmoNFSZz3dPqGRCGB9MSS1OzU1ILUIpgsEwenVAPTpLpWnXdtnU9lTOy7
        ZbbznGoQmbd8o8Xb8gsGt/4vM7P85b7BR9dmsc3yvb8u6LvWsgaKlv54JNqxoHMS6wzHwMNO
        nxfx3J6uIeD1MennvzntPxOMRR4Y3fbXOMx6iVMgTuOOduK+1AX3HU+WdJ5X+uMYUmr2dP2P
        onWeZe3s8h84VnUaV89//j/LZQ/D9i9365dc7lziYqT9wmJPzM/Ajx3f+otYnioc2XtDSON1
        5IEWC5crH7b/LWKcNOutmoxWb4Dkm93TCti2mfTZ+J3SnpBl+vF7srKR8LQ2AT7dOY3n279n
        H5/4ZUfvn4sT/lfwNk/QOMNhkJW7/kNaRZaOxXUxTWfPo4vYtac1eOQrsRRnJBpqMRcVJwIA
        NBwmvPoDAAA=
X-CMS-RootMailID: 20220421041604epcas5p414cf2e851d1bd828a151dc6b2b004680
References: <202205111513.3AD646936@keescook>
        <20220421041542.9195-1-maninder1.s@samsung.com>
        <CGME20220421041604epcas5p414cf2e851d1bd828a151dc6b2b004680@epcms5p1>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Wed, May 11, 2022 at 01:36:56PM +0530, Maninder Singh wrote:
> > kallsyms_show_value return false if KALLSYMS is disabled,
> > but its usage is done by module.c also.
> > Thus when KALLSYMS is disabled, system will not print module
> > load address:
> 
> Eek, I hadn't see the other changes this depends on. I think those
> changes need to be reworked first. Notably in the other patch, this is
> no good:
> 
>         /* address belongs to module */
>         if (add_offset)
>                 len = sprintf(buf, "0x%p+0x%lx", base, offset);
>         else
>                 len = sprintf(buf, "0x%lx", value);
> 
> This is printing raw kernel addresses with no hashing, as far as I can
> tell. That's not okay at all.
>

yes same was suggested by Petr also, because earlier we were printing base address also as raw address.

https://lkml.org/lkml/2022/2/28/847

but then modified approach to print base address as hash when we are going to show offset of module address,
but when we print complete address then we thought of keeping it same as it was:

original:
 [12.487424] ps 0xffff800000eb008c
with patch:
 [9.624152] ps 0xffff800001bd008c [crash]

But if its has to be hashed, will fix that also.

> Once that other patch gets fixed, this one then can be revisited.
> 

I will check detailed comments on that also

> And just on naming: "kallsyms_tiny" is a weird name: it's just "ksyms"
> -- there's no "all".  :)

Ok :)

Will name it as knosyms.c (if it seems ok).



Thanks,
Maninder Singh
