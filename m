Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737624C38BF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbiBXW2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiBXW2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:28:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70ED186412
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:27:50 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OM8g2O017851;
        Thu, 24 Feb 2022 22:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=S2pQkbyG0tdJ+ARls95XNZJNZL1V2A/Z3kyE48Us1EU=;
 b=R/jWBARp6NqPCSzXs84hJtiW5Pa89FXY6dDkviorXw70uCatoUrqSRy+A36scKX0OtmM
 FsEWWFnpJvZlszlzdmatJ99+OVZ6voIA4+2jfWUqsZ6V3ZWSjhh6RBzBxl9trBhLEhVI
 1m9nXCYtbK7yp5nSPOybT9pBqGNzCw3RManHzQDkTJt2GPy3FT4B0pWcqF5q+nOy6iKa
 623Qx9Jr8XPq+rAVzOaXr57sFzZjmwh/WpBsPCFGIaomKQI06yVnM0jOh5p4PbXk59z3
 suAUXOuxEjSa09jWxkEDsHy9yI2hB9RmQ0fS+b/b/QO1rtaJlApgEUndYKC4RzyF6aod UA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecxfb03x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 22:27:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OMKYIb094036;
        Thu, 24 Feb 2022 22:27:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3020.oracle.com with ESMTP id 3eb48473mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 22:27:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBKeBfkTQxWMyp4h8DT4sxMdfIZsOH1GogJNzsEcW9CocwGtILT3r5Wa9a5REBftYcnIQXNbZPFME8iYge5MOiUZcrsCpb69P7ZMe75KT4h+J31iW0SaSALCEFi0Ry8bhtaM30TKYwHxZs7GxZdNJla8WHkyv36A9OGZaWElyHUBR0HungdKoJSa3B4sALQ3H+mX3Ol3T0eAZgbFZ55o9+Zd1/r3Pk12bafRRPUV8TG+968my2+z5RUTzC8g0EbOJh/DV68rDp/OprDBjRT8RaKwWhtv188PjpYqY901D9y1M4Zex11ViF1bcly8sA86AEIkwxLwXbjNgaxKROuOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2pQkbyG0tdJ+ARls95XNZJNZL1V2A/Z3kyE48Us1EU=;
 b=HsCAfAeIPB0DfOROlR6adP03hNQSvLKYX3j5VGF8QCeKhe1t54LhFV1q9BcMdjRheIRf2uCXwU5Z7sWUzF9BrJv/h7Sb0vnLc7zkcTuyf7xKEp32eM8VQ8OpWZZcvv9wR6Mq52zxHpTWFS3qKadjygH9B7LuLa3jSYJJvYWvYpl4lylw/8Iv3eOAMFvRJJW8nmLKX5LgIxENzh/yAlPkrqd1eYWLLK80DtJN1KQfcsujUYSfPjy8LQe7vHt0bPwD+AITUSTtfYWBGTy+Vllyy1nUFoUOpv10K0f+yJUPO6wTNnYeJPxD6JLhPpWVww6Q7Iz7vCCE+JAWHadHEBPeIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2pQkbyG0tdJ+ARls95XNZJNZL1V2A/Z3kyE48Us1EU=;
 b=KUcbGhfp5xpymAEIutuNLkDG9vadfvyiSm2LtLtWCXO2y8TDJeVNiXbces/S0ukFaVNO5119eMSXqJiDMxJJSr/sX50ugCS3QpWt+r9AwBg5Ipi2kX6ezSJ/P3uaDxdCisvbuNV7L3HZ42t29w/tm1rr/cHwHn7zugQjx09diXc=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by CY4PR10MB1639.namprd10.prod.outlook.com (2603:10b6:910:b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Thu, 24 Feb
 2022 22:27:40 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 22:27:40 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
CC:     lkml <linux-kernel@vger.kernel.org>
Subject: [BUG REPORT] soft_reset (kexec/kdump) does not work with mainline xen
Thread-Topic: [BUG REPORT] soft_reset (kexec/kdump) does not work with
 mainline xen
Thread-Index: AQHYKc2TmfaW7HQJX0Cd51obFMzfDg==
Date:   Thu, 24 Feb 2022 22:27:40 +0000
Message-ID: <BYAPR10MB2663BBE2CEECCC4C6504B190F03D9@BYAPR10MB2663.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: e4ef5105-6856-7ae0-2fc5-8e279b317d5e
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76de6c41-7f92-42bf-7019-08d9f7e4de86
x-ms-traffictypediagnostic: CY4PR10MB1639:EE_
x-microsoft-antispam-prvs: <CY4PR10MB16391FDBDB9BBDC0A9DB2C9FF03D9@CY4PR10MB1639.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MO1kBy1uCGGbDXyVTjiqJ7QLUcVr4sCIgimzSv6LfYR/r3af51/XFVmNG7zbKkw2i+BBjuajq6oYBSVHYR56Ccg14w5zpJryosV3c/Ax62SWzPzrnvLZEBilG09MKRZhBw4V8q8lvscjZh9Ydx8Qma69KSsPp3siLzUoKrQW99nRnfXIwwOrmjX5IMPEFm/0m8Gs3SAInipl5BDF7Pk176njxifHz8TcNKaUN/zXXH2qYjfFwtIZ6mNQmJja86G7LlwwvQjExXNXmYYQ3f2goGJP+Ma34cegP+Xngp8iMAD8PLBa2GLmJbCdyuCygbgrzxryjY1Z/WlmfMkYtI3a9mOZM8aoKtIWiqctAPkZmt3HskUrtK4m4LDEXEQ6kZZXyO9/XCjjhGG9JXuexcw64cwZ9vqqTgPq8bqV906vNLhP1b0XSDrlncJO5DM79JkBB+9JMcA69pW0M3xW0R3bANwnxwD0gZhws1ouh68ssOg26M4dMC+XyS8pCpPhi/jaXBAsLuVE/ETjCINFjmwQfAaoGfjeuxH4GKmVtO1zgW68HT5Hm5hEjUuN/jc7z0t9SB5RwBc2YFPK0/6qACuHSOO9bIuRrgUDdbVbzZC5gu8jsBazklc/uHldr1WdaNI7fZe2iec8gnuCfR7EApXZULpPIZmvVT+sGzTR6DeZVoWgSmUPfwywBNK99ZwRalDHws0wFmyQZZNIeJ/LFRbwJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(64756008)(76116006)(66946007)(8676002)(66556008)(66476007)(2906002)(4326008)(9686003)(508600001)(8936002)(38070700005)(91956017)(86362001)(52536014)(186003)(38100700002)(83380400001)(316002)(6506007)(55016003)(33656002)(6916009)(5660300002)(7696005)(71200400001)(122000001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LtNTIvRHQ2UIz35RHgn1JlQ+hS4GV2k2aiiL44FpFzC1Ru5veN9/WDUu9x?=
 =?iso-8859-1?Q?bXSAZGFnKso4TRtYINMzeq9j/U87ZEpXj9GJSxIZK/GF9WQGGGKqJ+wkfP?=
 =?iso-8859-1?Q?MGlHtVAyRUL2vutvXONFWtHXm4pWwReMKQSCRHnFIkxgqP8y9Ot1H36q3b?=
 =?iso-8859-1?Q?gStJH0sIUw9TzLVDsDPKgQke4TPnfB4YOhOzSglCacI0G6UvRFt20QoIZr?=
 =?iso-8859-1?Q?Dzk20nzHTx3hRC/KGqNfx0GW3CQl4zST4VlsO/73Y494Dgt9cWAIWTWUoX?=
 =?iso-8859-1?Q?eHZ58Cxita1S6QToro6ulEmM5uV75JnC/Na6zhj67NfVq3cob/Z4pG/HhK?=
 =?iso-8859-1?Q?bDEEUTtDM6xJGVuMrEY3b2Fsd1EgLFfeOpYuWDP3jmf0apIppuTs2bqcus?=
 =?iso-8859-1?Q?KT+onPM4dGuQosr9gRBC36BAK/eNVaj+pwu2pT1PBWFG0evyaTuAerJHYf?=
 =?iso-8859-1?Q?F7jN9qxQ8PT/ja3TINGW5wpPERGzw9O7BwPxFlDvub/1BojKCRaTGQEvHZ?=
 =?iso-8859-1?Q?RYCG+0JsBzWX47IlFV6Hj2ON+h8whJ+rynGXwIY2AH2NAKZrKBlbCNN1rw?=
 =?iso-8859-1?Q?aCKVYbV01rwd7dFEwXFKkXmXaIEWyxQPFT0aN9vsm9wD7xdw292oQsFmM6?=
 =?iso-8859-1?Q?l/9AHQi3BbjW5J/fCjNF/ghjWTRzbPmksl1ZH+9NjcUrucUFsXjc3hULcv?=
 =?iso-8859-1?Q?CyIQuAEv5ZP63y9TgPkN1nq5fh2xGtQa5pKeI6lyCvMTO0LZpA2l9xEoxT?=
 =?iso-8859-1?Q?I4SmNHKZm5fUxSOnprtdBOrlBB6CFCgVapX3ZL/CFrt/7EGBFsOlppx7+F?=
 =?iso-8859-1?Q?/QyhbREhExnUWzeqwfPlM1Aw0Lb9Nkk6oxzEXdpuyJ/7f6ZNdaOOdSqGfM?=
 =?iso-8859-1?Q?2q+tmuyVwyiX0O5vH+s7JK3fKE2+IYXE+TKXeAuAabgTaFrBS4JIhjo9mJ?=
 =?iso-8859-1?Q?s71F5h4LAsjA1oBL0sIOl5NiXtkMLdFs3AILGlRO+8ABI89qTZgzePRW1E?=
 =?iso-8859-1?Q?2HWZxOTfIWMTXrIhOcB3KCtUeb+2Mr613px264FqKFhnosdCJH4nTwl1CX?=
 =?iso-8859-1?Q?4SoEVRs/uTfGZdn0CjCD4pn71ZQFQt5hDLIEsmSUgz4y3CkqNifm04ZXul?=
 =?iso-8859-1?Q?tWiiNA04DqU3HAIv+yB7c4npGD5lFR6dNdNZHOmFbY/kGI/Ugma4u5TlOo?=
 =?iso-8859-1?Q?U7O2ex4Ip+09h88JrtuM/OF1fOknSfwLOwlGiGKCkAw+uKjqLW2ixDJs12?=
 =?iso-8859-1?Q?dWNj7DPh29LNTvQUp5VS1/wu+YkNfQixThNUZSfHN/AmakqsTmxzEJGVRh?=
 =?iso-8859-1?Q?R40akrLKyb95XVe41e+EiM/axqonOcRypMlpdZctK5FzrCMcF/NjU/DBRz?=
 =?iso-8859-1?Q?00T1ZVpejwmM4pgl+Y7GrJGJe+fMGv+gr51RRSR3AHAdoe9W1M1HN1iCmI?=
 =?iso-8859-1?Q?HLI66OdRY6sjlSii7qdum8AYjCZymyUR1rUIy+7P6f3KFm8+5eZUJBiePF?=
 =?iso-8859-1?Q?+4t+FgZAqujGbil/d3BeK51vrltHh5s2gYGWm/X1JBV6xbymsmvThiSNCz?=
 =?iso-8859-1?Q?tRfNtYpEqwj5CaaBpx2veoC7hCCvQvNjhiA2I0sofzSOduIyYz62Jew2tq?=
 =?iso-8859-1?Q?CAY1sDwxDfjT5emo2AUqa5JF2FOH01IjEGET5LfU5yEDyyCPJzq0kTeelp?=
 =?iso-8859-1?Q?UYGfaXXAuMjiJIJXTEdvLHOyBRYKDPKEu1dgTMlh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76de6c41-7f92-42bf-7019-08d9f7e4de86
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 22:27:40.6342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FpydhbBq1ZQHoB7kiB/KAZ4dYzrlm8QMGpF/KZY7v/gT6kb5/lUZKmJLnve+iuu7CCpzkp84Ks6Cle8u2w9Jzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1639
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202240123
X-Proofpoint-GUID: ZEZV24tn7qXHqPIpLjn91YPzlsg2U9rc
X-Proofpoint-ORIG-GUID: ZEZV24tn7qXHqPIpLjn91YPzlsg2U9rc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,=0A=
=0A=
This is to report that the soft_reset (kexec/kdump) has not been working fo=
r me=0A=
since long time ago.=0A=
=0A=
I have tested again with the most recent mainline xen and the most recent=
=0A=
mainline kernel.=0A=
=0A=
While it works with my old xen version, it does not work with mainline xen.=
=0A=
=0A=
=0A=
This is the log of my HVM guest.=0A=
=0A=
Waiting for domain test-vm (domid 1) to die [pid 1265]=0A=
Domain 1 has shut down, reason code 5 0x5=0A=
Action for shutdown reason code 5 is soft-reset=0A=
Done. Rebooting now=0A=
xc: error: Failed to set d1's policy (err leaf 0xffffffff, subleaf 0xffffff=
ff, msr 0xffffffff) (17 =3D File exists): Internal error=0A=
libxl: error: libxl_cpuid.c:490:libxl__cpuid_legacy: Domain 1:Failed to app=
ly CPUID policy: File exists=0A=
libxl: error: libxl_create.c:1613:domcreate_rebuild_done: Domain 1:cannot (=
re-)build domain: -3=0A=
libxl: error: libxl_xshelp.c:201:libxl__xs_read_mandatory: xenstore read fa=
iled: `/libxl/1/type': No such file or directory=0A=
libxl: warning: libxl_dom.c:51:libxl__domain_type: unable to get domain typ=
e for domid=3D1, assuming HVM=0A=
=0A=
=0A=
Neither of below works.=0A=
=0A=
# kexec -l /boot/vmlinuz-5.17.0-rc4xen-00054-gf71077a4d84b-dirty --initrd=
=3D/boot/initrd.img-5.17.0-rc4xen-00054-gf71077a4d84b-dirty --reuse-cmdline=
=0A=
# kexec -e=0A=
=0A=
or=0A=
=0A=
# taskset -c 0 echo c > /proc/sysrq-trigger=0A=
=0A=
=0A=
Thank you very much!=0A=
=0A=
Dongli Zhang=
