Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16320519797
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 08:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345060AbiEDGwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345056AbiEDGwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:52:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54F7201A8;
        Tue,  3 May 2022 23:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651646907; x=1683182907;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uZN2fHwWW5LiuY67OGL4vkCfjL1EN1i1iwaVjXVpzUo=;
  b=IOJx1JP1fES+wBcQWZ1gOWNHOLS8LIzzUPIaDReevbkTiXzjTe3swD0l
   KEQyNADUBrpAgjc+uyqIyVIokTjd3Xx06KBwgOPEw6wMEdyZSEEN2GYPC
   lP2IIKRjHD0PS+lTcsom8AFNXuvD0hCpMdx/xE1jysauc7jXDERuAKh6P
   8d3tgD2jGedw2eGclOQMUpho9mrKZ3triTJjPtjLSYIo3yeF5TB4rm9Z/
   zCGnfYrPKCeUvAwRWcu4KyrYpsMjIWANFt4oRylYxIK8+3kJd/xptNqvi
   eva+A/yjLaK0PUJmqmpu/J1Rna1UU70NhlWvaz6jarKDgHfrhj8h/LLbC
   A==;
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="162662187"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 23:48:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 23:48:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 3 May 2022 23:48:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOZwJ2pXOEoxd2s/GckzHSHcXpOyBJ+3gUVGiXz5Xxsbu2qG335Ban8Gpk/jDaywlRaFqe6FjNYLV63EoMTlxWu3tIt3qFiamSuppPs+c6+Zr81qe4p054m/uUZsI/4ZYj+dM/qVV71F7JmPZzONsmK0hVnwWV61NG6FeC+4FTUxYcqcjK/ah8krLZnfO6nHl2T5s54bfT2UGKTwmdULSVyUM22p44VNVsG5dpLZzXzM6mqqN04s7bTlpIUnR4vCmPvMFtDEGgjLOCLFIdW6f1XHCipCFAKl6uRPBgC6531+girjpXMtIwLtZ6iKbs43bOeETmB3QPuROnDkkT2VxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZN2fHwWW5LiuY67OGL4vkCfjL1EN1i1iwaVjXVpzUo=;
 b=UwjGNbkHhHP58l241tMPtT4S7P+YFWPi5UlKJ6sumis36SCh4gHxvyPKIf2b5i24K/Wkljll+RuZel12i1geI3UIM4tAj/HPlxGSguWFEr6OY9HpI/kkcjgJVzfOaUEDCvjTTcb+YUfABQuXujgTogjyN7WbjrZ385nlHKdZIdTe1aFYxqL3fjtJuIVkeyiLuGU1zm99yVu8pR4Vsa4G9D+VtvGHk72s7qcQqqfh068DsEYWuh0J+YQ25OMg4ul22+PpLZKX1F1m6olvYCLcsyJ00L1IeggHV6RcW32bFM5KuaoedsBRHY2oQi2aROoOajavWxkaA5zko4LT9KojXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZN2fHwWW5LiuY67OGL4vkCfjL1EN1i1iwaVjXVpzUo=;
 b=L7fKwIGE71QJn/1NTWeHfxgejienU0XUpfYriYogOJZMvKUPC6AmeqPSSAu7UZpZjMS9ND1azMgp4MgVkO4ecf/gsMjm1pcraSXDjpyyOg5k8D5faI1iXMr2t5RcNlYAdPQSoG62TGVdots8lPOmyIFZFrOWVQiHpQTv4SqACbs=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by DM5PR11MB1754.namprd11.prod.outlook.com (2603:10b6:3:10a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 4 May
 2022 06:48:24 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18%9]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 06:48:24 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <krzk+dt@kernel.org>, <palmer@dabbelt.com>,
        <robh+dt@kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <Cyril.Jean@microchip.com>, <Daire.McNamara@microchip.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <palmer@rivosinc.com>, <arnd@arndb.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mail@conchuod.ie>
Subject: Re: [PATCH v3 5/8] riscv: dts: microchip: make the fabric dtsi board
 specific
Thread-Topic: [PATCH v3 5/8] riscv: dts: microchip: make the fabric dtsi board
 specific
