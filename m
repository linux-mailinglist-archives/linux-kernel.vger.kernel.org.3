Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0E357E780
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbiGVThT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbiGVThN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:37:13 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF95274DEC;
        Fri, 22 Jul 2022 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658518631; x=1690054631;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PcrpQLZ9JmMmqYij/QYOMNLxWyBQi5Zplv/MR+sCETM=;
  b=TjQKIoOjyiwNln9qY5v9tihhpjIrpRWVL60B+n4Wv9sGaLfWpyGBnFNp
   t6k17vLIC5qo3hwtaVr4Ld9xFTrkx17W2pJFBTHBjm/fw0qnyoPI4KPmY
   MfTrUzmmKVv2BAPMcJhPjAPhN5E79gRoKiUfGyFqVoysb6gkzyrbBHsCF
   wl+NNaGt+VaRMXisOX9FBMWZB4XoELartUVMF3wfZ43ppbxLdVDHOXKlV
   Pi7Jt/eaxzMySoExI18HL1gMTvD+g31Tj1NdwF59YcfPjzkhfRsclnFvU
   lnjFBDzxRstPMGRC0HmIxMmyUp9arEl7N1Y80CBcXTgoHyB0fzX9x4cDu
   w==;
X-IronPort-AV: E=Sophos;i="5.93,186,1654531200"; 
   d="scan'208";a="318760997"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jul 2022 03:37:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVekiqWPQa703z4qVFkB1TXPmzFv0Ly8M3/RICT3tCxGW9OIeTnaKdMvYEvNEnufIdQdD3m+yfhePxfQuZ63s7Absx/uQZb8rx2jIfO2jFB1HaX0FytS602PePX9PxioVyjelnyjPycDm5n//WsNti6ha2tPXMrl+whoxdR79D+OWoGd0GPDd9C9AMaIWSCSabvbGf6udWgpIxAwO0ObvltscFxvEZ83n46lIHWllmskV8YLMvTlh3dyNDSpuChdco8+6LXKYXt+I5hhO3HXI8V4TRpxbTyiIU1noQbiRLRi3aRi4WyDwbn04O6vwL3abHw654LW6eh/FflSxXuPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcrpQLZ9JmMmqYij/QYOMNLxWyBQi5Zplv/MR+sCETM=;
 b=DHWpchIB+G8QtGc9DH0ZKHv0u0aoMilJtqsAwwdnGyCyTfwQn58idK6om1bzhRYQhPa+Fsl36O4CjyUCnnYO48avJcUDK67r/rWWHkMl9sLwMvdq2lyrQLktZlYk9sJUj7U9u5OmJHZdX3xDs8/pXvRjOkt/WWAoaFxAXaiWRM54MWE32IW3VXljWAngDjL5amjoSpOQRP93EQKYz4gMe5n7DFhoeQDc5twBn89E2E7a8x0Dmth+fnoUi10x4KZ8KXyMffiRIerTECIa/H/thNgIhPCcaw2+XArbvaOrubNhQZSx/F3FhlJiJFiDtokV46ZIpyMvmZ8N6VhZ1hp8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcrpQLZ9JmMmqYij/QYOMNLxWyBQi5Zplv/MR+sCETM=;
 b=NLTouFLHnrYJNXERTNJdXYveeEl/xP9uiG7CdO6c9e/2TkKfCIOs3KoV+Hhj1mQ/IZc7fPPxz6ehVOGkSBs3lFlz+QMHBYn3WMBwJ/6/UAOD7vAmGLvcX9Uuj6pixC17ZRfo1ZP3EL8aeR+o5aQbdPaPGWNehd9tah8+Ei9z3Ec=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA2PR04MB7547.namprd04.prod.outlook.com (2603:10b6:806:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 19:37:06 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%8]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 19:37:06 +0000
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
Thread-Index: AQHYmz2OvInxSH8TlUq8qOHvad4nHq2IiDZAgAIkFwCAACFbcA==
Date:   Fri, 22 Jul 2022 19:37:05 +0000
Message-ID: <DM6PR04MB6575B4E2707200BDFFEE4A08FC909@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
 <DM6PR04MB65750EE12401C4F69B352E5CFC909@DM6PR04MB6575.namprd04.prod.outlook.com>
 <4838bb09-d5a8-9b6a-9011-5394b8869695@quicinc.com>
