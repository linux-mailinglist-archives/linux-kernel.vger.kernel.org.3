Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DC454408E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 02:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiFIA2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 20:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFIA2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 20:28:12 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC1C6372
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 17:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoY1DdGGi3mBSfKh08BdE5jQEpZ/yJWsrLhaYdQw1qiJnSlej0K49TVqnGMWqAN73wAdyzAJj/o6/zyTYqFcja4qM/e9+DSqDnMg20pYPWt5F+hWnyKrsBQyM9bV0b1JR0K25avt4JpKhc7DtPFlcnYivcEeWYs+06ZUwbx4xvNPkVIx163dg3+bpwPCG3Yg9k/4RNnBQxqk/bbmUbK9SNcm7Hd2IYVbtkkaAyQ5BCgzIJlcenCJC7a6QAr/FZfDNvlTSvTkGf7NzjHW6P2r0CN0KXyQAlVMTSIWH6JLMMNd0tgsJ3/GPPXG0PdtgQM8YBZxPNlK4SCBnzitPGpTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5IJwfKZu8yPgud+miDptkhC+MzN8XBPWSnc4REE0dI=;
 b=TfjQIzwYz9C8TClUeSso1J0YUjxj+LAHkqlwPosRkG93h80MbOlaBaPJ8PcMoaEa0O//L0Wn81NLZAGpIZusmSSt1Z8IvptiOCiBTKs/17kf0fKDB+T1saTnJh3mLmi8BOaeOVv/ZF6Gs7SPgWvlFWm5JwLsvxSnpuYlvBaCc07FiwV8GsXZfTOzg980vtEnvx3fSYM4UsNznjjTn2o974Xjw17Ijy/SVRm4b2FbJ9IGyskFgorSj6U6xfK7PX+j1huPU4XFCdw/6X7TUUWo4S71WuR36AAbsMJ0pEn9Q32BbbtMcp8lL71Utmge+DFTu4YVmR0isPn6bLlc/eZLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5IJwfKZu8yPgud+miDptkhC+MzN8XBPWSnc4REE0dI=;
 b=p5N0ZCrFDliQ4Toj3jhu28jA3atG/r22+rePI7eN5mgeFYnI5ZEuBt/+4D09uQ84AhvOfNzavoavP4foevlVgtQo5/sXybKvCkGsD+QlMZgwXhOcg68vZlAgvPZQseL55Wr7TY0E93B9DEKtTOxG9PVaaNVx8lBr64ihSweok5Ilj2dGNpoEqovASO85ERDsI7l3/ozrdEXqvVv7Oa8I/7/ZuIHvCdS9OOY2ESzDjrW+lnZdlLrk/sI9MXh0c8LqzEIgTSLGAqcmvlqu8icAz6fvo6ghllap/riK1D2JSErM9aQn6O3LS0/0lHHHNh4DT0vGVnHIOQV3UqMVzx/2Mw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB2422.namprd12.prod.outlook.com (2603:10b6:4:b9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 9 Jun
 2022 00:28:11 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 00:28:11 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Michael Kelley <mikelley@microsoft.com>
CC:     "caroline.subramoney@microsoft.com" 
        <caroline.subramoney@microsoft.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "riwurd@microsoft.com" <riwurd@microsoft.com>,
        "nathan.obr@microsoft.com" <nathan.obr@microsoft.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH v4 1/1] nvme: handle persistent internal error AER from
 NVMe controller
Thread-Topic: [PATCH v4 1/1] nvme: handle persistent internal error AER from
 NVMe controller
Thread-Index: AQHYe2kcP72pVk+OVk+EwBZ9BRmAeq1GN0KAgAABgwA=
Date:   Thu, 9 Jun 2022 00:28:10 +0000
Message-ID: <5a27e5a5-74eb-6c65-eb68-c655c3b5ae6e@nvidia.com>
References: <1654714341-41189-1-git-send-email-mikelley@microsoft.com>
 <0e57d8c2-9a30-f15e-dc38-da397ac81c34@nvidia.com>
