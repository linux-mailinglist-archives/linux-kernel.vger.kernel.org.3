Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB91F4D0617
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244678AbiCGSOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239563AbiCGSOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:14:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10662554BA;
        Mon,  7 Mar 2022 10:13:21 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 227HFZ1r028771;
        Mon, 7 Mar 2022 18:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YVuF6NP1VQBl8yY3XGh33qon/WRSsnISKMnsSgcczy4=;
 b=Qi4nPDUh7/fNnMmfJTjcR5VJ1ib5MEz+RD4/IAD+IGZa/bZnxHEn9F4op7iwZ6dEO8ft
 5POlqItD7YC9Wit9YnJtPYZYH0Cqq3x77YKfUm1HPe5UzOhe2ZTKYRceYZMKoRjNdOfH
 /zZq1Ny8HYZN4YdvjaFL+EklwOeV2jV6+OM5TTbpxEL/xiBH/ynm/vilFUNNVjNAtXt3
 wiOerVEQZvow3Le8loiZyyIUxfKfJRxXRjOKcXKLh/g79N35NiAnal+G8msr/BtjqxZt
 vnPc8wg1TTm79sdIQoFY6ApKFQtay47VnmJ66KfxiwwVEbbV9nfuxquY89gmy0I8iM/j IQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyfscn2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 18:13:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 227IB7L6192341;
        Mon, 7 Mar 2022 18:13:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by aserp3020.oracle.com with ESMTP id 3ekyp1c6y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 18:13:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATQzX7Pn9HteX18dv9DF+Drq3Jj6uCGQV+T+oFwYR2m36N4k0imrPAoF4PSaSKA4BfjEONF874VMZEIzhLcgOHt7Pl2qdfMfLnVCwYXzAxjFcOYW4BM55ytf+thTbYBAlRdyuq+XQXW4T7xkMtT7Lo3rRhJN8sSP+ow6P75O1GSsOOqxHnisElh5DSJTiSTfcylhuNgmHXJhdgRShGEAkdlO8hGRp/v7egkcczdc05LD8i8S0nKxbZl0GL1Pc4MzRmpiWHbhvdwR5KVQ6jUzPgyouwBiIdymUViLRfRmdK/3LAsAADGsuhcGKTlfchGGAHIZ1BxsjLi1CG6o2ea2Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVuF6NP1VQBl8yY3XGh33qon/WRSsnISKMnsSgcczy4=;
 b=VvLR/hPcMwof/wMjYAkAe+jv6qNQ19KXZQvH0Cuyl6PE0i5kytqOhaUyRMQikyYKoeT1UAqJUpFnbCQ1pjsmjmZGsjn8bQKwiFsS9GFCESHCakqIgq9f0mYMIXniLP+NwjDaLC1D5OCEa9z6NWF0sFqWlveNG5mbSs9/4pVAjaHU4mOHY9vCPv5ljU/BDNUMrP0yxMdN7s5kdf7g0UG9z/72zMUe98cd5wL96rWiGPGP8pyY385RtsR6vb7LdI1gZR7J6P4CGfaSaEz/oIjBCLZf3fL3qLVGrtupl+yn4aBaHYaL0/DM7+jXftcTVw4NnheAOsdyYIFDxYZ1DU7t1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVuF6NP1VQBl8yY3XGh33qon/WRSsnISKMnsSgcczy4=;
 b=yO1cNg9ozyg/oMI/3sHnjq7eq5XxvqmvsFQX0RDg8Kv6jDAmoLc3hWcucxpmhtOI9kFzbtuT6OAkk8SGANtz2vB2lpCy3sSNlnp9dWWtGvlZDgms09/gZVZTv1CbfZbVNddsVls37aLluA0qZi8YvwvrKhVfD9sLt+RkYnAOIn8=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MN2PR10MB3134.namprd10.prod.outlook.com (2603:10b6:208:128::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.21; Mon, 7 Mar
 2022 18:13:02 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a%7]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 18:13:02 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "mic@linux.microsoft.com" <mic@linux.microsoft.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 4/4] integrity: CA enforcement in machine keyring
Thread-Topic: [PATCH 4/4] integrity: CA enforcement in machine keyring
Thread-Index: AQHYLZNB/4y9NCkFlkOR37jouCPamKyv4ZWAgARhOoA=
Date:   Mon, 7 Mar 2022 18:13:02 +0000
Message-ID: <64A87331-C97E-4565-B222-9BF7208E5010@oracle.com>
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
 <20220301173651.3435350-5-eric.snowberg@oracle.com>
 <59f08890-f3f9-43fe-e1cc-6648071e33e0@linux.ibm.com>