In-Reply-To: <4838bb09-d5a8-9b6a-9011-5394b8869695@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65b5dd16-3767-4620-0558-08da6c198f5e
x-ms-traffictypediagnostic: SA2PR04MB7547:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nk0QwdeWdlvcU7d8Q78xrqqAaHtYN4C1Wos+uucocnoXf7Ir1+dSY0Wnnkqv6dBbwjLIhgqt8lj5Ne7moE/7JV8CKtUOWqmyPVLspX7uD3xW3W5ibIfB/+gw0ztcrH83LrM1StpqirWcQeqyc4Jp5oaQuDgwZgEvcb5EBwcvBE62eFaAIqkwv6GURlPAJtB1qhqnuHfISlnPOAbBvu0aJiNLrGhFzoyDZ4iXVDnPdxdNTshnrwa0UDGCQ5r63gq32rNO/7jGZzaYKuB1Ggb7rAnh6XiadPzQUA35oA61+YLs8EFfT7PYNd7/GSkmsZJrxKi6UdlAa+HIeIz9b8DaG1NC9KAkd+ZKCzqZamGq/7znIPFuXyfvAS2JI7bOQkLNwy+/88wt1hNvLYHSETz3EYaK8mxpeJN9QkAYsfXoPYwHdjWHMf+3U7bYGjhI7MGX5T9WqpExtwZ7ivTyB99eJ6WQuj+V7fAeb4M9PD71KFNxOPJq7alq5a+hEaREKNSSbSYYfWrsqzIn3LGab+MUWJDPO2C3UrdRdfLnhditptX9NMOOeLF8OWgw1pHBxjpwInyZMBkbR18J7HFwycQCbcYt0wMfY7ulmwDwG6FI6vpGTQQxSSv9j/LuIuCxTydE8YdcXrPfPD8CWNvW1xJMpz69GLCGUwgsFgU710gH4ujweQWF6+CjBWUE4QQIGszWRf63VYwQ50IZixzw7uKM7o+ILKKeqECsMSuT5Yf1vZqCjDJIO2jqRq3Knk6F3M+g+CW2HQRp+RpwfwZgDbx3uQUiI58fJCgXeK8G1ZRLZGW7FUVtUb8g6ibIdNJwSYsa9AAWZ5+FGyPY8UlPKwuz6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(8676002)(122000001)(316002)(64756008)(110136005)(38070700005)(66946007)(71200400001)(76116006)(82960400001)(54906003)(38100700002)(921005)(66556008)(55016003)(4326008)(66446008)(5660300002)(52536014)(478600001)(86362001)(7696005)(66476007)(9686003)(26005)(186003)(41300700001)(4744005)(2906002)(7416002)(33656002)(6506007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUxRMDVjd2pyVktoWXdDY3hYcEF0WmxvR1lvQmNyTW4wdVlxdTdOcitCY08y?=
 =?utf-8?B?R3VUSml6a0IrQU1Gd09vVWtnazJod2l2WU9ad1dxRjBTWFl5MmZ1clVpWUUz?=
 =?utf-8?B?dGJ6NTlVNFNWakpGTldSWWdUczY3N29rMzlHdDZSK1pOMkwwL05sTkp5QVIw?=
 =?utf-8?B?a0VGTVZTOVA3cVBIKytDMmZtUWZYMGZEOEF6eUp4Q3FFd3pBZUM0dUdYTDFu?=
 =?utf-8?B?ZWt0UWFFelBSZEtaUkwxdzFRL1ZtMlkvUFNKOGtQVk95Ky9lcitrZ3JKMERP?=
 =?utf-8?B?alZUbTh1d2l5bDNDUGhXaUl1ZEprbk9JVE16aWwvMStTNzM5WUJHT21ub0ti?=
 =?utf-8?B?eVJZNjhUWGhqQzZzMU9UbXhYR0NsVnZhM09GRlFXK0x6YWJVZkVncGhIN1hC?=
 =?utf-8?B?N2U2aDRCNlcwK3QxMnV0TW15Wk9yeUM0TkZLUmlBSE1nL1hlL1Z5c2pvanh6?=
 =?utf-8?B?MnJKZ0dtc2J5cUFIMEtwWlkrb2dIeG5JeDRJdWRuKzZLeGpUSC8ycXpnOHBJ?=
 =?utf-8?B?NThYcFFoT2wwaDJibyttMnl5WmRKclZnb0xxZXdmaTVmT01mcmRYZ2RodCtr?=
 =?utf-8?B?RWI4amwvZ25QTVVKRXdxazE4MllSMmVZbnVGZG9kSUJBakZDRUc4N0M2cmRT?=
 =?utf-8?B?UWhNd1gxWmNLZVo2S3pGZWE5dHk2UHczZHVEVUJmcXlxU0ZPVkRJUWxSdDBX?=
 =?utf-8?B?VDkvc0dweUQyY2NKVzdLWHVqOGhtQ1U3dUdvMjJMSEtwUm8yY0k1cXdKcHhM?=
 =?utf-8?B?VUxoUXNnMGs1NmxrMkl4L1lPcnI5TFZuZmpvT2dDbmFKZmtEc09sSkREN21D?=
 =?utf-8?B?OHJDeWR4bEk2S0NZTU1jWGZQb0QzSGE1NHJkQTVHTHdUWllTWGp3MmxKUy9L?=
 =?utf-8?B?VUpmRklhWVloelUxbWRTNkd6dTcrc2RTQkRTS2hFSGRqUkh4WjVPS1A4ME9U?=
 =?utf-8?B?WGVxeDB0VkdxV05ON3VKbHl3ZnYwbll5VTVMZ3d5RkFmZlR5alRkRWtVMkgw?=
 =?utf-8?B?WUkwYUxneFQ2UFpwTzcwQUovYnhETi9YMHNrVXlROUp5eStKK1BHcEJNcTdJ?=
 =?utf-8?B?ODQxcGZlQkE0WjVGNExpVnR4U001UVZUN3BoNE5XV1QzNDZvOTRoOG4wRFJh?=
 =?utf-8?B?OHo4TVZ2Q093eWhjN0IreVZ3SUFVZ2xVVEZCK0F3L05YeHhseEk4b3lLdkdv?=
 =?utf-8?B?Zk9sRmRQSFZZU011Q05BNktFN2NuMGdvY3craDl6eG8xejJMMG8zcXVuazRY?=
 =?utf-8?B?Z05ubW42R09UTU81VU1oVU5tQWZjRUxNNHArMTJOTkR2VXBVRWVYam9Zb3FZ?=
 =?utf-8?B?Uk1ITDJTTHBWR0RDajNDa1hJMGlVTTAzem9SWTZoQWRhTEhDTkI0a20vNmdt?=
 =?utf-8?B?QTMxMW43VHF5Q1lVT1JYNm5td2p3Wnd2c0dtNUFOMWxOcGRjRlAyRWN3aTBt?=
 =?utf-8?B?elRtb0p5V1dwT3JFdFNVV2hpckh5TUZ4V2ZtSmlOcml0VFFlN1pETGFwZ2k2?=
 =?utf-8?B?cFhibkRndlFIcTNrMCtHZUhWSE0xMmRpTFkvQW5kSWpMaGc5NnRObmErTjk4?=
 =?utf-8?B?clhVcFVqOWpiVHJQWGkyYStCS3I4TXhUTXM1QlNPOUFQMlNXSk9HYVJka2FB?=
 =?utf-8?B?b0ZUNGRZcWJwUXQ4RXU5Q2tnQk5ubU56UXZUVmYwQTdqd3ZNYzFwOU1NQW1k?=
 =?utf-8?B?U0pNdjVCNWU2ditZNURNczBqYUVnYTFlb1U3b1N4R0pZbTJIRE4rbDNpVzI5?=
 =?utf-8?B?blZkWWFIdjFveDhsTmR0TFNYR1JZellWcDVsNkYvY2JDdXgrVzJjZTZLd1Np?=
 =?utf-8?B?NXdGNWVvQmVHTWhLekxNSGJ6dC9iVXNuTC80eWdBTmYwSjgrMEYwWGZjK3I4?=
 =?utf-8?B?RnRSTmNnVWxhSjVNTEQzcDdUcEdYRjRBRVEvZXRpQjlRd2JaR1lKd3pzbTky?=
 =?utf-8?B?cURoZFBLQzdFRzZZVFQvQUZTdEVvQmRuVXBrNy95QVVQUTRJZ0tEcFc0dXJD?=
 =?utf-8?B?ck9VaXphQVJleWlxOGYycUllanJIYlR3TUFLRUU1QmQ2M3pCNXRabzQwSWYv?=
 =?utf-8?B?b0dtVlZCY1NhbUxwV0ZHVEVWTDZ2RW5CL0t1KzJPU3hjanFqdWs4L3dDdXc0?=
 =?utf-8?Q?atnsYy/B9W/hGbc0wmXjXdMf9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b5dd16-3767-4620-0558-08da6c198f5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 19:37:06.1007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guR2WzHe9nsDIoNOgBwZvt/r8U5k/S5pY2NBmf3Jf8+ETve5UlzLegIdr1tQFPoU4630IOH2AQFXnYx3HS1bCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7547
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+PiArDQo+ID4+ICsgICAgICAgLyogTWFudWFsbHkgYWxsb2NhdGUgTUNRIHJlc291cmNlICov
DQo+ID4gRGlkIHlvdSBjb25zaWRlciB0byBmb3JjZSBwcm92aWRpbmcgdGhlIE1DUSBjb25maWd1
cmF0aW9uPw0KSG93IGFib3V0IHRoaXMgb25lPw0KDQo+ID4gSXMgaXQgcG9zc2libGUsIHNpbmNl
IE1DUSBtZW1vcnkgc3BhY2UgaXMgKmFkZGVkKiB0byB0aGUgVVRSICYgVVRNUg0KPiA+IGxpc3Rz
LCBUaGF0IHdlJ2xsIGtlZXAgdXNpbmcgdGhlIGxlZ2FjeSBkb29yYmVsbCBmb3IgcXVlcnkgY29t
bWFuZHM/DQo+ID4gV291bGRuJ3QgaXQgd2lsbCBzaW1wbGlmeSB0aGUgaHdfcXVldWUgYm9va2tl
ZXBpbmcNCj4gPg0KPiBVbW0sIEkgZGlkbid0IHVuZGVyc3RhbmQgdGhpcyBzdWdnZXN0aW9uLiBQ
bGVhc2UgY2FuIHlvdSBlbGFib3JhdGUgYSBiaXQuDQo+IFdoZW4gTUNRIG1vZGUgaXMgc2VsZWN0
ZWQgdGhlIENvbmZpZy5RVCBpcyBzZXQgdG8gMS4NCj4gU28gaG93IHdvdWxkIHdlIGtlZXAgdXNp
bmcgdGhlIGxlZ2FjeSBkb29yYmVsbCBmb3IgcXVlcnkgY29tbWFuZHM/DQpTb3JyeSAtIG15IGJh
ZC4NClRoYW5rcyBmb3IgY2xhcmlmeWluZy4NCg0KVGhhbmtzLA0KQXZyaQ0K
