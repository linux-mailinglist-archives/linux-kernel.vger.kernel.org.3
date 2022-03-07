Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAC44CFDF6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239410AbiCGMST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237847AbiCGMSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:18:10 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CAC7F6EA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646655437; x=1678191437;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ocP83Lv65VfMns2FHy82ZZFOYKcIsGxE5HRKL9z6+04=;
  b=omP+gQZrdzO2IgxDbFx+5MmIwpKrYDuUtNq9cX+Zg+wmPn2vINff3HZJ
   OwcdrFhNCI5wfNDy8QubEKE9JPXWO47ZHBWrxI6/3hX1pj6S4uJOiYDWd
   97xQt87u2lDSGKAcBAgqR36l55Xvh7Rf52LU9qY9dWjgeU1IWLOvozAtN
   7SrypVXjY7L1JZHQkP3TO4vbeXAN1sA7zDxKIZmcfgZ/9wCg/ltpVPYPi
   W+cuUAauvl08NUiPbrP/mNyva8pZdIEi6cAP/HpDgkZP+aWXio80c2HVi
   q6dmf1d7y4ZplqdN2EPiwVw01zJgi7fiDBpLYXnSJ8RDt+QtpF9o+zfk7
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="148320274"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 05:17:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 05:17:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 05:17:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mysqtvFnT8E9ab680NotPBmmSa6pr4yjNniy3sky2ZyMoYV1AduXPLhCX33Z7JwOg2PXCzyDJxgl+X9m7EHjtj12sAuMYKGWSv/krReMwRIZcp31LU3lf41i4SWPVbD/kv4bgLVeUPVkbBE+zFRTjADJvS61n+3hvv2354wSIfaurat8djsVDKQ7LpNjpL47jgcSAMdFcHJkjjMR1nFIb/N4tYdRIklL9ZxQ5hlwIm8solCit9YGsh25BmwE67risdCu7cz+xlT0uMSnjBHOGeVBm3xbnRMoIQ20a7nG0blK4aJfDwcNJOnSLuKLANiRYSn1UqM9LwSvbStqwQDRmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocP83Lv65VfMns2FHy82ZZFOYKcIsGxE5HRKL9z6+04=;
 b=B2NFTScMRM3rncJsoULHs/SgFGC/vW1KzKc5AOd4+EnEh3xdlAH0ABrjw2p6yDzlmLqHPap0Dv/6/hwLjKX81pA9ekFeIFa/ORDQNvQ88cM0Rh5Yh4ERYEBMW9UzUQvskwonHEwThgPkV5pOrs/v8fHovM0VyzWDV1tJ4eMb4iKOTQ9r0LpI4z5toqLj+24ZijLhimTyNGV7FaFHnyvgCLYyR9RiuMyg+s95xKbeKpR7HQ7ut8kKGd+Cg13mOyrOAmecnj0aStUvdaawsS4T9ay/DsoB8G/VphgGwvRh/exqzjl5cuU0szDoB3y5a/DgdcQpWYXpstBEjZ6crWV0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocP83Lv65VfMns2FHy82ZZFOYKcIsGxE5HRKL9z6+04=;
 b=BWq4h3RQjugCrXJeeOkbZtSQDWRGMrIHcNwIJtBMZbBDsSNzn3LYmAtsDk7wYDKiwD+/WFjIBCHF5X7Vg45uyBUPl/WcSzfHoWo8u5pUR+dOwg1fNhMIesZA5nz3GZXiGKLbiUtLPIUmmee2XgTlSkTA2+zOaRJRzbVxrgUAG6s=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by DM8PR11MB5606.namprd11.prod.outlook.com (2603:10b6:8:3c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Mon, 7 Mar
 2022 12:17:09 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%5]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 12:17:09 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] clocksource/drivers/timer-microchip-pit64b: fixes
 and improvements
Thread-Topic: [PATCH v3 0/6] clocksource/drivers/timer-microchip-pit64b: fixes
 and improvements
Thread-Index: AQHYMh1EpDbaU3vZq0qpAhbgnNNKbw==
Date:   Mon, 7 Mar 2022 12:17:09 +0000
Message-ID: <9ddefe16-c782-1edd-a903-f68f1150b606@microchip.com>
References: <20220304133601.2404086-1-claudiu.beznea@microchip.com>
 <80f949af-ddab-b54d-b6ee-0fbcb1f74b51@linaro.org>
