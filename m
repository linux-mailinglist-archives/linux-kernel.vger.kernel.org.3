Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2A35A0FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbiHYMCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbiHYMCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:02:16 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60049.outbound.protection.outlook.com [40.107.6.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403EE8FD4C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UubCCWJ4sHk2MKVfnEOXMwJ/FRawdihHiNExrHZMnPARhPB0bpU6K6ZkvlXiPkg55McONUKKLQN+QjsrI7uzal422/VnyAmdFb07ptF8etpNlQ9KPnJb5zNbbzViCPVaCUmlt0LVOPHJlQJbGYy8ADdMD/7Sas/ni7VFmCTgCmzk5AwG+oLxD4vWqmq2kJtEsLhBYG4KaOltDFHmqnKJ92uMsbaiCD+u7EY/B+d51c/0yLgpNHVTWr4gebY/Adm+D1xF6XLzW99OuCxNVP3Xb8QWjx5nsbw9ZFSNfSVH/arrlNvfP0ZR2/Ojs4J4/KN/WvHc7eYs4nSfftQAdccuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFa9566fvtgPWVShfFN/hWNXcg49ZAzF4GPuUhrqAK4=;
 b=h8elS3eZJwloov1HhEIwTJEDF3vSRWG+BDKr38c5f8IvANU8sAfexZGZVQ/SpTu9gHAygGQbbylilWrAtpDkWMtTGpEFX6iFeFf3rH4aPnpGO6skNsuJi+8M5L9nBbBRZ/Q6tGJiGkpG9bIvv9vcnRYCGXu1DPGWHXkqpvM/AO1M2ctzDe/8PfaKX93A557LScdVBdqMwblj2PnyMAo7KM8imB/pMsO3pcfPGe7yxnon/DTf2WH5p7swPDGDmFi4H/+7pCv2YK2pJuj42XNKpH3iwjE9QKBNmDSvg15KQ+XpiDMRMU4GyO1w3arZ1WEG/rd5a2BstcAAgXhaTd+Ozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFa9566fvtgPWVShfFN/hWNXcg49ZAzF4GPuUhrqAK4=;
 b=r78X1teuNWyj1Zm1aURjc3Y41DX3bIXZkxd/8GPthLwVvrdRMuMeaZx1UbcBNCAACADlAOqocwCEpauVRnZLc43h6duZ/5wH9qsbJnadkvJ5c2XsoH5pnYFr+yxq0ywSo0itNGh8cJa/bKq/3oRqCjVgrrfUIlXB30aq0qVZ3J6AFwkUPa24F8DR/NzN/7artIlPlx8WbOqXvfkOsGxasq5UnzSU9S0WR/o/KPPm8SCtPKkg78lrFtNFGxy0jxVslnLwBXYtXIPXFPsIio9rhmDx3Xe9EHJQeqTAMBbePCqgIQ95QZEglA5CLDUnwm5T3POwAZuCmrgXvrq0l/A9WA==
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com (2603:10a6:102:1c5::10)
 by AM0PR02MB5827.eurprd02.prod.outlook.com (2603:10a6:208:180::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 12:02:12 +0000
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46]) by PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 12:02:12 +0000
From:   "Czerwacki, Eial" <eial.czerwacki@sap.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arsh, Leonid" <leonid.arsh@sap.com>,
        "Twaig, Oren" <oren.twaig@sap.com>,
        SAP vSMP Linux Maintainer <linux.vsmp@sap.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Eric Biggers <ebiggers@google.com>, Fei Li <fei1.li@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2] drivers/virt/vSMP: new driver
