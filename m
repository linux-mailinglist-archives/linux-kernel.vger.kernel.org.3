Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1263F5A0DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbiHYKRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237108AbiHYKRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:17:04 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6307A538
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1G0N8RWsNREiN/mMzPzpbMzahPaclruguyG2VWo6HoTlWAhEGTD+67aftYJ5a9H/ZpTQwqP6VAmNxkvBvtLu9g3YWpGFZnsRmchKecr3mf+hG3NpiRu4ZjXgZRygocnUt7SrfjQDQ4TQqLyB8rc7NkrEiOB3Av4vIOLKxR7z5sq5m+HsXmA8LLqOAsg9NLXl4hWdlZXEVIeSP6ng0/VwmTYfmDTR9q2n06nQjuY+30PyDBs+5IUyyC9knP4ApC+vky7ofGE4GALsNZPlrjE85xvggRusbrmcnLLmvtbPeHPe9SuJaWX1Pb1XmMkvDIV6SzaJDFFrquZbCbft9N7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Cd8cKHAs2EFNz0yE04M6uHRpL1kAkn8WK1FGZxceVA=;
 b=XncwTV0ckbzK4ofqybXUlGQLUXabkzQo5v5k83Z2abJoCP/b7JE5khvtgzK8DV9Z64562ykR6OtFTjygda7UJ/eva9RT+H1ZIvNV2Ei6VeBd8hoc6AZVi0eQfc09HhSdcLgvyXywjNnxefYzsfoA2joLc8eukJNzPuZlijCCFBBu8nTY4V605JDJrYdx8Sy3TjpD4kcpukbwD03QSJh41ly4CSTsbtn0JVtyXhcRCp4ROOq6pJ8cUhpSS6qLDEh2pf4qfMsWnZT/AbENzRz0mFFYwYFOGiJfQ/J8i3+QvostRPRL2f6PJw4jMCub2Teo610JXV6Q5tLWutyl8HWstg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Cd8cKHAs2EFNz0yE04M6uHRpL1kAkn8WK1FGZxceVA=;
 b=eEzvamBqPXrv5s5pBnpQl+vdY4kF2nBwQg3o8zao5W4B2AYwxNkTnhvfOyqRQI/zGJRVipv/cUwrDn0wNmbaTHCDT+io7p2IctV0mscs+yEUiLPIkCFHrCETTO1aDutRCagTqbXoTGhWXbWMnHyjP6SF1dC5x10Am2T7Qv/xpZQ+qhuZ430yTcqULrQDGsmJZfTVKxYRn5QsguFgMJXE4ufQ30ZQHFHskXHgl1UZvOpvHBY2oQ8n1HH0J6/RulM8Zkx+f8gDKukWfDt1GuFY6Gwi5BrXG+R3f6J8jW7X2oBS1dZRCTrA9poXEw+cXLI2LfaJGZlrHsrr+FyqGIaVtw==
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com (2603:10a6:102:1c5::10)
 by DB9PR02MB6538.eurprd02.prod.outlook.com (2603:10a6:10:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 10:16:59 +0000
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46]) by PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 10:16:59 +0000
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
Thread-Index: AQHYuErwCwPojP5fak60UhGlJnJEo62/OPAAgAACsWWAAB5kAIAADNqv
Date:   Thu, 25 Aug 2022 10:16:59 +0000
Message-ID: <PAXPR02MB7310694F20F95CA446FFF22481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
References: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwclcEJDf/POuHw5@kroah.com>
 <PAXPR02MB7310DFE86CAB92D0AE1A14BE81729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdBMIgSzEiFjc4D@kroah.com>
