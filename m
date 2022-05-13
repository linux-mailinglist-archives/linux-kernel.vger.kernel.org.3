Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5311525EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378900AbiEMJcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiEMJcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:32:19 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504637A47D
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652434338; x=1683970338;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KH2BK9hE9xsWVSxn/PwrMINbgCNBQSZKrJA6qaX2eVA=;
  b=eOK/l3WsypKyZOT8wiuh69jmrs1fpTrfURVpCs9XfW2BI+mrDm6b4pQ6
   tjYadsqYFieO0h0dFIXfXN/H48O8zX3x0jKtRBlpfJXIZ3sOuq2flFb0L
   FE8NPOPLj0HRV7K3q4l9j5deLjw2kNdKpW9huxeAuy0xl6PxMxomKFQwe
   JwWS3Lp8ZYtglN7MI5Ezjv78GFqxoNORWource60oYNoqKDE5AFRGlDGs
   WGGjw9L5MVTihNI31bU8LL5cegywW0F3UMRMBkh85G/cuPu9Sg2FyLtb7
   gLFv2ziTgVEvzeJadbfw+er45mtRS+eFjpRAeJ0lid19ADHGvrI3Shiyb
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,221,1647273600"; 
   d="scan'208";a="304473016"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2022 17:32:16 +0800
IronPort-SDR: JfS5fipLNLHQRMavL4JEAiTCAzGGdtnLIHwiF5G64s9VuSbkEVPjNTtVuBfRXmDq0kxLapm7YT
 LcWFsGYUrzknTZBfNVJ17ayXmSZfKCGe7EWvJtDQ2XFbMU7yjSQx6bnqyZx0QGlPw9/9glGdjO
 hdbIM2sp/iDMxXgYctI6OS6YUpHLYy3wTGqV94e0+2/jRL272BDoT4jD/oujorGC7w5azG/TmH
 emCUL4U1NlKcgb3pSevwsJRsoulhKExS0gUKY/yyV7uD9KCkAnvatu2yJplNUzbwGyOFBON4Aw
 w4hzrF3FEepQt8iQzldvUJ2A
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 May 2022 01:58:12 -0700
IronPort-SDR: GNBZd+P4W75G9FS1neDhiaqYs0tGStF36V0qjTYUStE9PPY/ToQfbBr1RbpcunRLOAgbd5TQkr
 QlEboewOy2v1IKRi8d7W1uv2JSEmoabR+mx882+WF2Hv2EZh0JhJfKkZoRYsFL04KKsydDI2M+
 6YIAOF2h+UzojO/tZQn9VqC5dC6Pw8DslVGeBZ2e+8LvRZma6EDAQEOhgWe6r+MJUOvRTBnJu9
 06aXWyKwa1UYXO6DvKlm7W2gqdTXtv0OBlFFAAMPjFQyUFNdLsv7MLaHztdjf+Qqvawfjon64v
 iqY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 May 2022 02:32:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L03MM58rRz1SVp4
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:32:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652434334; x=1655026335; bh=KH2BK9hE9xsWVSxn/PwrMINbgCNBQSZKrJA
        6qaX2eVA=; b=nxT5CZ3pULKILzz5et6S+/LrwhAJdTpkbWWCblYqPU/0rog6s5g
        FILpt7ojqXZzyxl0tHtYSXKPKqomckHQb9twd9C9qVY+lsCkLb62oUbLNJ1dkK88
        FC1+Di4GcB9MYIxvxqPfVOH2GytwecE2ToN5TUlbX98URoTspIwknFLHQJ03xhPZ
        qRGMJRLAgDlApdiA4TstzfpvFyAc4U4g/rbp+GkR0kX4ytBG2IP7Rol0ZcVUcwZ8
        ZYedN/SyIjr9zhqPD1swoKBw+2Gy4my+QVBWaFUqMh0QXRpP0dJL6IFe4vDNpiTa
        yo2ySNZ5jlNqbzadONoXgZ3Lb+FT0snMiHQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V3NbDLSCcS60 for <linux-kernel@vger.kernel.org>;
        Fri, 13 May 2022 02:32:14 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L03MJ0L9zz1Rvlc;
        Fri, 13 May 2022 02:32:11 -0700 (PDT)