In-Reply-To: <59f08890-f3f9-43fe-e1cc-6648071e33e0@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 722456bb-8102-413b-a12a-08da00661e80
x-ms-traffictypediagnostic: MN2PR10MB3134:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3134C36AE93EEF5B6811AA5B87089@MN2PR10MB3134.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4tATGp+BHw6tsGjP0noqPf0Z+zjzFUAfvvxvRYkVyxnGUQehU4/I032iDHIsFpqUCt91/bjFhTdLkfLYf5FLhH84WXhe8rIaoHdmOk4vztOkqAXxbpSI/m5AFaz5JHf8ExfIl3b917mhClSXM+3F61atCl88QIA227mKNFcA5JUPZXCFtEe8QOPrRnN34KSJsvpbwVxulHfEvUNiMAcQXRDxXNwBQlWkO1tBjZkxBYpFvQWOK8OHeFN6StFzQZabtf8HjF+SY/6NA+RWyslYRdEOe9HQQdxMiO+R0uBTqjav0jTLlCTDv8Xwn8U/ml7g7HJcxqhm46q2svaEtiF+SWz1tADUhPnABjeXV2wiytxpIXg/kBQw2S3uu/MeinU9lU76JSgpY+F3LMrkHEWARgi4mA0SJFgNpl9A/2eCSbY3D3ALuOFBXM8MY9zsv5Z8SzFclYaphSuWKHCiDgnGaKYVNoxMeaHNmVvVjMOYBL3tNR8xi4Hs8iOWkW/oGz3kswsIzJyOUmGaQ5DgWEC+p6/ImP0HnndMiSSTwUfn6uUGQTzS4vWMWGXW1BBFCTvlfbbv6YBcXnL5y+66joPRw74oD/oiD0AmPW0HFVZyXS+Q8OtJNQfMbWd1a3QN6BVo8bce+H4KcGSakaNHJK25GW/tHB3XKckNWokD52odHbkuC0sVagSER33uhn4n/hii1y/uV/QPrjUGZTogwPiMq+B3iG6Hjp7xCDXaRiB68b5auxiXs5ufb8s4w6iNB09jfeKTS/BTIzPc9T1N7i7ddhRYoKJa0joFiRt4B1rGYqXidaZhLUIeeGRf02zOI4dqnhOSzL9VPiueejFq6cfCNeRScOvwvan0rohZ9ay8REU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(38070700005)(122000001)(38100700002)(83380400001)(2616005)(186003)(26005)(86362001)(316002)(8936002)(6916009)(36756003)(33656002)(66476007)(54906003)(76116006)(91956017)(4326008)(8676002)(66446008)(64756008)(66556008)(66946007)(966005)(7416002)(44832011)(53546011)(508600001)(6506007)(2906002)(6486002)(71200400001)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W29ut7bpVXWnbOD376MnmPkUvgHicLebMCJHzUa4RFtgbDbL+tQhXJCg9MFx?=
 =?us-ascii?Q?M4Blgac8CVkD70tix8ofZs7xZFGg+QSgK3HZl8YviibBC0pYc6IZn0f8Prpp?=
 =?us-ascii?Q?r/G9Y5KrH8SVpi13fOldNfqPCS/CvcfFQwy5OiJew/mbRnWrkYfYdrp3Jpil?=
 =?us-ascii?Q?05sHz/iKakYa6+eekMjnrzV6xmeI65Rf/Et5ytaff/lomkxXGHXx+NpaOn3q?=
 =?us-ascii?Q?z5sT40MpESEPnvf+nDDm0b1/tAUQfLgnAFuB4OzO51ltgIchIwwFcn0eMOfO?=
 =?us-ascii?Q?dtFGuxT/+6zkMF7ZJafHuD6iNPet6f3G1holNQHVwm7hZkTCn+U36sWP4qNP?=
 =?us-ascii?Q?ZmXeLnjzfnGpGHCzeZyVCigb51TqXzaF4TU5X+Sc1NiUQDxDJUMweOTVp+Lg?=
 =?us-ascii?Q?qOI+b2Ogf3I8kqIf96uQn1AtfE+r+V40wtZ+PD9uFbeEAiyNG0q2ACN53s+a?=
 =?us-ascii?Q?zAO3U5Ng5x/8s9zYvMObD7IaNuSTpl1SQTJdHqx9E7S5NcNL+Gal8aI0C68A?=
 =?us-ascii?Q?w5a9RHcMK+B+CEIUE+FPIqM1KdpAxiMe6cI/36maSeFuDKKlF8+QpEbOlQXJ?=
 =?us-ascii?Q?kyy+fOHsmECI0mijBwF5x5iU2HLq/RraK+R+PsCPvjHMEAXWN86rEFnABSBR?=
 =?us-ascii?Q?8UNTVxq1r2ltNgw7YBWdYaCaihH4uBnuByu9mFpIm1o8KYosuJZ/eIjhK3KI?=
 =?us-ascii?Q?zboyKYpW/WzMg7agBfVu1qLZeJuermfqfEAHWkGSZN9HiPz4r3fLU40pRLE3?=
 =?us-ascii?Q?giKZckJoX8IizFXseUq+r0n/giD1SzTraWE8UmXGHek0SywvxbcCRoZtnc5G?=
 =?us-ascii?Q?agJzxaotPoWWXKUH5Iu5GFLbZSDEp7sFWVFTrw+72mebaHOVrmvKyyVNisM9?=
 =?us-ascii?Q?ptCYzqWxjdeg41qKlk37tbmbh9Feiyq4Z0YqWl7NQDKAl5NZ+9FI8KwkpqIS?=
 =?us-ascii?Q?5ieQ6X5VqC8B384/Ao2glWM+zICNg6G7LpSMW4dJXtoRYhP5vZC+Sd9RzTaE?=
 =?us-ascii?Q?ueultCLVy/Gj4LXq8BDC0AyqGBcfm6EzWaXIu4KHq+R2dpOHBB/BqiMpnboB?=
 =?us-ascii?Q?yq+ih/QggZF9IDF/G+6oFWZBMiuiDMK0McOLw/Ug5gtoE4D8Fp60PxpYGWJj?=
 =?us-ascii?Q?JJXoPbuXH3CDjuL5tLbWxx6R/4cOUj4q5LJZjpSCPi5k2W1uHEx9886GXzF1?=
 =?us-ascii?Q?ZYuY2soO0D1Dn/pVAq4u7eEnUZC0iHbw+E33MWT15qJ9I7YOxgWCeAJNrXU2?=
 =?us-ascii?Q?bZ6GbnQyjlg7wbWUBQ7tMAjTT4ugPMRkwGBC+pWDrZ8QQl2QLhotzwiKiPpl?=
 =?us-ascii?Q?5knBvjFZAswqXw/2UMUM8v4A8aUf2Fo8dF6ixZghfmm87hiJCJh7Op6vjWfX?=
 =?us-ascii?Q?QIkZiTeB1ptmIHBVwumje/jk1To08ZAYmbi+CoBK+novwt1b1rJNx3vm10/b?=
 =?us-ascii?Q?g2vnj62/SYadk0hwCCEYHY1zZMcqFn23B9O5k7Aoh8lZK56ol+iG0/HBpIRt?=
 =?us-ascii?Q?N785iiqzOQ4jtaZoHZ1k2fjVEODY2EP0yrJ/h6vu6aAnAV63ppA4olQ53UqX?=
 =?us-ascii?Q?/lm9+qwPUF5nabAELkK9slZnbIg3kdKnAaeiKV7XS4Oe1UeYBGxDOI/5aJyX?=
 =?us-ascii?Q?DR5uTY7fKQul7hZ1PmAzitp5GaMXuRl8PmkYHwKp3M0+oA7yPieH479SyFOO?=
 =?us-ascii?Q?nZc6/HLoYKFqph8PGLag7cZ6TWc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0D418E1AE413274DAEF05D2EAE0E9AA6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722456bb-8102-413b-a12a-08da00661e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 18:13:02.4444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7td9EGqZWew771+qsIOvWdCwqz5tt8n9QsjcE3iCBwee5KFj/BFz14oD0mGufDgM+ct+EaKO8BInLqU9LzcvUpz51sZVBgrN+At5QyoX1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3134
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10279 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203070103
X-Proofpoint-GUID: 90ONRFY6JsGy1QrUisfAY8JVPaM6MFpt
X-Proofpoint-ORIG-GUID: 90ONRFY6JsGy1QrUisfAY8JVPaM6MFpt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 4, 2022, at 4:19 PM, Stefan Berger <stefanb@linux.ibm.com> wrote:
>=20
>=20
> On 3/1/22 12:36, Eric Snowberg wrote:
>> When INTEGRITY_MACHINE_KEYRING is set, all Machine Owner Keys (MOK)
>> are loaded into the machine keyring.  Add a new
>> INTEGRITY_MACHINE_KEYRING_CA_ENFORCED option where only MOK CA keys are
>> added.
>>=20
>> Set the restriction check to restrict_link_by_ca.  This will only allow
>> CA keys into the machine keyring. Unlike when INTEGRITY_MACHINE_KEYRING
>> is enabled, IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY may
>> also be enabled, allowing IMA to use keys in the machine keyring as
>> another trust anchor.
>=20
> I tried to test this but could only do it by disabling the MokListTrusted=
RT variable check and then also the check for secure boot. It did load the =
expected keys onto the .machine keyring, enforcing the x509 indicating a se=
lf-signed CA if the compile time option CONFIG_INTEGRITY_MACHINE_KEYRING_CA=
_ENFORCED=3Dy was set, loading all keys in the case of CONFIG_INTEGRITY_MAC=
HINE_KEYRING=3Dy.
>=20
> I tried with this branch here from mokutils https://github.com/esnowberg/=
mokutil/tree/trust-mok but this seems to create an EFI variable with a diff=
erent name. I guess this is the wrong branch?

Thanks for testing.  During the shim review, Peter requested an EFI variabl=
e name
change. This did not impact anything in the kernel.  However it did impact =
mokutil.=20
The necessary mokutil changes are available in this pull request:

https://github.com/lcp/mokutil/pull/49