In-Reply-To: <80f949af-ddab-b54d-b6ee-0fbcb1f74b51@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27b62ac9-bd18-4c62-af30-08da0034672d
x-ms-traffictypediagnostic: DM8PR11MB5606:EE_
x-microsoft-antispam-prvs: <DM8PR11MB56063CD160C980C2998F617B87089@DM8PR11MB5606.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FFJil08pI29pI5Itk7H0nk2BuJU3bWQA9NmHmAyu1ulcuwQuHpaugpyKePy3kqBXjZPgIJ/gyiIM8ckmX6A/R4bDAd77hXvnKjJGRRQTltnBxEZNzw7lHPeLxt8pFc7a/M6walFsAp65zcU6OVP5m91WxxG/I9mC/m4QKjGiygfMFFjKWze9vyYeeOjzy5GJIsE0NXKDD8DavhzwHNv9pWk2vfDEqfMWoApkNrjugo8ynv2UphfkrQrExa8FVkfhEiUWNMqhnlzR1AwB9CdWcvwA+GfUvJdQEmTc1Ujr8rGNnAIs5lqG9ko5KfhzJZ304s2Si4iHLlkfgPh3m8iqcPEX9AWa6KrwmXqJuNCsHHc4RE+rGGOCz9eKZR6ZrP48BLbnOz726FtyMDpyeYJPc7lm+gyhxq2BwaG7mh+ZFyClx5sqbcyNNgF8VslfSBQG8r+zAq7JUWS9WlkOzqVTI85JyuE5PVPVmqZRTtvbRRRxE8W4Eme/JoWAQFSa9IlSY+xRFZdJxOJ6S/RbqgMZdW7FT1fURVGi//hPIFftqd9LaAH5i1ipTNZ7Qla1z4wBYnvm07OTNjx5xeixfo/PNx6woDIR2cDIs2cejOiZBdrLfcWXT6eUp2zPX+MnjI8d7ElzEUTTbRQ39gv34bI7bICm27h+mgDfTmTgkObuavy840fVKhanx9iWFMpjscpSSmprKigjiLxWrrke3Y54NEFKxweIXtJJDIMXYjKqJMLo6tNSDTxyzXyeXJgbORVPvDSMAC/281dBnUO8Q6iPxrx3yMSq7Pi6SNlhExziXLjji6GW+Pb6Qax9lhI3NlO1I2vZHkSPf1m5tLrISA3qopsE20qJ6sHLXh3VOk8QdYkc9ucovSyqg7WBpYVXXiQg7/BL7LC+yCgBdEh4ikSQ8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(966005)(6486002)(71200400001)(26005)(508600001)(2616005)(186003)(6512007)(53546011)(86362001)(6506007)(38070700005)(83380400001)(38100700002)(122000001)(8936002)(5660300002)(31686004)(66946007)(8676002)(66476007)(66446008)(64756008)(76116006)(66556008)(4326008)(36756003)(2906002)(54906003)(110136005)(316002)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aU54cWdsbDgwTHArNS9ubHJLTmdmektXSkhpYmQ1RWNIVnVWREZ4UFQwYzA2?=
 =?utf-8?B?cmovczYxaW5tWXEvVElCUFNBbVBhWXA4TE5rTVpwOW9KVzFXSzJITWRxWHU5?=
 =?utf-8?B?RE1yajZOTU1QY2ZHWFNtK0o0YndveHVoVW13V0VkSGZVOG1rOVAyRVhLQ0FV?=
 =?utf-8?B?WVNJWlJJWENRNjZxK1RwK1ljeDVVREU2d3JqVS9ad1YxWWpXdWxqR0VCSmVX?=
 =?utf-8?B?RDVuWjc3bzNicDVvUm5vTUJ0M2pvWVB1b3cxb3h2b3QyeGdwTnVWQUhmY3dK?=
 =?utf-8?B?bmZsTWxoTFFwSi9NV1NkQklJbnpvd0oxZnExVW9hWUdSamd4b3d6eXFkWWJ6?=
 =?utf-8?B?SEVveGc2WUo1Q1hGL2kzanZZQjNLOCtOd0s5c0FvL3pWQ0FrOXBTcXAraGh0?=
 =?utf-8?B?a00wYVJQRWFRY1NOS2pNNHJMdHROWGZSUEtiU0Rqb3ZGcFBQZytPSHFTVTZI?=
 =?utf-8?B?aWZRaHRUb2VpMy9SS280TDV1bEdTam1RNE1yZTRVUGtmWk9mZ3J0Y3F2RmFl?=
 =?utf-8?B?Y2pMZ2RQS2tEdmdOZ0U4M3QwNmdCTGFLZGZ0OXhLRng5ajM1TFFzT1ZkWW15?=
 =?utf-8?B?WGFmQUtRanVSY1k4eUxDNTZFTnNRNTVyMkRHN2tIRDE4V1ErRk01RzZCTFI3?=
 =?utf-8?B?R0FIMWd5MWRZcjBSZG9oM093ZVdPU013QXB0d2xhWVhjNTF4d2NSUExKKzJ3?=
 =?utf-8?B?MWxPendZMW5kSUc0cFpETERDTW5LaEJzZjV6aEZKYnh6VHNLeGd1dmgrUy9l?=
 =?utf-8?B?OHFCdmhvZ1ZYS1JURkZhVzdWQkxHbEZaa0ZZbEFOMzYzTEZnZkFiT0toTDN5?=
 =?utf-8?B?OC8vQzNYbVVBQWt1cFNoNDdNNkdBaDNLUVV5L0VVMU1GdEhlOWhtNmdnTXBX?=
 =?utf-8?B?TlVOOER0aTFPck1BckRQb3dwN2g4UW1rS1JUbkJHNkpOUkZPMTE2V012YXR4?=
 =?utf-8?B?U0pwYzI0Wm9mOFJmejR1UWFxcERsakY3RkN2YnozdEM1TEVqeEpTWXkvUmJC?=
 =?utf-8?B?R2trVld6Z3JBS0tZUkJmOWg1VWtwUTZnM1UrM0QrV0pNRlFMdkMxMGkxcHZ4?=
 =?utf-8?B?SlFUYVhGaVh0RXd0TGl4cFgxSkUrcGZkNmNUWFhGNDdEenFwcTdCUllva1Zk?=
 =?utf-8?B?N2NSMXZxMjRKcTRKTE5MTE9oazNMSW1sMktSZlB0cHc5VmFHZXhhcUVOU1p6?=
 =?utf-8?B?TUpnMTE1TWladUlWaExOVDdxQlVhRVluTjFkeE9aSVQvdWp0N2V4RnVkUWpM?=
 =?utf-8?B?c3JURnF6M3JLbVpWOU1EeERQcU4wamFuV0E1R0lMSkFkQjB4VFBxeFNmQnpn?=
 =?utf-8?B?YW9JZ05JSWFFUzhFd2trSGU5L2lFSGNBMGllLzJkb1BVMFVBSFZYTHVCZHVQ?=
 =?utf-8?B?eGMzSEpqaE1hSXV4REh6UXdzT0UwWkZCR0s1bmtHMU9GS2kyZzF0c3U0RFRH?=
 =?utf-8?B?dU4reUpTR0s4NVJ2UHFITEZiVFBuZm5QcU1mM011VnZ5cnFIUDUrQmVNeTJZ?=
 =?utf-8?B?dGE2RFRGQ1QyRkdpZ0RocmU4ZzlJTG1mcnk2dHFMUEF4TlduM1J1c3BLNkxH?=
 =?utf-8?B?NEUybXhOaUphNk43NGpFbHNxZnArNUVXZFVBMHU3WGJ2RDB6K3pFdTVoLzZF?=
 =?utf-8?B?cmxhTlpIRGM0NDlUUUxQUUd5MC9ZbnBpdUQ2dmFPUlpqVTVhTkd2SFBMaDZL?=
 =?utf-8?B?Z3ZRS2Z0ejNIaXVRV3RDUFkySWhaeTNpcGVsbi8rbTZ3aWh0MktaakM2K3pH?=
 =?utf-8?B?aTBxbzZGRnUydEJyMndSZy9Oai8rWFlxYVAxcFFiSnlEeTgwL3RCa2NjbTdN?=
 =?utf-8?B?QVhjd0xBeGZXMjMxbDZ6MEdiU1F2dGU2Z09lVktyNHVLcEJTbHpxaDc2NkVE?=
 =?utf-8?B?RVZrY3RTUElzTmNGd24wQW5kRlM4QVRSL0VFSEhVSXlHSEppZ0xXSUxQV1My?=
 =?utf-8?B?QUJneFBES2RLUVVjOVpwZWxtcnN2d1FwQXZlNTdLSVBCUjFOTzhNdE8zQzBY?=
 =?utf-8?B?d1lQSm8vN3FqUlpVYnJiZ1BHOHFDMXk4QkFvbGZJUTlIOHR1RDIyTU92RlYz?=
 =?utf-8?B?WWo4U3lTNWF1SnJqc3NCVSs5UGJuUDlhWDU3MUNDTGI2Zm43WDhLR1NKWUE3?=
 =?utf-8?B?aHRIcElBZTcyWVhGWlhwclR1VmJBR1pmSEZkRlNubE9Md3VWRUVnaVk3QmdH?=
 =?utf-8?B?aTMwWkNOZnlPV3pqWkdWaUdIZ2syZ2lCS1dJZ0dsTk5JT1ZIcDRQWm0rN254?=
 =?utf-8?B?QmJNMFFLYkI3U0tPNnVXME5maXpBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C25E3353CD8B75479863A45F714BF847@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b62ac9-bd18-4c62-af30-08da0034672d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 12:17:09.4912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oulXxbUM9+M1/0U54BD0bGxHi8YmakhC9pHF66awXBPiZM/QCQ/sWThjAeKzheT2F43DOqr/2b7ZoUlwtDy9y/3C0+4+n5dfhFzIFMiVIZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5606
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDMuMjAyMiAyMTo0NiwgRGFuaWVsIExlemNhbm8gd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlDQo+IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgQ2xhdWRpdSwNCj4gDQo+IEkgd291
bGQgbGlrZSB0byBwaWNrIHBhdGNoZXMgMSwyLDMgYnV0IG5vdCB0aGUgb3RoZXJzIG9uZSBiZWNh
dXNlIEknbQ0KPiBub3QgY29udmluY2VkIGFib3V0IHRoZSBzdXNwZW5kIC8gcmVzdW1lIGNoYW5n
ZXMgYW5kIG5lZWQgc29tZSB0aW1lIHRvDQo+IHRoaW5rIGFib3V0IGl0Lg0KSGkgRGFuaWVsLA0K
DQpTdXJlIQ0KDQpKdXN0IHRvIGxldCB5b3Uga25vdywgSSd2ZSB0ZXN0ZWQgaXQgb24gc3VzcGVu
ZC9yZXN1bWUgc2NlbmFyaW9zIChzb21lIG9mDQp0aGUgc2NlbmFyaW9zIHdlcmUgY3V0dGluZyBk
b3duIHRoZSBwb3dlciB0byBQSVQ2NEIgYmxvY2tzKSBhbmQgb24gYSBzeXN0ZW0NCmhhdmluZyBi
b3RoIFBJVDY0QiBhbmQgQVJNIGdlbmVyaWMgdGltZXIgZW5hYmxlZC4NCg0KVGhhbmsgeW91LA0K
Q2xhdWRpdSBCZXpuZWENCg0KPiANCj4gwqAgLS0gRC4NCj4gDQo+IA0KPiBPbiAwNC8wMy8yMDIy
IDE0OjM1LCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IEhpLA0KPj4NCj4+IFRoZSBzZXJpZXMg
YWRkcyBvbmUgZml4IGFuZCBmZXcgaW1wcm92ZW1lbnQgZm9yIFBJVDY0QiB0aW1lci4gUGF0Y2gg
MS83DQo+PiB3YXMgaW5pdGlhbGx5IHBvc3RlZCBhdCBbMV0uDQo+Pg0KPj4gVGhhbmsgeW91LA0K
Pj4gQ2xhdWRpdSBCZXpuZWENCj4+DQo+PiBbMV0NCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xrbWwvMjAyMTA3MDcwNTQ0MTUuOTI4MzItMS1jbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29t
Lw0KPj4NCj4+DQo+PiBDaGFuZ2VzIGluIHYzOg0KPj4gLSByZW1vdmVkIHBhdGNoICJjbG9ja3Nv
dXJjZS9kcml2ZXJzL3RpbWVyLW1pY3JvY2hpcC1waXQ2NGI6IHJlbW92ZQ0KPj4gdGltZXItb2Yg
ZGVwZW5lbmN5Ig0KPj4gwqDCoCBhcyBpdCBicmVha3MgYnVpbGQgb24gb3RoZXIgcGxhdGZvcm1z
DQo+PiAtIGFkYXB0IHBhdGNoIDYvNiB0byBjb21wbHkgd2l0aCBrZXJuZWwtZG9jIHNwZWNpZmlj
YXRpb24NCj4+DQo+PiBDaGFuZ2VzIGluIHYyOg0KPj4gLSByZW1vdmVkIHBhdGNoIDUvNyAiY2xv
Y2tzb3VyY2UvZHJpdmVycy90aW1lci1taWNyb2NoaXAtcGl0NjRiOiBhZGQNCj4+IGRlbGF5IHRp
bWVyIg0KPj4gwqDCoCB0byBhdm9pZCBjb21waWxhdGlvbiBlcnJvcnMgb24gbm9uIEFSTSBwbGF0
Zm9ybXM7IHdpbGwgcmUtaW50cm9kdWNlIGl0DQo+PiBhZnRlcg0KPj4gwqDCoCBhIGJpdCBvZiBy
ZXdvcmsgb24gQVQ5MSBzcGVjaWZpYyBLY29uZmlnDQo+PiAtIGFkZGVkIHBhdGNoICJjbG9ja3Nv
dXJjZS9kcml2ZXJzL3RpbWVyLW1pY3JvY2hpcC1waXQ2NGI6IGZpeA0KPj4gY29tcGlsYXRpb24g
d2FybmluZ3MiDQo+PiAtIGluIHBhdGNoICJjbG9ja3NvdXJjZS9kcml2ZXJzL3RpbWVyLW1pY3Jv
Y2hpcC1waXQ2NGI6IHVzZQ0KPj4gbWNocF9waXQ2NGJfe3N1c3BlbmQsDQo+PiDCoMKgIHJlc3Vt
ZX0iIHJlbW92ZSBnY2xrX3VucHJlcGFyZSwgcGNsa191bnByZXBhcmUgbGFiZWxzIGFuZCBjb2Rl
IHVuZGVyIHRoZW0NCj4+DQo+Pg0KPj4gQ2xhdWRpdSBCZXpuZWEgKDYpOg0KPj4gwqDCoCBjbG9j
a3NvdXJjZS9kcml2ZXJzL3RpbWVyLW1pY3JvY2hpcC1waXQ2NGI6IHJlbW92ZSBtbWlvIHNlbGVj
dGlvbg0KPj4gwqDCoCBjbG9ja3NvdXJjZS9kcml2ZXJzL3RpbWVyLW1pY3JvY2hpcC1waXQ2NGI6
IHVzZSBub3RyYWNlDQo+PiDCoMKgIGNsb2Nrc291cmNlL2RyaXZlcnMvdGltZXItbWljcm9jaGlw
LXBpdDY0YjogdXNlIDVNSHogZm9yIGNsb2NrZXZlbnQNCj4+IMKgwqAgY2xvY2tzb3VyY2UvZHJp
dmVycy90aW1lci1taWNyb2NoaXAtcGl0NjRiOiByZW1vdmUgc3VzcGVuZC9yZXN1bWUgb3BzDQo+
PiDCoMKgwqDCoCBmb3IgY2UNCj4+IMKgwqAgY2xvY2tzb3VyY2UvZHJpdmVycy90aW1lci1taWNy
b2NoaXAtcGl0NjRiOiB1c2UgbWNocF9waXQ2NGJfe3N1c3BlbmQsDQo+PiDCoMKgwqDCoCByZXN1
bWV9DQo+PiDCoMKgIGNsb2Nrc291cmNlL2RyaXZlcnMvdGltZXItbWljcm9jaGlwLXBpdDY0Yjog
Zml4IGNvbXBpbGF0aW9uIHdhcm5pbmdzDQo+Pg0KPj4gwqAgZHJpdmVycy9jbG9ja3NvdXJjZS9L
Y29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSAtDQo+PiDCoCBk
cml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLW1pY3JvY2hpcC1waXQ2NGIuYyB8IDcyICsrKysrKysr
LS0tLS0tLS0tLS0tDQo+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDQz
IGRlbGV0aW9ucygtKQ0KPj4NCj4gDQo+IA0KPiAtLSANCj4gPGh0dHA6Ly93d3cubGluYXJvLm9y
Zy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29Dcw0KPiAN
Cj4gRm9sbG93IExpbmFybzrCoCA8aHR0cDovL3d3dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJv
PiBGYWNlYm9vayB8DQo+IDxodHRwOi8vdHdpdHRlci5jb20vIyEvbGluYXJvb3JnPiBUd2l0dGVy
IHwNCj4gPGh0dHA6Ly93d3cubGluYXJvLm9yZy9saW5hcm8tYmxvZy8+IEJsb2cNCg0K
