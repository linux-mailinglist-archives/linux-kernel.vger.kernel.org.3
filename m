Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8437F46677E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359325AbhLBQFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:05:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17768 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347781AbhLBQFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:05:36 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2FM0ZJ015774;
        Thu, 2 Dec 2021 15:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=8b9j0CiIBpGm4ilMfyH2oQrNS1IkXaq553aNZWU3XbM=;
 b=HdNvFX6hD5rdqfDVyFzqPIwp9dGq+fDrgGzr67XmN8B+jvjy6k4qLJKA5G5pHdou5ajy
 r70CNSJJ2qPmQpPRPBeABpeWdFt/HKsA0HX+ZmGsOZeu7j+UPWzMzRH8mtXbXqmEr5yX
 jhv1ugl2JTGUxJZepA8tGVqYPSUKPhexNjYZPX5lxZLIE7OjKF+1DBsOc+UlvuEoF4dG
 /ykseHd0lewEhyT17APBdt7qaxFO9QogrQPzRrxcqDPvt7hu605OCT1qZNoVIv2ir9lZ
 Sylt42Kwx81VFTaFbZdZ6VWL4oHPOKXzv/Ah3730tVB/kUE/RqpzhLNBDlEfCaB4qF5n yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7t1rhnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Dec 2021 15:50:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B2FjqaK101168;
        Thu, 2 Dec 2021 15:50:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3020.oracle.com with ESMTP id 3cnhvgvr81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Dec 2021 15:50:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGsmcHu/+PmoNvUchhIJmP4rFe7cn5zTSGwjkBkeGgx3LYcOfq57di7+hsynFyeZj5aHeLW9rOrIgaZ6JzU+Dni3JFPBPimFH8ZIkPUTUQyVkxf43G6h86wqy9scI5z69U7Xps3ajMHBmXZ/MiITWa0hbc3p7DecQBy/Wuo3n1MnLuuUnqHiCtKOzN4ldVndeVfy2topI8eEN6TQRcpEbqz0WGtCaU9t3eav6nLCvhF2m6Mm8xwuG9em9qixyscDu8zjtAc9ZPyxPlhXMtw1qBgXVmvO8ypEgItgRFlRcoa1vJbXJPfUfwFpUSomG+g9GfL8JknY4mZCZXpbZ55V9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8b9j0CiIBpGm4ilMfyH2oQrNS1IkXaq553aNZWU3XbM=;
 b=TbpE+BB1rLbY0l/Ps4FMWLQn2iZFH6CAsnBr0ZrTu14tS2QOa3W3FWZmp1J1IEk3bGV2z32txgo5onSH3+Mfl7pw4D9pz7FtB470VUjYp4UkUvh+z5xXOOa2EBvr0Sz3+Qn5jLaewaWEnLHsfaouUgoa4wrV8hHiYM0lylK/k7Mya/4NphIXdXC3XtHvYk1ZPcGNBS3Qzko1lOI6vDi0hdntMPJbHUyrCsvspXszOm7WJ9evIqMVMiRut9MsYrZx5VfROl3xwQlVzXvxUIMa+pBEEfcRE1hhkC/hMahW6IcqRJ9HacN44VAmwT8l5n6BP0YZcmAST8/DzclI81So+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8b9j0CiIBpGm4ilMfyH2oQrNS1IkXaq553aNZWU3XbM=;
 b=whqdsUp2TYK1q3QttYc2dBF+Etkk+DVNk+IU9crbL/7wW+cTofVk1fCAaTfxLzWMIkqlOp+w0w6+u0MVcflu6Ags9fKah2GTeRCMI7PWrIYpe2oA8woWVcLN+xLHFaHAq3j3w+qrpApkoM8t111ZXpVaXjrLoAx86535Yp8T2mY=