In-Reply-To: <YwdBMIgSzEiFjc4D@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32d806cd-0e7d-4a73-f1ed-08da8682f251
x-ms-traffictypediagnostic: DB9PR02MB6538:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iMKniugXdTSRBvq9rej2gog4Oxwxsr9DaHzB4zY980iVxJ1JPDOPTzjQEiWBaIWWzPUthP80amM2fftGfA+VbHEclxE18KDMYoWJEZSFV78oQfXS589FoRHK2l3vLhIP3Cm9KfCz0BlVSDDE73nZpSxeRVhYly5p/XYWn34XfpX1xJrbnLURFy3OqUDWLmbR2XT81PudoJ4Twew3ebjsL67I90od67dTUuVbOhYXmgPMMIFt7nJeovlnXfvU0r29Io48qhyNLGwzucy5bwo2/IsjJXusaHHuCs9VXcKy9F6WDLthKFlC88AgqF1CzIgUR9G7YtDbnGMJVMNlzk9c8KaWpH41uSJzitlX73BegzM0nAfg6IFDLHsZsogvYaqnAYWzb0Yg3zDKDJh8p97J42QqIB0ciVhhcVmAHgVndyshn3THCZlrxRuC8nsKJPLQr+Hpa+mIHrIIHlLDBjzgr7hZdatSTXXaNhnYq7ViY1qjsJHvstCPWLT4cegOxJQq4Wm8AYHAsDUC8cwSC9VAzQUgKxSYliT/RbwT5AzTInWMzOv2uj4/FMKp/TBRngCuS5MgdDemJTAkNElhNmnv1FSM5Tw9D5bNZmbo9SOdOtMgl+2acvAp1+NP3UkDkA7W1nA4KZ+qL+We6xictsRTely8V31rBaD6LC9el1zvn+I+cVDZsj53+Iwl8Ex2icnI/rVV9NnYAJJlMvFK9Uy6beG+paEPrMslwc4CbAFWpZE8FYnG8QgjXqCVPPRCT2iMyN7D+F4IOBpnVlvPC2We9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7310.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(66476007)(66446008)(8676002)(52536014)(5660300002)(33656002)(66556008)(55016003)(91956017)(2906002)(4326008)(66946007)(316002)(6916009)(9686003)(7696005)(6506007)(478600001)(76116006)(26005)(41300700001)(8936002)(7416002)(71200400001)(186003)(83380400001)(122000001)(54906003)(86362001)(38070700005)(64756008)(38100700002)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QLKnqTCRVnlbwpu7gz/RSs4ch56gza6938fEUhoqlH/J51GIz1lPTuhgND?=
 =?iso-8859-1?Q?Ga9gM4+JjZPgpEvWuuQMsNsg+4lDJRElQfSMtdIsijQGgawtT2S9HF8B06?=
 =?iso-8859-1?Q?FlyT+DiQIZe73A2VjlZkddngS1y5lAi2Ch2mjZEmP38yfkJAaYNVm/m3R+?=
 =?iso-8859-1?Q?qPxePsgKeNT0vqcJ0lII62A4/3FwGO6AT4UJfTcGZ3xcQ+/soTWVhRnqa5?=
 =?iso-8859-1?Q?cx3CNrjUVTwnNOgRvIVe44oyDO8SuMEbhwqvyjRQ4mo1MDx0AVJjOx3qdR?=
 =?iso-8859-1?Q?ZpUqCDyC245SW/KcR3KqIctDrFBf6xsupcpYffw7gQQAQ1IAuR0UX+XdTD?=
 =?iso-8859-1?Q?Zno3IPaGZXhVKzsEM05wBubFvH6zoqZgUSDdlzPsgbO8C4pVqPK2oUT6Yb?=
 =?iso-8859-1?Q?ZAlYi3pwjV77h8It+j4ArrWe9mMXj/EgQs/hK4bnP1ASzlUV1yhBHDJbd+?=
 =?iso-8859-1?Q?9wz75kWXFsJVjBa6LwbpmReyWIhJ3HIfhCAGpUYcl4o6tnyrimrchMnovl?=
 =?iso-8859-1?Q?bVYjZuvNJcxHKoMSV5pkKvxKm2BjBcTu6jih04bwwKJ+UdB6S84sB+eOR5?=
 =?iso-8859-1?Q?ATP5cRvPo5v0qs2HOIbptFetS4bTVTIe4J/N4slN9Ef+AsA6LxnDuxQKxm?=
 =?iso-8859-1?Q?STuBfSCIKDRSZ0N24cYq0Az7wvyX5Dvz8WATVoG16K5NrWSt2ZlJL61ps8?=
 =?iso-8859-1?Q?P71rwd4/AcbNn/r2dW1lxoXS+fKebQdyX8/yGZgnYzMgV1bMr1RnHnlFiQ?=
 =?iso-8859-1?Q?KGiVABOJZh6s9CbCckIhkttZVcnb/shlLs2BXwQ2jvyfmqnMsZWS3Wsg2K?=
 =?iso-8859-1?Q?wtIb3LSUGB3N6PxW79f8t6vC9DzfIurD3xxvvnfTR7bD/vrzJgpPV3wrY7?=
 =?iso-8859-1?Q?vBfq1p2a3myHaZEwWq0swNXmOnejkD/v2ZYM8maSTK4DZanXqBZNZjnriw?=
 =?iso-8859-1?Q?Nv2XCFQf4q/Az+Ep4UF/UhTfnqWhwGec/VaFYUOUVg2//HtJ3GBaHwUDun?=
 =?iso-8859-1?Q?2X0EH2LAPM+tii9lgwDUvkRpi62K9CLmCzVw/kwhCOMEimJFSnAgdLzpUu?=
 =?iso-8859-1?Q?wqgeGLs2oyKp7N8mnzpGWqetn0Te71Wsp9bSD/nFjn+IyrZmnU1wSFhMQa?=
 =?iso-8859-1?Q?Mz8WkediowIu4DLKmtvGssMvFc/K5AjeMDuwH3EYVn97CGmLbeQlWeMdhL?=
 =?iso-8859-1?Q?eOjssuJi8xDVCAoLUiwyJjPmn3no/rhFdUszItBnOggignEPP1VcmJfgSQ?=
 =?iso-8859-1?Q?PxJdbGs2hCPg3Bm+RBrG2aDSqn2iIL8EALwPfw3q+fgsPRCOH0T1bwYvTP?=
 =?iso-8859-1?Q?kh9jyZSNNG7r+nV1+opyht4Ft7kmXXG7O6dXdlinCL6FUiyILIv5qY543g?=
 =?iso-8859-1?Q?8c2VDPasJQOz3wGo0I50IrKerZfG/SNN+y+diKscBVE+bKcGo0h5wv3vSQ?=
 =?iso-8859-1?Q?riQ1GGPuhsVgVWUiYeeDvteFGHJ4fIhetCdNhUuTaPGWE2vm9Ugea7+pHv?=
 =?iso-8859-1?Q?TdLAs23lAGzf+IfxJvcg7ZU4WupLbO7Uo6GEHqYuZ1uh9JfdfWv0u6t6Ke?=
 =?iso-8859-1?Q?vRT+jwTv4TZcF+IcqjvfgUPuRQDSXKhNfmdUm9NozyoHxDGRKG1FJHbaIA?=
 =?iso-8859-1?Q?+tUHOBLX1jHHWbGjyCz4STlQo81ObtR7vN?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7310.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d806cd-0e7d-4a73-f1ed-08da8682f251
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 10:16:59.5517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8wb1ygi2No2OY+llCn79+u+2+SEhIvnoAcO3f9irn7kkK7GzSML1+ZnpV0g+KnmcovE7NYTSZVE1EZtw/+KFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6538
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

