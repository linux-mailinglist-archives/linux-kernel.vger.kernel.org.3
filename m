Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC5D4E8B40
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 02:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbiC1Aj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 20:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiC1AjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 20:39:24 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5D84ECD8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 17:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648427865; x=1679963865;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1TF4VA8quiREm1FQHyiut+4zTzxjbm3Uliq7TS0u9NM=;
  b=lHHiDEyXhQopjkoocZ/LrVoB/z0XBRJgMS3clsyxrR8dJLlK3RyzpaR7
   6qp6ovnvj5Sl1HqlhEHHnuLKJIQOyNp057PCEPisdTDi29VGWmbWqk9pV
   WRQ28ndQxAC+EGuz0zmxSe515pAPVFEk68vmtX/ElAOmbs9GILbczm/as
   P9bEFjvink95SNPp/3pHvKBKxzpj0PNco+FxUYk8EnnhWM/zrqscy/Ohi
   VRXtKf86ywnqR1RXYl5C+T5p4CiuKAUtmBViPftr9neDja19MYaAcixj8
   IMG+JW9m4inGrleqxjRs5KezHv1yWLaonJCo2qTgyY4yu/rGva2zWnw5C
   w==;
X-IronPort-AV: E=Sophos;i="5.90,216,1643644800"; 
   d="scan'208";a="195287871"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 08:37:44 +0800
IronPort-SDR: 5biPfGQ5APLQzkq/piFl4oWZS3psgbWS95M5aDxZkm2puNMcw3AxVY0FT1OsCuxPm/NaynnuTI
 yTtAaPQLniOeRtm/QFZu3PbY16HLeBGYRc+21TF9be1q4sjsix6Xq902CWKoF/IVQoj45KE6t3
 cQaLOj0wXrtWpiMqPylEPkP71hzqmeJGl2F/IlnwsGhe+0TFExu/UM2D/6bEAmxtrPMIbqChqy
 0UpjzLdOTcQ21vddDCFblOu64t1DWUzy6s68Lhpo9MUNNSU0dkj8Lk60WeYKga/Zr/mOLNw1ZJ
 b1q2MHCmTRXbD9xIAcj5uxk2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2022 17:09:30 -0700
IronPort-SDR: LtbJEEtXN6mD2GQIVqOzaFrHw+6y6u37eTbHKV3IRJmA3GWizZo/j4icvE/FtZAj6RXCnWYkMZ
 xtGjzx1Rn8GhHgJYv9SMwXZ6xFV4xobbtRNADipSaannhTes3XWOJx4Pp5x/4mIv4d6tpTpgR5
 DDeRPP+NSO3D6KsoHsWvZHTRJkDM8OJVLtrDPhqYvut23IfGarbgyVhyMZq6+PW9llnTlTH6DY
 d9ymopRECpIawRKybEZREaBJ0B6Xg/40XY7IdR4hsnBT6gyA7wTTiJ/fKDjIWGADwKxIkXx1Xd
 SfA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2022 17:37:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KRYgr1DLRz1SHwl
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 17:37:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648427863; x=1651019864; bh=1TF4VA8quiREm1FQHyiut+4zTzxjbm3Uliq
        7TS0u9NM=; b=pjbgTIcMSMWIFByW35wNKP75c5I8RgtwfhwJoezZHoZ/lcE7QBh
        YWU2SmjjhDCjUdrLGigmGLf/VfqdQHcLa+6guLTXkXym3Z+zXos2/OPdT0YUMuGt
        qivcfy9yPQZHjNZF1uS7pbvKwFasX0p6WhO/ACikL/fEosN3PRAeObyMkR88LKtp
        cf+gaaMqJNGgGBn1A/TPbevHyWZlF0xH7ijlzIm2pP9BvyvnyF0exDsdCQ1vZLce
        GFHFtVTdp1KPfAXtNyRxsafn4BTQP0JDVrm+9YIewhWLRGxFY0Pa7UynE+u6E2CM
        XwQWIHFqwIO5zzowxiR8dM/j8vkX6wWxEIg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id l5jx-CHFtb8J for <linux-kernel@vger.kernel.org>;
        Sun, 27 Mar 2022 17:37:43 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KRYgp2wVNz1Rvlx;
        Sun, 27 Mar 2022 17:37:42 -0700 (PDT)
Message-ID: <b9dc8838-1272-5c7e-121d-768e7feed290@opensource.wdc.com>
Date:   Mon, 28 Mar 2022 09:37:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ata: Kconfig: Update SATA_LPM_POLICY default to "3"
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220324145905.4176-1-mario.limonciello@amd.com>
 <YjyInz126lgomIvW@infradead.org>
 <BL1PR12MB5157132871A3CBD381E7F072E2199@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <BL1PR12MB5157132871A3CBD381E7F072E2199@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/22 00:09, Limonciello, Mario wrote:
> [Public]
>=20
>> -----Original Message-----
>> From: Christoph Hellwig <hch@infradead.org>
>> Sent: Thursday, March 24, 2022 10:05
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>; open
>> list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers) <linux-
>> ide@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
>> Subject: Re: [PATCH] ata: Kconfig: Update SATA_LPM_POLICY default to "=
3"
>>
>> What about just reverting the rename of the config symbol?
>> It is a bit misleadin=E1=B8=91, but so are many other option nams.  An=
d they
>> really aren't the user interface anyway, the help text and description
>> are the main user interface and can be changed at will.
>=20
> It was the rename that prompted us to give it a closer look.
> I think this patch should to change the default should happen either wa=
y.
>=20
> If Damien or Linus wants to revert the rename, that's fine with me, but=
 if
> we land this patch then I think it should serve the intent of most peop=
le and
> distros.

I am OK with the change of the default value to 3 since this is what most
distros have today anyway. Nevertheless, I think we should fallback on th=
e
safe side with this and also revert the config name back to
CONFIG_SATA_LPM_MOBILE_POLICY to avoid any unintended side effects.

Please send a v2 with that rename and the default value change. As
Christoph suggested, the config option help text can be broader than what
the name suggests. I am thinking of something like this:

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index f27b12ba2ce7..ee3f96b5be70 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -125,14 +125,16 @@ config SATA_AHCI

 	  If unsure, say N.

-config SATA_LPM_POLICY
+config SATA_MOBILE_LPM_POLICY
 	int "Default SATA Link Power Management policy for low power chipsets"
 	range 0 4
-	default 0
+	default 3
 	depends on SATA_AHCI
 	help
 	  Select the Default SATA Link Power Management (LPM) policy to use
-	  for chipsets / "South Bridges" designated as supporting low power.
+	  for chipsets / "South Bridges" supporting low-power modes. Such
+	  chipsets are typically found on most laptops but desktops and
+	  servers now also widely use chipsets with low power modes support.

 	  The value set has the following meanings:
 		0 =3D> Keep firmware settings



--=20
Damien Le Moal
Western Digital Research
