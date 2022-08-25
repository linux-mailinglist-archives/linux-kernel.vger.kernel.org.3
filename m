Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6385A10B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbiHYMi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241863AbiHYMiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:38:50 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BF3B2769
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVEMlQngP8+dIrou5GHClyiADu+Xp5dm3D0u0RLOhJNcXQgxvm3FxcoJxm4X7Bke7yjGFoCm+wVdNLogs2AF1luYY0qVa1pUqN3JUAmCmwvOldIyDWXgooF/aGVnFQf3ITOcSCtnWZpFm8UcBPBHpYuRFEAqAkwD4+xxJZwp+xL745krXL1u1joiDLqmKsjK21WMeF/HnxoyhJNDgLGcmJt+9EHyOtNruHC9gfstgBcycPmYSa2sOy8OvM71UpIkNkidfRBQrKH/DIyo7h3eb27xDhJgXVCi4++3iKqBhfyQJVqI0RDQxnnbXRY71ENE+6D4JOklLitFi9wpPFXYNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xntLEFR3EWfs+h5/UQt0rryQCRCZ/EfWcPGRqcodw20=;
 b=jF3WxiUgdjsVv/QqssBAosfdud9klgOteTHfvYhi8SieIbVLtDCOGX5aqy9jCFF6P+ChzsWMz7A/YvdzLSOfAA9tgnNVOhkPFQSGUcKBZzPNMKrFB8rcQhLg4nPq2h/3hxTCIL0h05C+MtrPA4sJlQvwtrzKoEiPHjASti+mEIm7AT5iDqQMeiwjyT+ktQrASe+WGEIPM3NCIFBlqnnW36sSqo/6XfbksT5UsKTlGaYBHAI5MEeT5SBnVRp+D+qFZlnxMxbFfJ4el1G9Pb7ZtbVtDn+p3JY0wyqdj2ehaiHHQ/KgC75KdLLLPw4FtpsJE5v+7a4zUiWLWz+0VCAGig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xntLEFR3EWfs+h5/UQt0rryQCRCZ/EfWcPGRqcodw20=;
 b=JR6cAG1h7a18l+hiFQZHwBlrLxUPvt6fMjO7teuvbZZGLguxL4dL45T/KEwekCo8B1WapzYSEngBrzYS1O5FvHVTsOWKKNixkLdJdcs16iDws2GUtAHRYAhXL+5dnBysA0UBgV/cjuhpgdwlesqzcvAhS0I2p4A1FgO8ZhN8OXqhwG4XUgDr3gl7kI7MspmClL5pkGQli8JNH0KVVcxqzFgsTtmkBhoBhmx4ksZkHJ73RL22jMlYBH5K+Y9ZdO4Z26qidtG5DT0Oo+TVXtlgO9x7lr4RnwkE/ENokmqdhnv9nWEbuboPORXx0A0Tu1oqh1RUCZDfhszjUI0+1iO+AQ==
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com (2603:10a6:102:1c5::10)
 by AM6PR02MB3765.eurprd02.prod.outlook.com (2603:10a6:209:2b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Thu, 25 Aug
 2022 12:38:46 +0000
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46]) by PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 12:38:46 +0000
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
Thread-Index: AQHYuErwCwPojP5fak60UhGlJnJEo62/OPAAgAACsWWAAB5kAIAADNqvgAACQwCAAAE9j4AAFa6AgAAESN6AAATmgIAAA1dF
Date:   Thu, 25 Aug 2022 12:38:46 +0000
Message-ID: <PAXPR02MB7310B9D894613F9623D6D5A781729@PAXPR02MB7310.eurprd02.prod.outlook.com>
References: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwclcEJDf/POuHw5@kroah.com>
 <PAXPR02MB7310DFE86CAB92D0AE1A14BE81729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdBMIgSzEiFjc4D@kroah.com>
 <PAXPR02MB7310694F20F95CA446FFF22481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdN3vJ1Z+1yKfma@kroah.com>
 <PAXPR02MB73108383655C1FB4B98C3C2281729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdhF6r0egBc3w1m@kroah.com>
 <PAXPR02MB73109BEB7197DAEEAFE929F781729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdoyzTriZNr/qN1@kroah.com>
