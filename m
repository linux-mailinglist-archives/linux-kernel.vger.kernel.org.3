Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7818E4C6F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiB1O2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237136AbiB1O2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:28:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CBB25E9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:27:33 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SDcqrT030174;
        Mon, 28 Feb 2022 14:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TN8mniShMZYjJmwkLJimUu8E9xNI40xiymwIwmXbORY=;
 b=nLhvTo4yfoOvUylikYZXYeIZI/Lr+uxTvYsNAuduij0x4u/d31o2GnULk2y0wr3vAnCY
 ZfgYO+fpY2XZkSF36S1rUFiPG9Sqv2UubSGiS6tZW7LBuq00qugIWPxwV0qhV/H0Vmwg
 wriWLv7MlZEzfIe6SmPGU8+4lTJBGai/A5wAh03AftmeMWE0pRwRB7JMHe9u3L2sjncE
 eHCvMzDCk1VU6P/cTbt3ebmfg6AkNUmev2ebisSN5ykfkP7qbY4EZF3ODZF39Vp4b+Mf
 K/Hvj6F4hpzhxuwunzPMwhfSombEfOnvdWAAyKDk6ZdnsgGtgsp9JKU/uhRqN91wn0ft yA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efamccadg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 14:26:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21SEGkIE122804;
        Mon, 28 Feb 2022 14:26:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by aserp3020.oracle.com with ESMTP id 3efc131yc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 14:26:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcV3ab0kazBeMA7yhXOwJrXFHouy8gchWhijReJEg6/XaO7vq7KTvNHUEf595RIQ4zkqyOlTkYuEUsBehLcLxATjUtaaoy2W3HjCmh30uksugETpB3BC205fuohVUlnusyzv7Pz0OgIlR2Ib9WvK2hwDRxUVlX8EAQgl3ZhgX7Y+m++b25Zw/F3VECztCGET5cumZNw7YdFL4I5tEuRjqUtIU9VHXp9IST8Edgr/yf9+cjA0nMkCQZyhsJYypgcMlcnH9wNiQApnH+r+CoH0898pm8Fr5FfIfUipj68PG6bcG6hy1YqOxD7hKGS5Rg6cs/49MhZep50us/CKx1iSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TN8mniShMZYjJmwkLJimUu8E9xNI40xiymwIwmXbORY=;
 b=bs88bJm77FTKGlkqL2iXNRTIy6kVxgme6BmYqoXKVBmw+1K+PyBEYRign5j3LUYXxFpx4R6bfLegp5/fU2snI/Cpz7OzIgsv/ll4iDeG0Btca2jY+4VE4K2Tl/883qCyLaLLLFJHIUNOE5jxqqHjtdTGJDW3PlUYRTyY7oUhxGjt80wwMqrP7cEiRkAlnAuJjQOlHIVpFpMy56ssAEFE+PiLkm20nxg5lu9uUyjZKqEn4cLDxOPxYvxeK6AEDDiU5CLRe3dgelCPXv2gUILQdHnlVIQ3Co20Rx8rVo4NGetYpInPCfIeG4t4rJjGbdCDFXW353JlbLuNmtBJJmNF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TN8mniShMZYjJmwkLJimUu8E9xNI40xiymwIwmXbORY=;
 b=Xyq7bkIcDsQ7jMLBhKUU326W7FTZM/iJgOJhMvSwntAKpy0Tz8OurlT/lKD41FBf+xsFDM8YSX5wal/s6tWcaQGQnrZ3Hn9MS3/IeOx+YRichtHrB+4Z/Ry1HGH0T7uPOJK0F7oaP+XQAeSbfAuZRLu7sRMACLEZ735FBxwU7E8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB3720.namprd10.prod.outlook.com (2603:10b6:a03:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 14:26:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 14:26:47 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Hugh Dickins <hughd@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6 00/71] Introducing the Maple Tree
