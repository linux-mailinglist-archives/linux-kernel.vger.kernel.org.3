Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C950A5987B1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343660AbiHRPoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245095AbiHRPoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:44:13 -0400
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 Aug 2022 08:44:12 PDT
Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [139.138.35.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7497268B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1660837452; x=1692373452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3mft7jtW5qBsaGONBzNK20Sjsx8EpmKrBiCKSvYVezQ=;
  b=an1iEBTO5yCLvQsHDn8fRWmhMu2lzebLlP0roAktNygMN7VE6wTbcZDz
   TR3Z+f9apuFG4rOD8QgoxlOp3Oxk+HX05Kp8MpsgO1kJCs4hWWlKsZ7a4
   JgLEOIoxuXUlpxEyshcKL5Pw6G2FMpEUYWwJ3Q+aRmotrz/VpQ2K9MWpX
   4=;
Received: from mail-bn8nam04lp2048.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.48])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 08:41:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SO9aNDu9JwPpa34zV4pbaTyy3GhCuuDOBFdZr4jKQCrnnWNED94Xj/xc1I29O7nYbGKbLlIKis5SioY4eEhr4OXD7b6iw6ZuAFke0BaMBpIAWhKfXjsUHsOB/WzaNiK1M2I9rotuBVYPi1ZxKsyXLLEXF/PJvoa1HpwHMLJRVMkbNlk8yHiYHQ9VDuDkdoHfwRlqj8suP7VwI1d0vdMJ4dXYB3wytKi750zgOUZioMlpyxLNmTH7/hc20w3X7M/9fVNqczyy2VAw18L/UX1gPdWUIzJY6rsoSD9AKYqsr+zOJPIakYH/B7qwC3I4fLoEdQ7VoPJemC6uiCEhZEdm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RR59ir9ba+j8vUmXkeDeGu3DArmM4pXSjedJhI1mxA0=;
 b=iiyd9y3jqFenywdRLiR+MTgjdL5WT6y55EyzYJz9cnz09tIJ5y+DgEXCPNF4pWgrY7geRdVcEUek4x0lU5ocHuiCWiKsER6FMkcaqlmHMkQhCIvEr6nB6kl2s7jFQSyYvCFhNlnkRvRkycAejYXeHow7eHgEorsDvIcZuZs2M+w3UptYgORsM7JXexiZIgqCY9ZmA3xqoAMeVGpOtQWB3fr38K5Z5CBD2KVQoCI3ksCQSC1DzU2vdinJn8piI/YEI4HaFX0ib7SGV7b3ER+dWxOCyd+4S6DXt5k5fbiYF8LA/aiYyGB1IDv+10DjuIPRJPq4/ejvHzwGfkLIU/HIdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR59ir9ba+j8vUmXkeDeGu3DArmM4pXSjedJhI1mxA0=;
 b=gZqtqiiwDV1UMwHHtYgC2XNyOXoY88dettwD0NytU6NbobW4NQB2e79cumQmSGtfV9Qm6e8PP/+uaHuZK5T3tV/DaKRIVv0Xv2tFYWT1VZ09s4Q8C2S4/pngDOQv898n2ZfmfqRqGRyCd9vAl8MVLguX8UDxwGGy3W/iG51qqL4=