In-Reply-To: <0e57d8c2-9a30-f15e-dc38-da397ac81c34@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 644cdb2d-9fd3-40c4-af2a-08da49aeef0f
x-ms-traffictypediagnostic: DM5PR12MB2422:EE_
x-microsoft-antispam-prvs: <DM5PR12MB242213BB6BD90482E8E6FEF6A3A79@DM5PR12MB2422.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FaCy5sPS5S0TQvNQOueK9keCmvEjQPzYkgTPqjui2/fdfch/QN9COkD47cQdxDHURFLkmEPu9lVJ+Xi8IFrIouV1q89CQWlbluKy8gNhyLgjXLrWmNfcqJ3i3tedn5+WawAk/vLPSLxTozPCx5TWsjUPTrfUGviwcyCJb0AVU94rBq4QdrYBBsvoDvrU+nZVJRktxUPKq8X5jpojCNtBrHx2b1ZjDfzZ0ApBRSBHdu2nhFjW9isXa1REu1hK7iyClQ15gfT8s8g08O/sHzPe5atsQCj/9JhRUw8XDWlXadO4CWrT+dDlD9TuLEXkuAGnrGbHVlgDVL8V1yUUkX1nOJXx/g64Go6Kip6B03wcTyDmq7xuwEbpfKg7lbGJPzTCNFKR8mbNXJFnc3VTh8fxIG17Y2e6MYArk86/J98TvPOq9IK7uSOKDqqf1+02/jaOTHk6UMMC+lByyR8XI8JjxCR/GjK6iRB5j6zTsLHeE3PoXOPMkvHMdPIXZUxeAMLufdI3VA/0nss+wnHnQQHn74NUdxGb6m6B7iATkOYA+DYkCZJV5YBepVkrItMvZ2JHfC7RC0yiHz9OQNTVY+PD5E4S6IrrD9nDDhNwdbz5KZNd/jWSqJHSFO6fhnkMKS6Y0owj0ZGUvSrDgKxPdiBAzjMc8MSVT/MrSs70y1X+Z6WpUuUwFkJ0ZLJQJBrWw/PqptvQnQUHAfc5BCWcF+RRclyVU30KmbUs49x/31osz3LXUypgUfDNvuaid/5COfBMe8neH0vhn1hMwR3NTLp9MA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(122000001)(31696002)(83380400001)(38070700005)(38100700002)(71200400001)(6506007)(66556008)(66446008)(66946007)(66476007)(64756008)(4326008)(53546011)(76116006)(5660300002)(8676002)(7416002)(508600001)(2906002)(4744005)(8936002)(6486002)(36756003)(54906003)(6916009)(2616005)(186003)(91956017)(6512007)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWFKVzJZWTJlbGdpeWpFUXNwSWdic283VjNxUlE5eWJJZTNBaFpFUFpHS3hl?=
 =?utf-8?B?dlVkYjE5YWNkaEZoOHRvTzg2cnhHMmJiT0NqdFFTM25nVGozaDc3Mk5BNkpZ?=
 =?utf-8?B?K2xKWkZuWnl2YzA5MWI5ZklLdXE3OFhHZjVaa3VneGlhcnlBaDRDSXpFMGNF?=
 =?utf-8?B?cFJsZndCZTBCeTRMUFg0Qlg4RDZMaWdpdGtlMHRielJHZkxETzY3MEM4bG1s?=
 =?utf-8?B?TVBXd2M4ZkF5VWRwbGIxMXdLSjY0WTAwejBMbjR3Wk9DZ0orUTlnU0lZV1M4?=
 =?utf-8?B?N28zeEFsb0JnY0ZUM0JiOW02ai8rYTNRZ2pUUU1RMGVZWituRjN1dE91SGpG?=
 =?utf-8?B?SG5kU1ZJNld3emxNTVVyMmNER0t1c2RlWXlZUmhxTk9mWDB0ekpTSTVvQmpK?=
 =?utf-8?B?RTlFdVdwbWEvRlpzTGU1S2RJTlNiT1dmbHEwVGNFT1E0bGh3bkdNQ0M4UHZW?=
 =?utf-8?B?QnVsUlU3WnJzZGFKbVdoY0poM0pydGRkWlpSU1h0bTZ2d3B0Y3FCbzNPbCtU?=
 =?utf-8?B?b0xFVHZ0TFB1TnFaNDFQTEl2U2xNbGNhWmVXQ1BoY2RKUEVTN2Yrc2Q1YTll?=
 =?utf-8?B?YzRGUTRMNlhySFo0d3RmVHMrbzJNY1pnZXhicUFNcFY2UGtxWXM2MDRyUWFE?=
 =?utf-8?B?ellCcWs0T2hNdmhEZHlTL25aL2UzajlraTl2eW9EbWNUbmV6TU5kY0ErRE5N?=
 =?utf-8?B?OVc3TzROZTdzVmN3d1FxV1VzTEtFN3hRMUhPOG82bXQyZnFlc25zZmo5dW5a?=
 =?utf-8?B?bnJtS2hINFZsUk93NTFabXBKQVpBb1RpZG0vcE5QNTVKdUp5cFlzWE95UWRr?=
 =?utf-8?B?eXl0L0NkOS9lNytmNmVDbXlvdS9Lc0ZNdDVKaGVtdEIyVTFpem9ic1l5eUZ1?=
 =?utf-8?B?WHFBYVd2M2RsVStYVWlMbmVpTTZ2SDM5RHU4QXAvbHJXZEZTNTFIVjNxZnhP?=
 =?utf-8?B?VDFqcEg0RVB1UGNlRU9meklpa0RUbWhvT2JVcmR1bW9YMUdnYWpYR3REZURs?=
 =?utf-8?B?Y2NsQzh0dkNJWG5TeTFMaWtROStUYVp5WWxNWStZdllkYVBlemo3LzhORGlH?=
 =?utf-8?B?K0xHTXhJVysvRHdDamVOU0lEckdoZnptaURkTUtDaWVXUW50cnN0L044Z1RR?=
 =?utf-8?B?Q0lzcGQzT0hid1krdTVsZ3RXRTZYRnI1R2JuUXNPSk1WRWFTcU15Z3p5OERK?=
 =?utf-8?B?cFZKQVdnbHZQdmROZ0w0UGlwQnFab1k0VFhsUHU2MGVKWE5HOUpGRE9wMUR5?=
 =?utf-8?B?dmo4dVNpRXdFdnQxbElHRVU0TzY0ZEdCZWEwT2FuMnRiYVlFcmRJRW5IaTVk?=
 =?utf-8?B?MHF1b3VucDNySnlXQ3haczJ2STcwVTFsVDczSDR4dUdKN3pzcWJhU3NnY0kz?=
 =?utf-8?B?THpScWZ6S2U0VE90MXNPWUtwdktSRnR6WTN1cldoWXNYR2Vic1lpV24zeEtL?=
 =?utf-8?B?cnV3NThJYUhEbXhuYnhWNC9FZ2FGT3h2V0RMbjNUYzdEbEhRUENnSlpWanEw?=
 =?utf-8?B?QkJJb2tXY1BBSEhWY0pjT0xyOFFMMUlJaGxsc0tHRzN3QVZTVDVKQ1A4NURP?=
 =?utf-8?B?UFI1T0pMUmtPSDJlUDlqSmp2NVVCUjNHNkRUWkZMNGcwejRwRVQrdUpmdTVS?=
 =?utf-8?B?ZEg1TFNQOGpFR0JLWGtFeVJCVjE1Yk80VkEwaWpDakpqeDBaTVFrVzFlMnlV?=
 =?utf-8?B?dGZ6YTF0VUIrQnlOc3J5MUlzK2lkcDh4NTFIMFJnamU4WnIrODB4WGltOVNU?=
 =?utf-8?B?Mm5uSmZKVkVvai83Q3ZHUStEZXFiZ21Sb0tIVzZNei9RVWdGSVI2aUNwQlJN?=
 =?utf-8?B?bjhxODBtM3F2RW1CRDh5NWZEMVVaSjA4WnJydlcwbHZnZERDQ3Q5b082Sitp?=
 =?utf-8?B?UUErbjE2YytkcHRSWCtOZVpxVEo5SkJZNjR0K3N1dDNXTlAzNW1CYldYWm5K?=
 =?utf-8?B?VnZMNG5IS2JmNGI5dWR5cCtnTEcwS0cxQUNOL2trVGZCQWQxWTc5eFV5Si9u?=
 =?utf-8?B?NGt3Yjd1d0lQakFPcWdxSVFhZjNVTlpid2hjMzV1V2xRbXZlNHI5WmR2Zzg4?=
 =?utf-8?B?aG5hdnQzY3ErMUhmbFFtR1pacEhOS2ZCVzBMdFd2V3ZtNS9FUG13MU1yVW9U?=
 =?utf-8?B?V1Z4cTV0UHBCTzBrK2FPeGlnL0JpVFo4bVNMRGVPZUpORjFuS05YWE55N2hv?=
 =?utf-8?B?SlN2QnROMy8xZnkxenRERHVjMkkxelgyZWJLeE5MMjhIRTNoR1hVUFMrdlZy?=
 =?utf-8?B?SkdFeUxBTEs5WUpwaEdQSHgrb1BCU2dBa3M1Sk1hczBNV1hLd2pwRURwVHBJ?=
 =?utf-8?B?Q1Q2eHJOSENCMXdrcndNZUR1MzY0UUVrMlYyckhJUTNCK2dhU2VSbEJHRnZC?=
 =?utf-8?Q?enPKKLgWtOFC1SeWNCcDVtqNhPOqUCY4Xxq7gR1T6lfpW?=