Thread-Topic: [PATCH v6 00/71] Introducing the Maple Tree
Thread-Index: AQHYInmXxzMTjmF25U+e/3QAVwcn6KyjsEsAgAEA+wCAABTmAIAABoMAgAAlWwCAADGWgIABZhqAgAKPuQA=
Date:   Mon, 28 Feb 2022 14:26:46 +0000
Message-ID: <20220228142640.hitsubcjw3v2oues@revolver>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <YhhRrBpXTFolUAKi@qian> <20220225190846.u4fwebimd5ejfdpd@revolver>
 <20220225202334.bsw5t3retcchpn2e@revolver> <YhlAPOquxUICyGsR@qian>
 <Yhlfkk/gTz6a/hOD@archlinux-ax161> <20220226015803.h4w6y3doe3om2sbc@revolver>
 <5f8f4f-ad63-eb-fd73-d48748af8a76@google.com>
In-Reply-To: <5f8f4f-ad63-eb-fd73-d48748af8a76@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84148a59-1a59-46f7-9bb5-08d9fac65a0f
x-ms-traffictypediagnostic: BYAPR10MB3720:EE_
x-microsoft-antispam-prvs: <BYAPR10MB37200D284F565AB7C4EC1B8DFD019@BYAPR10MB3720.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y2T5erqG8qxYknX3HbD/Ri5cGLFA3GAGz7ToPHMtYN1XRWwX2Qbpof2sP16d+YSWD0vPajHl3avg4FOTmDJIYuvDKUOV9uI8/MGZ1TZSrRqCzYPS1kjq6J1cjeWK+asG0NNhuGzIzRuC7fuKWpjK0JKsZsW9LlPROC2XSqKsk5TU+LIpWbRIFs+G+dJSJrJ7EQMCCGRKq3HLZ9m1ROZyktaSOZ1f044C07LRLJczoaPgYgqcxvkcZctYYQmuHL0LKz24LvnmO0ZeEXFyB+Yf1ssbCecaYP6fljCtRWqrtUh/1JrQvONheJU3+2R3Ipr8592m4EcPSXuJyAixPLb7BrJRyGgVsbFYkYDcuZXR4FlPgVgqpzemAUyrAqSHw6Jf+JgSzQE8ibbfZsIgwii9Gmz0c+pv4BlfQBq2w5rWuwK2Ur+RmyczUXHZBm9Q6qBimU7Ekgi/9Pi/Z+05SYhj7itq95xWQGSCAj2rn/J1bMcOgK1j0tLd3eKonjepviAFDUL4UeyF6kJBpFIxEcd70G3tADu9y22K9UdDiEP/lAbyXckWHcikre+FrWgN6ki+wTmHHUFhRRbuxq9vWSl7Ht8u+mCFMOSOD20tspLZOVAsNWE4aT1aeYPtC72U4sn+MO6tu/8wCNaZi6QXGcPmg4Ez+jJO6tkjwL0LJpFMyGLxjQIlNziLz1n3gacdoVKXHIPjR13mdldz+9HOK9woapj1lxwzHmHPulZQkMwulwg6OyvD3VKoVkBvWAXQdPCoX/HCC9Kh9JxlKMsTIbsD+9DI6JV9WMzo++IWkUUm7E0SILg9Wsdd94S0yKEkgepiJ1fhHVeMyU9z3r5pvA4Xuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(83380400001)(8936002)(6506007)(71200400001)(186003)(26005)(6486002)(966005)(6512007)(9686003)(508600001)(110136005)(54906003)(38070700005)(316002)(122000001)(66476007)(64756008)(33716001)(66556008)(2906002)(8676002)(66446008)(4326008)(38100700002)(44832011)(86362001)(7416002)(5660300002)(91956017)(66946007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0oaLjvOXdsVh52LtDLj9ujXc4CvpTT2wjd9Px4BmiMMq2Py8MM6schs3c/n0?=
 =?us-ascii?Q?K+8C3V3qDSR4unXtloZd/YP5Z6KH/hiPXD7eoBOUXQyagsrtCIlglP3WYJ6m?=
 =?us-ascii?Q?6F2Js7rfXbHNKLBR68vQb7Dkz5Dk3tv95zaEyjexzRF7oSjYmD4NrBXZ7/rJ?=
 =?us-ascii?Q?jJO6GWsDITAMzVXlaEEn3pveeCBpcIlQGNgKdAqOH+hVVRkvkHa65aeRVBA1?=
 =?us-ascii?Q?eRTDgjmmRNrZuKE9a8WpGLhySrumO1jv1goaRloWjubfb9aKPSsGOEo4PsCb?=
 =?us-ascii?Q?dy8Aa7F7THW4iej/IhJiR/yuJw5W/wjUsHmBg98KPhuQlcVTs1nwOabimGLu?=
 =?us-ascii?Q?GOQfIwMcntx7c/S6+gQtC+n20BGVq3VKiaob3eHjN7/vCxLokHR0lvVhfCPq?=
 =?us-ascii?Q?0jl8y67MalEboiTvjDlGzGAeyBo55bBu0iuDq+e7EAgnyZZi/A7808GvIh+H?=
 =?us-ascii?Q?oiJQh17tKPKjKmRtoNuxPVT3kmzbsp0r60uRU5ceBrWxSx2Bb3JNSfcZVHSq?=
 =?us-ascii?Q?2r1BZKzC2AS+nLSXJhcleEvE2NReY9nAehzrvsgHuYo9Z4uatjjJYTZxXGo7?=
 =?us-ascii?Q?YWL3Pv7x65yf+PIbU3vY3b66nnGz78wHe6ohXBVEHSahyXaYxYTTwFcJnYsP?=
 =?us-ascii?Q?dvPuTChi06NLD4bhwZ1nurzDZPj4W/+TVg7Hn+fZkOW2KVePV5ISg7WLKC5s?=
 =?us-ascii?Q?TLwaX0Zt4mt9k6e5aQULOYbXs8dCx59KzP43rr6zdC6wwKTydmHPDEzI4yho?=
 =?us-ascii?Q?JHY0+OYO3tV1vKIbkcBfP9PdKpvBGYbCcI4GsD7fS5AVkxDlPvlVQEkUi3Dk?=
 =?us-ascii?Q?wNfJGXe9KvY93gtwE929V6gL8XBroRyH3ja9wRrSLB4sSdq3yj9YAbbYSIfL?=
 =?us-ascii?Q?D9UKRCu5gTUkGii0Fn+guNwMFA3kEmxfpb0akr+Kx1ZwF1XdiBxGMvFWwQnp?=
 =?us-ascii?Q?3Iqe1WncEK8eif7s6UPK+rxSRKRjBh7aQiypDW3DPP/h+ESZgIvaPF41e9lV?=
 =?us-ascii?Q?Be9FP5yzSFPhvkeyjvzF5LcyTZzBngkeAcNm/oqXAhNwqeMaKikKB8a4cAzW?=
 =?us-ascii?Q?whmedk6PcxyJKiMFh6B7MCHQSg3BMYBuFURPRDvAuEFjy3MKR2kj5dQmbJfO?=
 =?us-ascii?Q?bw0VCXU6WM4ZWcj+Dgc3eHc6mAFOi8c5vfnnsVbeIk3ixPWE3zjpbqFXZMTl?=
 =?us-ascii?Q?JAx9X+6Q0wuAjwfqMlZyaEQpeDtVA2k/wqC0GNQUNOZ9Nm5uSQ+5B8B2swvW?=
 =?us-ascii?Q?iIFgm3GWK1C4QCfFPyVi+azc1sZoAHZFSOJ9YRpk2Yuc+OhTVbUjqIbZZfl1?=
 =?us-ascii?Q?Czqd8ad3JLtewLCrZnyHbKz2AV9v6E3p3Fd1oQRDLQgSSTpKDi5vtT9jOmXD?=
 =?us-ascii?Q?GA1vxrFu6MQ7Dbzoat4dcn/FritxFKdQB5dFFcGXnpvE0RaZJC5eNYcxm9os?=
 =?us-ascii?Q?2LdBr5SUoX+RtlLCIR0YEPCDLAT+7a3W5mqAdr8CfSHRNFI/Q7GOS4nfHQDA?=
 =?us-ascii?Q?AGsMgOX6aYwoI3C47vUysB7fKMSuBRCzyNm/mkhCwdL1GlKktx+H837Euhbn?=
 =?us-ascii?Q?BhA8NAkwN1UipaJ1GMkh8MHbxvzEHkk0eKUB+HmeOCzRMIJYME3cGrdhV9Ne?=
 =?us-ascii?Q?tSAfNzl+GFjKOOzSonWVAA8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24A14B30E444B046A13B24D04E9B502C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84148a59-1a59-46f7-9bb5-08d9fac65a0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 14:26:47.0139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kW9Vbbqt2/zIkjDb23PD2OdRs+e3ziCE7x9OLyOpVVuZR8spXWKgXJa51YJRVD9SOMLYRwnuX1MiFFhHxJN8Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3720
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280076
X-Proofpoint-ORIG-GUID: lTVTDOP_3OGlMmyrw_hMbgEuDEOZF52L
X-Proofpoint-GUID: lTVTDOP_3OGlMmyrw_hMbgEuDEOZF52L
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins <hughd@google.com> [220226 18:20]:
> On Sat, 26 Feb 2022, Liam Howlett wrote:
> > * Nathan Chancellor <nathan@kernel.org> [220225 18:00]:
> > > On Fri, Feb 25, 2022 at 03:46:52PM -0500, Qian Cai wrote:
> > > > On Fri, Feb 25, 2022 at 08:23:41PM +0000, Liam Howlett wrote:
> > > > > I just booted an arm64 VM with my build and kasan enabled with no=
 issue.
> > > > > Could you please send me your config file for the build?
> > > >=20
> > > > On linux-next, I just do:
> > > >=20
> > > > $ make arch=3Darm64 defconfig debug.config [1]
> > > >=20
> > > > Then, I just generate some memory pressume into swapping/OOM Killer=
 to
> > > > trigger it.
> > > >=20
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git/tree/kernel/configs/debug.config
> > >=20
> > > Is the stacktrace [1] related to the conflict that Mark encountered [=
2]
> > > while merging the maple and folio trees? Booting a next-20220223 kern=
el
> > > on my Raspberry Pi 3 and 4 shows constant NULL pointer dereferences
> > > (just ARCH=3Darm and ARCH=3Darm64 defconfigs) and reverting the folio=
 and
> > > maple tree merges makes everything work properly again.
> > >=20
> > > [1]: https://lore.kernel.org/r/YhhRrBpXTFolUAKi@qian/
> > > [2]: https://lore.kernel.org/r/20220224011653.1380557-1-broonie@kerne=
l.org/
> >=20
> > Maybe?  I'm trying to figure out why it's having issues.. I've not been
> > able to reproduce it with just my maple tree branch.  Steven Rostedt
> > found a bad commit that has been fixed in either 20220224, I believe
> > [1].  It might be best to try next-20220225 and see if you have better
> > luck if that's an option.
> >=20
> > [1]:
> > https://lore.kernel.org/linux-fsdevel/f6fb6fd4-dcf2-4326-d25e-9a4a9dad5=
020@fb.com/T/#t
>=20
> Hi Liam, I think I have the beginnings of an answer for Qian's issue,
> details below; but first off, I'd better make my own opinion clear.
>=20
> I think this series, however good it may be so far, is undertested and
> not approaching ready for 5.18, and should not have been pushed via
> git tree into 5.17-rc-late-stage linux-next, subverting Andrew's mmotm.
>=20
> I believe Stephen and Mark should drop it from linux-next for now,
> while linux-next stabilizes for 5.18, while you work on testing and
> fixing, and resubmit rebased to 5.18-rc1 or -rc2 when you're ready.

Hugh,

Thank you for your testing, review, and thoughts on the maple tree.  I
agree with your findings and see the error, although still have
difficulty reproducing on amd64 and arm64 VMs.

Stephen, Please drop the maple tree from linux-next.


Thank you,
Liam=
