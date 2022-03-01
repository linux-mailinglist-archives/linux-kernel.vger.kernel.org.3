Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DA64C8C2C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiCANBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiCANBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:01:38 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62AA9AE69
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646139653; x=1677675653;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V4P91HQ+NMNBQJcCgDrZ9GmciyI6Yq/BmNIWieqqDiY=;
  b=cyOM+k5TB8SOmCnPck7bvE5CMBTAayCT6nctn4EuFq4Ewzs9KwQd8A8S
   jXjCCr6xyv4qzc0yHYzOSUbIKYj7aZcv2UorNodEujrjV8xM4YdLqmCDE
   zHHtgrPISg4jngQQKUPMnTU/gL6PsikikxQqQ/SR2XYBw7wWP0GwDnsdY
   0N0vBSr16qJuVnXSCnOdTkCXSPh0mp90RACF8lKwGFvC3S1gC+nLwuwyq
   Jr/AOTlQtecOF4wgo/wTMq3tmuI276kZ8J4QLDsyeJiy5z4nOPmysX1cs
   QG8Lr95flPvs+oAMN+dQnuq7/CpDkaa9KHDeXfyS+gXsRz2g2/iq7w+HH
   w==;
X-IronPort-AV: E=Sophos;i="5.90,146,1643644800"; 
   d="scan'208";a="195166646"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2022 21:00:52 +0800
IronPort-SDR: pJOs2AYpIXukGFEXglPhRpOLsWN8/g5FFqEAMJkRKpavjrwjUVX/jNbBA9IffDcYfdWCatUw19
 hiqg3sir7dKu89ymSlkdshv6hrTsXqAQyygKXW7LRk6CoEFdoMFrqEa0zBu++TbXYK/BLnbkBz
 58avzTkWq3GK/wMQUFYf2pLyOXvSjeWwWlonNG+DORWbr6saDVkuvMZvbsOjz18WCjd6gSUhK4
 7u2QUBb8jmSRLyX2qJuz7s98yPv7Aiq9F0giNa8uiYCw/6hjwZbYdgwvwA5Abg3lM97k2h+3Ii
 yy9kVQRfV2kI/a7xkWQh7VLi
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 04:32:15 -0800
IronPort-SDR: l2B9JwGcueu9BpWoV12oOtdAR4UaU6bsT4I7gduotC0mpofckUg8kNHkGfdY5H26pvdGqc54SQ
 u0lbQULVRIHOsLMEoUs+HHYMSK6YcvWFnQt6KK28KZ9syckteANnokuTMuZog0xAtCGyx+5wyQ
 uG6eFIxPdHNsx7LMT307BguyVuCdxMFz401WA3YSU4OmwU2CSyIgairE6qDfE66NlNzSTER7t8
 FZQpbLICYr+XDqKZ0p8d0t/OWBurLKmj3LsYfrqFYPWzSfB+eJdWykL2yWt4FQZqoYJHbeI2yj
 LRg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 05:00:52 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K7HRk6CCCz1SVnx
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:00:50 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646139650; x=1648731651; bh=V4P91HQ+NMNBQJcCgDrZ9GmciyI6Yq/BmNI
        WieqqDiY=; b=QcgaleYhIO2zpIm/4ewqqWcsK7F53iE8ZTKrWVWeBBsNWQjYlTJ
        39xRpQFuiqcj3mSvORI6Rk+c5PERje/bkC1xaxMNF2IjedLzXYLOiyxb5fVerSgN
        lZe+8srN/iUwDkWet/zcPQanib8a5bjIIBzQECEF3y5OLpQZ/tSB5j3Map52Hkhb
        Lv+M0wlUG+TcPcGMAWNERiydOZITuLP0yEFpwj6O4k+jvcUYsXnVr+eATRqlr4dt
        wIHxKiO0nf428Rrcszp2x8+OY72Bu6sHXVhTrI4EIWw1vBhMgX22NqrZvmvEYA65
        P0iYjUS28wmC88MozwByTibRKycrkGvMMPw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u-p3-Eym922z for <linux-kernel@vger.kernel.org>;
        Tue,  1 Mar 2022 05:00:50 -0800 (PST)
Received: from [10.112.1.94] (c02drav6md6t.wdc.com [10.112.1.94])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K7HRj0cSLz1Rvlx;
        Tue,  1 Mar 2022 05:00:48 -0800 (PST)
Message-ID: <10546882-389c-2f73-eb60-1f8fb9c761b6@opensource.wdc.com>
Date:   Tue, 1 Mar 2022 15:00:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v3 1/3] ata: ahci: Rename board_ahci_mobile
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
References: <20220225172319.846891-1-mario.limonciello@amd.com>
 <76957c33-cb62-5bf8-bb5d-adf9d6c6ce95@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <76957c33-cb62-5bf8-bb5d-adf9d6c6ce95@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/03/01 14:21, Paul Menzel wrote:
> Dear Damien,
>=20
>=20
> I have a patch on top of this series. It=E2=80=99d help me, if you coul=
d add=20
> them to the libata for-next branch. Thank you in advance.
>=20
>=20
> Kind regards,
>=20
> Paul

Yep. Sorry for being slow. Traveling this week so not easy to test.
Will try to put some time on this.

--=20
Damien Le Moal
Western Digital Research
