Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F795B12A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 04:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiIHCqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 22:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIHCqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 22:46:30 -0400
Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [216.71.153.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118076CF79;
        Wed,  7 Sep 2022 19:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1662605188; x=1694141188;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rBpXQsXFFpqyv9l02iuFPXNJNMxiS3irMVwq1aDh2eo=;
  b=jQ9DDw7QS7277hLEUrQ+Gfch4eLstuuKGFMJxCqmkxdkkffP8HfdBZ4z
   IqrXAPuWS8/h6r93S3rU0cnVljK7zzXlTES0Q1zKJcLEdCls68l8S59Wh
   BcFm30JFseaF5U/OqBV9OpIyR7wi5uGlL1Za12UCRGPTkuEuvSRf7QHyw
   w=;
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 19:46:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXcVUeCoD/vdJ9CFCoVchnUGttqAj/itYtZD5jNUGPGxcy+SaiZJiaL5P+dGtFXsYb3jfnX8ABy9TQ1Yj/qJD04Bj/6PBJ/UntyAqwmbadcJ6ARICe63SRtGZNdWbPgy+lwdg5udXj9y9XqPWkpKaVIzQRzXIqOny8tr2cqcydlxLO0ufFQiQonFuZEbKCjwZOYrvTvWqNRtrK7Hm1/CuT707rD2LGAGHtZH+O8XzeZG0l0Lqmib/viJhb+4180Xm4PFmNfgJbOm+Un6JClEMNShxpVT/Tg/JQ36Iep9ykrFY2BkjP1E86pBkTJHDH3UZjxUec53dOLNS3rlOwr1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7w8P2gQgo9IksBuP8fwiHXDlfM+2BCb+D9VxsKJg3g=;
 b=loyHUdpAI5dyScOmoAx9XYagQXe8/paa2vASg95FwA8EaBsvfoJNndbB+cpAOGiLXzjWWACgAtYILB0bTwzcnoLhu0/Hl/4vQdCHKnAUChsyFW3WOfTUhRE4i+1DP3ifHq06dgS7Y09g+/UlXMs8dKZPEIoLKlWHoiVY0u9F8JD6uWw6gP+Q9sM7joaYPYOEyGcyvpTXBL3Be/jTpBd28ftXIUcsgjY0/Z9NYs+iSzJrHxo+fgKFgIywmLcO5J7Kbd0AnNgi7z/0x4ZX5Vm7mGIQznOhB/c5imrmRpB7CUpTd8cM06TPY6aDrZGHpLr6ZM6a7DUncRUMuGr5IRmYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7w8P2gQgo9IksBuP8fwiHXDlfM+2BCb+D9VxsKJg3g=;
 b=HrWU0zrF6PSZX3pVkYTy0woK/gTkLRWR3lPyU5Mspnktus1baZnDO9ILtyJQQJHP1cHAzro4Y9KlqrZbWfjs1j/vYOU835KyyBgQzH6J0iVOtsvp7IFsClLdKRmNasRDjhfW5Ff4yfUJDqtA7zVhm5tdfOB5FGj/fs/42eykdMo=
Received: from SJ0PR20MB4409.namprd20.prod.outlook.com (2603:10b6:a03:42c::20)
 by BN0PR20MB3862.namprd20.prod.outlook.com (2603:10b6:408:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 02:46:24 +0000
Received: from SJ0PR20MB4409.namprd20.prod.outlook.com
 ([fe80::35cd:ad03:c16b:589]) by SJ0PR20MB4409.namprd20.prod.outlook.com
 ([fe80::35cd:ad03:c16b:589%6]) with mapi id 15.20.5612.012; Thu, 8 Sep 2022
 02:46:24 +0000
From:   Rory Chen <rory.c.chen@seagate.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Tyler Erickson <tyler.erickson@seagate.com>
CC:     Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Muhammad Ahmad <muhammad.ahmad@seagate.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "andrea.righi@canonical.com" <andrea.righi@canonical.com>,
        "glen.valante@linaro.org" <glen.valante@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Michael English <michael.english@seagate.com>,
        Andrew Ring <andrew.ring@seagate.com>,
        Varun Boddu <varunreddy.boddu@seagate.com>
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Thread-Topic: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Thread-Index: AQHYhxl16wZu53I2nkyhDu//lRykYq2Hfy1sgB6yWuSAAgaVgIAAJ4jqgAzCDACACvKxAIAVNerr
Date:   Thu, 8 Sep 2022 02:46:24 +0000
Message-ID: <SJ0PR20MB44098A7A5D1904FD68DFE73BA0409@SJ0PR20MB4409.namprd20.prod.outlook.com>
References: <20220623155335.6147-1-paolo.valente@linaro.org>
 <PH7PR20MB505849512979A89E8A66FB24F18E9@PH7PR20MB5058.namprd20.prod.outlook.com>
 <SJ0PR20MB44093D6FB740E543EDAAC002A0629@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <74F8D5E8-0D56-413B-A3CA-7462D9C862D6@linaro.org>
 <SJ0PR20MB4409EA5AC40DE61ED7A4BB13A0659@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <DS7PR20MB4782D8436B69B7EF53749425896D9@DS7PR20MB4782.namprd20.prod.outlook.com>
 <21A4C080-7FFB-4ABF-86C6-E8E05BD83E6C@linaro.org>
In-Reply-To: <21A4C080-7FFB-4ABF-86C6-E8E05BD83E6C@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Enabled=True;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SetDate=2022-09-08T02:46:20.142Z;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Name=Seagate
 Internal;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ContentBits=0;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR20MB4409:EE_|BN0PR20MB3862:EE_
x-ms-office365-filtering-correlation-id: 508c8c17-83b3-4f92-581f-08da914451f3
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F94b5lfrC8EuOGf7l2vsOPfqcUJqqfvKbyYfY/ufKEmXkblxvDATdU3eIk1lm7W5UWOpS2ur+/kkATuMBvQY5L4SBAuo6v3a5lqQ3E2xq5OYapr6al2gp6jb+LkxBv4o6jxgz49PjtZq4U+KEUddajpTxzUuMxFZbrdC7KyDnSA78ixPh/PwguCxtR3ViLZEWQlkli7yGboPgxTXXSkhMKN7wFyOzGaCSAC5WJbQtS1FHXkjTqJ0nakd20aTYCgZ8QawQV58Thl9dobkfSMHsE+wdgp4doDMQKZWXbaUhPD4zRCQn4iCeZM4Fubjad6U4R5BjebJgpOhRq7f4TkbVg+8UJlyht6Y2ULoojDYIIi4ScM8S88kqlKmwcSc+pqQ05Uhj+7JWw4+lbKxq55WrNzw7FGQMM8VwXAWElh4yFisuV81VG0kpv6ALcrNKIjiIh/j3f8iGLBHDuoCn+bp3S1BdbVrfpjPP6sZnbZGcZv3HVXEPuuvrlZ++4glW7q6iQ3xV7F3RwsKpg6py/0u77Mmk0Ce2wrYMzEPW8Usb65DYhgo5iXoj2aeavGulfM6+99NdQb+EWf8z16fE1f6PmJXWByvBjoBmEE8RzMQgmswup6kBwieEtQ5zweV/ZBtga7y2w/j/wLpHIymKC4fgMRyEpMJebDxILgk5NPrl68zk+bDzZA3wILGriLSNm6zopXGbTlBH7Wn5/XIYrS6z1uGY5LRdD5GnOgezvEyhDcRfbQdThe/BFyqLZaNdXyL8PMpWcl4jiADUBA5Blw9izqa6xcvwgL712z+sOXYMSI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR20MB4409.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(376002)(346002)(39860400002)(5660300002)(52536014)(33656002)(71200400001)(8936002)(2906002)(122000001)(83380400001)(38100700002)(66446008)(8676002)(91956017)(64756008)(66946007)(38070700005)(76116006)(66476007)(4326008)(55016003)(66556008)(6506007)(6636002)(7696005)(53546011)(86362001)(54906003)(110136005)(316002)(30864003)(107886003)(478600001)(186003)(9686003)(966005)(41300700001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GmV+kk9DM22tJNFNrIoO32gCaUIB7p0YxYq3OD2IdXB5tXYoqZTxdKoeV+?=
 =?iso-8859-1?Q?39d70GGpvm6f84inBFBr37qFTxkukY4V/Ih6Xin4faYAm80hitRW/9lMid?=
 =?iso-8859-1?Q?PbCJvM14XOIUlkeeGuOip796RUuw2jzjoOg727aIDQISolHqQCLKMRM1yj?=
 =?iso-8859-1?Q?ObIAi6uDBK66oLUWakjYzT3/v19bh5h/pLP5GUlzFUzRY8Gd+ifkcp1x1S?=
 =?iso-8859-1?Q?h0IIYN6HAoda/FfwtwY9rkt6/0jFWAUma4UJaoXkAZ9hd/pqzR+l5IuykK?=
 =?iso-8859-1?Q?z9NWDYmlIgQmxUE44qgKLFIbUqo6HN5jmyF8HA09E54M3AHLFLrOvEG41P?=
 =?iso-8859-1?Q?YUnRXES1zcfIf6ng/R4gLE+pWsYpLnwd/iXX9+QIYS4i1kENyN5zCZ+PIl?=
 =?iso-8859-1?Q?JZ1tov8tOt2SYq/wQ3BHQjIRchwe+NoulnW4yJvpnJW6v73rIxXl4uCHnr?=
 =?iso-8859-1?Q?G14XXGkYJOA8I22Z7tk0UrZ/2ROmOb+0HnJInD5oYUlZb/3JF3obUXO28b?=
 =?iso-8859-1?Q?2UYMvhwgHR7SKUBVnSDlVvimRQsCB/XM91khpRujHcEMFQe8mJOsdCks8F?=
 =?iso-8859-1?Q?v99Ct8pfKMn7pODwCXSjVxVy79O+sRNAH+JcukGYtu6mLHsMXblXGlQyxd?=
 =?iso-8859-1?Q?MVaJ1PYE2pPK3/kMSI/k5lVtxRyNMcfm5lxIibIyX77TpujCpce6wxdXDu?=
 =?iso-8859-1?Q?+VSatDadXNz1uMKjjX7441/q/e8tlFodVL8Sa2iSO4ESuZUETF4QIBQVOt?=
 =?iso-8859-1?Q?AKQV0WuandO7zREsV0tSciOJGcM0wCCvkMGmoY3WGg5otiCOgSfYs70oCs?=
 =?iso-8859-1?Q?J1MCPQErb+9ytDnybAQ7J3rCm28/VcpIQpzdukCT2nGvbkw9scGmfGUxn+?=
 =?iso-8859-1?Q?6x5HcvJsftHLf1gDXtI7MnWcxSezUahBmnKwqrgpI1AUx854e89c3+9g/j?=
 =?iso-8859-1?Q?oXkx5zTUH2dpLu2uuGbPnlI20BOigc7RKznYsOEwpFqB8FuXNRnSYP04jU?=
 =?iso-8859-1?Q?BIp9su3M2QwL9pIDnXogwuoUksmFzrf25HFR10en5NI+K49O7TKW/pUznd?=
 =?iso-8859-1?Q?/v1RnsPul6MqeOjxjJau/6lH0Jf37rEH681lLFWgyMMY3ooGrUHeJPWxqU?=
 =?iso-8859-1?Q?X7Nz05EwvYiNGGr2STaDlxsolZDhYDG7AMW7vWMV1GiAD3Yt/s8bxiEPTQ?=
 =?iso-8859-1?Q?oyjRodfufPgYwUZw8nGH0hi3dREglhYZCFgn5Sajteus3EbNx7Qsdp9tBd?=
 =?iso-8859-1?Q?1sGcir80voony8drTE0w3UFJdfdu4/IsunHxc/J2496YBaNQO0Wndaeyok?=
 =?iso-8859-1?Q?LjrwOfQgo7j6potMW47XCnLbVX/JHScyaaJHS4tq+T9ODKsV2HLYeJA8HO?=
 =?iso-8859-1?Q?dTFYnER/LGvq47EmYNUY+zozAc/NT0zL4MqwwlhnlweIvBn8yVcsAfRab2?=
 =?iso-8859-1?Q?U6Fq+JwgdDUtfVFFTBksln8Y93wIYukNX12L5q5Nks0tkSiGxlGUhvilzQ?=
 =?iso-8859-1?Q?ZXNihSmEuXR/Nm1fQg/xR8v6qVES81/Jea9K7lHjDA1KOPa8QAUytm79sq?=
 =?iso-8859-1?Q?k/+y5rIMYGYdzUEbvzFjr2r/EjWuMuZxJc511eZu2rJN4W9yTgfkzVjpzi?=
 =?iso-8859-1?Q?XksAmAoVEccZv+P8bKDeFj17wXplF1bz0A?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR20MB4409.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508c8c17-83b3-4f92-581f-08da914451f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 02:46:24.4739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGoXsTmfTNgx1jyzrmV/070xXWeqRpz7QPmbKSSTMHSOB1Idqbl+d3KufuPzdG09uAMZtEcHg2SSVkg7j5r3lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR20MB3862
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I change the comparison condition and it can eliminate the warning.
<               if (end >=3D iar->sector + 1 && end < iar->sector + iar->nr=
_sectors + 1)
>               if (end >=3D iar->sector && end < iar->sector + iar->nr_sec=
tors)

I don't know if this change is appropriate but  bio_end_sector deducting 1 =
said by Tyler seems to make sense.

From: Paolo Valente <paolo.valente@linaro.org>
Sent: Thursday, August 25, 2022 10:45 PM
To: Tyler Erickson <tyler.erickson@seagate.com>
Cc: Rory Chen <rory.c.chen@seagate.com>; Arie van der Hoeven <arie.vanderho=
even@seagate.com>; Muhammad Ahmad <muhammad.ahmad@seagate.com>; linux-block=
@vger.kernel.org <linux-block@vger.kernel.org>; linux-kernel@vger.kernel.or=
g <linux-kernel@vger.kernel.org>; Jan Kara <jack@suse.cz>; andrea.righi@can=
onical.com <andrea.righi@canonical.com>; glen.valante@linaro.org <glen.vala=
nte@linaro.org>; axboe@kernel.dk <axboe@kernel.dk>; Michael English <michae=
l.english@seagate.com>; Andrew Ring <andrew.ring@seagate.com>; Varun Boddu =
<varunreddy.boddu@seagate.com>
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator d=
rives


This message has originated from an External Source. Please use proper judg=
ment and caution when opening attachments, clicking links, or responding to=
 this email.


Hi

> Il giorno 18 ago 2022, alle ore 17:40, Tyler Erickson <tyler.erickson@sea=
gate.com> ha scritto:
>
> The libata layer is reporting correctly after the changes I submitted.
>
> The drive reports the actuator ranges as a starting LBA and a count of LB=
As for the range.
> If the code reading the reported values simply does startingLBA + range, =
this is an incorrect ending LBA for that actuator. This is because LBAs are=
 zero indexed and this simple addition is not taking that into account.
> The proper way to get the endingLBA is startingLBA + range - 1 to get the=
 last LBA value for where to issue a final IO read/write to account for LBA=
 values starting at zero rather than one.
>
> Here is an example from the output in SeaChest/openSeaChest:
> =3D=3D=3D=3DConcurrent Positioning Ranges=3D=3D=3D=3D
>
> Range#     #Elements            Lowest LBA          # of LBAs
>   0            1                                               0         =
  17578328064
>   1            1                         17578328064           1757832806=
4
>
> If using the incorrect formula to get the final LBA for actuator 0, you w=
ould get 17578328064, but this is the starting LBA reported by the drive fo=
r actuator 1.
> So to be consistent for all ranges, the final LBA for a given actuator sh=
ould be calculated as starting LBA + range - 1.
>

Ok

> I had reached out to Seagate's T10 and T13 representatives for clarificat=
ion and verification and this is most likely what is causing the error is a=
 missing - 1 somewhere after getting the information reported by the device=
. They agreed that the reporting from the drive and the SCSI to ATA transla=
tion is correct.
>
> I'm not sure where this is being read and calculated, but it is not an er=
ror in the low-level libata or sd level of the kernel. It may be in bfq, or=
 it may be in some other place after the sd layer.

This apparent mistake is in the macro bio_end_sector (defined in
include/linux/bio.h), which seems to be translated as sector+size.
Jens, can you shed a light on this point?

Thanks,
Paolo

> I know there were some additions to read this and report it up the stack,=
 but I did not think those were wrong as they seemed to pass the drive repo=
rted information up the stack.
>
> Tyler Erickson
> Seagate Technology
>
>
> Seagate Internal
>
> -----Original Message-----
> From: Rory Chen <rory.c.chen@seagate.com>
> Sent: Wednesday, August 10, 2022 6:59 AM
> To: Paolo Valente <paolo.valente@linaro.org>
> Cc: Arie van der Hoeven <arie.vanderhoeven@seagate.com>; Muhammad Ahmad <=
muhammad.ahmad@seagate.com>; linux-block@vger.kernel.org; linux-kernel@vger=
.kernel.org; Jan Kara <jack@suse.cz>; andrea.righi@canonical.com; glen.vala=
nte@linaro.org; axboe@kernel.dk; Tyler Erickson <tyler.erickson@seagate.com=
>; Michael English <michael.english@seagate.com>; Andrew Ring <andrew.ring@=
seagate.com>; Varun Boddu <varunreddy.boddu@seagate.com>
> Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator=
 drives
>
> The block trace shows the start sector is 35156656120 and transfer length=
 is 8 sectors, which is within the max LBA 35156656127 of drive. And this I=
O is completed successfully from the slice of parsed block trace though rep=
orting the warning message.
> 8,64   7       13     0.039401337 19176  Q  RA 35156656120 + 8 [systemd-u=
devd]
>  8,64   7       15     0.039403946 19176  P   N [systemd-udevd]
>  8,64   7       16     0.039405132 19176  I  RA 35156656120 + 8 [systemd-=
udevd]
>  8,64   7       18     0.039411554 19176  D  RA 35156656120 + 8 [systemd-=
udevd]
>  8,64   0       40     0.039479055     0  C  RA 35156656120 + 8 [0]
>
> It may need to know where calculate "bio_end_sector" value as 35156656128=
. I have patched libata and sd driver for Dual Actuator.
>
>
>
> From: Paolo Valente <paolo.valente@linaro.org>
> Sent: Wednesday, August 10, 2022 6:22 PM
> To: Rory Chen <rory.c.chen@seagate.com>
> Cc: Arie van der Hoeven <arie.vanderhoeven@seagate.com>; Muhammad Ahmad <=
muhammad.ahmad@seagate.com>; linux-block@vger.kernel.org <linux-block@vger.=
kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; J=
an Kara <jack@suse.cz>; andrea.righi@canonical.com <andrea.righi@canonical.=
com>; glen.valante@linaro.org <glen.valante@linaro.org>; axboe@kernel.dk <a=
xboe@kernel.dk>; Tyler Erickson <tyler.erickson@seagate.com>; Michael Engli=
sh <michael.english@seagate.com>; Andrew Ring <andrew.ring@seagate.com>; Va=
run Boddu <varunreddy.boddu@seagate.com>
> Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator=
 drives
>
>
> This message has originated from an External Source. Please use proper ju=
dgment and caution when opening attachments, clicking links, or responding =
to this email.
>
>
>> Il giorno 9 ago 2022, alle ore 05:47, Rory Chen <rory.c.chen@seagate.com=
> ha scritto:
>>
>> Resend the mail as plain text because previous mail with rich text
>> makes some mess and forget to add others at Seagate who worked on
>> validating the patch as well(Muhammad, Michael, Andrew, Varun,Tyler)
>>
>> Hi Paolo,
>>
>
> Hi
>
>> I am from Seagate China and face a problem when I'm evaluating the bfq p=
atches. Could you please check?
>> Thanks
>>
>> Issue statement
>> When running performance test on bfq patch, I observed warning message "=
bfq_actuator_index: bio sector out of ranges: end=3D35156656128" and OS hun=
g suddenly after some hours.
>> The warning message is reported from function bfq_actuator_index which d=
etermines IO request is in which index of actuators.  The bio_end_sector is=
 35156656128 but the max LBA for the drive is 35156656127 so it's beyond th=
e LBA range.
>
> Yep, this sanity check fails if the end sector of a new IO does not belon=
g to any sector range.
>
>> I captured the block trace and didn't found request LBA 35156656128 inst=
ead only found max request LBA 35156656127.
>
> Maybe in the trace you see only start sectors?  The failed check si perfo=
rmed on end sectors instead.
>
> At any rate, there seems to be an off-by-one error in the value(s) stored=
 in the sector field(s) of the blk_independent_access_range data structure.
>
> I guess we may need some help/feedback from people competent on this stuf=
f.
>
>> I'm not sure if this warning message is related to later OS hung.
>>
>
> Not easy to say.  At any rate, we can try with a development version of b=
fq.  It can help us detect the possible cause of this hang.  But let's see =
where we get with this sector error first.
>
> Thank you for testing this extended version of bfq, Paolo
>
>>
>> Problem environment
>> Kernel base is 5.18.9
>> Test HDD drive is Seagate ST18000NM0092 dual actuator SATA.
>> Actuator LBA mapping by reading VPD B9 Concurrent positioning ranges
>> VPD page:
>> LBA range number:0
>> number of storage elements:1
>> starting LBA:0x0
>> number of LBAs:0x417c00000 [17578328064] LBA range number:1 number of
>> storage elements:1 starting LBA:0x417c00000 number of LBAs:0x417c00000
>> [17578328064]
>>
>>
>>
>>
>>
>> From: Paolo Valente <paolo.valente@linaro.org>
>> Sent: Thursday, June 23, 2022 8:53 AM
>> To: Jens Axboe <axboe@kernel.dk>
>> Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>;
>> linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>;
>> jack@suse.cz <jack@suse.cz>; andrea.righi@canonical.com
>> <andrea.righi@canonical.com>; glen.valante@linaro.org
>> <glen.valante@linaro.org>; Arie van der Hoeven
>> <arie.vanderhoeven@seagate.com>; Paolo Valente
>> <paolo.valente@linaro.org>
>> Subject: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
>> drives
>>
>>
>> This message has originated from an External Source. Please use proper j=
udgment and caution when opening attachments, clicking links, or responding=
 to this email.
>>
>>
>> Hi,
>> this patch series extends BFQ so as to optimize I/O dispatch to
>> multi-actuator drives. In particular, this extension addresses the
>> following issue. Multi-actuator drives appear as a single device to
>> the I/O subsystem [1].  Yet they address commands to different
>> actuators internally, as a function of Logical Block Addressing
>> (LBAs). A given sector is reachable by only one of the actuators. For
>> example, Seagate's Serial Advanced Technology Attachment (SATA)
>> version contains two actuators and maps the lower half of the SATA LBA
>> space to the lower actuator and the upper half to the upper actuator.
>>
>> Evidently, to fully utilize actuators, no actuator must be left idle
>> or underutilized while there is pending I/O for it. To reach this
>> goal, the block layer must somehow control the load of each actuator
>> individually. This series enriches BFQ with such a per-actuator
>> control, as a first step. Then it also adds a simple mechanism for
>> guaranteeing that actuators with pending I/O are never left idle.
>>
>> See [1] for a more detailed overview of the problem and of the
>> solutions implemented in this patch series. There you will also find
>> some preliminary performance results.
>>
>> Thanks,
>> Paolo
>>
>> [1]
>> https://secure-web.cisco.com/1hcxnN1C3h1nW7mby7S66_LE8szirQwbQI0fBpYeP
>> rA0GTWfyuQyl0GpZaOn32xMSkNT0BUQWloDHFzZ23aYDZdi8NfdrEFLY9pQDBblIvn08LR
>> iTVoIOUC8zWSG_r2PCyLtx3ppZq5cWOib_8azxteRRcbKWGdbLPSqg9hfSJSqltth0ByLO
>> NHEoI3p3e9QNIn6nVAeQbsT3aOQe-F95XrQvaPrFJXx6RGL9kDXyfkbXIHcdcLBf895gYB
>> Fn5S2WjBDQq2kzDzZOlc1HekRUhg0qDQcFY6NydVfrqNfLbpAHAth6KyREscQhVTMVREEV
>> a1b6bQByX6grF5pn3pTIo0lODyfX6yRmcbReSYNfOZ65ZPvp-nH530FQ-5nXoRxFf74WIK
>> DrNTALs3xQvg03DH4jLez-T2M9xEu-sfEDAEdTGF7BcnmBW6vrPO4_p3k4/https%3A%2F
>> %2Fwww.linaro.org%2Fblog%2Fbudget-fair-queueing-bfq-linux-io-scheduler
>> -optimizations-for-multi-actuator-sata-hard-drives%2F
>>
>> Davide Zini (3):
>> block, bfq: split also async bfq_queues on a per-actuator basis
>> block, bfq: inject I/O to underutilized actuators  block, bfq: balance
>> I/O injection among underutilized actuators
>>
>> Federico Gavioli (1):
>> block, bfq: retrieve independent access ranges from request queue
>>
>> Paolo Valente (4):
>> block, bfq: split sync bfq_queues on a per-actuator basis  block,
>> bfq: forbid stable merging of queues associated with different
>>   actuators
>> block, bfq: turn scalar fields into arrays in bfq_io_cq  block, bfq:
>> turn BFQ_NUM_ACTUATORS into BFQ_MAX_ACTUATORS
>>
>> block/bfq-cgroup.c  |  97 +++++----
>> block/bfq-iosched.c | 488 +++++++++++++++++++++++++++++---------------
>> block/bfq-iosched.h | 149 ++++++++++----
>> block/bfq-wf2q.c    |   2 +-
>> 4 files changed, 493 insertions(+), 243 deletions(-)
>>
>> --
>> 2.20.1
>>
>>
>> Seagate Internal
>>
>> Seagate Internal
>
> Seagate Internal

Seagate Internal
