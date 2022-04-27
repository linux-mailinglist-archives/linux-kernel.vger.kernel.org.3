Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633C65115FF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiD0LMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiD0LMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:12:45 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EF8369DE;
        Wed, 27 Apr 2022 04:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1651057774; x=1651662574;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=MRDtIQvyBjrFzpyvBs95iCi+V6FSEo0cyHvAcEWhe5M=;
  b=1dA0zW4XQr5mElXLOJgzXBrGpb3QJswQPMEB0+UsrRsT67XvKOWwPNCh
   SyVb7RhQepIhgugN1EuZiZOICIIL8fZHS3ZhD7TAaaN/QqjodjGAdP97Y
   EZIbZSHIy07CNPQpGZkMtu9VDx4BR4HCVrxZEh0IyK0k2b2knHNrtwCFw
   Q=;
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 11:09:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PB2A0khXFl9AR5S9eM/DND6ku64GRVmV6MK4AXOXTzvE+1Z4Cyg2cDSMLz+6adABcKqKOYQqd/iy9CzRNKUqEEqQCxCUaAySCp23LK9LDr58apUzn55a+N1jt7bkpr9IH5YKLj0RI7Uq90jvTSNiT5NUHJSl4INMin5X7dz02oowXT84/E4ILDSnf0aU6VmJxJ76rHdcC+kQWA46ENCT/sjB7QodCdW4ssBHttbxpxJHETtQfEbGGy8JMvr9YuPQsw1zP5DkA4eBi+Mm3vuerIKIZD4Egz94oftaG9OUKbbl7dKf8kL5rb7EQmjm+elL/jiyezPqLy3qCkQpt2+Rjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRDtIQvyBjrFzpyvBs95iCi+V6FSEo0cyHvAcEWhe5M=;
 b=U4u59nueobIXLuJtmpHvsmV6S8X5jUfNqjb420GHnAuFDVHJFrijQG7thwWXoP6GachdIoDS17mkLSAvrtvKVzhBtgTGT7KH1RvVLEcVwFCC/d0MS3Dh9HRI1jONlqD8uaDNLw9hjRibfTYaPXEtde9p4He3QeLoJ0zj7tcnrMBTPTSh41StYjpmBh7ZTAYewlqxES74C13sS56EA3h3c2pYEwpB+WR944ikSWSPi/zGnrtH0MU95G5dktKzUxN7vDMLapnZKPiGThyBrZhcZ4B2VRaVrodtMTXO6JpfVmfDIpgiBkJ/Tr3oT56RRCeLEqdB3NT2wBBcQ798/otjuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SA0PR02MB7355.namprd02.prod.outlook.com (2603:10b6:806:d8::14)
 by CY4PR0201MB3473.namprd02.prod.outlook.com (2603:10b6:910:92::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Wed, 27 Apr
 2022 11:09:28 +0000
Received: from SA0PR02MB7355.namprd02.prod.outlook.com
 ([fe80::68f0:707:9742:bbd7]) by SA0PR02MB7355.namprd02.prod.outlook.com
 ([fe80::68f0:707:9742:bbd7%6]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 11:09:28 +0000
From:   "Srinivasarao Pathipati (Consultant)" <c_spathi@qti.qualcomm.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        quic_spathi <quic_spathi@quicinc.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V1] arm64: perf: Change PMCR write to read-modify-write
Thread-Topic: [PATCH V1] arm64: perf: Change PMCR write to read-modify-write
Thread-Index: AQHYWhyfRJpYYwNCwEONdqNIgffT2q0Di2mAgAAK+v4=
Date:   Wed, 27 Apr 2022 11:09:28 +0000
Message-ID: <SA0PR02MB735545C7F1138C04A87A42D6D9FA9@SA0PR02MB7355.namprd02.prod.outlook.com>
References: <1651053105-11557-1-git-send-email-quic_spathi@quicinc.com>
 <99352dbe-c7dd-73da-3e48-807dcaea3e91@arm.com>
In-Reply-To: <99352dbe-c7dd-73da-3e48-807dcaea3e91@arm.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc3cebdf-19bb-4f7d-9355-08da283e658b
x-ms-traffictypediagnostic: CY4PR0201MB3473:EE_
x-microsoft-antispam-prvs: <CY4PR0201MB3473345DFA4E4DFF695A4065D9FA9@CY4PR0201MB3473.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SR2pRhoZb9j2vYUGyXINwU+BEwKoZpNk6WHf6NWj2TRrtUCAf/70buh/S7+GNtO52DzlTrkF87kJ5QT08h43Ldd18L7Cqmz856kpREU5EDeMyhxcOOsanMl23zhwoLcW456lWNtJB+SwTaoHq5/fUgkciI5SwTwq1JAgkEllT+mKkpJsGpHjTIA9/dN4P3Y4wFpQjzjKuTVoO4o+/eCFZlSyqoZ//MJ/CvqWyDIiCBAcfJ3TQkyT/3inkXpjIKaQDj3W2IDssYha6+F9lskNuLoWWPhoNuQwhwAesrpbZgSEaiwK8YjDKNpqy0Iz2fgEE3Gv9QDvNXLoCpybBo+az0yMBIog0lZRH1qfs6RJqKFKbnCjAWZKRprswrF0aOfmg8LFMBNPXJTx9x7tE4AVHX/ky9QLgSX+5kW1Axv7Z3ZpyJ0lUGtULZlGF3GN6t4/mKuX3u8ke7f/NyzHdNRDQpbCajWpHJ2rb5tvfgNGAr43xowR8PB8KG4mEMobxh6t1iEwzR0CDoK7wyjSZGnXjw0AEbxVgL0oN3TjI5z/u4+ISbqFYpsNyyhwQav+UY/ph+UPIIZxdhQy+ufLjMTrY101Clav4Dd8eopPv6zRAd5Q2Br8CIwU6L9qZdGR6NXzPSXBVIu1Rme6ZUQccyUjtqnh5RfsxZ4CvVdUBS+uHO/jUo6c2sb1w3n+mDLcaXJrICBm2yH45pnFylTizAJDu1PyH0OaxvsSlpR3aSLd8u0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR02MB7355.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(186003)(9686003)(64756008)(71200400001)(38100700002)(33656002)(508600001)(26005)(2906002)(110136005)(6506007)(66946007)(55016003)(7696005)(76116006)(66446008)(91956017)(66556008)(66476007)(4744005)(921005)(8676002)(52536014)(8936002)(86362001)(5660300002)(316002)(7416002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MGVPt/elr7wn/HrCuQ5tOHoP3wf1ybjpXu0V14HLy/JNc5YJe7oYFUvLrX?=
 =?iso-8859-1?Q?UrDKtYFWkUIreI+zaszGKW7Kz7Rprbp0x8z8ku5hea9GcwF2l0GBw24Wxs?=
 =?iso-8859-1?Q?o4ialcZwtddHn0rMDgDmRogx1AkKCkv5sfUP0vnpjnUTs3l3ITSHh1IchH?=
 =?iso-8859-1?Q?wMOslMbEgq0Ayqe0ebpaljSakOprLokDHwmdD674V8rQV9LKgKvYhTXa95?=
 =?iso-8859-1?Q?ZnBObP1cx6xVzCunKi9jatg6cokxAKG1E6Xk6S6n8UEsNk6gcvr0s2hITz?=
 =?iso-8859-1?Q?4d9VJMilejitNy5/gPNn6DVuWWpobiEijIWG15B4/MKfgAA8VWacV28V8X?=
 =?iso-8859-1?Q?oeGVD9MKzcV+gD1+amJ4D3QHeaqMQeLG7upT3Dj9nlVurUbigZWCAA30xy?=
 =?iso-8859-1?Q?PJq6ZQZjcGWJh+CKHmEQY4t3xQZN7HYf5Q4QodsHLapoGLt6pkm5Q2sJJH?=
 =?iso-8859-1?Q?9bGxXuDIvZzL2BmDu1/7LZORlBxhwWvCY6jpZnEJCGhgh4ujeoPwdk8aqE?=
 =?iso-8859-1?Q?8NE1Q4Ctrf5bypwM5kFk0SpZ3/c08nRzdDZAVzKjjeMH0+OO0I2ROo24D3?=
 =?iso-8859-1?Q?fDny1z6Q1y5+K5c+Grx2wHBuDhXEvOsXgMWqiSFZDNTO5GmhniF/LvjN4t?=
 =?iso-8859-1?Q?s09Vpbv9IwDoegRZ/ZmHin/7iEmKBY0NwhgDXoaYd3E5A3vT3JPu/ZsvhR?=
 =?iso-8859-1?Q?d2z/VDD42h4BCMIop70JW4hKAOcDAVeNtOnwPVVLAQfxgR9Op9gQ7oqmVn?=
 =?iso-8859-1?Q?sYI4Y62w727rrGUu1lUwnxd2tnGK5/GUMshJssRXvQFtNE9BQ8t2q3NLEd?=
 =?iso-8859-1?Q?hHwx0KqtJ33rARu4mItkMp0xhYx8dIBqg/hKovsFbj30c35rNO2FPQ796W?=
 =?iso-8859-1?Q?MnzZoJivrVMN5Tz46nrei5WBqAIv9tYVzzPhBSl9koTb0YU+vZvEalJg2f?=
 =?iso-8859-1?Q?cq3qP5rM0CJl4hoWkDSd5boYH0xoYp1okRfeZl7i/M6fnr7+iDEI7+5cPH?=
 =?iso-8859-1?Q?qsnmYzYqVd6DCMosZZEhFD9BGqIdpLsEx3h4ZA/7qp+EJ1NYMzNZSPipHB?=
 =?iso-8859-1?Q?obF+Ky0B77x4SpnDlRBk28G01EuUZh/+vHgcudqqdOeVEQUYImITijY9B+?=
 =?iso-8859-1?Q?KgIHFK4/kkfQk0k8+baFb0elsTOzeSpfh4snCFyOuCc6GEhYEE8FkYPq1l?=
 =?iso-8859-1?Q?kYsdZ9PlcvPb5qSY4719HtSoOYjwA/wNE+q+Q5r+x9hHKhtF0Gf45yLsbG?=
 =?iso-8859-1?Q?o6hSxPogNhclpAAP9TEyQ/9bkjN8VQzGpQ1U1Cq0QB4cCswmQNOawchW7U?=
 =?iso-8859-1?Q?2uq1i61T7zhhmiDm1fUePUT8JQkz1MpYrupat0tclBsEFj/F7eZ21XOMOM?=
 =?iso-8859-1?Q?Cn3BhGoEkjYa046WzExCBaeML6OmYIVPGDJXWLuQUTftFYcx01zm848P47?=
 =?iso-8859-1?Q?ccYeBA9zVnxsPyhsP27XUiDcD7DtJa6Y61zDBgUC9YqL6iCDkS3x94YQbU?=
 =?iso-8859-1?Q?+KFiSYTZkfizwkkFCuBfN1wf8/JzP+Os3VAJmVWwhrtZ0lTJhlN5opwYQy?=
 =?iso-8859-1?Q?z8dR0dD8pWznLnMMOkfCiVxanJni3J4MlGong4mwf72wcOy1c+dQ8Hpl9O?=
 =?iso-8859-1?Q?Xi1dG2Qw8Mqo26F3NRqK8x5DK30uYCa1LWGNSKQ9hdnTioxcS6YCjrl9wZ?=
 =?iso-8859-1?Q?ATudFcYXCJlu63GRV4Yiuj5wsY/nEOI88KXNboIInQMA5NEdsGn/UYF1XC?=
 =?iso-8859-1?Q?E1PPYYcoqGlIJTg7GiOno0Fib1IwkvMGAtDCF/C9tplUOpRl/ukGVSrXhD?=
 =?iso-8859-1?Q?9wh9zETBxPem3FJebI6CwVTj1Vu4BgE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR02MB7355.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3cebdf-19bb-4f7d-9355-08da283e658b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 11:09:28.2451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXJy67kjgEz12kNQd0wIt+hCxm/RNnQk8ZH7xVNYmRmOQJpklsHtItAWm+3nTGOR2UwiWO6CuzKG0x2b6EEPcVwUkacXD8DcZ3/5nbqHoxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3473
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=0A=
>On 2022-04-27 10:51, Srinivasarao Pathipati wrote:=0A=
>> Preserve the bitfields of PMCR_EL0 during PMU reset.=0A=
>> Reset routine should set only PMCR.C, PMCR.P and PMCR.LC fields only=0A=
>> to reset the counters. Other fields should not be changed=0A=
>> as they could be set before PMU initialization and their value must=0A=
>> be preserved even after reset.=0A=
>=0A=
>No. We also want to ensure PMCR.E and PMCR.D are set to 0, for example.=0A=
>Given that nearly all the writeable fields in PMCR reset to an=0A=
>architecturally UNKNOWN value, preserving that is clearly nonsense.=0A=
>What's your *real* motivation here?=0A=
=0A=
Thanks Robin for reviewing this patch.=0A=
The X bit is set by firmware on Qualcomm chipsets =0A=
same is getting cleared by kernel from armv8pmu_reset().=0A=
We are trying to retain this bit with this patch.=0A=
=0A=
If it is wrong to retaining all bits? can we just retain X bit?=0A=
=0A=
=0A=
=0A=
=0A=
