Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB404A3BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 00:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbiA3X4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 18:56:48 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14550 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiA3X4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 18:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643587005; x=1675123005;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IbL3PjiyRfSGjP+MCmktAmlDzb3Y8TTYlrkcO9OhZQI=;
  b=ApaQXbqmRXOLmjNXniGUoG7BRoFkDE8FXZFvXWHl8hmYgHxD5lXlfLlZ
   FS8L5QSs2NomtgYJ0z2e+KblWAKPe8YfWjYBhufFyHe/96owLGKCMPJMZ
   EpRrpQ5YrXlZ/JaImvKpnJj/AQKeUjMis6hNYZI1zEGnN1lo4FRsZXi95
   /ZioXZJFtAhO5azNyKmL9WqvxcrZCuHD44E6bR72FaavaVlCy4UrjlDvv
   PlD2fgKJNSYF9pns1YwM50Y6w+6Ea9cZTnkBS7KiXihrKWu+LT44WiZWY
   NWrspcHjz/NR+QPD2QwbET5voZpTYlPHcH55yL/5m6C+mtIl7chK3lIP6
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,329,1635177600"; 
   d="scan'208";a="190709155"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2022 07:56:44 +0800
IronPort-SDR: oUv9yn1sRG+lLbza10/tYFlGOSwzR7kfIAQAyGtBqk1SEVZxTVORapYNaCD5KUo68ELUMxB4mr
 eVUrrUtf5TmJaOZzEoufSc2ZdJ+2+N6xpVIwAjOWmz4br5YHTw3w0vaW0xjZVFWO5UFX9xCWYI
 Sbb40E4eE177i0XeX7L9T7reYWPa0ukv8twagZsiLhL8OaofY2MziypG+z++1goffX43O4z3C6
 hOXmogNPSqaQUeOD5yfNIam4X3l4JJQgS2LzdhE7JB1GMiOx1ISSDj7yraAsLbEwKG2gCLOX2/
 vyFDIaosyG2tH75Irqev3iBE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 15:28:44 -0800
IronPort-SDR: 2dC2eeRUnaGj6Q9dBEBHDxYS8T0oQtar7vtEltNZL3IDfcMwZGf8mS1lXL/SaRbzFBcs9ceVE0
 bA+BDwkht9xS+3T3BBZw4Psoi8UqhjqorHv7T2oxvc3baTErNr0Pyk4rAKwkuljjH9RAxCcGRD
 nFXRzl+v84hNwV2iYz1JYAEBnWPlzy0/IQ24xVaDVt2a10ZI/C18NY1gRNppA6T6+AtEMj+mM0
 fgOoJAR4RhBRR8jIiGnem69M6NW+Mk8O7g/Nv9pfkUmiFABDrYuwT48hSt02eausU5KZRI2gsL
 JFQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 15:56:45 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jn7QN28c5z1SVp0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 15:56:44 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643587003; x=1646179004; bh=IbL3PjiyRfSGjP+MCmktAmlDzb3Y8TTYlrk
        cO9OhZQI=; b=JULyRYtYipNE/m5z1jJGU5ATjuHiE9rnEEW+XL6e1V4x1tPaiAZ
        xRy10TPAkFvy+a5jqT2e9Rjgu/jlFz2NKJmAqe1KnJUMSvZuY43aIpC0lAr9NnLY
        ukfDr5ZrwYCNg9tFj2pcv7rIKHDxIAeuNC1MJbe3nkoG79fXD1Y7OoE1PmcanLVD
        uFU6Zkli4VNI+fGxfDsqrX1QqQQwHnOqkehSd7Yci50vp98nZ9Jq01uQQMkRbIV3
        W9dlrsyGAtK9ZNKqhvP922EcpkLinSYzAQUIMj3TaYdVLMKV2KoiNTmEqgbk5AoK
        7LY4dzjh1+zPFAB8pEJSRAo3TXzjvKRWfeQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VYwbfuphfnGE for <linux-kernel@vger.kernel.org>;
        Sun, 30 Jan 2022 15:56:43 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jn7QL4KyMz1RvlN;
        Sun, 30 Jan 2022 15:56:42 -0800 (PST)
Message-ID: <2b0fa854-16e7-3d0b-a04a-971249646fab@opensource.wdc.com>
Date:   Mon, 31 Jan 2022 08:56:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH] dt-bindings: ata: convert ata/cortina,gemini-sata-bridge
 to yaml
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220129204004.1009571-1-clabbe@baylibre.com>
 <CACRpkdb9R-BwdVzyeaQOjagsQU=2-06VNqKPG9fMa7C93eDC7A@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <CACRpkdb9R-BwdVzyeaQOjagsQU=2-06VNqKPG9fMa7C93eDC7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/30 9:26, Linus Walleij wrote:
> Thanks for doing this Corentin!
> 
> On Sat, Jan 29, 2022 at 9:40 PM Corentin Labbe <clabbe@baylibre.com> wrote:
> 
>> This patch converts ata/cortina,gemini-sata-bridge binding to yaml
>>
>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Knowing that drivers/ata is a bit sparsely maintained I suggest that Rob apply
> this patch when he feels it looks good.

What do you mean ? I am doing my best here to maintain ata !
But I definitely do not have all the hardware supported for testing :)

That said, I am perfectly fine with Rob taking device tree patches if that is
not a problem for him.

> 
> Yours,
> Linus Walleij


-- 
Damien Le Moal
Western Digital Research