Message-ID: <83ae3312-36ea-fa01-9b53-28818a04699f@opensource.wdc.com>
Date:   Fri, 13 May 2022 11:32:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v3 08/23] ata: libahci_platform: Add function returning a
 clock-handle by id
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>,
        Hannes Reinecke <hare@suse.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-9-Sergey.Semin@baikalelectronics.ru>
 <0732a28c-579e-52f8-21ad-653fd9a10aa2@suse.de>
 <20220512142607.u2kls35pevnjsjjh@mobilestation>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220512142607.u2kls35pevnjsjjh@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/12 16:26, Serge Semin wrote:
> On Thu, May 12, 2022 at 08:32:37AM +0200, Hannes Reinecke wrote:
>> On 5/12/22 01:17, Serge Semin wrote:
>>> Since all the clocks are retrieved by the method
>>> ahci_platform_get_resources() there is no need for the LLD (glue) dri=
vers
>>> to be looking for some particular of them in the kernel clocks table
>>> again. Instead we suggest to add a simple method returning a
>>> device-specific clock with passed connection ID if it is managed to b=
e
>>> found. Otherwise the function will return NULL. Thus the glue-drivers
>>> won't need to either manually touching the hpriv->clks array or calli=
ng
>>> clk_get()-friends. The AHCI platform drivers will be able to use the =
new
>>> function right after the ahci_platform_get_resources() method invocat=
ion
>>> and up to the device removal.
>>>
>>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>>
>>> ---
>>>
>>> Changelog v2:
>>> - Fix some grammar mistakes in the method description.
>>> ---
>>>   drivers/ata/libahci_platform.c | 27 +++++++++++++++++++++++++++
>>>   include/linux/ahci_platform.h  |  3 +++
>>>   2 files changed, 30 insertions(+)
>>>
>>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_pla=
tform.c
>>> index 3cff86c225fd..7ff6626fd569 100644
>>> --- a/drivers/ata/libahci_platform.c
>>> +++ b/drivers/ata/libahci_platform.c
>>> @@ -94,6 +94,33 @@ void ahci_platform_disable_phys(struct ahci_host_p=
riv *hpriv)
>>>   }
>>>   EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
>>> +/**
>>> + * ahci_platform_find_clk - Find platform clock
>>> + * @hpriv: host private area to store config values
>>> + * @con_id: clock connection ID
>>> + *
>>> + * This function returns a pointer to the clock descriptor of the cl=
ock with
>>> + * the passed ID.
>>> + *
>>> + * RETURNS:
>>> + * Pointer to the clock descriptor on success otherwise NULL
>>> + */
>>> +struct clk *ahci_platform_find_clk(struct ahci_host_priv *hpriv, con=
st char *con_id)
>>> +{
>>> +	struct clk *clk =3D NULL;
>>> +	int i;
>>> +
>>> +	for (i =3D 0; i < hpriv->n_clks; i++) {
>>> +		if (!strcmp(hpriv->clks[i].id, con_id)) {
>>> +			clk =3D hpriv->clks[i].clk;
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> +	return clk;
>>> +}
>>> +EXPORT_SYMBOL_GPL(ahci_platform_find_clk);
>>> +
>>>   /**
>>>    * ahci_platform_enable_clks - Enable platform clocks
>>>    * @hpriv: host private area to store config values
>>> diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platf=
orm.h
>>> index 49e5383d4222..fd964e6a68d6 100644
>>> --- a/include/linux/ahci_platform.h
>>> +++ b/include/linux/ahci_platform.h
>>> @@ -13,6 +13,7 @@
>>>   #include <linux/compiler.h>
>>> +struct clk;
>>>   struct device;
>>>   struct ata_port_info;
>>>   struct ahci_host_priv;
>>> @@ -21,6 +22,8 @@ struct scsi_host_template;
>>>   int ahci_platform_enable_phys(struct ahci_host_priv *hpriv);
>>>   void ahci_platform_disable_phys(struct ahci_host_priv *hpriv);
>>> +struct clk *
>>> +ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con=
_id);
>>>   int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
>>>   void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
>>>   int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv);
>>
>=20
>> Where is this function being used?
>=20
> It will be used in the DWC AHCI SATA driver and can be utilized in the
> rest of the drivers to simplify the available clocks access.
> BTW Damien asked the same question in v1. My response was the same.

Please squash this patch together with the patch introducing the first us=
e of
this function.

>=20
> -Sergey
>=20
>>
>> Cheers,
>>
>> Hannes
>> --=20
>> Dr. Hannes Reinecke		           Kernel Storage Architect
>> hare@suse.de			                  +49 911 74053 688
>> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnbe=
rg
>> HRB 36809 (AG N=C3=BCrnberg), GF: Felix Imend=C3=B6rffer


--=20
Damien Le Moal
Western Digital Research
