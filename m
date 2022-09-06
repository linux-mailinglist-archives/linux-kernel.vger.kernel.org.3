Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AFC5AF33B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIFSCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIFSCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:02:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052EFB02A3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 11:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662487349; x=1694023349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=daJKG6yz8Q8565HhHa0TNvI8O+X6Tw5lDfPbestEp8k=;
  b=bvV00zWxrxtKxqZkQI6V5gz1QD5TlK7xc5M18IBaLvrmyLM5QZEkyXQI
   6rA0WS4G+mGCHtytH20cw/Z356xQOGjR3Gju034eaSBnpw5KOpPNwQWa3
   Xvny3KDYAT2NTdFIF3Q2e3YoKAKSprLbeQ+tBEJ4Y9XmK371jNUXicvPw
   uk6FXwOAZA1jMRI7ZM0zbODu2LoznSGaSPs4c0zvVgG1MI5eSwNAf6G3g
   9/twLQocVJnsq29OUwMO8cT7VBIU/lWOOJAfbUmk2u/d+bG7Bug3nTfW0
   HSXa9RWUtT0C2svj0gQV3Yp0hUtg+3y/gpe/P69L704s6Z/w9aE0VUpxs
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="179390088"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 11:02:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 11:02:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 6 Sep 2022 11:02:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYuETGIeNE8FUWUIxliyFLKSiJBmSUmPWdFl+o4y9uXRytaWbEdsFYYo87V4QkS5BZSsCb7N/CueVaWOZtdRQPL1Pv2ScJReUQoyX/lUw2Ae6e2PewvrrFluq+6BIlmAxPpfh+MswImbfAL5u/Er/RBsGRWHo3dEUD/nO0fjMmVvN9gHU/7jBChYe25ksTIJsyifqx9fLHAxPuAwjRuuO5jNA5kMeMzXQPw2NBMt10Lh9hPSEOjDBBDIEC/EzuiMpgNSYo5lEnYQB2hqGPY+3kXSixY3iONdYrOOTafrt7q3M0zgcT2VQIBB4YBErTh3SWs/eY6EUu0ROFVzdFGi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fg6oFhYCkG1/N3yCHT4tPcJATMif2KgjF4XuHnWHrgM=;
 b=PzesozR5a1YZQsiS2My3ySyssssjOBzdArCnGRUIDSR70b66KkU1qTc3WLCMSHNpxPsieaRQrRRwHWsmfyxAWrViei+vDcAekAB+I0O7RYbU2qFBXOpLD72OOjdl8bLw4lCDykiQOLoBUtcexRCjH/ldC/DhIaJ4neEx5bmjLCuv0GgNFuKF0Dz99gyMp1uLtjQsIXQD2YDYKgJMl11mfWkmXEalf40wDanXKdYIb2JmtHyjdQzrzHNvax/WE90PxB63PI/x6+YVaT1xeoyBobhvlLtmzILUNd5mXfD0DkccA2HAxtcvdP67TzqtYPS0fW+FqSnO9J9KTH9gYo4mWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg6oFhYCkG1/N3yCHT4tPcJATMif2KgjF4XuHnWHrgM=;
 b=H2TA65jZO3PVLx3vrDs7iI4sU936ODsxiu8hFTSbaZ6JrFr5rHR/QqfuhPSz/tFFsH4Rh8Yi6p+zDbiDdZ34umaetkQ0twMnsoLjNd1hQGsXt2OU0Qdv1t4ZmLcIqnFVfx3Bc6zcNV7Ur7zRD0pBvBDvs5q64w0ZGdmLL+yzJqA=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by CH2PR11MB4389.namprd11.prod.outlook.com (2603:10b6:610:3f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 18:02:22 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5588.014; Tue, 6 Sep 2022
 18:02:22 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: RE: [char-misc:char-misc-next 21/24]
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:135:34: sparse: sparse:
 symbol 'pci1xxxx_gpio_auxiliary_id_table' was not declared. Should it be
 static?
Thread-Topic: [char-misc:char-misc-next 21/24]
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:135:34: sparse: sparse:
 symbol 'pci1xxxx_gpio_auxiliary_id_table' was not declared. Should it be
 static?
Thread-Index: AQHYwPINBFGtBPTAu0ifzHiXlRk4Fa3Sr8ZA
Date:   Tue, 6 Sep 2022 18:02:22 +0000
Message-ID: <BN8PR11MB3668B1EAD67AFB7CB5CCB6C2E97E9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <202209051441.knwv3o1D-lkp@intel.com>
In-Reply-To: <202209051441.knwv3o1D-lkp@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be7b50a0-ae7f-47df-d2f6-08da9031f295
x-ms-traffictypediagnostic: CH2PR11MB4389:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: quGO0tos9NHEBQjYh5W9E9X05P1QSlurqPOLcGqUpz9rx+SBWWyXg9EAAzsJ4a5TvP0cnakHoTA5aUdqJ3TA7eVpTKjqvs4s3EXW878tnMjWUCIGJeDexmTq05SQsc8Ub+AMQKcBweKjrp3X6oWlol+nVacU4EjtwrOcjl4MgsIk2rgwvf6wi6dUTyM3tkbZuqtuI1HtstcUvCAawYzcbMaviFDnyCPwQHhHZLyGebzNxRb1JU4UwRWwvbHZnBmF9zakveoGxDU4Yx9pGIcgRDqH1NBzrgFU5tv/gGcNw7XgP0/k5cM7pUwjUh8NglH17bUnwTDd7yFvZzkMW7yNMu5fs2Kdy2VqlcI7TK1F78RLsfeuaXTKfxfUCCc0FZGdaG8P93p/M2aLVNK6ksWvTXhpv46/Ey26IvlyfZrK16h3cP2gFJkjI23nFKaX0HDCEXxU5P9vFldKBiyY1Io5o2KBSUDpeI8sbQmvTImt7zPm1LI0kewvf8757pq3JzTllDUHElkUvJ3u3Vg2HmthpXUMzZBGW0YpaiTDsPqYiJ1bQdOHGt5zJHK1cVpv+XWfwp0gW2/WtQhSGPsrGCb0nLamJEpThQBuB5FrYCA40//9MsXE4ymI91PtNJeNIZ8nOibeMGYK6SgTR+q8PCNvlq9fLsNcOi9e3FOKFkqv4AJlidjmiAlj22i4SuymcuZ8y9xQOAo1xIpWXTtVNe3oeaoKRrGx3PsK8gdyUsvJNWFI5bj+tVGnM59DsHiMd95aQ4s4aRGJJt9GjmTHI+6WhchzrfV5NhCt2q1EikDqolWEwCl9K4ZqNV5hCOnkgTmExYCXWDlB+uZXUjJFjJqUpkBydY8VKslMCR0AgUClQiI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(396003)(366004)(8676002)(122000001)(76116006)(64756008)(66446008)(4326008)(66476007)(66556008)(66946007)(38100700002)(71200400001)(41300700001)(186003)(966005)(53546011)(6506007)(478600001)(7696005)(26005)(9686003)(54906003)(83380400001)(316002)(6916009)(2906002)(86362001)(5660300002)(33656002)(52536014)(8936002)(55016003)(38070700005)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?abxW0KW3TmeVykTdjLwXvb3+y4f/jEJD7LM21wMy2OEKZQBHtM1VO3CJubqk?=
 =?us-ascii?Q?5bvB3i/YY2j9QZKpPYXjfvZV6I9uwygWH00sj+7r//DR2/ZU5H2vRbDsIocu?=
 =?us-ascii?Q?kHXHCmKl/zxlVdVN8S465/SlX2nIMuhXPyUZA8+Be6XEYzvpMuBk0ozyGEX/?=
 =?us-ascii?Q?X7QBOahbW9kFGaGidydCLf19YaMdN3KrsrrOa2mTgsIncb9N7ILLADagW5H5?=
 =?us-ascii?Q?0oDJMXsObRV4GQb5sdLuBg7YPAqa8eOsFj9F+1ZjFXAsaP+aqdB1kOx1q5XB?=
 =?us-ascii?Q?OX7ssBehnTMBGWjs4SUf2Fsa8hQZUfYT1adjptpflVZvsq4+Pcx34wgKCaC4?=
 =?us-ascii?Q?bcf9EfYQ6OeEctmqohFHDS1oHQ3YQNoOWOEm+ZlHvIMp2OBucQviyyaIO0AL?=
 =?us-ascii?Q?LjGrt8jTDhGGZQNYqTRKtVj+X/OzKBOK8Phb7a86GTV+RD1YpaictqLLtf0N?=
 =?us-ascii?Q?Ztx7Wkdn/1sA85SVVohtd13+HAXP/5CKWYr9LRJ+ZA8pFYp7lyeVXsF1Vrlj?=
 =?us-ascii?Q?zTpHIckZBRgFM72Sr7qBGsOQ+wSmXo8SUbdFyJh5lwJdXXuv++9So9QDpK5i?=
 =?us-ascii?Q?YYAnMC+fWFHn4syrM0ALzWlVp4uIKDqpG6q3FwYhnTaa2vVtaI5f/q/iTmD9?=
 =?us-ascii?Q?l4b7L1IYEXDJ7scsS+nOu4UhZBTfTprIoAV4F8ZCgRY/4GtNaGsGdnvQ+Ez/?=
 =?us-ascii?Q?Y/bQEuVt14lJIV8+kHrrvZ8nWSLPEoJElEMNKkDEhwcboxphyv2CmNKsVNX8?=
 =?us-ascii?Q?vMjg8hjd2JvB83YBH1F4zKsyOJ4XDGbaXnKLClHb40hyfPIARIsk5uABmJjz?=
 =?us-ascii?Q?LBZH96URSsCs0taQFeKrrWa+VTFhS+xZRlJKpRM3xCbHxStaNbLovTcfjpOn?=
 =?us-ascii?Q?ApzMni9k60NQmd1/XdJDiZ1GRiaKmprMg0AhzUhMbh7OMbTRQuYArfar56yp?=
 =?us-ascii?Q?1lcxOw3gKZWonaQVXZABldKdblvT+NMLPPRG+z1gR0cU+3IInspClZj+dvgq?=
 =?us-ascii?Q?ufcTP1Z/r84i4XE01h3an2s5OYpHFMqhKEP1EoCIf4nxqAxo8G9xvyYpBxW9?=
 =?us-ascii?Q?TAo1S3MJY2G+7m0SDO/ovd3mj3uwPdwHNOMakaDMUQ0UEuNIV5tK/3nuJec+?=
 =?us-ascii?Q?9cWzUpb3vCNPzfwrfZLYPk92FOevxpBQrFd48wtUWOyyBBr0czb1r2i2SeBh?=
 =?us-ascii?Q?ZghyVy0VA8mDnLhYhHTdWqtIuyosS8Xc5OQUv/CVteBHZxOtTgEpiX8ZhSgP?=
 =?us-ascii?Q?qWg3iWRLBjT3CiONHof0baelmII5gxNdr/FGtyKVMN47Sv0Xlhjm43koQ2Kr?=
 =?us-ascii?Q?/p8x2e1z/M6UNuAru0WMpsypZCJ2erWtrkpuN/PjtzsE563lkoD0qacg7OXM?=
 =?us-ascii?Q?t9h58lB5w5NDME0vn+PcWfWptugdgYQ+fd8lmufVOjHTq1T02eMYaHK0ROvB?=
 =?us-ascii?Q?RLCPTxeOawcAsz4DJ7+iK1Q+CwtM0grPqNr4pQdefl4hn/nkHaZhkXNMyfug?=
 =?us-ascii?Q?GE0BFO7lDpNN0xM3arjT4YszMC8yT83nvg0ymTrFTHiKQ3W11EUmCf3KyV85?=
 =?us-ascii?Q?8zt6d0lBp8lvNIf297iHYxbUX3U14etDY2BEufoho82Uy72Yvpq9ucS+vTJg?=
 =?us-ascii?Q?jjhmSdx+U2gx462Pt9fIPq8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7b50a0-ae7f-47df-d2f6-08da9031f295
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 18:02:22.3580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WMrU4uckglv4N9lSvZZNqvFBIdzts6YWcxaWaKJyiOr5TkryG9HU7tn9Tf5mnxnvjDEzSUJEz0GEMgNSaUMg3WI4mEXw5/rjtoPXqvs8PTv7oqHRnBx1gbEWioVgSK3l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4389
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Monday, September 5, 2022 12:07 PM
> To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> Cc: kbuild-all@lists.01.org; linux-kernel@vger.kernel.org; Greg Kroah-
> Hartman <gregkh@linuxfoundation.org>
> Subject: [char-misc:char-misc-next 21/24]
> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:135:34: sparse: sparse:
> symbol 'pci1xxxx_gpio_auxiliary_id_table' was not declared. Should it be
> static?
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.=
git
> char-misc-next
> head:   50e177c5bfd9abc3828cb57e14e6169170f6764a
> commit: 7d3e4d807df2a216b9aa2944372f2b3f6ef3f205 [21/24] misc:
> microchip: pci1xxxx: load gpio driver for the gpio controller auxiliary d=
evice
> enumerated by the auxiliary bus driver.
> config: i386-randconfig-s033-20220905
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
.
.
.
>=20
> sparse warnings: (new ones prefixed by >>)
> >> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:135:34: sparse:
> sparse: symbol 'pci1xxxx_gpio_auxiliary_id_table' was not declared. Shoul=
d it
> be static?
Greg, do I need to submit another patch to resolve this warning on char-mis=
c-next?
I did not combine this with the last patch thinking that the last patch wou=
ld
be merged with the commit that introduced the errors and not queued.

Thank You.

Regards,
Kumaravel