In-Reply-To: <YwdoyzTriZNr/qN1@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e525615-651a-4741-f996-08da8696c0a3
x-ms-traffictypediagnostic: AM6PR02MB3765:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KsHha0dzwkDD64kNiKsYcqLfDXGI9ItuHCUZtL5QSk81uRACxYOiKzRGXglK4PQhpxIyVR1Bz4G8vHvCxpTleFfQNmpdPN6iqGmVRtSOZ12KI8+AbRmmkkuhQ70xSznapQiJL0U7CuPzbTCaGBUmWmeUP4Ktbpe3qpCkLzI9MwiCVzfm1OdthEH1T2TWqRYRtu0V8HGcLKUzGxjMG109/apQWKNcxAtJxtf8JmchUlkGDvTcz++tfjlBu/1yWd04l1dEbrJ3FiPNmH75Pz3dnFS5p089td9MlVanwr3XAZ6fEZG0924Q60BQDPsoMjt3DlRmzvOmDv2X1kMCmFjdqDJU9G4HusRYq8CtsO3SWRbsofQ6X9gDUv4Qb6g1JyZfmtwFUFdmXCENHTMjABohkSuQqUOS1BYZrnglefNQJFj1S0MHL2wl0vhno00mYtHRRjlM+A9iedu4p/NgHluJnOOmKF2hOYXChsurbYvrTSzVYgPi/138yiLkaBSzjfNR75vZMNeyscTpfHLrtgOwBCnz7wPXcdw5d6suOkis1X1PQ5u3s4O7W9AXb3Hcs7VabySONVZHb7zaHwAwnwNB82SSpa+Cgblk4nYbpIyEtAFk+6q6KafkqWEue/fSYmzcbMYRZUAyTtCzg0EQTukF7J+IIUocdSAdl7xYEgR4kdpIT1lxtoXzm2Ssn8UKSQ/a8eC3JVsE4vQFa1V1e6J/NmYIA/UXS+4+yxAy6ADBa6wL+AOyIfs4NdfRBH5iWj2DtfWUWlTDw8RqDKn1cBOZBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7310.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(82960400001)(71200400001)(38070700005)(86362001)(66946007)(66476007)(66556008)(64756008)(66446008)(8936002)(55016003)(76116006)(54906003)(316002)(8676002)(91956017)(4326008)(6916009)(478600001)(83380400001)(186003)(122000001)(41300700001)(6506007)(38100700002)(7696005)(26005)(9686003)(7416002)(33656002)(2906002)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gXn3POyPGeTPnmRZPsqVEBx7MiM1Eh7kpJQwIqSl+wMNlEslIEjJNJ9nY9?=
 =?iso-8859-1?Q?MBThCsRDsX0JmeZ/4vkUEvH/gn4KBeSS4ziXN5JOPbE0Fffd6HBSzio9HY?=
 =?iso-8859-1?Q?9pScAvvWu7EiUXgM/pBg0V6RHuLb6G2/BsGBh1OgKsTThmixXkXYLdj1Nh?=
 =?iso-8859-1?Q?v3/THkceO8dvEf7W1wrwSBzQyLzjC/A3AEkddy24pUzybraJb5LKbWARde?=
 =?iso-8859-1?Q?KlRq1KG4KiKPNo0XkwVYZJZTvodUvY93jwNIN1UyE8LP7pkNOOr0iZ2ggf?=
 =?iso-8859-1?Q?UYHg5wfUMhtw/liUTkjCACeTnTwU3PY13etPpfQE2JFOfihgm+U9Q+KGvf?=
 =?iso-8859-1?Q?jhK8bauHxxq9lpD01LP0k7yNsIGQ0tS922Sr5bCWd3pORz8qIKtguSiLIr?=
 =?iso-8859-1?Q?N+7p5avkAmY7L3EaRoOuZQccPW72JOry4HA20WkIpVzcgRUyfuRihT+dEb?=
 =?iso-8859-1?Q?qn1K7E8xLrtdhVFDYyBUsS1haUqXgxRZLdJiKgtc+DVe4zORr/seDVWKEj?=
 =?iso-8859-1?Q?sZjAzk3VbnehA4l6OKT6OKeKCVquSpMnBz26JUTj9nHNEzUCX1ehdCyGKl?=
 =?iso-8859-1?Q?gOkPlkwPvXrUzjiSb+kLJvNKxSpUcsQFGbI0SP06HC6mBS3ruRY7P4ecNY?=
 =?iso-8859-1?Q?Go8rvZ/pYNfiVs91LHWh8B9hM5xnNGCeO2qx5NEvkhxCBYMFuKAZZ0yFgz?=
 =?iso-8859-1?Q?zLElbr3Clu/s5eKd/0Ct/H31pUVVmGe1TUlTS72hywbTj+CB+pnqM2wcpv?=
 =?iso-8859-1?Q?RbpVO/pgmLYt9KhkhjA4QP/OrjEOvscH8iub+t6LQmzbDjuFi8u5wukeT3?=
 =?iso-8859-1?Q?424rWeR671xJc2rHNp5eIiZgle2W+11KgW+qkAxC5QoYqVfEW181qkWFYd?=
 =?iso-8859-1?Q?qLlW+tdqzV4RTNpNvaEMVqelbuFXW75kjQKsUak4Yu9YpH/nie+7jGDoMa?=
 =?iso-8859-1?Q?/rrk8ABf7Kmkoc3Oo2ok1YIfpHM6keX0NvC1LxWpI0fY0dIvYAgivygyo5?=
 =?iso-8859-1?Q?fx+kJ8xBPB/+lXzxYD8iKNcu0JoCt3bFe9IzRbRWCQn/ReIVqfkHkXf2YA?=
 =?iso-8859-1?Q?Zbii8Cb3GC0BkxoDLJM5LP8db5tE0rDap4y3IrbWiRDzHASrj58EIRBcsQ?=
 =?iso-8859-1?Q?jAvQ9q9vZ5Y7cEE23FismwC076f5xZcE6M875KU4EkUH+EmNY9A9zbILev?=
 =?iso-8859-1?Q?LyaV9VN8Om029PJynqqFH8rhifAcwMKDiQP1cUqBK5dSQrnkPRSzdZmE3Z?=
 =?iso-8859-1?Q?wlWfj6EBber9baU6y8boMvsyXOrfHOJAo8pTtWROcVS0Xpy5kb4bJ6BrwA?=
 =?iso-8859-1?Q?wi0XAHhV7O/2MTMgCOeA6n67xX8gDXnKM2mEr0wzGXvjT17mtIdACZHEDG?=
 =?iso-8859-1?Q?tfZrDW2wHI+Uxk0iN5pggSs/oJ24c+2HKP5xq+pP34qNnu+Zc7hX/H5Fpn?=
 =?iso-8859-1?Q?ocFbSK7k9xIQ9sBgrbqVq/o7s31BeFE3Ie5qswyAd26xnU/AyvfFP3KRYS?=
 =?iso-8859-1?Q?IWK7HEW1riIK0z5FFNbqWbjXaWxUWOCP0VpavPsdPlusiP8+x24D6PVFjK?=
 =?iso-8859-1?Q?guJNwlb06ZCHu5gnSbQFM3DVHEQmrqkURC0sGjyDv+DvvqNp/nl+EBQ1xU?=
 =?iso-8859-1?Q?/7vzVO4dtDm7WUMx9Q4cHCfFChYK33DI8a?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7310.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e525615-651a-4741-f996-08da8696c0a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 12:38:46.1065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9IZ9vZfnPeRErwBWUm13jmmQspRwWSsIbLk9/vNLstgm+1SHtYTr2tb2vPjYFQkXYhJdGSuCy1z2lmS/DWrGcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB3765
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Aug 25, 2022 at 12:02:12PM +0000, Czerwacki, Eial wrote:=0A=
>> >On Thu, Aug 25, 2022 at 10:41:28AM +0000, Czerwacki, Eial wrote:=0A=
>> >> >On Thu, Aug 25, 2022 at 10:16:59AM +0000, Czerwacki, Eial wrote:=0A=
>> >> >> >> >And why is your version file a binary file?=A0 It should just =
be a small=0A=
>> >> >> >> >text string, right?=0A=
>> >> >> >> not so small, it can reach up to 512kb.=0A=
>> >> >> >=0A=
>> >> >> >That was not obvious at all.=A0 Please document this.=0A=
>> >> >> where should the document be?=0A=
>> >> >> in the code as a comment or in another file?=0A=
>> >> >=0A=
>> >> >In the Documentation/ABI/ file that describes this file.=0A=
>> >> ok, will place it there=0A=
>> >> =0A=
>> >> >=0A=
>> >> >> >And how in the world is a "version" that big?=A0 What exactly doe=
s this=0A=
>> >> >> >contain?=0A=
>> >> >> it 's size depends on the number of resources it uses.=0A=
>> >> >> here is an example:=0A=
>> >> >> :~> cat /sys/hypervisor/vsmp/version=A0 =0A=
>> >> >> SAP vSMP Foundation: 10.6.2862.0 (Aug 22 2022 15:21:02)=0A=
>> >> >> System configuration:=0A=
>> >> >>=A0=A0=A0 Boards:=A0=A0=A0=A0=A0 2=0A=
>> >> >>=A0=A0=A0=A0=A0=A0 1 x Proc. + I/O + Memory=0A=
>> >> >>=A0=A0=A0=A0=A0=A0 1 x NVM devices (Amazon.com Amazon EC2 NVMe Inst=
ance Storage)=0A=
>> >> >>=A0=A0=A0 Processors:=A0 1, Cores: 2, Threads: 4=0A=
>> >> >>=A0=A0=A0=A0=A0=A0=A0 Intel(R) Xeon(R) Platinum 8124M CPU @ 3.00GHz=
 Stepping 04=0A=