>On Thu, Aug 25, 2022 at 09:17:57AM +0000, Czerwacki, Eial wrote:=0A=
>> Greetings Greg,=0A=
>> =0A=
>> thank you for the comments, see my comment below.=0A=
>> >On Thu, Aug 25, 2022 at 06:24:02AM +0000, Czerwacki, Eial wrote:=0A=
>> >> Introducing the vSMP guest driver which allows interaction with the=
=0A=
>> >> vSMP control device when running a Linux OS atop of the vSMP hypervis=
or.=0A=
>> >> vSMP is a resource aggregation hypervisor from SAP.=0A=
>> >> =0A=
>> >> The driver comprises of api part which facilitates communication with=
=0A=
>> >> the hypervisor and version which displays the hypervisor's version.=
=0A=
>> >> =0A=
>> >> This patch s based on previous patches sent to the staging tree maili=
ng=0A=
>> >> lists=0A=
>> >> =0A=
>> >> Signed-off-by: Eial Czerwacki <eial.czerwacki@sap.com>=0A=
>> >> Acked-by: Leonid Arsh <leonid.arsh@sap.com>=0A=
>> >> Acked-by: Oren Twaig <oren.twaig@sap.com>=0A=
>> >> CC: SAP vSMP Linux Maintainer <linux.vsmp@sap.com>=0A=
>> >> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>=0A=
>> >> CC: Arnd Bergmann <arnd@arndb.de>=0A=
>> >> CC: Dan Carpenter <dan.carpenter@oracle.com>=0A=
>> >> CC: Andra Paraschiv <andraprs@amazon.com>=0A=
>> >> CC: Borislav Petkov <bp@suse.de>=0A=
>> >> CC: Brijesh Singh <brijesh.singh@amd.com>=0A=
>> >> CC: Eric Biggers <ebiggers@google.com>=0A=
>> >> CC: Fei Li <fei1.li@intel.com>=0A=
>> >> CC: Hans de Goede <hdegoede@redhat.com>=0A=
>> >> CC: Jens Axboe <axboe@kernel.dk>=0A=
>> >> CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0A=
>> >> =0A=
>> >> v1 -> v2:=0A=
>> >>=A0=A0=A0=A0=A0=A0=A0 - fix -0 var init in add_sysfs_entries (pointed =
out by Dan Carpenter)=0A=
>> >> ---=0A=
>> >>=A0 Documentation/ABI/stable/sysfs-driver-vsmp |=A0=A0 5 +=0A=
>> >>=A0 MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 6 +=0A=
>> >>=A0 drivers/virt/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +=0A=
>> >>=A0 drivers/virt/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +=0A=
>> >>=A0 drivers/virt/vsmp/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |=A0 11 +=0A=
>> >>=A0 drivers/virt/vsmp/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0=A0 7 +=0A=
>> >>=A0 drivers/virt/vsmp/api/api.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 | 249 +++++++++++++++++++++=0A=
>> >>=A0 drivers/virt/vsmp/api/api.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0 69 ++++++=0A=
>> >>=A0 drivers/virt/vsmp/include/registers.h=A0=A0=A0=A0=A0 |=A0 12 +=0A=
>> >>=A0 drivers/virt/vsmp/version/version.c=A0=A0=A0=A0=A0=A0=A0 | 118 +++=
+++++++=0A=
>> >>=A0 drivers/virt/vsmp/version/version.h=A0=A0=A0=A0=A0=A0=A0 |=A0 14 +=
+=0A=
>> >>=A0 drivers/virt/vsmp/vsmp_main.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 | 110 +++++++++=0A=
>> >>=A0 12 files changed, 605 insertions(+)=0A=
>> >=0A=
>> >Why do you have all of these different .c and .h files for only 600=0A=
>> >lines of code?=A0 Shouldn't this all just be in a single .c file?=A0 Wh=
y=0A=
>> >have a subdir for just 300 lines?=0A=
>> >=0A=
>> >Please mush this all into a single .c file going forward, speading it=
=0A=
>> >out like this makes no sense.=0A=
>> the current driver has two modules, version and api, in later versions o=
f the=0A=
>> driver support for additional features will be added.=0A=
>> at that time, this might cause the single file to inflate, so we thought=
 to split it=0A=
