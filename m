Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5116F4FBCBA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346318AbiDKNFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbiDKNFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:05:48 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971AA1A059
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649682214; x=1681218214;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GonxJXSP5Jp3Xd7YM5AlvcGjeaM6Z6X6GgWrsHdG9Yw=;
  b=Uf0/26P8YF6C9pHs3h7I5LQ+p6p2Ofvt3cUIiiJhUSTDIAf+/V2axB3d
   6EnGqiCQcGHBFJvEM/ZxkBIcV6jMgjEbMwZd5UhuMa8BHxsCpuvOVb6cI
   dteP+28ITKO6wWDR3b5wmCNUuuLtjuWxaaWbi0B2Tqmer2OL7R8AIEdN9
   IgB+eDPJmrFuizzhtBYoJw4nAEalF+fYBLDa+MdG4ukZqVBQOS2npRjO/
   c8sNSW5kfJpRm910J2G+SCMn+njPiqkczM9GlpWJrt0xAXPfdKYLnjHyh
   4WOm5g0rNIL7lVzkDvq6yk25ZJZMgMCc3wBcT/290K0pFw7B9mGVdgBeY
   g==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643644800"; 
   d="scan'208";a="198525882"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2022 21:03:32 +0800
IronPort-SDR: vJFA7e0EaazsH7nmH3oQJKn3c+edI0wymuFQQnacC6Bd2hdDtDZDimbcXSUD9E1KeerygvWfum
 lApsPdoJtkJRR+OUdqGsB960+jWBmRLkpkbYE8NditKEUZ+M6i6WJoBqqp6fGBh+5w4kDhaE3J
 EMTaVKaUmLoswiycz1ysrpjckwtOJ3Kuxt8CIKAthV98trqyct7amczlAFv6Oxo+7nTPhQxQti
 aXEFbJB7eI2XcpMiQhMxZTMsflQp6kduFnBdfkGfRrQob/YlXqdFl2kh0dB3nCZBMh0mE22jYe
 wTqw2TdQSh8WLhK5HZUgrsE8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 05:34:48 -0700
IronPort-SDR: CPatczW72buAMTZdl5mZ+lugdcde06AFu9zAA+6zz1eAbYYfWSIGGBn90EtRh36k+rElZl2vKo
 oE15FgFDDnrUhsXy4fxO50aC/dfuUN4vuMXgnpSyOqSTiZVBy2QPr8zGKacsT+5L/rD9jN9DOE
 1xtK7Q98WnXCqNLNNyMtEZouhaAiWSDp6eiOr98tDsPLOBsc7usLt6YsttnusRXOPhKyvLUqJG
 PHmMZ2jPMrZ9xS/VsObfoHc7uxaccX245Bj/s77ebTiA1Lq8ZR+HYWl4BGij1ZTe2zmHHk0R0Z
 XWk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 06:03:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KcTYv0cH7z1SVp6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:03:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649682210; x=1652274211; bh=GonxJXSP5Jp3Xd7YM5AlvcGjeaM6Z6X6GgW
        rsHdG9Yw=; b=uOG3e7awlyrhX10tYSqVxTqB52BuS6mHzh9d9Fw8N3z1pJ2MJOb
        6en0NLwtDpvYkwtSOt4ypp6WMh0NyJB2Ux5EnMb9LVDLvDlQT5ttcscr7lEOFe4/
        9osknsfdRqwhNKGkUkEz35M7K3VTddIE+7BRxt2NXPzSYE64IAb9+assY+K5XDEr
        P3k2wj0Zj/aEm4B31udF1UxxZjlzLfRKMTYjsdJcpuDW9Vla2ke7QfMyqcw9tA51
        sSZAtM5W3yB7MK+LTAVm2RHUmZAzOUOg6p9V/4JiP2+F5B3FYPTFLdLISryRlQih
        4/ief4Fg4713T2aNFj9KoPMLB38BkSa1lFA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aVPir5OhQueK for <linux-kernel@vger.kernel.org>;
        Mon, 11 Apr 2022 06:03:30 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KcTYr3pcLz1Rvlx;
        Mon, 11 Apr 2022 06:03:28 -0700 (PDT)
Message-ID: <382133db-7a90-6092-d3cc-3c4f5d851838@opensource.wdc.com>
Date:   Mon, 11 Apr 2022 22:03:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 17/21] ata: ahci: Add DWC AHCI SATA controller support
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-18-Sergey.Semin@baikalelectronics.ru>
 <2f873143-eb45-e652-063d-615d63055401@opensource.wdc.com>
 <20220411124126.wnfykivcvtllyua6@mobilestation>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220411124126.wnfykivcvtllyua6@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 21:41, Serge Semin wrote:
> I beg your pardon what convention? Is it defined in someplace of the
> subsystem docs? If it's not then how should I know about that? These
> are the device-specific macro. The static methods below are also
> platform-specific and the standard kernel coding style doesn't specify
> any rule about that. Moreover the most of the AHCI glue drivers (LLDD
> like ahci_mtk.c, ahci_ceva.c, ahci_brcm.c, ahci_st.c, ahci_tegra.c,
> ahci_xgene.c, etc) use the same prefixing style as I do here. Finally
> the prefix reflects the actual device name "DWC AHCI". So if there is
> no subsystem-specific restrictions I normally define the prefix in
> that order for the sake of the clarity.

Look at how other ahci drivers have named things. That's the "convention"
I am talking about. Most of them name things ahci_xxx_... Same for macros.

> 
> Note I don't mind to convert the code to being the way you ask, but if
> it's really the AHCI-specific codying style convention then it would be
> very useful to have it described/advertised in some place in the
> kernel so to know about that beforehead for the developers reference.
> So do you insist on switching the words order in the names prefix here?

It is nice to have code consistency in the naming. That always facilitate
grepping the code.


-- 
Damien Le Moal
Western Digital Research