>> >> >>=A0=A0=A0 Memory (MB): 30976 (of 103192), Cache: 7527, Private: 646=
89=0A=
>> >> >>=A0=A0=A0=A0=A0=A0 1 x=A0 6400MB=A0=A0=A0 [ 7825/ 321/ 1104]=A0=A0=
=A0=A0=A0 =0A=
>> >> >>=A0=A0=A0=A0=A0=A0 1 x 24576MB=A0=A0=A0 [95367/7206/63585]=A0=A0=A0=
=A0=A0=A0 00:1f.0#1=0A=
>> >> >>=A0=A0=A0 Boot device: [HDD] NVMe: Amazon Elastic Block Store=A0=A0=
=A0=A0=A0=A0=A0 =0A=
>> >> >> Supported until: Aug 22 2024=0A=
>> >> >=0A=
>> >> >That is crazy, and is not a version.=A0 It's a "configuration".=0A=
>> >> it is called version for history reasons...=0A=
>> >=0A=
>> >There is no "history" here, you can create whatever sane interface you=
=0A=
>> >want right now, there is no backwards compatible issues involved at all=
.=0A=
>> you are correct, however, it depends on how much change the hypervisor c=
ode requires=0A=
>> if any (latter is preferable)=0A=
>=0A=
>I do not understand, again, what tool consumes this today?=0A=
there are monitoring utils that parses it.=0A=
see comment below for more on this=0A=
=0A=
>=0A=
>> >> >See above, make it text only for the version.=A0 If you want to expo=
rt=0A=
>> >> >other things, be explicit and make them "one value per sysfs file" o=
r=0A=
>> >> >use debugfs for debugging things that no one relies on.=0A=
>> >> so you suggest braking the summery into files, e.g. one for cpus, one=
 for ram and etcetera?=0A=
>> >=0A=
>> >Again, who uses this information and what is it used for?=0A=
>> >=0A=
>> >thanks,=0A=
>> >=0A=
>> >greg k-h=0A=
>> =0A=
>> both user who uses the product and the development team.=0A=
>> it is used to provide a summery of the system. for example, which device=
s are used=0A=
>> by the hypervisor.=0A=
>=0A=
>That's a very odd way to display this as a free-flowing, impossible to=0A=
>parse, file.=A0 Please use something that will be able to be maintained=0A=
>over time.=0A=
>=0A=
>thanks,=0A=
>=0A=
>greg k-h=0A=
=0A=
your suggestion to brake the configuration seems sound, we will implement t=
hat and=0A=
provide a new patch=0A=
=0A=
Thanks for the reviews.=0A=
=0A=
Eial=