>> to several files to make it more organized.=0A=
>> is there any way to keep it in different code files?=0A=
>=0A=
>Keep it small and together now.=A0 If you need to change it in the future,=
=0A=
>wonderful, do it then.=A0 Don't do things that we never know will happen=
=0A=
>or not.=0A=
>=0A=
>One file, and one module, is great to start with.=A0 Please do that for=0A=
>now.=0A=
>=0A=
I understand, I'll restrucure it into one file=0A=
=0A=
>=0A=
>> =0A=
>> >=0A=
>> >>=A0 create mode 100644 Documentation/ABI/stable/sysfs-driver-vsmp=0A=
>> >>=A0 create mode 100644 drivers/virt/vsmp/Kconfig=0A=
>> >>=A0 create mode 100644 drivers/virt/vsmp/Makefile=0A=
>> >>=A0 create mode 100644 drivers/virt/vsmp/api/api.c=0A=
>> >>=A0 create mode 100644 drivers/virt/vsmp/api/api.h=0A=
>> >>=A0 create mode 100644 drivers/virt/vsmp/include/registers.h=0A=
>> >>=A0 create mode 100644 drivers/virt/vsmp/version/version.c=0A=
>> >>=A0 create mode 100644 drivers/virt/vsmp/version/version.h=0A=
>> >>=A0 create mode 100644 drivers/virt/vsmp/vsmp_main.c=0A=
>> >> =0A=
>> >> diff --git a/Documentation/ABI/stable/sysfs-driver-vsmp b/Documentati=
on/ABI/stable/sysfs-driver-vsmp=0A=
>> >> new file mode 100644=0A=
>> >> index 000000000000..18a0a62f40ed=0A=
>> >> --- /dev/null=0A=
>> >> +++ b/Documentation/ABI/stable/sysfs-driver-vsmp=0A=
>> >> @@ -0,0 +1,5 @@=0A=
>> >> +What:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /sys/hypervisor/vsmp/version=0A=
>> >> +Date:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Aug 2022=0A=
>> >=0A=
>> >August is almost over :(=0A=
>> will fix, thank!=0A=
>> =0A=
>> >=0A=
>> >> +Contact:=A0=A0=A0=A0=A0=A0=A0 Eial Czerwacki <eial.czerwacki@sap.com=
>=0A=
>> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 linux-vsmp@sap.com=0A=
>> >=0A=
>> >No need for an alias here.=0A=
>> it's not an alias, it is a shard mailbox for the team so others can=0A=
>> view the mails history.=0A=
>> I saw that the same methodology is done with mailing lists.=0A=
>=0A=
>That's a mailing list?=A0 Ah, didn't realize that, sorry, was not obvious.=
=0A=
>=0A=
>> >> diff --git a/MAINTAINERS b/MAINTAINERS=0A=
>> >> index f512b430c7cb..cf74089c4d19 100644=0A=
>> >> --- a/MAINTAINERS=0A=
>> >> +++ b/MAINTAINERS=0A=
>> >> @@ -21783,6 +21783,12 @@ F:=A0=A0 lib/test_printf.c=0A=
>> >>=A0 F:=A0=A0 lib/test_scanf.c=0A=
>> >>=A0 F:=A0=A0 lib/vsprintf.c=0A=
>> >> =0A=
>> >> +VSMP GUEST DRIVER=0A=
>> >> +M:=A0=A0 Eial Czerwacki <eial.czerwacki@sap.com>=0A=
>> >> +M:=A0=A0 linux-vsmp@sap.com=0A=
>> >=0A=
>> >Again, no random aliases please, stick to a person as a contact.=0A=
>> see above comment=0A=
>=0A=
>If this is a mailing list, mark it as such, you did not do so.=0A=
I'll mark it accordingly.=0A=
=0A=
>=0A=
>=0A=
>> >> +/*=0A=
>> >> + * Register the vSMP sysfs object for user space interaction=0A=
>> >> + */=0A=
>> >> +int vsmp_register_sysfs_group(const struct bin_attribute *bin_attr)=
=0A=
>> >> +{=0A=
>> >> +=A0=A0=A0=A0 int error =3D -EINVAL;=0A=
>> >> +=0A=
>> >> +=A0=A0=A0=A0 if (vsmp_sysfs_kobj && bin_attr) {=0A=
>> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error =3D sysfs_create_bin_file=
(vsmp_sysfs_kobj, bin_attr);=0A=
>> >=0A=
>> >You raced userspace and lost :(=0A=
>> not sure I understand, can you elaborate more please?=0A=
>=0A=
>Fix up your sysfs usage first, and then we can revisit this.=0A=
will do.=0A=
=0A=
>=0A=
>=0A=
>> >=0A=
>> >And why is your version file a binary file?=A0 It should just be a smal=
l=0A=
>> >text string, right?=0A=
>> not so small, it can reach up to 512kb.=0A=
>=0A=
>That was not obvious at all.=A0 Please document this.=0A=
where should the document be?=0A=
in the code as a comment or in another file?=0A=
=0A=
>=0A=
>And how in the world is a "version" that big?=A0 What exactly does this=0A=
>contain?=0A=
it 's size depends on the number of resources it uses.=0A=
here is an example:=0A=
:~> cat /sys/hypervisor/vsmp/version  =0A=
SAP vSMP Foundation: 10.6.2862.0 (Aug 22 2022 15:21:02)=0A=
System configuration:=0A=
   Boards:      2=0A=
      1 x Proc. + I/O + Memory=0A=
      1 x NVM devices (Amazon.com Amazon EC2 NVMe Instance Storage)=0A=
   Processors:  1, Cores: 2, Threads: 4=0A=
       Intel(R) Xeon(R) Platinum 8124M CPU @ 3.00GHz Stepping 04=0A=
   Memory (MB): 30976 (of 103192), Cache: 7527, Private: 64689=0A=
      1 x  6400MB    [ 7825/ 321/ 1104]      =0A=
      1 x 24576MB    [95367/7206/63585]       00:1f.0#1=0A=
   Boot device: [HDD] NVMe: Amazon Elastic Block Store        =0A=
Supported until: Aug 22 2024=0A=
=0A=
>=0A=
>> that is why I decided to go with binary, I understood that the text is r=
ather limited.=0A=
>=0A=
>That is true, sysfs is "one value per file", this can not be a file that=
=0A=
>you parse.=0A=
should I keep it as bin then?=0A=
=0A=
>=0A=
>=0A=
>> >> +int open_cfg_addr(struct pci_dev *pdev)=0A=
>> >> +{=0A=
>> >> +=A0=A0=A0=A0 u64 cfg_start;=0A=
>> >> +=A0=A0=A0=A0 u32 cfg_len;=0A=
>> >> +=0A=
>> >> +=A0=A0=A0=A0 vsmp_dev_obj =3D pdev;=0A=
>> >> +=A0=A0=A0=A0 cfg_start =3D pci_resource_start(vsmp_dev_obj, 0);=0A=
>> >> +=A0=A0=A0=A0 cfg_len =3D pci_resource_len(vsmp_dev_obj, 0);=0A=
>> >> +=0A=
>> >> +=A0=A0=A0=A0 dev_dbg(get_dev(), "Mapping bar 0: [0x%llx,0x%llx]\n",=
=0A=
>> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cfg_start, cfg_start + cfg_len)=
;=0A=
>> >=0A=
>> >Again, you have a device, use that.=A0 Goes for the whole driver.=0A=
>> I think I've missed something, please correct me if I'm wrong,=0A=
>> I don't need to save the pdev because there is an existing framework=0A=
>> that provides it?=0A=
>=0A=
>You have pdev, use that in your dev_dbg() call.=0A=
I have pdev when the probe cb is called, however in other funcs I=0A=
don't have it.=0A=
I'll look into other drivers see what they are doing instead=0A=
of wasting your time=0A=
=0A=
>=0A=
>> >> +#define FILE_PREM 0444=0A=
>> >=0A=
>> >File permission of what?=A0 And shouldn't it be "PERM", not "PREM"?=A0 =
And=0A=
>> >why do you need it at all?=A0 Just use the proper sysfs macros and you=
=0A=
>> >never need it.=A0 See below.=0A=
>> all the sysfs files (1 for now) should be read for all users.=0A=
>=0A=
>Then use the proper sysfs macros for that, do not set it yourself.=0A=
(Y)=0A=
=0A=
>=0A=
>> I'll submit a new version after a proper file structure will be decided=
=0A=
>> thanks again for you comments.=0A=
>=0A=
>Again, stick with one file to start with.=A0 You can always change that=0A=
>later once it is merged if you really need it.=0A=
>=0A=
>thanks,=0A=
>=0A=
>greg k-h=0A=
=0A=
great, thanks.=0A=
=0A=
Eial=
