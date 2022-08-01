Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBDB5873DA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 00:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiHAWV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 18:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiHAWVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 18:21:17 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B71A2B27D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 15:21:17 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271KBSwu023097
        for <linux-kernel@vger.kernel.org>; Mon, 1 Aug 2022 15:21:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=fn+n44Z+Bv9db+CCj4unyIKJ51L3rq+I/YBL0EWStGA=;
 b=Zm89jiTrWU8DYXhU9Twlc5z7+7Dymd1S5iituKTfR++Rlqx1WDqPRbk8x1nGniZvy+2L
 EcXVfMTvY8aICD9YOL54H4Vv3sFUqJRNFLxxgPCVpjjBrUBH8vx+8LXwneBrguMvxk7m
 idUDfaRvMgEYBo2MDW7vgG3i28A8ec3ZQqQ= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hn0pjyb0y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 15:21:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0NRy2py7f00v399bGiEWlSUgLDBsJbyNnRIPUNPDDLyj0uknwfZxaZ6Wsqz3+003Tope4HqiMCw88kGZXAZyllROsBTTWSCmb+Kjn5PqyNjsVT5LHmFmieUjRf3m77c19fRVV7ZSjpFIgmJHSefuxM0CTGEFkwitsr4wLA/QkemsdIOcQUq39f3IqFnftvpfgURcmxlnAnXWc+Xib+a19K00V15ZJD1OuYv9SsikElVCXElMPNGVD1sRXkVr0wCXfeSjx4aZuvQ4ONgaWUn7TrDt0eXV0/WJW1pgkCFL6i8hzBG/8Ftf3FKkZSdf53u0288vjrxmUzieKOtq34vxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fn+n44Z+Bv9db+CCj4unyIKJ51L3rq+I/YBL0EWStGA=;
 b=O+aLWIZ5Q0VpVEe+S+xUcfROgJy6GDlTVFKnjPl36pey2MWFIsI3cEFt1DT8iGEHvz2SaYBtoQz+PF24EWVuCxos6LIUwSFLIJU9m0cbHdWDk8y6aOk4Ji8FIFkMBRDWmW3fqknB2Uvb5eeC4Lw2g5pJ56ANefpkk7fUQcE7VMgJYwWLtedYRB/6oLaOq3sysrcEovpC4qsxCMV95rBtwHFY5giQyuRofW2HrYhs10A5q8rtBp4AvJU8V/SO8bqhIrZ65IedPJbMOorkK2Rc/iTZBEKiBFdt7C3oS0+OOMH8AOPU1BA2oej/FveURKX7Rg9WvBlT8cwdoiA18uF5+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1781.namprd15.prod.outlook.com (2603:10b6:910:1f::13)
 by DM5PR15MB1580.namprd15.prod.outlook.com (2603:10b6:3:d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Mon, 1 Aug
 2022 22:21:14 +0000
Received: from CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118]) by CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118%11]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 22:21:14 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/sys_x86_64: fix VMA alginment for mmap file to THP
Thread-Topic: [PATCH] x86/sys_x86_64: fix VMA alginment for mmap file to THP
Thread-Index: AQHYo4NYo2cunMxDR0ijczlOUkjOmq2VwMOAgATiOoA=
Date:   Mon, 1 Aug 2022 22:21:14 +0000
Message-ID: <15AEB38C-375C-4551-A7E9-7CEFE37E9426@fb.com>
References: <20220729194214.1309313-1-alexlzhu@fb.com>
 <YuQ5FYWMXLw+LpVA@casper.infradead.org>
