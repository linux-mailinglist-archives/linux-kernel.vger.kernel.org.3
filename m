Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D1E57E842
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiGVUW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiGVUWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:22:52 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88E8326FE;
        Fri, 22 Jul 2022 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658521371; x=1690057371;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3LWLWI3YHq4hozRUubEEnbF+hfpkbtvGhtyQdZdsatU=;
  b=NS3NhgzMRZOSU7pbnF/i3CyBWYPHiYYzcE7Dbgn3IUFLMLOFzYrJoh++
   HV1U8OG8xaRQEGP7W8Iq4ph1VAuCT3EulOY0PzBWswqsWnbd5PsllgMRH
   Sw3sMylrB/dHDh3SdTqpBB5ZlmO64fOOjKoVLVp7/K86J/RAi+Me9o7dg
   PfE5jM+6RIhYdURKFUxCcbHHa17USlVSkAt9jPnkgLIw6ayOGDsfZvaKF
   vL3A+UBqeLf3NKBwHksAYe5f/mEWWQPxB65E7j93AP9TFYIzaW6PvxqBI
   WN60nGlPhkl1YciYi+04dp/3xkTiwjutEzKvTeivaIgtwVh0rRTXpgRRC
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,186,1654531200"; 
   d="scan'208";a="311004002"
Received: from mail-sn1anam02lp2042.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.42])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jul 2022 04:22:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B31obJ9lgcY6i5FytW7HOPEZxBtkqcHtfbYbDbe4Y+FJb0Vb2Ty/CthVxlS4+t4FyyEnUJRb1owzgncYX2FNccf4OmazFJjbb4lzqjSq9JarJ+Owth826tY4NnMNqfLIq71dl93sfz4iICySXt/mOH+Km6bJhYID213a4m/QZmoJOZCGrXMs6GXLeDuxHD3KZvb/MXRlHfDSRyBnXJDDTaeVsAXwJnIPVf+wT54fwxXU0qkK+zvitJROPxyUOYEkiFu0B/kfc5lHLr+4Pm2Iu0MVIl3JM3o8MZQACqJjMwa/l5WtScz7yvABc4wBrYzOhFH6xw5CcAlll/3CSBtRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LWLWI3YHq4hozRUubEEnbF+hfpkbtvGhtyQdZdsatU=;
 b=Sj36UNcFSOZVcP/yF7shTLxszea5R/k2Oz8d4bARzKjPC/hyuNe9AK0rFF1dyvc1oJZW9/DRLh+/HaUC66Ap1wkS2Ik5pLaPT1ICQIsH4zP8c9ki4AvooR/bM1st2yeK9dfixmE23F0SN5wWFZyDJhiIgmR4Qjyzbcut5WwwyTFMLkkBtmbQ7aInEjyGTVL6TO/nFhl5iSXnJ6sROKMClKNGEZmB0dMgH07IEfEaHh+/l5fGu0GpFd34pNRXemRfVscRYUI+yOSlXupgxOB53ntEq3y2n6BqqWsX1Xi2xaPZu35UG+iJOGe7P0yM52bv2zexJSTZpoUeRfewbmPXFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LWLWI3YHq4hozRUubEEnbF+hfpkbtvGhtyQdZdsatU=;
 b=gMEJYHvYA3UydH+Vv+Oyfy4P+EZBFFzSL67qEFRVN7lDEq7gwXpYMLYo7HPZzfc4I5YhxWK7BRr2VP/O06UroI8VmKAsgKm+r78aJrF0s62ZupKqB0lpGRk7k+BGU5Qcq8EPk6/39fRqg7xy0EdPXfSzWtrRkJDXn3KHIPXO5v4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM5PR04MB0586.namprd04.prod.outlook.com (2603:10b6:3:a1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Fri, 22 Jul 2022 20:22:47 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%8]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 20:22:47 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>,
        Can Guo <quic_cang@quicinc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Thread-Topic: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Thread-Index: AQHYmz2OvInxSH8TlUq8qOHvad4nHq2IiDZAgAIkFwCAACFbcIAAC0KAgAABy4A=
Date:   Fri, 22 Jul 2022 20:22:47 +0000
Message-ID: <DM6PR04MB6575FDB764DDA0047B4D08E6FC909@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
 <DM6PR04MB65750EE12401C4F69B352E5CFC909@DM6PR04MB6575.namprd04.prod.outlook.com>
 <4838bb09-d5a8-9b6a-9011-5394b8869695@quicinc.com>
 <DM6PR04MB6575B4E2707200BDFFEE4A08FC909@DM6PR04MB6575.namprd04.prod.outlook.com>
 <34bd42f1-bf2e-854f-90ba-174db7c68adc@quicinc.com>