x-ms-exchange-antispam-messagedata-1: 07SiX7ieGp1lFw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D9009EB1ABD8D419555FD14962CD25B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644cdb2d-9fd3-40c4-af2a-08da49aeef0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 00:28:10.9797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hrhyE0s75wVFgy+9S9JVbRyadiqlLmIBV0cpFimXPQ5PCJsvVoMae4xQ/G7QOatIdms/VYMahK+b8DPtfDy/Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2422
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi84LzIyIDE3OjIyLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+IE9uIDYvOC8yMiAx
MTo1MiwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+PiBJbiB0aGUgTlZNIEV4cHJlc3MgUmV2aXNp
b24gMS40IHNwZWMsIEZpZ3VyZSAxNDUgZGVzY3JpYmVzIHBvc3NpYmxlDQo+PiB2YWx1ZXMgZm9y
IGFuIEFFUiB3aXRoIGV2ZW50IHR5cGUgIkVycm9yIiAodmFsdWUgMDAwYikuIEZvciBhDQo+PiBQ
ZXJzaXN0ZW50IEludGVybmFsIEVycm9yICh2YWx1ZSAwM2gpLCB0aGUgaG9zdCBzaG91bGQgcGVy
Zm9ybSBhDQo+PiBjb250cm9sbGVyIHJlc2V0Lg0KPj4NCj4+IEFkZCBzdXBwb3J0IGZvciB0aGlz
IGVycm9yIHVzaW5nIGNvZGUgdGhhdCBhbHJlYWR5IGV4aXN0cyBmb3INCj4+IGRvaW5nIGEgY29u
dHJvbGxlciByZXNldC4gQXMgcGFydCBvZiB0aGlzIHN1cHBvcnQsIGludHJvZHVjZQ0KPj4gdHdv
IHV0aWxpdHkgZnVuY3Rpb25zIGZvciBwYXJzaW5nIHRoZSBBRVIgdHlwZSBhbmQgc3VidHlwZS4N
Cj4+DQo+PiBUaGlzIG5ldyBzdXBwb3J0IHdhcyB0ZXN0ZWQgaW4gYSBsYWIgZW52aXJvbm1lbnQg
d2hlcmUgd2UgY2FuDQo+PiBnZW5lcmF0ZSB0aGUgcGVyc2lzdGVudCBpbnRlcm5hbCBlcnJvciBv
biBkZW1hbmQsIGFuZCBvYnNlcnZlDQo+PiBib3RoIHRoZSBMaW51eCBzaWRlIGFuZCBOVk1lIGNv
bnRyb2xsZXIgc2lkZSB0byBzZWUgdGhhdCB0aGUNCj4+IGNvbnRyb2xsZXIgcmVzZXQgaGFzIGJl
ZW4gZG9uZS4NCj4+DQo+Pg0KDQpDYW4geW91IHBsZWFzZSBjbGFyaWZ5IHRoYXQgd2hpY2ggdHJh
bnNwb3J0cyB5b3UgaGF2ZSB0ZXN0ZWQNCnN1Y2ggYXMgUkRNQSwgVENQLCBhbmQgUENJZSA/DQoN
Ci1jaw0KDQoNCg==