Received: from DS7PR20MB4782.namprd20.prod.outlook.com (2603:10b6:8:9a::14) by
 DM5PR20MB1563.namprd20.prod.outlook.com (2603:10b6:3:139::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.16; Thu, 18 Aug 2022 15:41:00 +0000
Received: from DS7PR20MB4782.namprd20.prod.outlook.com
 ([fe80::d60:616c:6273:de66]) by DS7PR20MB4782.namprd20.prod.outlook.com
 ([fe80::d60:616c:6273:de66%2]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 15:40:59 +0000
From:   Tyler Erickson <tyler.erickson@seagate.com>
To:     Rory Chen <rory.c.chen@seagate.com>,
        Paolo Valente <paolo.valente@linaro.org>
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
Subject: RE: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Thread-Topic: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Thread-Index: AQHYhxl16wZu53I2nkyhDu//lRykYq2Hfy1sgB6yWuSAAgaVgIAAJ4jqgAzCDAA=
Date:   Thu, 18 Aug 2022 15:40:59 +0000
Message-ID: <DS7PR20MB4782D8436B69B7EF53749425896D9@DS7PR20MB4782.namprd20.prod.outlook.com>
References: <20220623155335.6147-1-paolo.valente@linaro.org>
 <PH7PR20MB505849512979A89E8A66FB24F18E9@PH7PR20MB5058.namprd20.prod.outlook.com>
 <SJ0PR20MB44093D6FB740E543EDAAC002A0629@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <74F8D5E8-0D56-413B-A3CA-7462D9C862D6@linaro.org>
 <SJ0PR20MB4409EA5AC40DE61ED7A4BB13A0659@SJ0PR20MB4409.namprd20.prod.outlook.com>
In-Reply-To: <SJ0PR20MB4409EA5AC40DE61ED7A4BB13A0659@SJ0PR20MB4409.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Enabled=true;
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SetDate=2022-08-18T15:40:58Z;
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Method=Standard;
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Name=Seagate Internal;
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ActionId=5c9b48e1-24bf-4c20-afd9-4d5acd293885;
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ContentBits=2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28afce59-546f-4c31-e386-08da81300cc2
x-ms-traffictypediagnostic: DM5PR20MB1563:EE_
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ECOYrgtC71bFRBqmAXkkoic+mWDWzh99SriugdjC5IhcG9jTFQXBZKzgZzJ/L2JF+dxE0qnUFM56gW0nQSmqxsjl1tRrgTHMEJ2b7TQ/MBr8Ej7LBqE3IHDcX2go6hlwYVhmDcimwS2d+LWnxtT+urUvKbMlTE0EURrB+HY4yID7yGGuxwmulF5gku4rpphkK46Vq6LP++0kttOf+/3ip8U5iL/rbDWNelBQ25U7YYLhWBB9GyrziR/OoXZriiI93xtHNqWjX+8PcoUGLtG39APpo3zlMSep4XKgIiW4Ptl+NF0ZZG0PitxVkPcTAzKOnxoQwgEvgLy6kg+wZXtriOJ5kWGB9ooarqh38r7tWlcMvMManxCjltWImK9l5o3naneSetaF7G6xv6bU+ggOvQOBrWiTYiC2dlEu+UU1eROi4uLPSYFcfrt5DjBNmsZlp0BKrJdyQ82DNhCNINLTcg2fAG1cgaGY5sUEVXNudGlpjxx96+FW0YoNZpvG0ghfsHhR5Bn7tdfX4gs+1PIE7EvKO9CEaKsAD2TWXHDseiSqcQAYNCCRt+gTypqzJMlA/ep97KrFGVgPHOme30GuAqE5tLhwZFdzKRG1bXBpTHzXFl4XfAftx8N2DVkhB+zCgnu/5w66BvfLppDYUCCDlntRIVnfX7zPHhpUSkdkHcyGb3qpXsTJJJBXr2HaL4ebiGft0SBfG0zVcrucpmKSP8dmmptU0KTsZwudVwL2SDB7Xx1SbCdqN6OKtoTMHzAFMeUI7SZ28LxLnIQpMkKcG3DR92X1FAQm1z1qxs6V3w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR20MB4782.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(39860400002)(366004)(346002)(136003)(966005)(33656002)(2906002)(53546011)(8676002)(38070700005)(76116006)(7696005)(6506007)(66556008)(66476007)(4326008)(66946007)(64756008)(66446008)(8936002)(44832011)(52536014)(5660300002)(41300700001)(9686003)(86362001)(26005)(107886003)(478600001)(55016003)(186003)(316002)(110136005)(54906003)(38100700002)(122000001)(83380400001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oLmJkRYkbBBhWyn9kR8XwuIOvRHZB1qc6ce5JClulRbgz/qMKgX8qLdmX0Im?=
 =?us-ascii?Q?mY/Z2d1y8bPX9D6aXEUkMFZviKqniW32V4Ba5h/yAK1N3xEPVyqjXmWlNbI+?=
 =?us-ascii?Q?tgefyQnU10IsTgovkC8OUeI2XsHLTpayJ3KHUrGC2Dz/DxHJsKaPbn+Q9DBw?=
 =?us-ascii?Q?RVfAYyaBDclZnCr8SxGHIiMQou5YztUE/kzp7qQvPlKSLTey14KK6wfv7K3w?=
 =?us-ascii?Q?l/4tgLADM0bs/CAt2PbdZH1+b9cHTayIJHXayHcO/xfpkOQuOtZ0XMSah3JH?=
 =?us-ascii?Q?yyo91UgJHkEvrElZ49xvfdaEC0mfrqxF1o0+CeXVKV1LFpHhVZs4bayyveE6?=
 =?us-ascii?Q?gQMNTDr/oVD532f8mdVea1Ib8Jr0pOZyAJdCBiFi1Er2Cppe61/4i3C9wSWL?=
 =?us-ascii?Q?W/vgKbbqaUIoT0loVXxemr60iM5uuhYszwgoOxULe+Jp6LzP787VfNj1rlIY?=
 =?us-ascii?Q?xVXSvJywTzl15YS8LEx+gHAL1D8CWXjOh8LFc/WVJiWaA1H7LbnGvG4kvNIF?=
 =?us-ascii?Q?fIJtWGyx5FzT2qRLUucUF/rhtgmbLhyKYFFBiON6f/v4BxqHc0w2upQhibEY?=
 =?us-ascii?Q?3TMcMMHD91ejy3OWxns3gAk6uSylHJV8IPDhzZwOyb5mtaSxGhit2lLtrM74?=
 =?us-ascii?Q?vCKFgHKdIE3sBnde8bkxj2JezeXlx0ZVRqr5gz/Q3zdLskCjDQgVHmqACcCS?=
 =?us-ascii?Q?nNhp2Z+/GgovIovkIwWvHYZV52NwXpaqBdRx+H18p2mgjoObptr+e7tI8LSM?=
 =?us-ascii?Q?n+hwu4EgQwfn9avrDBX7fMFUMV398XY7/1tzk/KWILAdbCdW7Qky14ZPy3Hk?=
 =?us-ascii?Q?CsrXizZ2SGebsujmn3q3M32XkR80TpEk81BQigXETE+RF/mwZ5nr7q0rqXmf?=
 =?us-ascii?Q?bug0MKEbJZ0DzBzn9fDtBSqO7W5v0VRkJI+fcwdY6y4Opgpl8XhRFv96183a?=
 =?us-ascii?Q?2KOR7lXQgAr/kSWPlk2InzMGY6cT15oBGHERBvT2xDxGzpWwRCeLf1hvl4pG?=
 =?us-ascii?Q?jbhWeOCkAcDolBJtDXqnocSYWHIRK6bin2hboyTJE/C+/7ekLWzUuJxRq13e?=
 =?us-ascii?Q?U7M5M9udAj4pIpv3dcZfpmKKYo+WZqi+8kIbdijqzLlEVbTwIr7AUC1w8OtE?=
 =?us-ascii?Q?IaNioH4elwmZdN1uEO24q+/udWq2uatku33c/EC4pbofQ0EgOa5+P6NRQ4jY?=
 =?us-ascii?Q?auo0ikz1m/IMoOtZfo2ut8wQD2KUGQxMoLXdccEyto8y9cUqN70x2JZd+9PN?=
 =?us-ascii?Q?YXdlPsnQAm0M1iDkGOERUgICCXqGWzvXz5vlE+PLftGxeeww1YXNRzMw/+LL?=
 =?us-ascii?Q?Qg/r9uiA1Jvm1+MiLeBXuhr6zfXTzIrMiod7T/dv/sjJflhXTbr91RhYmyRM?=
 =?us-ascii?Q?53e8Ofa+jl204OodE63rIqJ5kz+gxsAGmTJvCcUg/SeaKIUk1meGc06YiEOC?=
 =?us-ascii?Q?OAR+OPvs+qA5pAgJH5lK3XMHq+lq+NXr2Lc4ilWX4K6n/0Wt3G94pzIX2vli?=
 =?us-ascii?Q?oco6qcXql/XQ3HBclOW6FndVj7+4j2DnC20EO/NJ21muK/WqjIxRQyTV07V4?=
 =?us-ascii?Q?ks37ZYivXsAhcWf2TUeq9AeiFTjofaDT4PdaswovcPu8Bd2lieNytybNJe7R?=
 =?us-ascii?Q?hQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?0Ny5u4qClq+KXYwvt7LduprDPLffEpn6v2/z5aM4z88URsLI6rffLH40O7Hb?=
 =?us-ascii?Q?3PTdMF+OeTO8sH268i/SSTJcARe8g9b6emSk7uEthRSGN6sW/jhCH6OQ+fmA?=
 =?us-ascii?Q?SkrvUt3xHbrYyUtYzgg5YyxKh5gK56hyW92z9qYO79bceHpN+9iVSZtfqsnl?=
 =?us-ascii?Q?Vz3N6XZ3GLVs8P+ht1Snfe10mykytFrkjZYrCJdb1qSbHE+2I2DkgoSzkmHB?=
 =?us-ascii?Q?o6/9uoCyk+ql+SRvYqxtOcyVzwrZMnCIflsrPeKUNuMdct/YqFOUMDW8mu7r?=
 =?us-ascii?Q?a1Rg8DGyH8b3wV3jvEIo4cKlSgneT9odpD7fTIETOL+n7tivtl43j0MzJQ+h?=
 =?us-ascii?Q?5nFZepTwdR9qjl/DaYeY55oNN53qNnwxQzQixoSU/X77QwerVaOtYxlj5cRi?=
 =?us-ascii?Q?Kx1xXfFj+GW+ORo7MhjVdmCTnea3t+fdPTnceiDkMox35mhnqNhaVj8iRO6R?=
 =?us-ascii?Q?VekV3OLhD7Q6nLUqwZrLf9hneqIc636L+cSgZv4D4BU1nwhOX7H5PW4x/B4W?=
 =?us-ascii?Q?mqhMQkp8fafsWPUpIMp4ownx0vg0IpO2zWXfkyXPbyHXLJoPDovQSKg78Rnv?=
 =?us-ascii?Q?q9qnT8Nrrjt/7Z3OdkWASnbw/vKD0GUufYMBE5AMWWllsjRhInXY+A+2Rq+r?=
 =?us-ascii?Q?idVkxXdzxCVINfcZDIObWfi02Qhvz9gQlKLKMIZkjKDMi+GUi+8PVl1DywGI?=
 =?us-ascii?Q?V+qB5vYRCqlTBR3s7RDrpxak8r8CqgtiFNWdydyPC1+nQLz2KG5+IdUKDnGd?=
 =?us-ascii?Q?QmFTVylmLxCyV2lkWDQ3eD0mOUqsh9aqlduhOH80o3Jo+8RH6FBhycHxgYmT?=
 =?us-ascii?Q?7KPmTUw09ewf+dEdjcorcrqAb/yId/sIZjEYHsuTsdNoliyQN26fhonVsuk0?=
 =?us-ascii?Q?t6s8/C9UocqJX+Ojg7KSZ88xnSt4yG2lNRi+SDrLUwaHLVo+u6vbVjybqS7O?=
 =?us-ascii?Q?sHPFGOFLgWNhxGMPEwL9FO3O7vBFCiAtl2wkY4QY9tuwujADRLu9LyQkpVFL?=
 =?us-ascii?Q?7UCKyggdmOD7qEbs1obODJPgLzObQ84g0qvw+vO19z6JKQ3QrsinaExOkRRK?=
 =?us-ascii?Q?PPVYuFy1ESIkhyP1nu+SfbwwyDkMUg=3D=3D?=
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR20MB4782.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28afce59-546f-4c31-e386-08da81300cc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 15:40:59.8702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TR7p18dxBltCPtnKIql69tMZsPaLae5Omxw10BcXDvSmzFFrIQuPVKOo7AZthOKvboZmD3rmeXCSQyzzuwX447+LZAOppIGk8KYD6jfe2yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR20MB1563
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The libata layer is reporting correctly after the changes I submitted.
=20
The drive reports the actuator ranges as a starting LBA and a count of LBAs=
 for the range.
If the code reading the reported values simply does startingLBA + range, th=
is is an incorrect ending LBA for that actuator. This is because LBAs are z=
ero indexed and this simple addition is not taking that into account.
The proper way to get the endingLBA is startingLBA + range - 1 to get the l=
ast LBA value for where to issue a final IO read/write to account for LBA v=
alues starting at zero rather than one.
=20
Here is an example from the output in SeaChest/openSeaChest:
=3D=3D=3D=3DConcurrent Positioning Ranges=3D=3D=3D=3D
=20
Range#     #Elements            Lowest LBA          # of LBAs     =20
   0            1                                               0          =
 17578328064
   1            1                         17578328064           17578328064
=20
If using the incorrect formula to get the final LBA for actuator 0, you wou=
ld get 17578328064, but this is the starting LBA reported by the drive for =
actuator 1.
So to be consistent for all ranges, the final LBA for a given actuator shou=
ld be calculated as starting LBA + range - 1.
=20
I had reached out to Seagate's T10 and T13 representatives for clarificatio=
n and verification and this is most likely what is causing the error is a m=
issing - 1 somewhere after getting the information reported by the device. =
They agreed that the reporting from the drive and the SCSI to ATA translati=
on is correct.
=20
I'm not sure where this is being read and calculated, but it is not an erro=
r in the low-level libata or sd level of the kernel. It may be in bfq, or i=
t may be in some other place after the sd layer. I know there were some add=
itions to read this and report it up the stack, but I did not think those w=
ere wrong as they seemed to pass the drive reported information up the stac=
k.

Tyler Erickson
Seagate Technology


Seagate Internal

-----Original Message-----
From: Rory Chen <rory.c.chen@seagate.com>=20
Sent: Wednesday, August 10, 2022 6:59 AM
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Arie van der Hoeven <arie.vanderhoeven@seagate.com>; Muhammad Ahmad <mu=
hammad.ahmad@seagate.com>; linux-block@vger.kernel.org; linux-kernel@vger.k=
ernel.org; Jan Kara <jack@suse.cz>; andrea.righi@canonical.com; glen.valant=
e@linaro.org; axboe@kernel.dk; Tyler Erickson <tyler.erickson@seagate.com>;=
 Michael English <michael.english@seagate.com>; Andrew Ring <andrew.ring@se=
agate.com>; Varun Boddu <varunreddy.boddu@seagate.com>
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator d=
rives

The block trace shows the start sector is 35156656120 and transfer length i=
s 8 sectors, which is within the max LBA 35156656127 of drive. And this IO =
is completed successfully from the slice of parsed block trace though repor=
ting the warning message.
 8,64   7       13     0.039401337 19176  Q  RA 35156656120 + 8 [systemd-ud=
evd]
  8,64   7       15     0.039403946 19176  P   N [systemd-udevd]
  8,64   7       16     0.039405132 19176  I  RA 35156656120 + 8 [systemd-u=
devd]
  8,64   7       18     0.039411554 19176  D  RA 35156656120 + 8 [systemd-u=
devd]
  8,64   0       40     0.039479055     0  C  RA 35156656120 + 8 [0]

It may need to know where calculate "bio_end_sector" value as 35156656128. =
I have patched libata and sd driver for Dual Actuator.



From: Paolo Valente <paolo.valente@linaro.org>
Sent: Wednesday, August 10, 2022 6:22 PM
To: Rory Chen <rory.c.chen@seagate.com>
Cc: Arie van der Hoeven <arie.vanderhoeven@seagate.com>; Muhammad Ahmad <mu=
hammad.ahmad@seagate.com>; linux-block@vger.kernel.org <linux-block@vger.ke=
rnel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Jan=
 Kara <jack@suse.cz>; andrea.righi@canonical.com <andrea.righi@canonical.co=
m>; glen.valante@linaro.org <glen.valante@linaro.org>; axboe@kernel.dk <axb=
oe@kernel.dk>; Tyler Erickson <tyler.erickson@seagate.com>; Michael English=
 <michael.english@seagate.com>; Andrew Ring <andrew.ring@seagate.com>; Varu=
n Boddu <varunreddy.boddu@seagate.com>
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator d=
rives


This message has originated from an External Source. Please use proper judg=
ment and caution when opening attachments, clicking links, or responding to=
 this email.


> Il giorno 9 ago 2022, alle ore 05:47, Rory Chen <rory.c.chen@seagate.com>=
 ha scritto:
>
> Resend the mail as plain text because previous mail with rich text=20
> makes some mess and forget to add others at Seagate who worked on=20
> validating the patch as well(Muhammad, Michael, Andrew, Varun,Tyler)
>
> Hi Paolo,
>

Hi

> I am from Seagate China and face a problem when I'm evaluating the bfq pa=
tches. Could you please check?
> Thanks
>
> Issue statement
> When running performance test on bfq patch, I observed warning message "b=
fq_actuator_index: bio sector out of ranges: end=3D35156656128" and OS hung=
 suddenly after some hours.
> The warning message is reported from function bfq_actuator_index which de=
termines IO request is in which index of actuators.  The bio_end_sector is =
35156656128 but the max LBA for the drive is 35156656127 so it's beyond the=
 LBA range.

Yep, this sanity check fails if the end sector of a new IO does not belong =
to any sector range.

>  I captured the block trace and didn't found request LBA 35156656128 inst=
ead only found max request LBA 35156656127.

Maybe in the trace you see only start sectors?  The failed check si perform=
ed on end sectors instead.

At any rate, there seems to be an off-by-one error in the value(s) stored i=
n the sector field(s) of the blk_independent_access_range data structure.

I guess we may need some help/feedback from people competent on this stuff.

> I'm not sure if this warning message is related to later OS hung.
>

Not easy to say.  At any rate, we can try with a development version of bfq=
.  It can help us detect the possible cause of this hang.  But let's see wh=
ere we get with this sector error first.

Thank you for testing this extended version of bfq, Paolo

>
> Problem environment
> Kernel base is 5.18.9
> Test HDD drive is Seagate ST18000NM0092 dual actuator SATA.
> Actuator LBA mapping by reading VPD B9 Concurrent positioning ranges=20
> VPD page:
> LBA range number:0
> number of storage elements:1
> starting LBA:0x0
> number of LBAs:0x417c00000 [17578328064] LBA range number:1 number of=20
> storage elements:1 starting LBA:0x417c00000 number of LBAs:0x417c00000=20
> [17578328064]
>
>
>
>
>
> From: Paolo Valente <paolo.valente@linaro.org>
> Sent: Thursday, June 23, 2022 8:53 AM
> To: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>;=20
> linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>;=20
> jack@suse.cz <jack@suse.cz>; andrea.righi@canonical.com=20
> <andrea.righi@canonical.com>; glen.valante@linaro.org=20
> <glen.valante@linaro.org>; Arie van der Hoeven=20
> <arie.vanderhoeven@seagate.com>; Paolo Valente=20
> <paolo.valente@linaro.org>
> Subject: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator=20
> drives
>
>
> This message has originated from an External Source. Please use proper ju=
dgment and caution when opening attachments, clicking links, or responding =
to this email.
>
>
> Hi,
> this patch series extends BFQ so as to optimize I/O dispatch to=20
> multi-actuator drives. In particular, this extension addresses the=20
> following issue. Multi-actuator drives appear as a single device to=20
> the I/O subsystem [1].  Yet they address commands to different=20
> actuators internally, as a function of Logical Block Addressing=20
> (LBAs). A given sector is reachable by only one of the actuators. For=20
> example, Seagate's Serial Advanced Technology Attachment (SATA)=20
> version contains two actuators and maps the lower half of the SATA LBA=20
> space to the lower actuator and the upper half to the upper actuator.
>
> Evidently, to fully utilize actuators, no actuator must be left idle=20
> or underutilized while there is pending I/O for it. To reach this=20
> goal, the block layer must somehow control the load of each actuator=20
> individually. This series enriches BFQ with such a per-actuator=20
> control, as a first step. Then it also adds a simple mechanism for=20
> guaranteeing that actuators with pending I/O are never left idle.
>
> See [1] for a more detailed overview of the problem and of the=20
> solutions implemented in this patch series. There you will also find=20
> some preliminary performance results.
>
> Thanks,
> Paolo
>
> [1]=20
> https://secure-web.cisco.com/1hcxnN1C3h1nW7mby7S66_LE8szirQwbQI0fBpYeP
> rA0GTWfyuQyl0GpZaOn32xMSkNT0BUQWloDHFzZ23aYDZdi8NfdrEFLY9pQDBblIvn08LR
> iTVoIOUC8zWSG_r2PCyLtx3ppZq5cWOib_8azxteRRcbKWGdbLPSqg9hfSJSqltth0ByLO
> NHEoI3p3e9QNIn6nVAeQbsT3aOQe-F95XrQvaPrFJXx6RGL9kDXyfkbXIHcdcLBf895gYB
> Fn5S2WjBDQq2kzDzZOlc1HekRUhg0qDQcFY6NydVfrqNfLbpAHAth6KyREscQhVTMVREEV
> a1b6bQByX6grF5pn3pTIo0lODyfX6yRmcbReSYNfOZ65ZPvp-nH530FQ-5nXoRxFf74WIK
> DrNTALs3xQvg03DH4jLez-T2M9xEu-sfEDAEdTGF7BcnmBW6vrPO4_p3k4/https%3A%2F
> %2Fwww.linaro.org%2Fblog%2Fbudget-fair-queueing-bfq-linux-io-scheduler
> -optimizations-for-multi-actuator-sata-hard-drives%2F
>
> Davide Zini (3):
>  block, bfq: split also async bfq_queues on a per-actuator basis =20
> block, bfq: inject I/O to underutilized actuators  block, bfq: balance=20
> I/O injection among underutilized actuators
>
> Federico Gavioli (1):
>  block, bfq: retrieve independent access ranges from request queue
>
> Paolo Valente (4):
>  block, bfq: split sync bfq_queues on a per-actuator basis  block,=20
> bfq: forbid stable merging of queues associated with different
>    actuators
>  block, bfq: turn scalar fields into arrays in bfq_io_cq  block, bfq:=20
> turn BFQ_NUM_ACTUATORS into BFQ_MAX_ACTUATORS
>
> block/bfq-cgroup.c  |  97 +++++----
> block/bfq-iosched.c | 488 +++++++++++++++++++++++++++++---------------
> block/bfq-iosched.h | 149 ++++++++++----
> block/bfq-wf2q.c    |   2 +-
> 4 files changed, 493 insertions(+), 243 deletions(-)
>
> --
> 2.20.1
>
>
> Seagate Internal
>
> Seagate Internal

Seagate Internal