In-Reply-To: <YuQ5FYWMXLw+LpVA@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b90ee4d-075d-4857-4629-08da740c25a1
x-ms-traffictypediagnostic: DM5PR15MB1580:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +aJmwHzf7N86mMyhE0j5MueK207Ll8Sv+VDU3uGxOQh2HnCzTJFJIHXgqxw840Fnrb+DU3dqw01uXWqawJXxljgmVPWjMJChvtceGuA2YxWDbtDyFNFZPH3ElDYTX9g07m8PfbwjHv3LFPr7pqNNfCzr3DhiF/WvswQivmxwhO3Ah6ntKmNqKglZ3Xoy1O8acZ7Uy1WrnGqUSpPmvJTA9XGDJpFWtU0c70yHzw1zYy61DWiYqy2ze/kg2Qs9u9mQDQm//koCAVMyh2kMQb7bJ7A/PSzMdd7/qJdVv797nFcWbPxO2TYjbUtzE0ESy6+ISYPfk/+3dEwpKTRW06wjx9UqgcZgcOOw99+NiawgRSEg2Swmjk8gwF8ljOeEqSIOQfDToqKcJ8hGiYK74yuNvSlVZKQmvE/Myem8/FojVRSBf/5P+7sU94f/TOnob6lBonaBWB3yHMmrjQbVd7RChJkMlh9xe9OTpnr6o/zxX2/ibJMJ0pSshjYJ2vMTDDgIhgDlJFJ5vAK7jTj9HLMJ8/GMQnGXKNG5oDxeNt1HjZ3V5NajUkdNAzBwH3Sp2mc22JEQ4gDB86dOA1Fdi7eXADPkQW6XI2Qm34IlEx5mvv+H83t1UjbgudUaz8VRFne3hGmAGndVOvMdqBn3Su9N4HPQXsxVkOFn1TI7+HMw75PGbXIqvkDA1btZUlKw/6UFUKb1pN4tJE3/Bi44STDgVgA3uyx+uMOtjJ6wU6UvYVPKIldPeSLpWt6Ndr7MC6toXBvNtpflnxn3rkuSZnW1CugylggMraiXiQVwhVKMnsfCqzwoDTnkPWSM6Ef3dApBnlXIXM6QUCeQdnKPvPf0QQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1781.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(91956017)(76116006)(2616005)(558084003)(5660300002)(2906002)(33656002)(478600001)(41300700001)(8936002)(6512007)(6486002)(8676002)(6506007)(64756008)(66556008)(4326008)(66476007)(71200400001)(66946007)(66446008)(86362001)(54906003)(6916009)(36756003)(38070700005)(38100700002)(186003)(316002)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gf73NlOuhC4KRbMrT0P8FbR2Cab2LF7pT1z/XfGem0Hq9Ep+ZpmLp/NHKeHV?=
 =?us-ascii?Q?tDgweJprHplsrf/jQuJlRKgzNBh0QT2GTW7hAUYf1QhMc8/Ja8qcD+Uc+1U7?=
 =?us-ascii?Q?YgWAa/KUJFl029kdmtzgAbZhoXqAFpZ7JV5AykH08zSnVhkCfyiLtNpUjEvr?=
 =?us-ascii?Q?q1WivwQDM6p92n73E9MeePkoYTSXJgyvh9LUuYxYbFP3UV4zZ4rxxbEkodrA?=
 =?us-ascii?Q?Sv8rAS9anWfvQ0pb/Z+L6BWtQsH0iph+x0VnRubayOqfTyaCGoCDHMepe6dQ?=
 =?us-ascii?Q?j4Y/NWoiGrxFu96j9qilFf8Etmx6QlUqLUG5AHZIa/h8gl1aenlFle0K7mtu?=
 =?us-ascii?Q?sOKCKfJ6jqQm/9wJk2KLoQXT1rZRxUrgjDihzWK+rUndAWvUq4ADXjXtb3Bw?=
 =?us-ascii?Q?8Rs8njJwGeMylqscPKLZVSaFQMFEg+80Zry2wBNwfo7lU9HLSjdDEINOjNq5?=
 =?us-ascii?Q?Inq4helODNOaZ8e325z55CiRYAR+T5fHVvMTArH86PnGYeXS1uGva2erS/co?=
 =?us-ascii?Q?dlS2ncmfxSNjPs35tNVc3iQ3R2fRhIoWk4zGHBfqsTM2Nhn1F8czU5Paog1C?=
 =?us-ascii?Q?vXRK8mpuKZSug1nBx0PIN2284V+uTDUKj9y54vDgyYP9hpzdVFgYGc0Hpdp/?=
 =?us-ascii?Q?lofcG1qK9CMoAYlWzkRFtgnszTGm/qARkIYbSHIZadINBqye2Pdz+V285Tdb?=
 =?us-ascii?Q?lNWtEB3Em9fgnK7OU6SRY084h2mddu+N2J3dfDZNW037o4tU8nb/D73D2Mfq?=
 =?us-ascii?Q?Vxyd/L6n0PL5LLG3+uqGoIlEvQ3HoSxrTKQfKtR7x1Z68fGNMmk6q+OefgzH?=
 =?us-ascii?Q?j8FgsMBt8w49LXz0jRrxOVxNO0cJF+e7AoyTYB1DY5CDAc0Q0O0YR6PvxX46?=
 =?us-ascii?Q?oPJsmleZ96b2eP9T+dUwfGAz1g2G6axmLUiTVJ6ln4aG4LM5eDIeKBfs6Z/g?=
 =?us-ascii?Q?QfCKeuB221SfHh9oVe5dxZJQT2ovD4ebmvBzkYdWD9UlGi1Knqq7XelIw14M?=
 =?us-ascii?Q?1QbatUcYeVjcA1Tk6YgwncVBzq9Zps93Oc7ejhg30jsQqyWN9JFWDqr2f0bA?=
 =?us-ascii?Q?V/Gon60m0NmUH8BFU+01UBBqa5d1xg6vOQMBR05oiZCuFSyHniIQeqTq61Vy?=
 =?us-ascii?Q?gPhfA4WhDPKlfjqKF4hXXlbmsfcFu+UaWTtw2IONvpumh7XmbbTwDObV3RK7?=
 =?us-ascii?Q?W3jM/c9dhnPvLGw+pT+WaRXBB8mVky3jvJ/WquFLhyqujA+QsP1J9qxgiR15?=
 =?us-ascii?Q?A3fN/TodcE/xcCVuibLNNOKdAl3uSmmzS7SyMkEJ1yTwX1At90rRQ9i56lTT?=
 =?us-ascii?Q?vFxmwwtmQJUoVZroFgRjkLBjCDZmnxvDxvy9Tx0akxUjxleXkWGbkEUlwyPs?=
 =?us-ascii?Q?Ct2Aou7zsoF5ghYGKP8cF+NUPyrgmB4fo6vjaq2RWHc8WGpfWOGXHJZMUbdS?=
 =?us-ascii?Q?TcrR8MnRc5iGaftUXYY9QN3tGYdakEIFN8qYAi+57lHDcERrY54UCYG5ptF8?=
 =?us-ascii?Q?g2JKWKdjMvh32Y0MFdrYq7lHxMaNqN+wjq4Sx/AFF1R+GxX6MaNWpdyrnbF6?=
 =?us-ascii?Q?Qwd8KAWAbCPsPqdrFQvXbR9hCgZj65ptR9ovf7fZnrOnwgOzDGcFGe0/bmM+?=
 =?us-ascii?Q?bDbOUkuPEkQF/+gLdhco9Qc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A52C70CCBA9C149BAF812D54F699C42@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1781.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b90ee4d-075d-4857-4629-08da740c25a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 22:21:14.5477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GEGvQ8c1Yv7gC7ObQxtzLp0hh7dXQki7ZSHWftmKIIV26fxuCRNr0yba8Wg4X/5X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1580
X-Proofpoint-ORIG-GUID: ka81WPzjidIw9-saQqMLhPTCauS5btDu
X-Proofpoint-GUID: ka81WPzjidIw9-saQqMLhPTCauS5btDu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_11,2022-08-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Matthew,

Thanks for your suggestion. I tested thp_get_unmapped_area on btrfs and that does indeed solve the issue. Have posted a v2 including the btrfs maintainers. 

Thanks!
Alex

