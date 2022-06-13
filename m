Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80389548095
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbiFMH2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbiFMH23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:28:29 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128C81B796
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655105307; x=1686641307;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ioVbeCZUDKKWK4KyDAA+d0UWPzUSkKFLUq/QnEjSJTk=;
  b=RImUlLsNqviQRPAeBqTx9Dt8YgWGmBG9usx1fktRkD0YuuUmkODhaQ9e
   mNs6HIViNEnaRX1Xldbmw/dysMDZNuJB7wz3m8wgtoEX8AchlH088Wn3+
   K5OdKdlj81PUN6wPIt7XmCUZ5TPOCvzz22+mIcjbe49HLIYmy7LeeY6fH
   +Ohbk0jw1qXxluUpZ2CxRq05nbcoETnN6M4OnNak1RCovExqjSG27AqAm
   LaIgmLipRqKLbxZ51vEma3e8KdnI2cy7fLJBOxR2egIKUGABSAApGo9U2
   /46sRKaHBbJMpZH6n7vBVn1s/qZn5rws2Kxgb5f7sMJniDik8GWJtYb82
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647273600"; 
   d="scan'208";a="207827390"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2022 15:28:26 +0800
IronPort-SDR: il2CxPHQH8sipLpRb5XPeRbUufCAoHr36s8MS4FyUB3MUDf6NoQjcy0YUDNh3XFV6LX0zhQVL9
 oWeI6qxUatN/+gflWHG4qjWRSkSsoHjKUZ5yqngKNqaUR5bEhJs+1bNi5WLPe/R+dj5yfzwdVB
 NPVpM8Jvdw0lXxDl5p3ORN5i4S8BSsHpO9iv/ZFWDuVYpjA82eqdDhakVqDa3C9ZC397A+NSVh
 Vc/xCy/uLZZH7zgS8nmJ7KR7M/3c3p5Bn78BbM4KUVFdSjevFoiMxRmb1BAQiTkvq4TS50ldRk
 IGF4QhIvHpn6AY2+rIEUArJz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2022 23:51:31 -0700
IronPort-SDR: deZfY/IP09941omncvavWD/JItkA5IgD4EST8rDJpcxQG9zfP61xX+lihOX2XC3mjh+XmT4dPy
 qHTJDt3WM9r23875YXQhEAxQA0SlHUJo8t2rHBM0VRA5kcxzslsstgl4Tisu2UOSNFIavNqxz6
 GlwYtfuHf6d3qEtVVqA6NWal8IBNdkrxoIXbOXDLX8H+tZMPpERiy9Gryw8CKfUYlFU3O5BvT2
 MdUenuvofIOOsSHKMJakV2dc0KjD+qsQZJ1HEgVmmKwKoEZIQ3EiMOB035UbSKtdqQ1jWd3Zzn
 IUc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2022 00:28:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LM38C40cTz1SVp2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:28:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655105307; x=1657697308; bh=ioVbeCZUDKKWK4KyDAA+d0UWPzUSkKFLUq/
        QnEjSJTk=; b=ZLIYkurlcWMcd3KRU8iJpMcCMEwUiAuiT7HdDS0pSkufNRpAsuu
        DP9quFszcuFbJ734A5HH37ieeQqs0DsDRhFa44O6jdNOZPFRo0goGWOmQ8mz2HhY
        karvD8eXhDBOfvaloELwy4CaEFmTKt9CXW/EnfqBN1SNjam9jr85xzIzgq9E/MWE
        PmiPeO9lv2gyQqzAWZNh9E/RDrNDJ9z4QUHZm86/j4RTHhkzdcmTRwvg+ydz7vvZ
        KkL+YhauXYZkLq6x2F9XQ3uV05d0aBL404BKw0LXCiW09ECGL2CYJoJWNE+UOQdi
        meUCdkhRDlK4KHcOaT6/dIBdA+c3D4UBrTg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cufNTEzT0Tjk for <linux-kernel@vger.kernel.org>;
        Mon, 13 Jun 2022 00:28:27 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LM3895YRtz1Rvlc;
        Mon, 13 Jun 2022 00:28:25 -0700 (PDT)
Message-ID: <671ce4c0-77b0-5d39-5f65-dce6e47ac48e@opensource.wdc.com>
Date:   Mon, 13 Jun 2022 16:28:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/4] pm8001 driver improvements
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jinpu.wang@cloud.ionos.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.de, Ajish.Koshy@microchip.com
References: <1654879602-33497-1-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1654879602-33497-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/22 01:46, John Garry wrote:
> This small series includes the following:
> - Rework how some shost values are set
> - Fix a longstanding bug that the driver attempts to use tags before they
>   are configured
> - Stop using {set, clear}_bit()
> - Expose HW queues
> 
> Any testing would be appreciated as this driver is still broken for my
> arm64 system, i.e. just broken.
> 
> John Garry (4):
>   scsi: pm8001: Rework shost initial values
>   scsi: pm8001: Setup tags before using them
>   scsi: pm8001: Use non-atomic bitmap ops for tag alloc + free
>   scsi: pm8001: Expose HW queues for pm80xx hw
> 
>  drivers/scsi/pm8001/pm8001_hwi.c  |  5 +++
>  drivers/scsi/pm8001/pm8001_init.c | 73 +++++++++++++++++++++----------
>  drivers/scsi/pm8001/pm8001_sas.c  | 10 +++--
>  drivers/scsi/pm8001/pm8001_sas.h  |  3 ++
>  drivers/scsi/pm8001/pm80xx_hwi.c  | 46 +++++++++++++++----
>  5 files changed, 101 insertions(+), 36 deletions(-)
> 

Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