Received: from PH0PR10MB5660.namprd10.prod.outlook.com (2603:10b6:510:ff::6)
 by PH0PR10MB5872.namprd10.prod.outlook.com (2603:10b6:510:146::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 2 Dec
 2021 15:50:02 +0000
Received: from PH0PR10MB5660.namprd10.prod.outlook.com
 ([fe80::edf9:9b48:57b3:2a20]) by PH0PR10MB5660.namprd10.prod.outlook.com
 ([fe80::edf9:9b48:57b3:2a20%6]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 15:50:02 +0000
From:   John Haxby <john.haxby@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jeffrey Walton <noloader@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Simo Sorce <simo@redhat.com>,
        Stephan Mueller <smueller@chronox.de>, Tso Ted <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Thread-Topic: [PATCH v43 01/15] Linux Random Number Generator
Thread-Index: AQHX3vewWy39tI151EiqhdM1dyRTOqwOlDWAgAEQ04CABlX5gIAACNuAgAABvwCABKj0gIAADu0AgAFO9YCAABvzgIAAB4GAgAAU1wCAACnxgIAABo6AgAARSwCAAVVDAIAAFX6AgAASNgCAAGSUgIAAcfWAgACQkoA=
Date:   Thu, 2 Dec 2021 15:50:02 +0000
Message-ID: <B4344F73-2591-40F0-AD5D-3E3C86D2288F@oracle.com>
References: <YaYvYdnSaAvS8MAk@kroah.com>
 <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
 <YaZHKHjomEivul6U@kroah.com> <YaZqVxI1C8RByq+w@gmail.com>
 <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
 <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <49d6091e571e24efff7bc4dc70c4c62628eb0782.camel@redhat.com>
 <CAHmME9q-WUGQ7NUO7oafUBkGBNtWePGXHGfEd2rTmZMUA49+DQ@mail.gmail.com>
 <CAH8yC8k1WMwjoUXY_2nWjLMLVLPQsno3asyDEYVRJ4pg=OpLQA@mail.gmail.com>
 <Yahx41BRXW5E7yWQ@kroah.com>
In-Reply-To: <Yahx41BRXW5E7yWQ@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8957c9a3-e21f-479a-772d-08d9b5ab6715
x-ms-traffictypediagnostic: PH0PR10MB5872:
x-microsoft-antispam-prvs: <PH0PR10MB58728A3F7A4DA7B445574141E4699@PH0PR10MB5872.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4tkd/Pu9iYBHP4gpvm5k0ZIpUbKEoYa7yJC99oGJVcciWP7z99EGdebgrGIDJtLzw1aYkCc5CgGBEkYInbh1qStwFIrk3ex0HE1dLKpcGOaMgxsgp4IN4ZGvNqoYRmx/681bv0ktouS4io/zlWhU9uzydS+BdCBb2cobTINIlqItXv5pFpUg74qADtf6Q1ulKhfLuX8jfWnZqumVSS5GOXSFuBr67wfkS1+znH2GJClfA/0zdXOOOavgHqA144FynOX43zMWrNpoSWjzGPl3LrvKz0kfow4MPUTxrarw8GVr19T9mm0CsiRSAkEkGMbYHhPaQ1OelmOsTCGIuNnX9mO7hkM7niGJhuApW9d9660DFKhdiC9nH01WOGBNInZ93goE7K8CoQzvZyWQ7h/gjRLt9x+P0AkMmwS7lpGvGXPwarVxnCIYsCG4Zf+H9YCalNeF9VUp5l09jk5Tywjn4z+77KWXBZqvTwLGpsPIC9Yyjpv2EfdNfwvDQI7rHt5uOC92gb7sU0T3NPWFUiQUSbN5+tMyvjJQzhrYZST6rz5UTXHM1qVwTLAAd/PKNj2tjpMiQsQlh2Ql7Sq/Z+fNiF7l786JNDRJ8yQRvmjg71wSc6dlj8j2xnU/URbDUyDiPC3m/rRjHvF9a4949nzr9Xt3tDBClCI8AMSHo0olR27kOAX3weEL7r9h+qywmVLSPKGh7U+foOOx4HMMFWV/W7RHGMW9UeV5A87iboNx3Ze0Plsybc9wMjkCTQENWc9+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(91956017)(33656002)(38070700005)(53546011)(508600001)(7416002)(316002)(6916009)(2906002)(6506007)(186003)(66446008)(86362001)(38100700002)(66556008)(54906003)(5660300002)(7406005)(66476007)(122000001)(8936002)(83380400001)(44832011)(36756003)(6512007)(71200400001)(99936003)(6486002)(2616005)(76116006)(64756008)(8676002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?st0eJD+YTKciH0H/eXr340VdWXLD35XkhPoMCpA25z/1EWuDBYhWg5g1HLTF?=
 =?us-ascii?Q?d6EkdkZ0tsR/OD3JRS/yBosJ7+bZ0VwLP1rOoBKNgHlhqkMdP8w3kf7NN1/O?=
 =?us-ascii?Q?eIrQ0FNjhCqkgn0+dgimEmGP1bMCcWgs5Uxw2X+DIVDb1rQiTvER+F4c9n1W?=
 =?us-ascii?Q?fCQbO5OO8RgGfEqH5QVBsr+CpcwwOitdzW6xBIGs64fCf6snl4ItK/mbUcTP?=
 =?us-ascii?Q?uDGmjLEw7lOkcRwlczgVLq7diGV2mXeHkXyRY1gdcsyVZRRmubtgdkr1E+Z0?=
 =?us-ascii?Q?rqjnmjyG3BkQ7W+P2s+yQDPLDZGedxC0J2tlotRC7/jUnPI1t+6E4FP1Y/uR?=
 =?us-ascii?Q?2QRD+NvYzvybBQOQJRUlog4VwdieCuaxNOVsK22Ji0uV9bV5lVQ1kajjJAdt?=
 =?us-ascii?Q?/7bvvuO4zVIkKq4imOgSN26NZq54LUIFZD/4EHmb0iIoYACBc9qg3gkuT821?=
 =?us-ascii?Q?PpHFHATzMwx5LyBgogJm4fhk0PBqMp8RGhnJCBr6nBJnJHArvESMlNl388ey?=
 =?us-ascii?Q?8TMq5SZoCXOXz0cNuYEi1o5M25yXP7E1PdEeQchvD0kb7JL29Vr/JJwPFAqh?=
 =?us-ascii?Q?1z/J13LH0Ip0IGM6rAoDAydYFahLqsg8WVgpmlDxRCxupXhTup6lKdiGlTfK?=
 =?us-ascii?Q?Ik4pJUppGoUKRUliHcUZliscgPeMpFlQ/TQ7zBLztTAzG4g4knnH/y95MvGs?=
 =?us-ascii?Q?KkBE6AnaeiETpDn2lo9p9LZzMqXaPEJj/AGAx54t1CUSLP0PiAUQQ2f942+c?=
 =?us-ascii?Q?F7UiO6Y5C2plsaf2gcCFosVy7d7WoiZWoawX0I+EaC36Of4qL/QhFD7U21Sw?=
 =?us-ascii?Q?61WZ+DXE25VkRSHj5VgkUFBYLbQmZUIHctvrLdW7cMsgdJmPckyk0LDFKAqi?=
 =?us-ascii?Q?greH9Vz0KUow3x2OB+Dz67sRpI06Z6YU07GJ4SJ8F6KImWqSNtzRvv92anSd?=
 =?us-ascii?Q?r9VIr2/ysbcV7XHXd74u0U9RVNoM7/tcPAXJ2WwhbH5Ytz54fQ9HciupRLeW?=
 =?us-ascii?Q?f6FnrulIYN6Qn0tx2nujpiLU3x1sNMmHOKt4buJYrie23TuqxCQaFu26ixDV?=
 =?us-ascii?Q?9DBJj+vYKtYFU4qhEQIeTtnB3fzRjSnfYos8TcRqwT0cE2HhUXRDN0+L0Aqi?=
 =?us-ascii?Q?VEmlBqI41cK5gZiINmhigTUiMoWe3DTKnYEt5q/WNMFGrJm4pyoWlBaT8LQP?=
 =?us-ascii?Q?xqsYeCXacvpUMfA8acrfyW8FCh4GKQaOKLZtwtTxXwFOu0ysTAP+E7dYTHXL?=
 =?us-ascii?Q?+1x1GGiv+/wvVRyCpmb+zsrgO9Ro6/w4Aiunlxs6S9aoN7APdcnsd0I8kM7A?=
 =?us-ascii?Q?81ki2iEautzI44e/iv3CuST+xBaJriZAUlrWC4s1lN4gSwtNoKkMp/EIKnN3?=
 =?us-ascii?Q?OO3T5JmdXSoECIW+UN1iozj3gHf7ulWYJpd3k9m2b7VTRHvISdZAzbYFNw24?=
 =?us-ascii?Q?N52rdAd1fi3vLRVfASFSYFhB9m/ac1wSFkNgylk/F6qdYBCQSMiKzrpOB7Yo?=
 =?us-ascii?Q?DzX7bwTuc/h2hvDwprfV8OKSBswY7spkK/FTYC5WP3MBNZ3bNEJAOXwIB9Kq?=
 =?us-ascii?Q?FS4tAwfceLL7X8rznyzV9vL8XoCiRLZ9Ewcu9DgTAWVwGpbctMLo2vny3i/V?=
 =?us-ascii?Q?2gfYEYceNwxPHKvbsaod5BRYxTn89H52No9cXp9aGDFwe9ysTrPh6tiOeZb9?=
 =?us-ascii?Q?2Q8y2V1ixuOFjEw7hM+TLh0crFI=3D?=
Content-Type: multipart/signed;
        boundary="Apple-Mail=_142DB8CB-0477-40BA-BBFB-BCFA93F11EB6";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8957c9a3-e21f-479a-772d-08d9b5ab6715
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 15:50:02.2195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 95O0Q3zHT42SHDJZJVx0rjWnEzgKmHnigmwM8Tbtt8mpiNv2qhryQO8mCu9dHvdWppJjb1ArLHuEutBHAiQixA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5872
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112020104
X-Proofpoint-ORIG-GUID: CSPlcsGNHtVRaISRloy1gQtzrNYifpIs
X-Proofpoint-GUID: CSPlcsGNHtVRaISRloy1gQtzrNYifpIs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_142DB8CB-0477-40BA-BBFB-BCFA93F11EB6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 2 Dec 2021, at 07:12, Greg Kroah-Hartman =
<gregkh@linuxfoundation.org> wrote:
>=20
> On Wed, Dec 01, 2021 at 07:24:43PM -0500, Jeffrey Walton wrote:
>> On Wed, Dec 1, 2021 at 1:25 PM Jason A. Donenfeld <Jason@zx2c4.com> =
wrote:
>>>=20
>>> On Wed, Dec 1, 2021 at 12:19 PM Simo Sorce <simo@redhat.com> wrote:
>>>> that much it is, and it is a required one. However having worked a =
lot
>>>> on this I can tell you there is actually real cryptographic value =
in
>>>> the requirements FIPS introduced over the years
>>>> Well I think most of the requirements are sane practices, hopefully
>>>> controversial stuff will be minimal.
>>>> I happen to think quite a few of the requirements are actually good
>>>> ideas to implement to improve the guarantees of randomness
>>>=20
>>> If you think there are good ways to improve the RNG, of course send
>>> patches for this, justifying why, taking into account recent =
research
>>> into the topic you wish to patch, etc. Don't write, "because FIPS";
>>> instead argue rationale for each patch. And if you _do_ feel the =
need
>>> to appeal to authority, perhaps links to the various eprint papers =
you
>>> consulted would be worthwhile. Preferably you're able to do this in =
a
>>> small, incremental way, with small standalone patchsets, instead of
>>> gigantic series.
>>=20
>> I may be parsing things incorrectly, but you seem to be rejecting the
>> NIST requirements, and then positioning your personal opinion as
>> superior. It sounds like one authority is being replaced by another.
>> Perhaps I am missing something.
>>=20
>> I am also guessing you've never read the relevant NIST documents. The
>> documents state the security goals and provide the steps to achieve
>> them in an implementation.
>=20
> Ok, I think this thread has gone on long enough without any real
> patches.
>=20
> Please, if you want to support NIST, or any other type of thing, =
submit
> patches that implement what you think will help achieve this.  Absent =
of
> that, we have no idea what NIST or any other random document aims to
> require or wish.


Part of the problem here is that NIST (and the concomitant fips =
certification) is a moving target.   A couple of years ago, we were =
fine. Today's requirements are different, tomorrow's will be different =
again.  Today's requirements being different are what resulted in the =
small patch I mentioned earlier.

You suggested, Greg, that I submit that and see what happens.   I can =
take a hint :) so I'm working on that as a possible way forward to =
decouple things a bit without too much churn.

jch



>=20
> thanks,
>=20
> greg k-h


--Apple-Mail=_142DB8CB-0477-40BA-BBFB-BCFA93F11EB6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQT+pxvb11CFWUkNSOVFC7t+lC+jyAUCYajrKQAKCRBFC7t+lC+j
yLESAP9YvxlsPc4rSOfaHCEA3ni2teG5iztqEsknHDpm/67VyAEAhWogejRp+8KS
jPNSPXQefnHSshWertNeARZR1a351jY=
=IGXH
-----END PGP SIGNATURE-----

--Apple-Mail=_142DB8CB-0477-40BA-BBFB-BCFA93F11EB6--