Thread-Index: AQHYXZFx3GEwXDbW30itPbpot0SwZq0N1RUAgAB1lgA=
Date:   Wed, 4 May 2022 06:48:24 +0000
Message-ID: <872a2d30-89ad-b66a-7d03-90d3de85c51b@microchip.com>
References: <20220501192557.2631936-1-mail@conchuod.ie>
 <20220501192557.2631936-6-mail@conchuod.ie> <1892011.PYKUYFuaPT@phil>
In-Reply-To: <1892011.PYKUYFuaPT@phil>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02a7d386-0af9-40de-cc42-08da2d9a1606
x-ms-traffictypediagnostic: DM5PR11MB1754:EE_
x-microsoft-antispam-prvs: <DM5PR11MB17544666BB86C3D4383636B798C39@DM5PR11MB1754.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tXCL2Gbf0VnWzAEHor09/4l0ZVTjj0z6XurKIRbx5UMzFMpr3pWASUOCxi9fk9ik4XjGfOKI+JIjWLCy3Re07sWHMKXQVffwhWePmYdfmO+gEluHtNlyYqI1ZcKBW4XlodD+sqzrrCrtGNbrfo8o/+IN9QBZrVfBzvdf8+wFIER1c2jSSe1hSrrGwB2OMDpbcKz9qf6z9KOXTgUYy8kxmQnMKMKVLmK+Mi2dSbbl8wd3SKcpsB4/Oal454p3rhbpAIs/teDDwBKi743nwIFmbEV29jgvi/RCcPNt8Z/Sc9L/146HwamxkMGz9mn1oK8BGQZkzazmuDh0M+BvPl+f26AWBfBnDwoy2iOYGSM4V3zUZhCiZtTl9x7NgcXx8vUvnFJrYOeCu9tByDQIMIZbzcxSTdnx0kQ8Pc/OsmaDhDctO/NqGiJ7u0XrB3ME+73Pn1tLnDX+aG3Iy8+jj7egnzq/rPEK2hZjOItjdRdXZnbNwgBwOPOZBwXQithSw0YayngPSKETMg+/vCIap2xm4lkk6Y0F+4pgAkPJ7ugMMNION79cXpeJbYDyO96SshCopW9jjs3P4f/twyRjxAnvshS3mGbMQZqnkiTNOhO6bD9vdX5BsszAcIWxGastAtbgjh1x71GDy4vLtkpsKoJC9k5Eb/xTCM5HmAV9VmznFGWi75mSv7ruXEwQ+kzIIgjiHsSRodp3PnNO6puUgytSH78RKLihaLyUT74Jdf+BJYLvtilXizPJRqJ7G6Nq4kLQk0UL8zadQ/7KbS7CX2vyKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(83380400001)(6486002)(2616005)(508600001)(86362001)(316002)(71200400001)(2906002)(6506007)(26005)(53546011)(36756003)(186003)(66476007)(66946007)(4326008)(91956017)(6512007)(122000001)(66556008)(8676002)(64756008)(66446008)(76116006)(38100700002)(38070700005)(110136005)(7416002)(54906003)(5660300002)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW83VFdRakkzd1VLV0lDWVZldVBUeVVsbE5BMDNlU2JTd2UxZjRIa3lXVVR2?=
 =?utf-8?B?SkVKbkZFVmRHeWtYQmJrcy9BK1JQRkdoSzh3VHBDK1JmZFBERm12K3pQQmNX?=
 =?utf-8?B?WDRtcHN6R29oSGRDNVM1MEpLWm5CaHdBQkZHcFJzZUtNU2Q3ZlE2a3lTU29Z?=
 =?utf-8?B?UlArdXZUMG5aWlN3OGxKUFk0S3I4WkR3cEw4VVozTHllNmk1QklOYURnd0hT?=
 =?utf-8?B?RG1sMkVxT1dWTGZoNmlFZjJiR1FJazZNSWp0RDBsZmVxR0k1M2N0ZFpWbzUw?=
 =?utf-8?B?OVpoOW80WlRRQnpnNnV4VnJYVnVkTEZnWUlDZXpzOU9XYWM3cmNaeXVUdG0y?=
 =?utf-8?B?eVpZazBCemd3aFJBeTR2NzAxTUZSa1owUmdzclRadjBMN1RBOTVXZDBEcjBv?=
 =?utf-8?B?ZTZQNndGblpYanpVOTM0aDBSalRGaGlsS0gyWkYyazNyRWN6a04zVFFZTkJB?=
 =?utf-8?B?ODBPYjVtaGQyVEpsU05jcVR3RFBHZmdMY2E3a2RUOEdvQmh2eTBwa3dsZ2Rm?=
 =?utf-8?B?MWxwVkJCMTVycUZqQVc5U0d3cVVHbVRCTC9jbkx3Qk52Y1VucVRtNjVKckZ4?=
 =?utf-8?B?dmFCdExIQVlIZkk1L001NDlNdHlHdWIrSHZoTHZndE9tWm9mbE9xSlBMeWpL?=
 =?utf-8?B?Q2JPTzlHSUpLN0MwOVpkTjlmS1dPVkRqZUFOVFhaeXVFYksrN3hsVjh5STVo?=
 =?utf-8?B?UmZkc1RsQjBsbHBBemlKejdla0wwSzFvMHcvOWQyaU96WEM2VW1rY09nTDVC?=
 =?utf-8?B?SnAwQ1lSK2FUNURJVmJXelVOMkgwSEFtNUNxNnpnOG5Mb1BXWlhiRXB4TFlZ?=
 =?utf-8?B?ZnRzRXNnd2xIYkgxaDIrcndYUnJUMEEwVVNzSVN1RzMvV2VEbzFxaUlYZmN5?=
 =?utf-8?B?bnRFelQvQVMvclVGcXEzdE5hc1h4TXFHTzB5VndmcFZqOWZRYWJIajJGZnpC?=
 =?utf-8?B?dFl2YldhQkZJOHVRME1GWE1peGFGZmFjeGRsSTE3Yi9saXUzQkU5eXQxUDJ2?=
 =?utf-8?B?b3RjYmhaN3A2dVMvNE1ibUNSMlV5b1YweXhseTBTRi9KVmp1S0FPbnJYTGJI?=
 =?utf-8?B?RGNjSFRMVzlab05iN2xHRTZXY0dBWmY1cElwZW9mMFMra0ZhMFI4NVJvZkFE?=
 =?utf-8?B?a2Fsd2hrUEJWNjhMZlkvdDkxMWVjdFRwbW8xYXhwSHowS20xalhzdGRBbE5P?=
 =?utf-8?B?V3AzWCtHWHlLc0YxN1NQTnlmV1N6U3MrQUNNeUFjd2o0cGxPaFZQbUdGR1k3?=
 =?utf-8?B?VW9tb0tQaWhrSDBaMlZYbmdqeHBHNk9WYWtxR2paWXVUWTViUDUwcXhtUzlo?=
 =?utf-8?B?RzN1SkZUUVVJaFc0clBYcm9vbkdwZEMrRFBZRldPK2F2S0hrbnozN1dZY3hz?=
 =?utf-8?B?RlNiNkJuRTQ0RUhEOVo3K0JCK0paa1lzVkVkR1VBYjFaeUdjWDY2WW1USndz?=
 =?utf-8?B?dXQ2UWFwWEY0TjhLYnFMWXpKTHR0K0k2U3FuVXRjWWR3eC9uTzFMYWlZSm92?=
 =?utf-8?B?d2FlbjJqM1Z1QnRjNWN4UnZjY0k2UUVmOHVxWEVNR2NGUmJVdlZsRXJJOG9i?=
 =?utf-8?B?dkJkblBqME12Y2dhNGJtM1Z0WERMamQ0RFVBSjViYlJnSnlXa0hHZ1RPRDlO?=
 =?utf-8?B?cVo2VnhaZXUycFg4eVcxVnV4VFBqVW0yd2JCSmhza0R0d2xzaGxLdnl4TFUv?=
 =?utf-8?B?WUl4c2EyY0RMcW1xUXhiTGV3L29MYlJ3TU5DM05uYm9lSkY4ZUFxNmd4bnJ6?=
 =?utf-8?B?SXQyVWxvV3BPL3JnUllvTnI0RFR4UDNHR1RqeGMrV25Mck1vQ3NoL2FDellX?=
 =?utf-8?B?TTBqMjlHK21KWmh0b3BRNVh4K012S0lDbFVVbnZxMGJxZXZEam4wZnZVL3k1?=
 =?utf-8?B?dGtpYk5tN1pFREFVblVSNkxoOSs3YU13TXFCZ0ttY1l1QVAyWVNMWFlRbmxG?=
 =?utf-8?B?ditzRGR1Wm5ZVE1qelgwZFREV2prL0kwSWd2UDFJRzBNYzVPcWl6QUhPdGpu?=
 =?utf-8?B?WGtPbmxITVBsTTlJRVZrQ05wNkhFeC9zSE1KY3M2Ym5qU2VSWkhMZ0J3dkZl?=
 =?utf-8?B?WDVlSXR5WGEyWFF0SE8xV3E1dFZlNEpGTXMvZkFHSVpJUGtFMGZ5eDlMNGI1?=
 =?utf-8?B?dmFzVkZXUmhTc2wwV2ROejFtODV6R3NwT0Y0UXFMaCtZUHF1cGw3bGE2MWxX?=
 =?utf-8?B?cEltdTJFUlNGQjFySFh0c2pZU0V1MHJ3WTIvVFl6SHQrUlV2Tk5Ma1liaGRF?=
 =?utf-8?B?c0F0eklGNzAya1J2aU0zQkFjamN3UnkzK1BMOGN2V2FJbk1jeFBRdEl4ZmZt?=
 =?utf-8?B?NmRBaXB4eDdrTk4wenFVWlc4NHBEdXliT014aGxJTElxS25HZWthN2ZIK2NC?=
 =?utf-8?Q?7eKbDRaLXJI61Vec=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B18CF5141326648BC69C5798E014A39@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a7d386-0af9-40de-cc42-08da2d9a1606
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 06:48:24.3635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/XH/EBncVgADnwybgVp3rnHTTp20wobuuhtOcxLC7oS3RrWxFy82iwj7SIecfrqKkE084koc81QV+kkBYHCyersgoehvCyFLPwPo6IEvY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1754
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQvMDUvMjAyMiAwMDo0NywgSGVpa28gU3R1ZWJuZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQW0gU29ubnRhZywgMS4gTWFpIDIwMjIsIDIx
OjI1OjU2IENFU1Qgc2NocmllYiBDb25vciBEb29sZXk6DQo+PiBGcm9tOiBDb25vciBEb29sZXkg
PGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IEN1cnJlbnRseSBtcGZzLWZhYnJp
Yy5kdHNpIGlzIGluY2x1ZGVkIGJ5IG1wZnMuZHRzaSAtIHdoaWNoIGlzIGZpbmUNCj4+IGN1cnJl
bnRseSBzaW5jZSB0aGVyZSBpcyBvbmx5IG9uZSBib2FyZCB3aXRoIHRoaXMgU29DIHVwc3RyZWFt
Lg0KPj4NCj4+IEhvd2V2ZXIgaWYgYW5vdGhlciBib2FyZCB3YXMgYWRkZWQsIGl0IHdvdWxkIGlu
Y2x1ZGUgdGhlIGZhYnJpYyBjb250ZW50cw0KPj4gb2YgdGhlIEljaWNsZSBLaXQncyByZWZlcmVu
Y2UgZGVzaWduLiBUbyBhdm9pZCB0aGlzLCByZW5hbWUNCj4+IG1wZnMtZmFicmljLmR0c2kgdG8g
bXBmcy1pY2ljbGUta2l0LWZhYnJpYy5kdHNpICYgaW5jbHVkZSBpdCBpbiB0aGUgZHRzDQo+PiBy
YXRoZXIgdGhhbiBtcGZzLmR0c2kuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5
IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICAuLi4vbWljcm9jaGlw
L3ttcGZzLWZhYnJpYy5kdHNpID0+IG1wZnMtaWNpY2xlLWtpdC1mYWJyaWMuZHRzaX0gfCAyICsr
DQo+PiAgIGFyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21wZnMtaWNpY2xlLWtpdC5kdHMg
ICAgICAgICAgICAgICB8IDEgKw0KPj4gICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9t
cGZzLmR0c2kgICAgICAgICAgICAgICAgICAgICAgICAgfCAxIC0NCj4+ICAgMyBmaWxlcyBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+ICAgcmVuYW1lIGFyY2gvcmlz
Y3YvYm9vdC9kdHMvbWljcm9jaGlwL3ttcGZzLWZhYnJpYy5kdHNpID0+IG1wZnMtaWNpY2xlLWtp
dC1mYWJyaWMuZHRzaX0gKDkxJSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290
L2R0cy9taWNyb2NoaXAvbXBmcy1mYWJyaWMuZHRzaSBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWlj
cm9jaGlwL21wZnMtaWNpY2xlLWtpdC1mYWJyaWMuZHRzaQ0KPj4gc2ltaWxhcml0eSBpbmRleCA5
MSUNCj4+IHJlbmFtZSBmcm9tIGFyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21wZnMtZmFi
cmljLmR0c2kNCj4+IHJlbmFtZSB0byBhcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9tcGZz
LWljaWNsZS1raXQtZmFicmljLmR0c2kNCj4+IGluZGV4IGNjYWFjMzM3MWNmOS4uMGQyODg1OGI4
M2YyIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbXBmcy1m
YWJyaWMuZHRzaQ0KPj4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbXBmcy1p
Y2ljbGUta2l0LWZhYnJpYy5kdHNpDQo+PiBAQCAtMiw2ICsyLDggQEANCj4+ICAgLyogQ29weXJp
Z2h0IChjKSAyMDIwLTIwMjEgTWljcm9jaGlwIFRlY2hub2xvZ3kgSW5jICovDQo+Pg0KPj4gICAv
IHsNCj4+ICsgICAgIGNvbXBhdGlibGUgPSAibWljcm9jaGlwLG1wZnMtaWNpY2xlLXJlZmVyZW5j
ZS1ydGx2MjIwMyIsICJtaWNyb2NoaXAsbXBmcyI7DQo+PiArDQo+IA0KPiBJIGRvbid0IHJlYWxs
eSB1bmRlcnN0YW5kIHRoZSBtZWFuaW5nIG9mIHRoZSBhZGRlZCBjb21wYXRpYmxlIHlldC4NCg0K
DQpJIGFkZGVkIGl0IGZvciBpbmZvcm1hdGlvbmFsIHB1cnBvc2VzIG1vcmUgdGhhbiBhbnl0aGlu
ZyBlbHNlLg0KVGhlIGNvbnRlbnRzIG9mIHRoaXMgZmlsZSBtYXRjaCB0aGUgMjIuMDMgcmVmZXJl
bmNlIGRlc2lnbiBmb3INCnRoZSBpY2ljbGUga2l0J3MgRlBHQSBmYWJyaWMgJiBhbiBvbGRlciB2
ZXJzaW9uIG9mIHRoZSBkZXNpZ24NCm1heSBub3QgaGF2ZSB0aGUgaTJjIG9yIHB3bSBkZXZpY2Vz
Lg0KDQo+IEl0IHdpbGwgZ2V0IG92ZXJyaWRkZW4gYnkgdGhlIGNvbXBhdGlibGUgaW4gdGhlIGR0
cyBhbmQgYWxzbyB0aGUNCj4gZmFicmljIGR0c2kgZm9yIHRoZSBwb2xhcmJlcnJ5IGRvZXMgbm90
IGNvbnRhaW4gYSBzaW1pbGFyIHRoaW5nLg0KDQpJIGRpZCBub3QgYWRkIG9uZSBmb3IgdGhlIHBv
bGFyYmVycnkgYi9jIGl0IGhhcyAodG8gbXkga25vd2xlZGdlKQ0Kbm8gdmVyc2lvbmluZyBzY2hl
bWUgbm9yIGZhYnJpYyBwZXJpcGhlcmFscyBpbiB0aGUgZGVzaWduIGdpdmVuDQp0byBjdXN0b21l
cnMuDQoNClRoYW5rcywNCkNvbm9yLg0K
