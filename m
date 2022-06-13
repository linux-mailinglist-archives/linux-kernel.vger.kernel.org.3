Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2C3547F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiFMGZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiFMGZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:25:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B4910B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655101536; x=1686637536;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e7vPPXNRiz6ITT90Y6jGBQKgIXDf7baP3AQhB7ifxas=;
  b=ENscI6LSLUD5v+oRT7ICkik7O/ZItIK+kzFZh6EWOsLmhM6HmKrveo3E
   acBV1FffXNHSC4RGOErAeouqy2eHcFCnsL5gzwDu67dOdRVnJW3sNEPG6
   OlKsQe5BCa0gBvecDlboNQkN08e0yrlNQW0jR9tzooS+oyRf4Z4ccBxAy
   qZ8GFWPRTsrcTkVMLnad31MWEbAvH/s/ggqhEjMa1qvgpPHZDIqDtXGRS
   GBdvrt5ErSklSAutwv6WHpnJfHtsleTotMPvgqbkZvoCqBLRnv873k80Z
   fyCF8+k5FKyp7YIIihOzzm+y09668//zzk82qRUCyy3Slh1LNMlh5aJTT
   A==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="99705221"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jun 2022 23:25:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 12 Jun 2022 23:25:33 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sun, 12 Jun 2022 23:25:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYWlyPu6RT185c9j3j8g9cyXBsOsFrND8KAZ5XAl/9UNWQGMCKfPTa71sWfMs52I5jxOQXLdLobhL+chEseohjl0JTGjlP5wCp/6BDTuaJPTak7/BbHUiZEmF1Qk+NoWyCBp2fauG7MpcW/N2Q9NYZ8IaZ7jochXxpmwIglUMyFKh+fLds3DGuLcBc4Og4cpDuabs52+/L7j7pIusu0xXYqVACOutD6cIc7gPq3JLI/WPKxnDUUlslcgOzZdNF2zJOwKCguyIzIvvi3v9J/RPmYeQIR14DJPg1NhsDETgjD0XOtnwQscSiPS0B3EmtiGIZK+jn9WyURDk8thM8B+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7vPPXNRiz6ITT90Y6jGBQKgIXDf7baP3AQhB7ifxas=;
 b=QEiQqj8VJzi6bktK8WRgv2d34N6dO9Nrf4KN9lhgOny7P6X4ZUvMRZ0WI4SAhXEqLnhZGPZPNPuVACcAf+Px2NNJHXOWWvHONnTwOvrIyI/Mu8/tdgrY9LLijAwXBUnhdm/Dfxe1L5nBsC5JdfsIztXETzCixUlFWik5Pzg1qvt0KG2KY4f7HyVVq4b74H+sqMuN/X1/Ir1CVmi7Vohf2e6aXMlYy8qWvJIAO1T1O9FhO5VabMLIt0r8KGBHkOSrpYi3AI4XVKl6ZoduLnpdT5IIGct2HaqZnRP3pOH1VE5M32uRGaGBjO/U2pdObs4Qb+7jLWNQthNQTNkP2istFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7vPPXNRiz6ITT90Y6jGBQKgIXDf7baP3AQhB7ifxas=;
 b=bzKWTJFYIMfkHnv6EoOP5mCBMS6WU+Jy1mJihISG53/kz2zQs/PIJmwUE3M9UYBDh/klE650sU/ZOeEvF32IEPW0L/dK+n5uy7x/zoDbmcq0YdsdOwAp43aIL9RnYhZcFh2sTMM1cj3Gn99GZIXefxo3HBlvbvDtKpt+Evg63Nk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB1876.namprd11.prod.outlook.com (2603:10b6:404:ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 06:25:22 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 06:25:22 +0000
From:   <Conor.Dooley@microchip.com>
To:     <coelacanthus@outlook.com>, <palmer@rivosinc.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>
CC:     <xc-tan@outlook.com>, <dramforever@live.com>, <c141028@gmail.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <guoren@kernel.org>, <yash.shah@sifive.com>
Subject: Re: [PATCH v2] riscv: don't allow write but not read page mapping
 request in mmap
Thread-Topic: [PATCH v2] riscv: don't allow write but not read page mapping
 request in mmap
Thread-Index: AQHYfuV1GWsMvwuZjEWjcn7lYAdUl61M3n6A
Date:   Mon, 13 Jun 2022 06:25:22 +0000
Message-ID: <ea438a37-1736-27bb-32d5-560fd434654c@microchip.com>
References: <PH7PR14MB5594801243EB482C01963A2FCEAB9@PH7PR14MB5594.namprd14.prod.outlook.com>
In-Reply-To: <PH7PR14MB5594801243EB482C01963A2FCEAB9@PH7PR14MB5594.namprd14.prod.outlook.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09feb610-ba46-49d9-c274-08da4d057e9a
x-ms-traffictypediagnostic: BN6PR11MB1876:EE_
x-microsoft-antispam-prvs: <BN6PR11MB1876458CED1537B0188AAD9C98AB9@BN6PR11MB1876.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CgzEs4j8ZZx0VIGEeuGtwfKVSB+3h5Vea3LUKp3ioo4Eb+6Rulu9LkN+YzuuZ+h/kAWHaFIDrmMwOl8xWXY+8HgsOhQEva2gqknYd/lVvoCub/0Up34ZfwlwYVb3kk1AYRXEHDoCBwGBMza2qYWfENhnuEhc1w6X7gTj4Dtx11GVmhEdhbT5YB2lF1CKCfau2HvtkJEzsr7Pq+mmfCqXwsv09m9lh1YbCvAo+2/sAYB/vymkLhkhj/zMVG+RgrsWZukev7+SQeLnSnOK01wcqPWluVqyiWsbw4mDKtbCDF4pJofmwtktN8Fhrh+mMmqA+KZjUNsgZUOYUatF5VBo4cGsTvkvJFGHVE17aEUsHDf59YMnHInyr31Wg12x9hti+EkFMK7A3k0ec8nS4ou1MFDlON1gDJz/QH8uXEFRdNsTBXPlW8KnolPm/9c+snGlwOxjLsogSQJtPmzovMuQGH86Ws2XoEcaRRPVsG6GFBH6tNMlahAIlkTcHsgwf2s7Rxw5Ft/kW+2Z2vmCB1Sy6UwAAtHuLOxU9PjN/XofWdmw0OnqWyhfamsX2JsGiEBMwNFqLM528YQQna0SilTNQlpGcYxr+W+fzwkhta7SGos0O8ItsGXCmpRVhi69VLFTEZTh6twO8mHDUjyvWBmUh11QZwsG2zVU2XfU4J8wSVmYy7Gy+17NOPv7cSw/yB6eYiawtG2BM4fIIBjekF0sJdRqNX2xtHDIwaYTEwl1kEmhc2h5OrjJ8+If9ZjrKWeChD3Je/JVomORmIG8lceAinsx76fVBbEZsUtGD3AELhS2o8WWUFmeHOm84UpApDSEBlCP3AQWsqV2ZHP8UaHem6gsxs/uXS/Ub7l9FAr+TsaAWewWLRi0/dnAMZhy24nqcv6C1grEm9N2CnnQ4m6w+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66946007)(45080400002)(316002)(966005)(508600001)(6486002)(110136005)(66446008)(26005)(76116006)(91956017)(54906003)(71200400001)(6512007)(53546011)(31686004)(86362001)(36756003)(5660300002)(31696002)(8936002)(7416002)(2906002)(66476007)(4326008)(2616005)(64756008)(8676002)(66556008)(83380400001)(186003)(38100700002)(6506007)(38070700005)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkZCMnltdG9Vc2I1OUxSS1BpYVFPdVlhOWRSTU03WUF3K3FFVmJSY1QzM0Ra?=
 =?utf-8?B?K0c3ekpRdFhvaG5oKzV0dGN3ckhpNnZER3d4OTg3SjhLU2hTOHJZU3B0MmZq?=
 =?utf-8?B?d2dkK3JsWG5hcThua1M3RTFKQmp2d3NTR1JtblBicWVucnhvT0tlS1dPVjdJ?=
 =?utf-8?B?eGxybGdCcjI2YlZCQmFUUmpickg2L0s0YTEwZ2VZLy9LaGVRVXhyWkt1a2x5?=
 =?utf-8?B?NjhEQVdRUWgwZjF5Y0dZenNhMFhYdmx2YkNYQ2NXTlF4UytEZ1M5MjhUaFds?=
 =?utf-8?B?dUpLaUc2VXlSajgza1AwcHhzMmpjd2hvV0lKZ2FvTEZhYUZDc0xvNFg4QUl1?=
 =?utf-8?B?c2czK3NDMm9DSzVuM2JEN3N1ZEhwaVA0MDM5eTYwdEdhSjgrcUhwREdSajYr?=
 =?utf-8?B?Tlo5cGMxQjNuNyt5ZFhEdGVVd1dTemVPOE9pb3hleTBHbFYzK1VUSVU2SXlB?=
 =?utf-8?B?ZEFnSDVpZ3EyMDlKRnpaV21iOWNxYVhLclpUQ0JWRi9CSUUxUWwzd0N0QlVF?=
 =?utf-8?B?Y202bTB4ZHYwQWZOYjYwbEZNMzJ6M3J5WnIxYmw5aFVTSUFmVFYrT0Q1UU9Y?=
 =?utf-8?B?YWJZZEdWdDZPY2EwWld5NkVyZ0tnWjhVNFFCMzlHcGJTTXY1WFNPRmh4c01V?=
 =?utf-8?B?Z2syTklONEVCUXNBeDBPQXVEVytBMHpyYnpPZXZ1YXBSRVp5MWRwY0kySnVo?=
 =?utf-8?B?OHVCSXFtMHNYZTkwOHRKdGpyRGh1WVN2TmljU2x5QlMrb05EUWdSRW02ZDl2?=
 =?utf-8?B?VXd2N25qa0JmS2lZd2ZhOGJETnJCRCttcHVmS2EvQVJZS0kwVkVrUnFCYy9E?=
 =?utf-8?B?cG1RbWp0V1pxUHJOM1N2M0V6VVRHdmRlV0lhUk4xcTI1YjU2L1dJZHpXTFFn?=
 =?utf-8?B?Nnp4Yy9ZVzA0d1VPZ3RnZWZhS3pFb0lHQmxORGRiTzB2U0p2VG5UVTVERm1z?=
 =?utf-8?B?WWNFSDNaRHhCN25sWEEyTkFGczJkdVFMSE4zVklpZG1KZ0lVL29adUhkZTlO?=
 =?utf-8?B?b0YyYS80VE9mNnY5WDV5cXpPL3BGeGlWSGNpRis4blE2VGNRQ3h4S0s4a3lN?=
 =?utf-8?B?d3dZSzE4Yk9xaWlWbm1SOEtxQi9zR21JM2o0VlJMRjNvQWxMNXZhcGVXL0I5?=
 =?utf-8?B?Qm02djRsK3pCWjZMYlo3d0RYOUNYQ2lZTlRReDBmVTRWOUNpWlpMVmI5MXho?=
 =?utf-8?B?MWZIZWJNcm9KRTBNblpJa3ZrTHE0WnB4emdFWERPZU9lSlRFZytxTnYxQnhV?=
 =?utf-8?B?TUpKTXRMTytqb2hqNHI4MzhseDF2aFM2UHg2V2Q0K29zZmtoM2JrMlJBODZr?=
 =?utf-8?B?clNLbkdpVkZqS0ViQUwrdWU1UzFla21nS3VuQjk4Qy9FQkJodFBoMkFWcFBB?=
 =?utf-8?B?eUErVndZV093R0VDQzBHQXRNTnB3WmRxZkFMV2FrMUpNSXBhMVprVFo4TThl?=
 =?utf-8?B?R0lPTmpFazE4YlFzb3NKN0lhNElkY3VETVFsajJ1OFdNWGhhajF0em1UUnh5?=
 =?utf-8?B?NlhRRjRZYTVSRWJsQmM3dzZKRXdXbFFubkd6ZEl6WW9CdHhSSkgya3c2eEkv?=
 =?utf-8?B?STZWa3lWNEVsRVo2WjNwS0krUjI4ZkkzV1BBWWlHb2N3bDB5Nit0UGQzUFhM?=
 =?utf-8?B?dXdTeUJodXg0SDM3dzVod3hyNVF0ekFiSlMzSkRaMEQwaTlFSWhTWFVVdWFE?=
 =?utf-8?B?c0lRa2pzeHJzUmNiMU9xaS9qeUJ4N002eENUTTJ3Q0NwS00xMlpBZk9NNEQ1?=
 =?utf-8?B?SFlZYjMvdnpQMG8vZUh1MGpoajREVldLdlBkK1RhbEx3cVczNHg2RnFzT3R2?=
 =?utf-8?B?UjI4TE8zNHM2ZkdGTWxnM1oxeG9UUlNkN1JiY3M1d0F6c2dUVGxHM01VUUxr?=
 =?utf-8?B?dC9wSHJlR29ZZysyVmM3ZkVVbDZnQzhSdFNtaTIwVnM1SG1EVnRmYTZ4T2ZU?=
 =?utf-8?B?TUNGRWVaSWZtSXI5eWcrQUI1OURPZURMc2xKYUhSV1lvbnNsQ2dRWG42K0NL?=
 =?utf-8?B?bDF6cCtZU05LZS80UEV2c1p1TlFCMEk0WlNOTTlRc1c1eG5HajFpUFIrR3Vh?=
 =?utf-8?B?cmE5cjlQZkovdWZuZmozTXA1azVlc282Y1ZoZUMyemhDcG5SOGoxM05FK2o1?=
 =?utf-8?B?b1I3M25KUC80QUJyN0RtZUhHc1pFU1dpMVU0QWxGQ1FPeDRJQ3dMc3dvZXVQ?=
 =?utf-8?B?T3VsMHRHR0tWSGU3cHZTb0VSUFZsWXRGbFQyajRPQmxlSTVKQWd6djhsQzRN?=
 =?utf-8?B?MGdMNXVydjh3b2tKcGdHa25PU2ZaVjkzYUdtUk9UMjNWb0FZRG9XeFJKaCsv?=
 =?utf-8?B?dElJZ2I3MGFJZS95ZGNHU2pSd2VxOGdDdHEyd3Zwb1dySXBvOFNxUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BDF4A8F35E5F54EAE43F6CE2141D2E5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09feb610-ba46-49d9-c274-08da4d057e9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 06:25:22.0437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wlDRHDH4cs+RoR5NAoU+sL0M7z+qOm08cnjfbMwlSxwTt+OLVn1Xf++VTW0HBOJxdPqcIoueig3q7GmNDf+A5/VY0mF3cUsEoYm6f3ocpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1876
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMvMDYvMjAyMiAwNjoyMCwgQ2VsZXN0ZSBMaXUgd3JvdGU6DQo+IFtZb3UgZG9uJ3Qgb2Z0
ZW4gZ2V0IGVtYWlsIGZyb20gY29lbGFjYW50aHVzQG91dGxvb2suY29tLiBMZWFybiB3aHkgdGhp
cyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZp
Y2F0aW9uIF0NCj4gDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4g
V2hlbiB4Y3RhbiB0cmllcyB0byBydW4gb25lIG9mIGxpYmFpbydzIHRlc3RzDQo+IChodHRwczov
L3BhZ3VyZS5pby9saWJhaW8vYmxvYi8xYjE4YmZhZmM2YTJmN2I5ZmEyYzZiZTc3YTk1YWZlZDhi
N2JlNDQ4L2YvaGFybmVzcy9jYXNlcy81LnQpLA0KPiBpdCBlbmNvdW50ZXJzIGEgc3RyYW5nZSBi
ZWhhdmlvcjogZm9yIHRoZSBzYW1lIFBST1RfV1JJVEUgb25seSBtYXBwaW5nLA0KPiB0aGVyZSB3
YXMgYSBkaXNjcmVwYW5jeSBpbiB3aGV0aGVyIGl0IGNvdWxkIGJlIHJlYWQgYmVmb3JlIGFuZCBh
ZnRlciB3cml0aW5nDQo+IChyZWFkYWJsZSBiZWZvcmUgd3JpdGluZywgdW5yZWFkYWJsZSBhZnRl
ciB3cml0aW5nKS4gQWZ0ZXIgc29tZSBpbnZlc3RpZ2F0aW9uLA0KPiBJIGZvdW5kIHRoYXQgbW1h
cCBhbGxvd3Mgd3JpdGUgb25seSBtYXBwaW5nLCBhbiB1bmRlZmluZWQgYmVoYXZpb3IsIG9uIFJJ
U0MtVi4NCj4gDQo+IEFzIG1lbnRpb25lZCBpbiBUYWJsZSA0LjUgaW4gUklTQy1WIHNwZWMgVm9s
dW1lIDIgU2VjdGlvbiA0LjMgdmVyc2lvbg0KPiAiMjAyMTEyMDMgUHJpdmlsZWdlZCBBcmNoaXRl
Y3R1cmUgdjEuMTIsIFJhdGlmaWVkIlsxXSwgdGhlIFBURSBwZXJtaXNzaW9uDQo+IGJpdCBjb21i
aW5hdGlvbiBvZiAid3JpdGUrIXJlYWQiIGlzICJSZXNlcnZlZCBmb3IgZnV0dXJlIHVzZS4iLiBI
ZW5jZSwgZG9uJ3QNCj4gYWxsb3cgc3VjaCBtYXBwaW5nIHJlcXVlc3QgaW4gbW1hcCBjYWxsLiBJ
biB0aGUgY3VycmVudCBjb2RlWzJdLCB3cml0ZStleGVjDQo+IG9ubHkgaXMgbWFya2VkIGFzIGlu
dmFsaWQsIGJ1dCB3cml0ZSBvbmx5IGlzIG5vdCBtYXJrZWQgYXMgaW52YWxpZC4NCj4gDQo+IFRo
aXMgcGF0Y2ggcmVmaW5lcyB0aGF0IGp1ZGdtZW50Lg0KPiANCj4gWzFdOiBodHRwczovL2dpdGh1
Yi5jb20vcmlzY3YvcmlzY3YtaXNhLW1hbnVhbC9yZWxlYXNlcy9kb3dubG9hZC9Qcml2LXYxLjEy
L3Jpc2N2LXByaXZpbGVnZWQtMjAyMTEyMDMucGRmDQo+IFsyXTogbW9kaWZpZWQgaW4gY29tbWl0
IGUwZDE3Yzg0MmMwZjgyNGZkNGRmOWY0Njg4NzA5ZmM2OTA3MjAxZTENCj4gICAgICAgKGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpdC9jb21taXQvP2lkPWUwZDE3Yzg0MmMwZjgyNGZkNGRmOWY0Njg4NzA5ZmM2OTA3MjAxZTEp
DQo+IA0KPiBSZXBvcnRlZC1ieTogeGN0YW4gPHhjLXRhbkBvdXRsb29rLmNvbT4NCj4gQ28tZGV2
ZWxvcGVkLWJ5OiBkcmFtIDxkcmFtZm9yZXZlckBsaXZlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
ZHJhbSA8ZHJhbWZvcmV2ZXJAbGl2ZS5jb20+DQoNClRob3NlIGRvbid0IGxvb2sgbGlrZSAicmVh
bCIgbmFtZXM/DQpodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNz
L3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1sI3NpZ24teW91ci13b3JrLXRoZS1kZXZlbG9wZXItcy1j
ZXJ0aWZpY2F0ZS1vZi1vcmlnaW4NCg0KPiBDby1kZXZlbG9wZWQtYnk6IFJ1aXpoZSBQYW4gPGMx
NDEwMjhAZ21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBSdWl6aGUgUGFuIDxjMTQxMDI4QGdt
YWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQ2VsZXN0ZSBMaXUgPGNvZWxhY2FudGh1c0BvdXRs
b29rLmNvbT4NCj4gQ2M6IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEd1byBSZW4gPGd1b3JlbkBrZXJuZWwu
b3JnPg0KPiBDYzogWWFzaCBTaGFoIDx5YXNoLnNoYWhAc2lmaXZlLmNvbT4NCj4gLS0tDQo+IHYy
OiBUaGlzIHZlcnNpb24gYWRkcyBhIGxpbmsgdG8gdGhlIHJlZmVyZW5jZWQgc3BlYywgYW5kIHJl
ZmVyZW5jZSBvZiB0aGUNCj4gcHJldmlvdXMgcmVsYXRlZCBtb2RpZmljYXRpb24uDQo+IA0KPiAg
IGFyY2gvcmlzY3Yva2VybmVsL3N5c19yaXNjdi5jIHwgNSArKy0tLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9yaXNjdi9rZXJuZWwvc3lzX3Jpc2N2LmMgYi9hcmNoL3Jpc2N2L2tlcm5lbC9zeXNfcmlz
Y3YuYw0KPiBpbmRleCA5YzAxOTRmMTc2ZmMuLjU3MTU1NmJiOTI2MSAxMDA2NDQNCj4gLS0tIGEv
YXJjaC9yaXNjdi9rZXJuZWwvc3lzX3Jpc2N2LmMNCj4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwv
c3lzX3Jpc2N2LmMNCj4gQEAgLTE4LDkgKzE4LDggQEAgc3RhdGljIGxvbmcgcmlzY3Zfc3lzX21t
YXAodW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nIGxlbiwNCj4gICAgICAgICAgaWYg
KHVubGlrZWx5KG9mZnNldCAmICh+UEFHRV9NQVNLID4+IHBhZ2Vfc2hpZnRfb2Zmc2V0KSkpDQo+
ICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiAtICAgICAgIGlmICgocHJv
dCAmIFBST1RfV1JJVEUpICYmIChwcm90ICYgUFJPVF9FWEVDKSkNCj4gLSAgICAgICAgICAgICAg
IGlmICh1bmxpa2VseSghKHByb3QgJiBQUk9UX1JFQUQpKSkNCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICsgICAgICAgaWYgKHVubGlrZWx5KChwcm90ICYgUFJP
VF9XUklURSkgJiYgIShwcm90ICYgUFJPVF9SRUFEKSkpDQo+ICsgICAgICAgICAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4gDQo+ICAgICAgICAgIHJldHVybiBrc3lzX21tYXBfcGdvZmYoYWRkciwg
bGVuLCBwcm90LCBmbGFncywgZmQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
b2Zmc2V0ID4+IChQQUdFX1NISUZUIC0gcGFnZV9zaGlmdF9vZmZzZXQpKTsNCj4gLS0NCj4gMi4z
Ni4xDQo+IA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18NCj4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+IGxpbnV4LXJpc2N2QGxpc3RzLmlu
ZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1yaXNjdg0KDQo=