Thread-Topic: [PATCH v2] drivers/virt/vSMP: new driver
Thread-Index: AQHYuErwCwPojP5fak60UhGlJnJEo62/OPAAgAACsWWAAB5kAIAADNqvgAACQwCAAAE9j4AAFa6AgAAESN4=
Date:   Thu, 25 Aug 2022 12:02:12 +0000
Message-ID: <PAXPR02MB73109BEB7197DAEEAFE929F781729@PAXPR02MB7310.eurprd02.prod.outlook.com>
References: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwclcEJDf/POuHw5@kroah.com>
 <PAXPR02MB7310DFE86CAB92D0AE1A14BE81729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdBMIgSzEiFjc4D@kroah.com>
 <PAXPR02MB7310694F20F95CA446FFF22481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdN3vJ1Z+1yKfma@kroah.com>
 <PAXPR02MB73108383655C1FB4B98C3C2281729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdhF6r0egBc3w1m@kroah.com>
In-Reply-To: <YwdhF6r0egBc3w1m@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f786abe-db74-40af-7978-08da8691a557
x-ms-traffictypediagnostic: AM0PR02MB5827:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gSEu4EObShRvKJXy2DlJjaPLjMUmIoUOx2VLSsYdRfTnnZHxm3vT/wgnyWPfBkzvu6+aotccdnWCNk85EU/kDFeNxBg5Gr5yifd+kSqlcFBHur6jJMif/citOuhZgTOn9qnHfGUkiqgRPspHaAn1NsM2ATQ1hY0PFHFqD8dNwlTnolkeOogTJpP+o/t6ImFWZYnuLK+R/uKe4NJlvoB7NsmpyiCdGvQ5NZ/NwpKhJP18oMxt52kbZInV4zXJAwLtgEglTqAf4zWBgn5K1QqXquzMkNcfq281ZQGoGGcm8HoFMmpCyqK/Fvrcx+sHGxB3YEQ+p2S9musN+11WRatB7oX0kA/Ou5mHUX0srbeUMm6sw+13F1AF4XleIxVqn1ubosF+vm0vxZzUe2Tv9Be0IdlyY2alKLjacA4XDGk2Ik5XSCJQs95srgmG0Fs/c4qh9EwICOFx8+t2UnUXSJ/th+cgwLho7P4McbMoWhjxbWoV9Kc48dggxdUSujApnuyxv9J7ijLityTIqpon/ySRtOf3sTCrZ1w+jq5gVJROdSjYN6Zxds9Mxz0tf+NQyOYG9/faAEJ70jeFkQaSWT+hzaQ0jnC1U4StwJvqhJ+mmzgYVV4+HN22sSCktv5DnUkXFQe3yc2bCCkSHhUnA6KxQ911zR93lbOUt1Xln2aCYcCjNsdOjNrEvJYR5+AXd3LcYZRympBQkimspy5IvPP/HMc/stSp128HcPm7g28ffh1L3NTGxW7xYMz1BIQwcEma1TgZgxij+z6w4jYnGRsn4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7310.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(66556008)(66946007)(52536014)(4326008)(86362001)(91956017)(66476007)(8936002)(478600001)(54906003)(8676002)(64756008)(38100700002)(76116006)(6916009)(316002)(66446008)(71200400001)(41300700001)(38070700005)(82960400001)(55016003)(33656002)(186003)(83380400001)(26005)(122000001)(9686003)(6506007)(2906002)(7416002)(7696005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?glRZGA8W0RFjWg+72wzUFqsgGH2CIRuYfEVf21wpn+4OQl3Bxh8GId0SLe?=
 =?iso-8859-1?Q?cN3XlkBmCvVAGjMaBO5HiJfNJYQ8OLKVuK8jRkYKAS0CDp+5P60nwFl00m?=
 =?iso-8859-1?Q?+8qisXy52nvl+4BsjpYUgrO79Ts56Eh6xgK5X42bPUYCZHnAwYkYqZ/AVu?=
 =?iso-8859-1?Q?HsHYNwiKoMAOONeUe/hJeFiOaQ87yFQ4yW4DdDrzJBV7SwLy1mpTN+GRhV?=
 =?iso-8859-1?Q?qCBw6c1aiI51AeKJZ04BTmK1a7nyhZxp2Kw1J4s6eScd7P7mFXKiNYyn9J?=
 =?iso-8859-1?Q?nKg4jQ4EqNki+8XbaIg/LLLnvAqclzpUGTZvWNO1U4Ao25nR6sFnfdsucn?=
 =?iso-8859-1?Q?mr2Q77/dr+Guy9HhjdakNhis4w+L4Ov9mbmK/o9s4wlqXVa4yaj1uaH+e0?=
 =?iso-8859-1?Q?5pQTpYVLWa9k0QNtzkbh/FHYCG1jG8d8Q9lJKDn9T1YAY1iysdpkoRMQ4W?=
 =?iso-8859-1?Q?/AR59yOGDdKBCJsNeC/APdas5sRiBRYIhH0CklQHZlJareDJjdaNp4YnHZ?=
 =?iso-8859-1?Q?5HYo2ijDhp97v9iZWIPoz2VYVhyDnXMrxxPfivaqlUEELwo26/qe/+ZOQ/?=
 =?iso-8859-1?Q?hT7otHbE5pHsWLwdn0fSEHbY4gYj653OMpdwjeMKDYggUJjm6yWq97s3ES?=
 =?iso-8859-1?Q?uavrOq0bWcHDHQS5IRoPu3CtF/o4KESJnV3QThZVaXNZn3A9Kh8JpHI0CM?=
 =?iso-8859-1?Q?Ak8b0SCodvpBvA/Iw2h0PgvUOk5ZUIn6d0OLBW0yqdq6V/Fqcr8FfQjsYi?=
 =?iso-8859-1?Q?xNMIuSbtLs0Sn3SVp6WDFNB+WgvYtrETxUeCVal5akU8JAr5rG5kIppYMl?=
 =?iso-8859-1?Q?ITdoUww9yCRKUTJl9Yj72i1StWyETuRXqVZOzyeha0uDPPp1nckwy5sT7+?=
 =?iso-8859-1?Q?pyM1X3GBcSEBsB7FGV7zEgyVP7xjizhMiFYI5QiC7MD0/osHX0ha0Fojfn?=
 =?iso-8859-1?Q?lZAMcM0LYSWOoo/PmC5Q4C9q87kOYNQmAOTzXGmrBCQ3I21VpJ4Q81fSDu?=
 =?iso-8859-1?Q?fGCxY7b+iTKcpBrJNmvosx6qBd1MPGSs99/gg0z8FNM8rvGW44nwb5AdoR?=
 =?iso-8859-1?Q?+G4CmG6ZtPg0cY26htAjzOaawqVgymg66MinAZsA4HuoSPAoNGfhK+OKcW?=
 =?iso-8859-1?Q?v1MB8+RNu1Ce6YyyKmJLyvy5GjA8dNAiRCKZlSYieDyagdJpjD0jl8G3NT?=
 =?iso-8859-1?Q?iZq6OGvL1P9CS+ulutxVnZBQAM2faB6Qi6nwl2/pEUgeb3Yo8zwA8nBqvg?=
 =?iso-8859-1?Q?lgQOoyex0gUBD/mxWrqDF3087AHObyucWDH6unIpnT99jik5RDrCoRjKqC?=
 =?iso-8859-1?Q?aBwTisLcUAPQGpet8OmZHKEPYFw5p5pHYrnweNkKKMGgjO6vz8ikt4H7tr?=
 =?iso-8859-1?Q?WN7Oyg53lBIJoQ5HPbGqPgkGxkv/iGF+WrTBObfLG7b2EOn6C+3UC9cMJi?=
 =?iso-8859-1?Q?XABE6FRBAGGK6kC8H5kZjodD0sibkq6DjsRekVIoAfQ6vcIv4rkkupLe7Q?=
 =?iso-8859-1?Q?oWvvcbQaWks82cyRmfmDpzqnGUMWzhh1wVJC+rI14thQ4Ip35kEq19wT94?=
 =?iso-8859-1?Q?nYzqLcYusGsxiTcKe+ym3rq5T1ASOuB60zOwkcMnVUI6GTnbLpW5yQqqnU?=
 =?iso-8859-1?Q?HRr5p6VnQizzr0yBkGTfdbgpHZ+AMTUFD/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7310.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f786abe-db74-40af-7978-08da8691a557
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 12:02:12.8074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2DLcG0yFYV7b8ICAEJIvWna3mOor8JmwMIsNzd1CLBqE9sV1wmJn++XliMmKoLasrQTb0VBQVa8jS8nVAm8CMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5827
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Aug 25, 2022 at 10:41:28AM +0000, Czerwacki, Eial wrote:=0A=
>> >On Thu, Aug 25, 2022 at 10:16:59AM +0000, Czerwacki, Eial wrote:=0A=
>> >> >> >And why is your version file a binary file?  It should just be a =
small=0A=
>> >> >> >text string, right?=0A=
>> >> >> not so small, it can reach up to 512kb.=0A=
>> >> >=0A=
>> >> >That was not obvious at all.  Please document this.=0A=
>> >> where should the document be?=0A=
>> >> in the code as a comment or in another file?=0A=
>> >=0A=
>> >In the Documentation/ABI/ file that describes this file.=0A=
>> ok, will place it there=0A=
>> =0A=
>> >=0A=
>> >> >And how in the world is a "version" that big?  What exactly does thi=
s=0A=
>> >> >contain?=0A=
>> >> it 's size depends on the number of resources it uses.=0A=
>> >> here is an example:=0A=
>> >> :~> cat /sys/hypervisor/vsmp/version  =0A=
>> >> SAP vSMP Foundation: 10.6.2862.0 (Aug 22 2022 15:21:02)=0A=
>> >> System configuration:=0A=
>> >>    Boards:      2=0A=
>> >>       1 x Proc. + I/O + Memory=0A=
>> >>       1 x NVM devices (Amazon.com Amazon EC2 NVMe Instance Storage)=
=0A=
>> >>    Processors:  1, Cores: 2, Threads: 4=0A=
>> >>        Intel(R) Xeon(R) Platinum 8124M CPU @ 3.00GHz Stepping 04=0A=
>> >>    Memory (MB): 30976 (of 103192), Cache: 7527, Private: 64689=0A=
>> >>       1 x  6400MB    [ 7825/ 321/ 1104]      =0A=
>> >>       1 x 24576MB    [95367/7206/63585]       00:1f.0#1=0A=
>> >>    Boot device: [HDD] NVMe: Amazon Elastic Block Store        =0A=
>> >> Supported until: Aug 22 2024=0A=
>> >=0A=
>> >That is crazy, and is not a version.  It's a "configuration".=0A=
>> it is called version for history reasons...=0A=
>=0A=
>There is no "history" here, you can create whatever sane interface you=0A=
>want right now, there is no backwards compatible issues involved at all.=
=0A=
you are correct, however, it depends on how much change the hypervisor code=
 requires=0A=
if any (latter is preferable)=0A=
=0A=
>=0A=
>> >See above, make it text only for the version.  If you want to export=0A=
>> >other things, be explicit and make them "one value per sysfs file" or=
=0A=
>> >use debugfs for debugging things that no one relies on.=0A=
>> so you suggest braking the summery into files, e.g. one for cpus, one fo=
r ram and etcetera?=0A=
>=0A=
>Again, who uses this information and what is it used for?=0A=
>=0A=
>thanks,=0A=
>=0A=
>greg k-h=0A=
=0A=
both user who uses the product and the development team.=0A=
it is used to provide a summery of the system. for example, which devices a=
re used=0A=
by the hypervisor.=0A=
=0A=
Thanks,=0A=
=0A=
Eial=