In-Reply-To: <34bd42f1-bf2e-854f-90ba-174db7c68adc@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1aff5364-a425-41a4-b7dd-08da6c1ff13b
x-ms-traffictypediagnostic: DM5PR04MB0586:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CKVFlNVaXt5N6mSp3oqO4lpcyOmA7Gsx3zhVJNA3AH4yFBmjdG5RfKTkK21H9t8s8u2AnZhoIswU9HvkNRRr9kSynZSbLA/U29u5yYodCO/5EqJ6HB4zNuTED2jaMom8t5FdNHD5aHtQYepleI2brqyph/AHZ/3cLhWkpB4rrzw1yjy05k1m8sUHY+GFefNfjTRUt4xlGoXt0MqD9JczjS97gLVJItiPDTjfd8CGUhkM6bYaxSYnnqAB4WhXqvsdBquKSuNuK7X+h91atLWbUHVqfpuEGPjhGV5fpRymMig82w9hTfzwcXhfa7nTGfJ61XnoWPtjxfL6xAEOyAdjgcMA/0PAEnrMRfIf5D1WGud/PnkgcKqDlniKiXcy7uSR2GNdx+s8gNHTEeH8XsVGXG93ilCVNyS/2XEISFIaEhbqcy48juU/JSnc6EAI6lhZ+iXNKVaCk35+3XN9kuxp5iZ0T6K9ejUCxDDAJDfU0MBDLKzpl12WhJgzMj+zpAIsivpq/68Fe+ByYHkbX5pwudMsUaJyDVckRzD5ONYF7gKjK/nKhGfHSIjgL3uNxPrjNLr4wE11PvK5koRFrxIPmsv/JDKOJb2haXsLcY0dvy5npMKbr6p8265wl0Z5Ifm+Sr8z7tz6IrL2T4dhCqAXXlc0+hqkWi6s5yhRhvaRsg+g4DmH+htQt78cxJSfc0mfzpMPQMD+LLO3aBl3jjcu/krMeqUPDJDCeN93XxA+BRm7734Rq5IGvj2jUPWFMcolTkyY2wrBHuvYMym2k1Wg2CWiNDRAUdVjjD5drgHgH4tUP4HnwC/gM2vLqRSjdw2Z8d88jQZzlHY5x3VocG7I5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(38070700005)(86362001)(921005)(4326008)(82960400001)(66476007)(38100700002)(66446008)(122000001)(8676002)(66946007)(55016003)(64756008)(316002)(66556008)(2906002)(9686003)(8936002)(54906003)(4744005)(6506007)(26005)(7416002)(7696005)(110136005)(41300700001)(478600001)(71200400001)(186003)(76116006)(5660300002)(53546011)(33656002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFB3VVJXNjh1U1dYZTlLcXdxMzJWR05PdXVSOU5rNDBwTDNLYTdldmgrRGJp?=
 =?utf-8?B?TjZIVUk4Z0tNcEF5RFJvYkIweGhhVTZFM1RWdlB4aHFDQVo0OVAxc1JQSjFW?=
 =?utf-8?B?dUlhakw0R3NLL0lUckN6amhGNnNkQmFmZ1kwdEo5QW5xUEZ0SnhGL3hmcFlG?=
 =?utf-8?B?Zk1Da0Q2am4vbllrV0RjU0k2bXQzNVVTeTF2aUt1dXl3Ym5mVmVjMHpWdDNI?=
 =?utf-8?B?WmZXU1hWTm12b2Q4eUJ5RTQ0YmwwT1VCdmNITHFMME1uVnpzR1FzSjVvVkRy?=
 =?utf-8?B?Zk1CZDVnVnJIeVJ6U1hNd1hHd0lnc0FpSks0VURnd3BWUU5MeXJFMm9wZG4z?=
 =?utf-8?B?L3ZWdTNPRWVuR2VueXdmZ1loSnRobmJSdWxGdDNBTXRuL0JaNUgwc1ZYQ3hU?=
 =?utf-8?B?ODU5MmVNQWRCam4rYjllaDZ5OXVwQUt4SWVPM21KRThEVWR4eW91RE1ONEhl?=
 =?utf-8?B?SHN3UTZORnMvQkJKNmlvZWpaQXNGeDBJSDlIalgxT1lOWlk4OVREZTAwd0Fv?=
 =?utf-8?B?V0dBVzA5cURESUQvbWMxNkI0SlYzV01UbDV0Z3kralhUWWIvZmcwN1ErdFVJ?=
 =?utf-8?B?UGRtaUJRMmIyemNRY3dqZGhHUTRkVTBUYzJ0bWxFYkFSK2FTOE1iSjJRMEd2?=
 =?utf-8?B?M3JwVG1oTmI4THpiK0VGR2oxaFNEWmduZlBXbFFiQlMxc0VLTy9EZk9TTklp?=
 =?utf-8?B?NEtCQks1MTVGS2ptZHNIRDM0eEhSUFVGM01DVVdGVzVzc2o3SmlCWUtZWm9i?=
 =?utf-8?B?QkxKNkZtTzViVWZZT2RvRzlBcTc4cTI5akpRVkJkQjloazhPZzRwa295OFhF?=
 =?utf-8?B?a0ZYd0pqVkU0K2dOYjJPYmxzemVSeFVVcTkzNDhFZ01zTGtaM29UbFFSWElS?=
 =?utf-8?B?NzEzbmlCeUNEWkdWVFVMSnVPcG50R2tZcHVkb0FpVFRyenpFVTNPSFRIeitT?=
 =?utf-8?B?SFRDODY1d3RhWFRMUmVFTHlieThmdDdOclVWOHI3OWJjNDA2N3dZNGFTWEVP?=
 =?utf-8?B?cGtwMURySDhhRzV4a1NVaVF2VjdveVB5VThLcG5mc0xjZ001TTZNY3pVblZs?=
 =?utf-8?B?cFRzU2x3UERzQXlLYmh1UnJXdHZHTDJLV3MwVTgxT3NtaUIxSmw5azR3RkdF?=
 =?utf-8?B?emo0TEU0dnAxYU9hNmxDNG5zL1VQTmcyQllsSktuWElYNjZrTDJtTFNMdU1z?=
 =?utf-8?B?YlJIMG9lZ1BmeSt5V3FQeHlLY0UweC9VWkJoeExvMGh0MVBMNC9VdXVTL3V5?=
 =?utf-8?B?a0Jqc20vSGt1ejhDZHErVHFqeENTdjh2UThSRTVsT0ZmZWNsVVdtMnZxYkRO?=
 =?utf-8?B?bnN1c3BMYy9HMVhvVk55eWZFdzBFdGdkejhVZkpoakdWSmJubm1jQTdiYUpm?=
 =?utf-8?B?a3kybFRSd1JZVTlXd0w3TzRJdkd3OVhZQmQyU0VmckFMVTRGTkpIWjkrQmxR?=
 =?utf-8?B?Wm96OEFoOXdUOUtmbEtUNGpaOE8rZ2dhTzIrVHVFN2N2eEd4MkdNZEVxVjMr?=
 =?utf-8?B?MFpKYWhWcU5iWk15N2M2a0FuTXEwcUJ0SDFVTDR0TkVzelJNVS81cFdrbnpV?=
 =?utf-8?B?TWVndFd2UWx3YnZNbmprcjV1OGNQZTJoOXhjN2VHRnJtY2p1Sy9GdjVtRUxw?=
 =?utf-8?B?ZFhpN1puZndzMGExeS9KU0Uyc05GRjhhYUtna1o5RU0wMFN6SHk2cWZGK0Yy?=
 =?utf-8?B?cWl1K2E2eEhvSXdCU1NWMFFqQitYaWhZb3h1UXA3bVg0RStXSkhhOUdGN1g2?=
 =?utf-8?B?bkg5ZmRLMCtMRXdTd2hWam1aRFkxWUVnd2ZZdnVKVmtUN2lnU1QrSUZScjFX?=
 =?utf-8?B?TERLV0JSQVpsVy9zTTZDL0J2dmNnRmZaNDJCRTRBd2p1d05jajlGaW90UkZ4?=
 =?utf-8?B?Mk9Ka1JFTnlWNnVuRkxndVdMaUNaazRqQWg0S0U1Nk9wWE9JR2FvU01Pb0xs?=
 =?utf-8?B?dHJGZTdxMW9HZi9UdGVhcnVueFVIdHRnTDJyUlZ3QWw1VDZCZW9KdVo5Vnps?=
 =?utf-8?B?Y2tUR0g0U3FpY1VlTmx0UEtQNzdlSFc2MmJlQTJYZ2R2OS8rQkovRjlvWDAv?=
 =?utf-8?B?ZkZrU0VxQ0tlTmV4SEZQcURMcmJiQU1rL2Z1enFoSi9YN0Y1R1h5VnlBd1Rs?=
 =?utf-8?Q?G/VF2XXmwF0IAqcvPAYpTQDiI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aff5364-a425-41a4-b7dd-08da6c1ff13b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 20:22:47.3042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0+gaOXXwZVQ3JIjQbZBX1+ktyr6oQTKJMf9V5gsSAs/ygFIQyimYKfozpkoz66+p/UmhXBbwvvNNpf/Of2XKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0586
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBPbiA3LzIyLzIwMjIgMTI6MzcgUE0sIEF2cmkgQWx0bWFuIHdyb3RlOg0KPiA+Pj4+ICsN
Cj4gPj4+PiArICAgICAgIC8qIE1hbnVhbGx5IGFsbG9jYXRlIE1DUSByZXNvdXJjZSAqLw0KPiA+
Pj4gRGlkIHlvdSBjb25zaWRlciB0byBmb3JjZSBwcm92aWRpbmcgdGhlIE1DUSBjb25maWd1cmF0
aW9uPw0KPiA+IEhvdyBhYm91dCB0aGlzIG9uZT8NCj4gPg0KPiBTb3JyeSBtaXNzZWQgdGhpcyBj
b21tZW50Lg0KPiBEbyB5b3UgbWVhbiB0byByZXR1cm4gZXJyb3IgaWYgTUNRIGNvbmZpZ3VyYXRp
b24gaXMgdW5kZWZpbmVkPw0KWWVzLiBJdCdzIGxpa2UgYW4gdW5zZXQgcGxhdGZvcm0gY2FwYWJp
bGl0eS4NCg0KVGhhbmtzLA0KQXZyaQ0KPiANCj4gLWFzZA0K
